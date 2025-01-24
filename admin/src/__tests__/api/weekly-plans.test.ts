import { describe, expect, it, jest, beforeEach } from '@jest/globals'
import { GET, POST } from '@/app/api/weekly-plans/route'
import { prisma } from '@/lib/prisma'
import { JWTService } from '@/lib/jwt'
import { createTestRequest } from '../helpers/test-utils'

// Mock Prisma
jest.mock('@/lib/prisma', () => ({
  prisma: {
    weeklyPlan: {
      findFirst: jest.fn(),
      create: jest.fn(),
    },
  },
}))

describe('Weekly Plans API', () => {
  const mockJwtService: JWTService = {
    sign: jest.fn().mockReturnValue('mock-token'),
    verify: jest.fn().mockReturnValue({ userId: 'test-user-id' })
  }

  const mockPlan = {
    id: '1',
    userId: 'test-user-id',
    weekStartDate: new Date('2024-01-01'),
    meals: []
  }

  beforeEach(() => {
    jest.clearAllMocks()
  })

  describe('GET /api/weekly-plans', () => {
    it('should return 401 if no auth token provided', async () => {
      const request = createTestRequest('GET', '/api/weekly-plans')

      const res = await GET(request, mockJwtService)
      const data = await res.json()

      expect(res.status).toBe(401)
      expect(data.error).toBe('Unauthorized')
    })

    it('should return 404 if no weekly plan found', async () => {
      ;(prisma.weeklyPlan.findFirst as jest.Mock).mockResolvedValueOnce(null)

      const request = createTestRequest(
        'GET',
        '/api/weekly-plans',
        {},
        { 'Authorization': 'Bearer valid-token' }
      )

      const res = await GET(request, mockJwtService)
      const data = await res.json()

      expect(res.status).toBe(404)
      expect(data.error).toBe('Weekly plan not found')
    })

    it('should return weekly plan if found', async () => {
      ;(prisma.weeklyPlan.findFirst as jest.Mock).mockResolvedValueOnce(mockPlan)

      const request = createTestRequest(
        'GET',
        '/api/weekly-plans',
        {},
        { 'Authorization': 'Bearer valid-token' }
      )

      const res = await GET(request, mockJwtService)
      const data = await res.json()

      expect(res.status).toBe(200)
      expect(data).toEqual(mockPlan)
    })
  })

  describe('POST /api/weekly-plans', () => {
    it('should return 401 if no auth token provided', async () => {
      const request = createTestRequest('POST', '/api/weekly-plans')

      const res = await POST(request, mockJwtService)
      const data = await res.json()

      expect(res.status).toBe(401)
      expect(data.error).toBe('Unauthorized')
    })

    it('should return 400 if week start date is missing', async () => {
      const request = createTestRequest(
        'POST',
        '/api/weekly-plans',
        {},
        { 'Authorization': 'Bearer valid-token' }
      )

      const res = await POST(request, mockJwtService)
      const data = await res.json()

      expect(res.status).toBe(400)
      expect(data.error).toBe('Week start date is required')
    })

    it('should create weekly plan successfully', async () => {
      ;(prisma.weeklyPlan.create as jest.Mock).mockResolvedValueOnce(mockPlan)

      const request = createTestRequest(
        'POST',
        '/api/weekly-plans',
        { weekStartDate: '2024-01-01' },
        { 'Authorization': 'Bearer valid-token' }
      )

      const res = await POST(request, mockJwtService)
      const data = await res.json()

      expect(res.status).toBe(201)
      expect(data).toEqual(mockPlan)
      expect(prisma.weeklyPlan.create).toHaveBeenCalledWith({
        data: {
          userId: 'test-user-id',
          weekStartDate: new Date('2024-01-01'),
          meals: []
        }
      })
    })
  })
})
