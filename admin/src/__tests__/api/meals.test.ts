import { describe, expect, it, beforeEach } from '@jest/globals'
import { mockMeal, mockPrisma, mockUser, stripDateFields } from '../helpers/testUtils'
import { GET, POST, PATCH } from '@/app/api/meals/route'

jest.mock('@/lib/prisma', () => ({
  prisma: mockPrisma
}))

describe('Meals API', () => {
  beforeEach(() => {
    jest.clearAllMocks()
    mockPrisma.meal.findMany.mockResolvedValue([mockMeal])
    mockPrisma.meal.create.mockResolvedValue(mockMeal)
    mockPrisma.meal.update.mockResolvedValue(mockMeal)
  })

  describe('GET /api/meals', () => {
    it('should return all meals with user information', async () => {
      const request = new Request('http://localhost:3000/api/meals')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data[0])).toEqual(stripDateFields(mockMeal))
      expect(mockPrisma.meal.findMany).toHaveBeenCalledWith({
        where: {},
        include: {
          user: {
            select: {
              username: true
            }
          }
        },
        orderBy: {
          name: 'asc'
        }
      })
    })

    it('should filter by user ID and favorite status', async () => {
      const request = new Request(
        'http://localhost:3000/api/meals?userId=' + mockUser.id + '&favoritesOnly=true'
      )
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data[0])).toEqual(stripDateFields(mockMeal))
      expect(mockPrisma.meal.findMany).toHaveBeenCalledWith({
        where: {
          userId: mockUser.id,
          isFavorite: true
        },
        include: {
          user: {
            select: {
              username: true
            }
          }
        },
        orderBy: {
          name: 'asc'
        }
      })
    })

    it('should handle errors', async () => {
      mockPrisma.meal.findMany.mockRejectedValue(new Error('Database error'))
      const request = new Request('http://localhost:3000/api/meals')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data).toEqual({ error: 'Failed to fetch meals' })
    })
  })

  describe('POST /api/meals', () => {
    it('should create a new meal', async () => {
      const newMeal = {
        name: 'New Test Meal',
        description: 'A new test meal',
        userId: mockUser.id,
        isFavorite: true
      }

      mockPrisma.meal.create.mockResolvedValueOnce({
        ...mockMeal,
        ...newMeal
      })

      const request = new Request('http://localhost:3000/api/meals', {
        method: 'POST',
        body: JSON.stringify(newMeal)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(stripDateFields(data)).toEqual(
        stripDateFields({
          ...mockMeal,
          ...newMeal
        })
      )
      expect(mockPrisma.meal.create).toHaveBeenCalledWith({
        data: newMeal,
        include: {
          user: {
            select: {
              username: true
            }
          }
        }
      })
    })

    it('should handle validation errors', async () => {
      const request = new Request('http://localhost:3000/api/meals', {
        method: 'POST',
        body: JSON.stringify({})
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Invalid request data')
    })
  })

  describe('PATCH /api/meals', () => {
    it('should update a meal', async () => {
      const updates = {
        name: 'Updated Test Meal',
        description: 'An updated test meal',
        isFavorite: true
      }

      const request = new Request(
        'http://localhost:3000/api/meals?id=' + mockMeal.id,
        {
          method: 'PATCH',
          body: JSON.stringify(updates)
        }
      )

      mockPrisma.meal.update.mockResolvedValueOnce({
        ...mockMeal,
        ...updates
      })

      const response = await PATCH(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data)).toEqual(
        stripDateFields({
          ...mockMeal,
          ...updates
        })
      )
      expect(mockPrisma.meal.update).toHaveBeenCalledWith({
        where: { id: mockMeal.id },
        data: updates,
        include: {
          user: {
            select: {
              username: true
            }
          }
        }
      })
    })

    it('should handle missing ID', async () => {
      const request = new Request('http://localhost:3000/api/meals', {
        method: 'PATCH',
        body: JSON.stringify({ name: 'Updated Test Meal' })
      })

      const response = await PATCH(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Meal ID is required')
    })
  })
})
