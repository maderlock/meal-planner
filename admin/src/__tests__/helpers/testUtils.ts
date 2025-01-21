import { prisma } from '@/lib/prisma'

export const mockPrisma = prisma as jest.Mocked<typeof prisma>

export const TEST_DATE = '2025-01-21T22:18:21Z'

export const mockUser = {
  id: '123e4567-e89b-12d3-a456-426614174000',
  email: 'test@example.com',
  firebaseUid: 'firebase123',
  username: 'testuser',
  createdAt: TEST_DATE,
  updatedAt: TEST_DATE,
}

export const mockMeal = {
  id: '123e4567-e89b-12d3-a456-426614174001',
  name: 'Test Meal',
  description: 'A test meal',
  userId: mockUser.id,
  createdAt: TEST_DATE,
  updatedAt: TEST_DATE,
  user: {
    username: mockUser.username
  }
}

export const stripDateFields = (obj: any) => {
  const newObj = { ...obj }
  delete newObj.createdAt
  delete newObj.updatedAt
  return newObj
}
