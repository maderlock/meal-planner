import { prisma } from '@/lib/prisma'

// Create a more complete mock of the Prisma client
const mockPrismaClient = {
  meal: {
    findMany: jest.fn().mockResolvedValue([]),
    create: jest.fn().mockResolvedValue(null),
    update: jest.fn().mockResolvedValue(null),
    delete: jest.fn().mockResolvedValue(null),
  },
  weeklyPlan: {
    findFirst: jest.fn().mockResolvedValue(null),
    create: jest.fn().mockResolvedValue(null),
    update: jest.fn().mockResolvedValue(null),
    delete: jest.fn().mockResolvedValue(null),
  },
  mealPlan: {
    create: jest.fn().mockResolvedValue(null),
    deleteMany: jest.fn().mockResolvedValue({ count: 0 }),
  },
  user: {
    findMany: jest.fn().mockResolvedValue([]),
    create: jest.fn().mockResolvedValue(null),
    findUnique: jest.fn().mockResolvedValue(null),
  },
}

export const mockPrisma = mockPrismaClient as unknown as typeof prisma

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
  isFavorite: false,
  createdAt: TEST_DATE,
  updatedAt: TEST_DATE,
  user: {
    username: mockUser.username
  }
}

export const mockMealPlan = {
  id: '123e4567-e89b-12d3-a456-426614174002',
  weeklyPlanId: '123e4567-e89b-12d3-a456-426614174003',
  mealId: mockMeal.id,
  dayOfWeek: 1,
  mealType: 'dinner',
  createdAt: TEST_DATE,
  updatedAt: TEST_DATE,
  meal: mockMeal
}

export const mockWeeklyPlan = {
  id: '123e4567-e89b-12d3-a456-426614174003',
  userId: mockUser.id,
  weekStartDate: '2025-01-20', // Monday
  createdAt: TEST_DATE,
  updatedAt: TEST_DATE,
  mealPlans: [mockMealPlan]
}

export const stripDateFields = (obj: any) => {
  if (!obj) return obj
  const newObj = { ...obj }
  delete newObj.createdAt
  delete newObj.updatedAt
  if (newObj.weekStartDate) {
    delete newObj.weekStartDate
  }
  if (newObj.mealPlans) {
    newObj.mealPlans = newObj.mealPlans.map((mp: any) => stripDateFields(mp))
  }
  if (newObj.meal) {
    newObj.meal = stripDateFields(newObj.meal)
  }
  return newObj
}
