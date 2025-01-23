import { describe, expect, it, beforeEach } from '@jest/globals'
import { mockMeal, mockUser, mockFavoriteMeal, stripDateFields } from '../helpers/testUtils'
import { GET, POST, PATCH } from '@/app/api/meals/route'
import { prismaMock } from '../../../jest.setup'

describe('Meals API', () => {
  beforeEach(() => {
    jest.clearAllMocks()
  })

  describe('GET /api/meals', () => {
    it('should return all meals', async () => {
      prismaMock.meal.findMany.mockResolvedValue([mockMeal])

      const request = new Request('http://localhost:3000/api/meals')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(data).toEqual([mockMeal])
      expect(prismaMock.meal.findMany).toHaveBeenCalled()
    })

    it('should return empty array when no meals exist', async () => {
      prismaMock.meal.findMany.mockResolvedValue([])

      const request = new Request('http://localhost:3000/api/meals')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(data).toEqual([])
    })

    it('should return meals with favorite status for a user', async () => {
      prismaMock.meal.findMany.mockResolvedValue([mockMeal])
      prismaMock.favoriteMeal.findMany.mockResolvedValue([mockFavoriteMeal])

      const request = new Request(
        'http://localhost:3000/api/meals?userId=' + mockUser.id
      )
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data[0])).toEqual(stripDateFields({
        ...mockMeal,
        isFavorite: true
      }))
      expect(prismaMock.favoriteMeal.findMany).toHaveBeenCalledWith({
        where: {
          userId: mockUser.id
        },
        select: {
          mealId: true
        }
      })
    })

    it('should filter by favorites only', async () => {
      prismaMock.meal.findMany.mockResolvedValue([mockMeal])
      prismaMock.favoriteMeal.findMany.mockResolvedValue([mockFavoriteMeal])

      const request = new Request(
        'http://localhost:3000/api/meals?userId=' + mockUser.id + '&favoritesOnly=true'
      )
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data[0])).toEqual(stripDateFields({
        ...mockMeal,
        isFavorite: true
      }))
      expect(prismaMock.favoriteMeal.findMany).toHaveBeenCalledWith({
        where: {
          userId: mockUser.id
        },
        select: {
          mealId: true
        }
      })
    })

    it('should handle errors', async () => {
      prismaMock.meal.findMany.mockRejectedValue(new Error('Database error'))
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
        ingredients: ['New Ingredient 1', 'New Ingredient 2'],
        instructions: ['New Step 1', 'New Step 2'],
        imageUrl: 'https://example.com/new-image.jpg'
      }

      prismaMock.meal.create.mockResolvedValue({ ...mockMeal, ...newMeal })

      const request = new Request('http://localhost:3000/api/meals', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(newMeal)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(data).toMatchObject(newMeal)
      expect(prismaMock.meal.create).toHaveBeenCalledWith({
        data: newMeal
      })
    })

    it('should return 400 if request data is invalid', async () => {
      const request = new Request('http://localhost:3000/api/meals', {
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

    it('should handle validation errors', async () => {
      const request = new Request('http://localhost:3000/api/meals', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ name: '' })
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
        description: 'An updated test meal'
      }

      prismaMock.meal.update.mockResolvedValue({ ...mockMeal, ...updates })

      const request = new Request(
        'http://localhost:3000/api/meals?id=' + mockMeal.id,
        {
          method: 'PATCH',
          body: JSON.stringify(updates)
        }
      )

      const response = await PATCH(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(data).toMatchObject(updates)
      expect(prismaMock.meal.update).toHaveBeenCalledWith({
        where: { id: mockMeal.id },
        data: updates
      })
    })

    it('should handle missing id', async () => {
      const request = new Request('http://localhost:3000/api/meals', {
        method: 'PATCH',
        body: JSON.stringify({})
      })

      const response = await PATCH(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Meal ID is required')
    })

    it('should handle validation errors', async () => {
      const request = new Request(
        'http://localhost:3000/api/meals?id=' + mockMeal.id,
        {
          method: 'PATCH',
          body: JSON.stringify({ name: '' })
        }
      )

      const response = await PATCH(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Invalid request data')
    })
  })
})
