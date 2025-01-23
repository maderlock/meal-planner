import { NextResponse } from 'next/server'
import { GET, POST } from '@/app/api/users/route'
import { mockUser } from '../helpers/testUtils'
import { prismaMock } from '../../../jest.setup'

describe('Users API', () => {
  beforeEach(() => {
    jest.clearAllMocks()
  })

  describe('GET /api/users', () => {
    it('should return all users', async () => {
      prismaMock.user.findMany.mockResolvedValue([mockUser])

      const request = new Request('http://localhost:3000/api/users')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(data).toEqual([mockUser])
      expect(prismaMock.user.findMany).toHaveBeenCalledWith({
        select: {
          id: true,
          email: true,
          username: true,
          firebaseUid: true,
          createdAt: true
        }
      })
    })

    it('should handle errors', async () => {
      prismaMock.user.findMany.mockRejectedValue(new Error('Database error'))

      const request = new Request('http://localhost:3000/api/users')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data.error).toBe('Failed to fetch users')
    })
  })

  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      const newUser = {
        email: 'new@example.com',
        username: 'newuser',
        name: 'New User',
        firebaseUid: 'firebase456'
      }

      prismaMock.user.create.mockResolvedValue({ ...mockUser, ...newUser })

      const request = new Request('http://localhost:3000/api/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(newUser)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(data).toMatchObject({
        id: mockUser.id,
        email: newUser.email,
        username: newUser.username,
        firebaseUid: newUser.firebaseUid,
        createdAt: mockUser.createdAt
      })
      expect(prismaMock.user.create).toHaveBeenCalledWith({
        data: {
          email: newUser.email,
          username: newUser.username,
          firebaseUid: newUser.firebaseUid
        },
        select: {
          id: true,
          email: true,
          username: true,
          firebaseUid: true,
          createdAt: true
        }
      })
    })

    it('should handle validation errors', async () => {
      const request = new Request('http://localhost:3000/api/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Invalid request data')
    })

    it('should handle database errors', async () => {
      const newUser = {
        email: 'new@example.com',
        username: 'newuser',
        name: 'New User',
        firebaseUid: 'firebase456'
      }

      prismaMock.user.create.mockRejectedValue(new Error('Database error'))

      const request = new Request('http://localhost:3000/api/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(newUser)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data.error).toBe('Failed to create user')
    })
  })
})
