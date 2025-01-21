import { GET, POST } from '@/app/api/users/route'
import { mockPrisma, mockUser, stripDateFields } from '../helpers/testUtils'

describe('Users API', () => {
  beforeEach(() => {
    jest.clearAllMocks()
  })

  describe('GET /api/users', () => {
    it('should return all users', async () => {
      mockPrisma.user.findMany.mockResolvedValue([mockUser])

      const response = await GET()
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

      const response = await GET()
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data).toEqual({ error: 'Failed to fetch users' })
    })
  })

  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      const newUser = {
        email: 'new@example.com',
        firebaseUid: 'firebase456',
        username: 'newuser'
      }

      mockPrisma.user.create.mockResolvedValue({
        ...mockUser,
        ...newUser
      })

      const request = new Request('http://localhost/api/users', {
        method: 'POST',
        body: JSON.stringify(newUser)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(stripDateFields(data)).toMatchObject(stripDateFields({
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

    it('should handle invalid input', async () => {
      const invalidUser = {
        email: 'invalid-email',
        firebaseUid: '',
        username: 'a'
      }

      const request = new Request('http://localhost/api/users', {
        method: 'POST',
        body: JSON.stringify(invalidUser)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Invalid request data')
      expect(mockPrisma.user.create).not.toHaveBeenCalled()
    })

    it('should handle database errors', async () => {
      const newUser = {
        email: 'new@example.com',
        firebaseUid: 'firebase456',
        username: 'newuser'
      }

      mockPrisma.user.create.mockRejectedValue(new Error('Database error'))

      const request = new Request('http://localhost/api/users', {
        method: 'POST',
        body: JSON.stringify(newUser)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data.error).toBe('Failed to create user')
    })
  })
})
