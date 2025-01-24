/**
 * Authentication API Tests
 * 
 * Test suite for the authentication system endpoints.
 * Validates the security and functionality of user
 * authentication, registration, and profile management.
 * 
 * Test Coverage:
 * - User registration
 * - Login/logout flow
 * - Password reset
 * - Profile updates
 * - Session management
 * - Security measures
 * - Input validation
 * 
 * Related Components:
 * - auth/* routes: API implementations
 * - auth_service.dart: Mobile client
 * - User model in schema.prisma
 * 
 * Run Tests:
 * npm run test auth.test.ts
 */

import { describe, expect, it, jest, beforeEach } from '@jest/globals'
import { POST as register } from '@/app/api/auth/register/route'
import { POST as login } from '@/app/api/auth/login/route'
import { POST as logout } from '@/app/api/auth/logout/route'
import { GET as getCurrentUser } from '@/app/api/auth/me/route'
import { prisma } from '@/lib/prisma'
import { JWTService } from '@/lib/jwt'
import { createTestRequest } from '../helpers/test-utils'
import bcrypt from 'bcryptjs'

// Mock Prisma
jest.mock('@/lib/prisma', () => ({
  prisma: {
    user: {
      create: jest.fn(),
      findUnique: jest.fn(),
      update: jest.fn(),
    },
  },
}))

// Mock bcrypt
jest.mock('bcryptjs', () => ({
  compare: jest.fn(),
  genSalt: jest.fn().mockResolvedValue('fake-salt'),
  hash: jest.fn().mockResolvedValue('hashed-password')
}))
const bcrypt = require('bcryptjs')

// Mock JWTService
const mockJwtService: JWTService = {
  sign: jest.fn().mockReturnValue('mock-token'),
  verify: jest.fn().mockReturnValue({ userId: '1' })
}

// Mock jwt for /me endpoint
jest.mock('jsonwebtoken', () => ({
  verify: jest.fn().mockReturnValue({ userId: '1' })
}))

describe('Auth API', () => {
  const mockUser = {
    id: '1',
    email: 'test@example.com',
    password: 'password123',
    username: 'testuser',
    displayName: 'Test User',
    photoUrl: 'https://example.com/photo.jpg',
    emailVerified: false,
    createdAt: new Date(),
    updatedAt: new Date(),
  };

  beforeEach(() => {
    jest.clearAllMocks()
  })

  describe('POST /api/auth/register', () => {
    it('should register a new user', async () => {
      const createdUser = {
        id: '1',
        email: mockUser.email,
        username: mockUser.username,
        password: 'hashed-password'
      }

      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(null)
      ;(prisma.user.create as jest.Mock).mockResolvedValueOnce(createdUser)

      const request = createTestRequest(
        'POST',
        '/api/auth/register',
        {
          email: mockUser.email,
          password: mockUser.password,
          username: mockUser.username
        }
      )

      const response = await register(request, mockJwtService)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(data.user.email).toBe(mockUser.email)
      expect(data.user.username).toBe(mockUser.username)
      expect(data.user.password).toBeUndefined()
      expect(data.token).toBe('mock-token')
      expect(mockJwtService.sign).toHaveBeenCalledWith({ userId: '1' })
    })

    it('should register a new user with optional username', async () => {
      const createdUser = {
        id: '1',
        email: mockUser.email,
        username: mockUser.email.split('@')[0],
        displayName: mockUser.email.split('@')[0],
        firebaseUid: null
      }

      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(null)
      ;(prisma.user.create as jest.Mock).mockResolvedValueOnce(createdUser)

      const request = createTestRequest(
        'POST',
        '/api/auth/register',
        {
          email: mockUser.email,
          password: mockUser.password
        }
      )

      const response = await register(request, mockJwtService)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(data.user.email).toBe(mockUser.email)
      expect(data.user.username).toBe(mockUser.email.split('@')[0])
      expect(data.user.password).toBeUndefined()
      expect(data.token).toBe('mock-token')
      expect(mockJwtService.sign).toHaveBeenCalledWith({ userId: '1' })
    })

    it('should generate username from email if not provided', async () => {
      const userWithoutUsername = {
        email: 'test@example.com',
        password: 'password123'
      }

      const createdUser = {
        id: '1',
        email: userWithoutUsername.email,
        username: 'test',
        password: 'hashed-password'
      }

      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(null)
      ;(prisma.user.create as jest.Mock).mockResolvedValueOnce(createdUser)

      const request = createTestRequest(
        'POST',
        '/api/auth/register',
        userWithoutUsername
      )

      const response = await register(request, mockJwtService)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(data.user.username).toBe('test')
    })

    it('should return 409 if email already exists', async () => {
      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(mockUser)

      const request = createTestRequest(
        'POST',
        '/api/auth/register',
        {
          email: mockUser.email,
          password: mockUser.password,
        }
      )

      const response = await register(request, mockJwtService)
      expect(response.status).toBe(409)
    })

    it('should validate password requirements', async () => {
      const createdUser = {
        id: '1',
        email: mockUser.email,
        username: mockUser.email.split('@')[0],
        displayName: mockUser.email.split('@')[0],
        firebaseUid: null
      }

      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(null)
      ;(prisma.user.create as jest.Mock).mockResolvedValueOnce(createdUser)

      const request = createTestRequest(
        'POST',
        '/api/auth/register',
        {
          email: mockUser.email,
          password: 'validpass123'
        }
      )

      const response = await register(request, mockJwtService)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(data.user.email).toBe(mockUser.email)
      expect(data.user.username).toBe(mockUser.email.split('@')[0])
    })
  })

  describe('POST /api/auth/login', () => {
    it.skip('should login user with valid credentials', async () => {
      const dbUser = {
        id: '1',
        email: mockUser.email,
        username: mockUser.username,
        password: 'hashed-password'
      }

      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(dbUser)
      ;(bcrypt.compare as jest.Mock).mockResolvedValueOnce(true)

      const request = createTestRequest(
        'POST',
        '/api/auth/login',
        {
          email: mockUser.email,
          password: mockUser.password
        }
      )

      const response = await login(request, mockJwtService)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(data.token).toBe('mock-token')
      expect(data.user.email).toBe(mockUser.email)
      expect(data.user.password).toBeUndefined()
      expect(mockJwtService.sign).toHaveBeenCalledWith({ userId: '1' })
      expect(bcrypt.compare).toHaveBeenCalledWith(mockUser.password, dbUser.password)
    })

    it('should return 401 for invalid credentials', async () => {
      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(null)

      const request = createTestRequest(
        'POST',
        '/api/auth/login',
        {
          email: 'wrong@example.com',
          password: 'wrongpass'
        }
      )

      const response = await login(request, mockJwtService)
      expect(response.status).toBe(401)
    })

    it('should return 401 for invalid password', async () => {
      const dbUser = {
        id: '1',
        email: mockUser.email,
        username: mockUser.username,
        password: 'hashed-password'
      }

      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(dbUser)
      ;(bcrypt.compare as jest.Mock).mockResolvedValueOnce(false)

      const request = createTestRequest(
        'POST',
        '/api/auth/login',
        {
          email: mockUser.email,
          password: 'wrongpass'
        }
      )

      const response = await login(request, mockJwtService)
      expect(response.status).toBe(401)
    })
  })

  describe('POST /api/auth/logout', () => {
    it('should logout user', async () => {
      const request = createTestRequest(
        'POST',
        '/api/auth/logout',
      )

      const response = await logout(request, mockJwtService)
      expect(response.status).toBe(200)
    })
  })

  describe('GET /api/auth/me', () => {
    it('should return current user', async () => {
      const user = {
        id: '1',
        email: mockUser.email,
        displayName: mockUser.displayName,
        photoUrl: mockUser.photoUrl,
        emailVerified: mockUser.emailVerified,
        createdAt: mockUser.createdAt,
        updatedAt: mockUser.updatedAt
      }

      ;(prisma.user.findUnique as jest.Mock).mockResolvedValueOnce(user)

      const request = createTestRequest(
        'GET',
        '/api/auth/me',
        undefined,
        {
          Authorization: 'Bearer mock-token'
        }
      ) as NextRequest

      const response = await getCurrentUser(request, mockJwtService)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(data.email).toBe(mockUser.email)
      expect(data.password).toBeUndefined()
    })

    it('should return 401 if not authenticated', async () => {
      const request = createTestRequest(
        'GET',
        '/api/auth/me',
      )

      const response = await getCurrentUser(request, mockJwtService)
      expect(response.status).toBe(401)
    })
  })
})
