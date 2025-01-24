/**
 * Test utilities for API testing
 * 
 * This file provides helper functions and mocks for testing API endpoints.
 * It includes request/response mocking and common test data.
 */

import { prisma } from '@/lib/prisma'
import { jest } from '@jest/globals'

// Mock UUIDs for testing
const TEST_UUID_1 = '123e4567-e89b-12d3-a456-426614174000'
const TEST_UUID_2 = '987fcdeb-51a2-43f7-9abc-123456789012'
const TEST_UUID_3 = 'abc12345-6789-def0-1234-567890123456'
const TEST_UUID_4 = 'def67890-1234-5678-9abc-def012345678'

export const mockUser = {
  id: TEST_UUID_1,
  email: 'test@example.com',
  username: 'testuser',
  firebaseUid: 'firebase123',
  name: 'Test User',
  createdAt: new Date('2025-01-23T16:32:52Z'),
  updatedAt: new Date('2025-01-23T16:32:52Z')
}

export const mockMeal = {
  id: TEST_UUID_2,
  name: 'Test Meal',
  description: 'A test meal',
  ingredients: ['Ingredient 1', 'Ingredient 2'],
  instructions: ['Step 1', 'Step 2'],
  imageUrl: 'https://example.com/image.jpg',
  createdAt: new Date('2025-01-23T16:32:52Z'),
  updatedAt: new Date('2025-01-23T16:32:52Z')
}

export const mockFavoriteMeal = {
  userId: TEST_UUID_1,
  mealId: TEST_UUID_2,
  createdAt: new Date('2025-01-23T16:32:52Z'),
  meal: mockMeal
}

export const mockMealAssignment = {
  id: TEST_UUID_3,
  weeklyPlanId: TEST_UUID_4,
  mealId: TEST_UUID_2,
  dayOfWeek: 1,
  mealType: 'breakfast',
  createdAt: new Date('2025-01-23T16:32:52Z'),
  updatedAt: new Date('2025-01-23T16:32:52Z'),
  meal: mockMeal
}

export const mockWeeklyPlan = {
  id: TEST_UUID_4,
  userId: TEST_UUID_1,
  weekStartDate: new Date('2025-01-20T00:00:00Z'),
  createdAt: new Date('2025-01-23T16:32:52Z'),
  updatedAt: new Date('2025-01-23T16:32:52Z'),
  mealPlans: [mockMealAssignment]
}

// Mock Prisma Client
export const prismaMock = {
  user: {
    findUnique: jest.fn(),
    findFirst: jest.fn(),
    findMany: jest.fn(),
    create: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  },
  meal: {
    findUnique: jest.fn(),
    findMany: jest.fn(),
    create: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  },
  weeklyPlan: {
    findUnique: jest.fn(),
    findMany: jest.fn(),
    create: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  },
  mealAssignment: {
    findUnique: jest.fn(),
    findMany: jest.fn(),
    create: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  },
  favoriteMeal: {
    findUnique: jest.fn(),
    findMany: jest.fn(),
    create: jest.fn(),
    delete: jest.fn(),
  },
} as unknown as typeof prisma

// Helper function to strip date fields for comparison
export function stripDateFields<T extends Record<string, any>>(obj: T): T {
  const newObj = { ...obj }
  for (const key in newObj) {
    if (newObj[key] instanceof Date) {
      newObj[key] = newObj[key].toISOString()
    } else if (typeof newObj[key] === 'object' && newObj[key] !== null) {
      newObj[key] = stripDateFields(newObj[key])
    }
  }
  return newObj
}

// Mock Next.js Response
export class MockNextResponse {
  constructor(
    public body: any,
    public init: ResponseInit = {}
  ) {}

  public headers: Headers

  static json(data: any, init: ResponseInit = {}) {
    return new MockNextResponse(
      JSON.stringify(data),
      {
        ...init,
        headers: {
          'Content-Type': 'application/json',
          ...init.headers,
        },
      }
    )
  }
}

// Mock Next.js Request
export class MockNextRequest {
  private url: string;
  private config: RequestInit;
  public headers: Headers;
  public method: string;

  constructor(url: string, config: RequestInit = {}) {
    this.url = url;
    this.config = config;
    this.headers = new Headers(config.headers || {});
    this.method = config.method || 'GET';
  }

  async json() {
    if (!this.config.body) return undefined;
    return JSON.parse(this.config.body as string);
  }

  get nextUrl() {
    return new URL(this.url);
  }
}

export const TEST_DATE = '2025-01-21T22:18:21Z'
