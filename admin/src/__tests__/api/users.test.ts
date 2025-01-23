import { describe, expect, it, beforeEach } from '@jest/globals'
import { mockUser, mockPrisma, stripDateFields } from '../helpers/testUtils'
import { GET, POST } from '@/app/api/users/route'

jest.mock('@/lib/prisma', () => ({
  prisma: mockPrisma
}))

describe('Users API', () => {
  beforeEach(() => {
    jest.clearAllMocks()
    mockPrisma.user.findMany.mockResolvedValue([mockUser])
    mockPrisma.user.create.mockResolvedValue(mockUser)
  })

  describe('GET /api/users', () => {
    it('should return all users', async () => {
      const request = new Request('http://localhost:3000/api/users')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data[0])).toEqual(stripDateFields(mockUser))
      expect(mockPrisma.user.findMany).toHaveBeenCalledWith({
        select: {
          id: true,
          email: true,
          username: true,
          createdAt: true
        }
      })
    })

    it('should handle errors', async () => {
      mockPrisma.user.findMany.mockRejectedValue(new Error('Database error'))
      const request = new Request('http://localhost:3000/api/users')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data).toEqual({ error: 'Failed to fetch users' })
    })
  })

  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      const newUser = {
        email: 'test@example.com',
        username: 'testuser',
        firebaseUid: 'firebase123'
      }

      mockPrisma.user.create.mockResolvedValueOnce({
        ...mockUser,
        ...newUser
      })

      const request = new Request('http://localhost:3000/api/users', {
        method: 'POST',
        body: JSON.stringify(newUser)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(stripDateFields(data)).toEqual(stripDateFields({
        ...mockUser,
        ...newUser
      }))
      expect(mockPrisma.user.create).toHaveBeenCalledWith({
        data: newUser,
        select: {
          id: true,
          email: true,
          username: true,
          createdAt: true
        }
      })
    })

    it('should handle validation errors', async () => {
      const request = new Request('http://localhost:3000/api/users', {
        method: 'POST',
        body: JSON.stringify({})
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Invalid request data')
    })

    it('should handle database errors', async () => {
      mockPrisma.user.create.mockRejectedValue(new Error('Database error'))
      const request = new Request('http://localhost:3000/api/users', {
        method: 'POST',
        body: JSON.stringify({
          email: 'test@example.com',
          username: 'testuser',
          firebaseUid: 'firebase123'
        })
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data.error).toBe('Failed to create user')
    })
  })
})
