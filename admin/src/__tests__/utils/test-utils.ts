import { prisma } from '@/lib/prisma'
import { NextRequest } from 'next/server'
import { prismaMock } from '../../../jest.setup'

export async function clearTestData() {
  await prismaMock.weeklyPlan.deleteMany.mockResolvedValue({ count: 0 })
  await prismaMock.user.deleteMany.mockResolvedValue({ count: 0 })
  await prismaMock.meal.deleteMany.mockResolvedValue({ count: 0 })
  await prismaMock.favorite.deleteMany.mockResolvedValue({ count: 0 })
}

export async function createMockUser(userId: string) {
  const user = {
    id: userId,
    email: 'test@example.com',
    username: 'testuser',
    firebaseUid: 'firebase-123',
  }
  prismaMock.user.create.mockResolvedValue(user)
  return user
}

// Helper function to create a mock NextRequest for testing
export function createMockRequest(
  url: string | URL,
  options: RequestInit = {}
): NextRequest {
  const defaultHeaders = {
    'Content-Type': 'application/json',
    Authorization: 'Bearer mock-token',
  }

  const headers = new Headers({
    ...defaultHeaders,
    ...(options.headers || {}),
  })

  return {
    url: url instanceof URL ? url.toString() : url,
    method: options.method || 'GET',
    headers,
    json: async () => options.body ? JSON.parse(options.body as string) : undefined,
  } as unknown as NextRequest
}
