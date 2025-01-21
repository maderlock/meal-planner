import { GET, POST } from '@/app/api/meals/route'
import { mockPrisma, mockMeal, stripDateFields } from '../helpers/testUtils'

describe('Meals API', () => {
  beforeEach(() => {
    jest.clearAllMocks()
  })

  describe('GET /api/meals', () => {
    it('should return all meals with user information', async () => {
      mockPrisma.meal.findMany.mockResolvedValue([mockMeal])

      const response = await GET()
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(stripDateFields(data[0])).toEqual(stripDateFields(mockMeal))
      expect(mockPrisma.meal.findMany).toHaveBeenCalledWith({
        include: {
          user: {
            select: {
              username: true
            }
          }
        }
      })
    })

    it('should handle errors', async () => {
      mockPrisma.meal.findMany.mockRejectedValue(new Error('Database error'))

      const response = await GET()
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
        userId: mockMeal.userId
      }

      mockPrisma.meal.create.mockResolvedValue({
        ...mockMeal,
        ...newMeal
      })

      const request = new Request('http://localhost/api/meals', {
        method: 'POST',
        body: JSON.stringify(newMeal)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(stripDateFields(data)).toMatchObject(stripDateFields({
        ...mockMeal,
        ...newMeal
      }))
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

    it('should handle invalid input', async () => {
      const invalidMeal = {
        description: 'Missing required name',
        userId: 'invalid-uuid'
      }

      const request = new Request('http://localhost/api/meals', {
        method: 'POST',
        body: JSON.stringify(invalidMeal)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(400)
      expect(data.error).toBe('Invalid request data')
      expect(mockPrisma.meal.create).not.toHaveBeenCalled()
    })

    it('should handle database errors', async () => {
      const newMeal = {
        name: 'New Test Meal',
        description: 'A new test meal',
        userId: mockMeal.userId
      }

      mockPrisma.meal.create.mockRejectedValue(new Error('Database error'))

      const request = new Request('http://localhost/api/meals', {
        method: 'POST',
        body: JSON.stringify(newMeal)
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(500)
      expect(data.error).toBe('Failed to create meal')
    })
  })
})
