import { NextResponse } from 'next/server'
import { GET, POST } from '@/app/api/weekly-plans/route'
import { mockUser, mockWeeklyPlan, mockMeal, mockMealAssignment, stripDateFields } from '../helpers/testUtils'
import { prismaMock } from '../../../jest.setup'

describe('Weekly Plans API', () => {
  describe('GET /api/weekly-plans', () => {
    it('should return weekly plan for a user', async () => {
      const weekStartDate = new Date('2025-01-20T00:00:00Z')
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(mockWeeklyPlan)

      const request = new Request(
        `http://localhost:3000/api/weekly-plans?userId=${mockUser.id}&weekStartDate=${weekStartDate.toISOString()}`
      )
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data)).toEqual(stripDateFields(mockWeeklyPlan))
      expect(prismaMock.weeklyPlan.findFirst).toHaveBeenCalledWith({
        where: {
          userId: mockUser.id,
          weekStartDate
        },
        include: {
          mealPlans: {
            include: {
              meal: true
            }
          }
        }
      })
    })

    it('should return 400 if no user ID is provided', async () => {
      const request = new Request('http://localhost:3000/api/weekly-plans')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('User ID is required')
    })

    it('should return 404 if no weekly plan is found', async () => {
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(null)

      const request = new Request(
        `http://localhost:3000/api/weekly-plans?userId=${mockUser.id}&weekStartDate=2025-01-20T00:00:00Z`
      )
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(404)
      expect(data.error).toBe('Weekly plan not found')
    })
  })

  describe('POST /api/weekly-plans', () => {
    it('should create a new weekly plan', async () => {
      const weekStartDate = new Date('2025-01-20T00:00:00Z')
      prismaMock.weeklyPlan.create.mockResolvedValue(mockWeeklyPlan)

      const request = new Request('http://localhost:3000/api/weekly-plans', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          userId: mockUser.id,
          weekStartDate: weekStartDate.toISOString()
        })
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(stripDateFields(data)).toEqual(stripDateFields(mockWeeklyPlan))
      expect(prismaMock.weeklyPlan.create).toHaveBeenCalledWith({
        data: {
          userId: mockUser.id,
          weekStartDate
        },
        include: {
          mealPlans: {
            include: {
              meal: true
            }
          }
        }
      })
    })

    it('should return 400 if request data is invalid', async () => {
      const request = new Request('http://localhost:3000/api/weekly-plans', {
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
  })
})
