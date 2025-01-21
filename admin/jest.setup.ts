import '@testing-library/jest-dom'

// Mock the Prisma client
jest.mock('@/lib/prisma', () => ({
  prisma: {
    user: {
      findMany: jest.fn(),
      create: jest.fn(),
    },
    meal: {
      findMany: jest.fn(),
      create: jest.fn(),
    },
  },
}))
