import { NextResponse } from 'next/server'
import { GET, POST, DELETE } from '@/app/api/favorites/route'
import { mockUser, mockMeal, mockFavoriteMeal, stripDateFields } from '../helpers/testUtils'
import { prismaMock } from '../../../jest.setup'

describe('Favorites API', () => {
  beforeEach(() => {
    jest.clearAllMocks()
  })

  describe('GET /api/favorites', () => {
    it('should return favorite meals for a user', async () => {
      prismaMock.favoriteMeal.findMany.mockResolvedValue([mockFavoriteMeal])

      const request = new Request(
        `http://localhost:3000/api/favorites?userId=${mockUser.id}`
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
        include: {
          meal: true
        }
      })
    })

    it('should return 400 if no user ID is provided', async () => {
      const request = new Request('http://localhost:3000/api/favorites')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('User ID is required')
    })
  })

  describe('POST /api/favorites', () => {
    it('should create a new favorite meal', async () => {
      prismaMock.favoriteMeal.create.mockResolvedValue(mockFavoriteMeal)

      const request = new Request('http://localhost:3000/api/favorites', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          userId: mockUser.id,
          mealId: mockMeal.id
        })
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(stripDateFields(data)).toEqual(stripDateFields(mockFavoriteMeal))
      expect(prismaMock.favoriteMeal.create).toHaveBeenCalledWith({
        data: {
          userId: mockUser.id,
          mealId: mockMeal.id
        },
        include: {
          meal: true
        }
      })
    })

    it('should handle duplicate favorites', async () => {
      prismaMock.favoriteMeal.create.mockRejectedValue(new Error('Unique constraint failed'))

      const request = new Request('http://localhost:3000/api/favorites', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          userId: mockUser.id,
          mealId: mockMeal.id
        })
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(409)
      expect(data.error).toBe('Meal is already in favorites')
    })

    it('should return 400 if request data is invalid', async () => {
      const request = new Request('http://localhost:3000/api/favorites', {
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

  describe('DELETE /api/favorites', () => {
    it('should delete a favorite meal', async () => {
      prismaMock.favoriteMeal.delete.mockResolvedValue(mockFavoriteMeal)

      const request = new Request(
        `http://localhost:3000/api/favorites?userId=${mockUser.id}&mealId=${mockMeal.id}`,
        {
          method: 'DELETE'
        }
      )

      const response = await DELETE(request)

      expect(response.status).toBe(204)
      expect(prismaMock.favoriteMeal.delete).toHaveBeenCalledWith({
        where: {
          userId_mealId: {
            userId: mockUser.id,
            mealId: mockMeal.id
          }
        }
      })
    })

    it('should handle non-existent favorite', async () => {
      prismaMock.favoriteMeal.delete.mockRejectedValue(new Error('Record to delete does not exist'))

      const request = new Request(
        `http://localhost:3000/api/favorites?userId=${mockUser.id}&mealId=${mockMeal.id}`,
        {
          method: 'DELETE'
        }
      )

      const response = await DELETE(request)
      const data = await response.json()

      expect(response.status).toBe(404)
      expect(data.error).toBe('Favorite not found')
    })

    it('should return 400 if request data is invalid', async () => {
      const request = new Request('http://localhost:3000/api/favorites', {
        method: 'DELETE'
      })

      const response = await DELETE(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('User ID and Meal ID are required')
    })
  })
})
