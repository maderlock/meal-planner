import { describe, expect, it, beforeEach } from '@jest/globals'
import { mockWeeklyPlan, mockPrisma, mockUser, mockMealPlan, stripDateFields } from '../helpers/testUtils'
import { GET, POST } from '@/app/api/weekly-plans/route'
import { POST as postMeals, DELETE as deleteMeals } from '@/app/api/weekly-plans/[id]/meals/route'

jest.mock('@/lib/prisma', () => ({
  prisma: mockPrisma
}))

describe('Weekly Plans API', () => {
  beforeEach(() => {
    jest.clearAllMocks()
    mockPrisma.weeklyPlan.findFirst.mockResolvedValue(mockWeeklyPlan)
    mockPrisma.weeklyPlan.create.mockResolvedValue(mockWeeklyPlan)
    mockPrisma.mealPlan.create.mockResolvedValue(mockMealPlan)
    mockPrisma.mealPlan.deleteMany.mockResolvedValue({ count: 1 })
  })

  describe('GET /api/weekly-plans', () => {
    it('should return current week plan if it exists', async () => {
      const request = new Request(
        'http://localhost:3000/api/weekly-plans?userId=' + mockUser.id
      )
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data)).toEqual(stripDateFields(mockWeeklyPlan))
      expect(mockPrisma.weeklyPlan.findFirst).toHaveBeenCalledWith({
        where: expect.objectContaining({
          userId: mockUser.id
        }),
        include: {
          mealPlans: {
            include: {
              meal: true
            }
          }
        }
      })
    })

    it('should create a new week plan if none exists', async () => {
      mockPrisma.weeklyPlan.findFirst.mockResolvedValueOnce(null)
      const request = new Request(
        'http://localhost:3000/api/weekly-plans?userId=' + mockUser.id
      )
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data)).toEqual(stripDateFields(mockWeeklyPlan))
      expect(mockPrisma.weeklyPlan.create).toHaveBeenCalled()
    })

    it('should handle missing userId', async () => {
      const request = new Request('http://localhost:3000/api/weekly-plans')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('User ID is required')
    })

    it('should handle errors', async () => {
      mockPrisma.weeklyPlan.findFirst.mockRejectedValue(new Error('Database error'))
      const request = new Request(
        'http://localhost:3000/api/weekly-plans?userId=' + mockUser.id
      )
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data).toEqual({ error: 'Failed to fetch weekly plan' })
    })
  })

  describe('POST /api/weekly-plans', () => {
    it('should create a new weekly plan', async () => {
      const newPlan = {
        userId: mockUser.id,
        weekStartDate: new Date('2025-01-20')
      }

      const request = new Request('http://localhost:3000/api/weekly-plans', {
        method: 'POST',
        body: JSON.stringify(newPlan)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(stripDateFields(data)).toEqual(stripDateFields(mockWeeklyPlan))
      expect(mockPrisma.weeklyPlan.create).toHaveBeenCalledWith({
        data: expect.objectContaining({
          userId: newPlan.userId,
          weekStartDate: expect.any(Date)
        }),
        include: {
          mealPlans: {
            include: {
              meal: true
            }
          }
        }
      })
    })

    it('should handle validation errors', async () => {
      const request = new Request('http://localhost:3000/api/weekly-plans', {
        method: 'POST',
        body: JSON.stringify({})
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Invalid request data')
    })
  })

  describe('POST /api/weekly-plans/[id]/meals', () => {
    it('should update a meal plan', async () => {
      const newMealPlan = {
        mealId: mockMealPlan.mealId,
        dayOfWeek: 1,
        mealType: 'dinner'
      }

      const request = new Request(
        `http://localhost:3000/api/weekly-plans/${mockWeeklyPlan.id}/meals`,
        {
          method: 'POST',
          body: JSON.stringify(newMealPlan)
        }
      )

      const response = await postMeals(request, {
        params: { id: mockWeeklyPlan.id }
      })
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(stripDateFields(data)).toEqual(stripDateFields(mockMealPlan))
      expect(mockPrisma.mealPlan.create).toHaveBeenCalledWith({
        data: {
          weeklyPlanId: mockWeeklyPlan.id,
          mealId: newMealPlan.mealId,
          dayOfWeek: newMealPlan.dayOfWeek,
          mealType: newMealPlan.mealType
        },
        include: {
          meal: true
        }
      })
    })
  })

  describe('DELETE /api/weekly-plans/[id]/meals', () => {
    it('should delete a meal plan', async () => {
      const request = new Request(
        `http://localhost:3000/api/weekly-plans/${mockWeeklyPlan.id}/meals?dayOfWeek=1&mealType=dinner`,
        {
          method: 'DELETE'
        }
      )

      const response = await deleteMeals(request, {
        params: { id: mockWeeklyPlan.id }
      })

      expect(response.status).toBe(204)
      expect(mockPrisma.mealPlan.deleteMany).toHaveBeenCalledWith({
        where: {
          weeklyPlanId: mockWeeklyPlan.id,
          dayOfWeek: 1,
          mealType: 'dinner'
        }
      })
    })

    it('should handle missing parameters', async () => {
      const request = new Request(
        `http://localhost:3000/api/weekly-plans/${mockWeeklyPlan.id}/meals`,
        {
          method: 'DELETE'
        }
      )

      const response = await deleteMeals(request, {
        params: { id: mockWeeklyPlan.id }
      })
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Day of week and meal type are required')
      expect(mockPrisma.mealPlan.deleteMany).not.toHaveBeenCalled()
    })
  })
})
