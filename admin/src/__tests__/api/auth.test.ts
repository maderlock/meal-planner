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

import { describe, expect, it, beforeEach } from '@jest/globals';
import { prismaMock } from '../../../jest.setup';
import { NextRequest } from 'next/server';
import { POST as register } from '@/app/api/auth/register/route';
import { POST as login } from '@/app/api/auth/login/route';
import { POST as logout } from '@/app/api/auth/logout/route';
import { GET as getCurrentUser } from '@/app/api/auth/me/route';
import { POST as resetPassword } from '@/app/api/auth/reset-password/route';
import { PATCH as updateProfile } from '@/app/api/auth/profile/route';
import bcrypt from 'bcryptjs';

describe('Auth API', () => {
  const mockUser = {
    id: '1',
    email: 'test@example.com',
    password: bcrypt.hashSync('password123', 10),
    displayName: 'Test User',
    photoUrl: 'https://example.com/photo.jpg',
    emailVerified: false,
    createdAt: new Date(),
    updatedAt: new Date(),
  };

  beforeEach(() => {
    prismaMock.user.findUnique.mockReset();
    prismaMock.user.create.mockReset();
    prismaMock.user.update.mockReset();
  });

  describe('POST /api/auth/register', () => {
    it('should register a new user', async () => {
      prismaMock.user.findUnique.mockResolvedValue(null);
      prismaMock.user.create.mockResolvedValue(mockUser);

      const request = new NextRequest('http://localhost:3000/api/auth/register', {
        method: 'POST',
        body: JSON.stringify({
          email: 'test@example.com',
          password: 'password123',
        }),
      });

      const response = await register(request);
      const data = await response.json();

      expect(response.status).toBe(201);
      expect(data.email).toBe(mockUser.email);
      expect(data.password).toBeUndefined();
    });

    it('should return 409 if email already exists', async () => {
      prismaMock.user.findUnique.mockResolvedValue(mockUser);

      const request = new NextRequest('http://localhost:3000/api/auth/register', {
        method: 'POST',
        body: JSON.stringify({
          email: 'test@example.com',
          password: 'password123',
        }),
      });

      const response = await register(request);
      expect(response.status).toBe(409);
    });
  });

  describe('POST /api/auth/login', () => {
    it('should login user with valid credentials', async () => {
      prismaMock.user.findUnique.mockResolvedValue(mockUser);

      const request = new NextRequest('http://localhost:3000/api/auth/login', {
        method: 'POST',
        body: JSON.stringify({
          email: 'test@example.com',
          password: 'password123',
        }),
      });

      const response = await login(request);
      const data = await response.json();

      expect(response.status).toBe(200);
      expect(data.email).toBe(mockUser.email);
      expect(data.password).toBeUndefined();
    });

    it('should return 401 for invalid credentials', async () => {
      prismaMock.user.findUnique.mockResolvedValue(mockUser);

      const request = new NextRequest('http://localhost:3000/api/auth/login', {
        method: 'POST',
        body: JSON.stringify({
          email: 'test@example.com',
          password: 'wrongpassword',
        }),
      });

      const response = await login(request);
      expect(response.status).toBe(401);
    });
  });

  describe('GET /api/auth/me', () => {
    it('should return current user', async () => {
      prismaMock.user.findUnique.mockResolvedValue(mockUser);

      const request = new NextRequest('http://localhost:3000/api/auth/me', {
        method: 'GET',
      });

      const response = await getCurrentUser(request);
      const data = await response.json();

      expect(response.status).toBe(200);
      expect(data.email).toBe(mockUser.email);
      expect(data.password).toBeUndefined();
    });

    it('should return 401 if not authenticated', async () => {
      prismaMock.user.findUnique.mockResolvedValue(null);

      const request = new NextRequest('http://localhost:3000/api/auth/me', {
        method: 'GET',
      });

      const response = await getCurrentUser(request);
      expect(response.status).toBe(401);
    });
  });

  describe('PATCH /api/auth/profile', () => {
    it('should update user profile', async () => {
      const updatedUser = {
        ...mockUser,
        displayName: 'Updated Name',
        photoUrl: 'https://example.com/new-photo.jpg',
      };

      prismaMock.user.findUnique.mockResolvedValue(mockUser);
      prismaMock.user.update.mockResolvedValue(updatedUser);

      const request = new NextRequest('http://localhost:3000/api/auth/profile', {
        method: 'PATCH',
        body: JSON.stringify({
          displayName: 'Updated Name',
          photoUrl: 'https://example.com/new-photo.jpg',
        }),
      });

      const response = await updateProfile(request);
      const data = await response.json();

      expect(response.status).toBe(200);
      expect(data.displayName).toBe(updatedUser.displayName);
      expect(data.photoUrl).toBe(updatedUser.photoUrl);
      expect(data.password).toBeUndefined();
    });

    it('should return 401 if not authenticated', async () => {
      prismaMock.user.findUnique.mockResolvedValue(null);

      const request = new NextRequest('http://localhost:3000/api/auth/profile', {
        method: 'PATCH',
        body: JSON.stringify({
          displayName: 'Updated Name',
        }),
      });

      const response = await updateProfile(request);
      expect(response.status).toBe(401);
    });
  });

  describe('POST /api/auth/reset-password', () => {
    it('should initiate password reset', async () => {
      prismaMock.user.findUnique.mockResolvedValue(mockUser);

      const request = new NextRequest('http://localhost:3000/api/auth/reset-password', {
        method: 'POST',
        body: JSON.stringify({
          email: 'test@example.com',
        }),
      });

      const response = await resetPassword(request);
      expect(response.status).toBe(200);
    });

    it('should return 404 if user not found', async () => {
      prismaMock.user.findUnique.mockResolvedValue(null);

      const request = new NextRequest('http://localhost:3000/api/auth/reset-password', {
        method: 'POST',
        body: JSON.stringify({
          email: 'nonexistent@example.com',
        }),
      });

      const response = await resetPassword(request);
      expect(response.status).toBe(404);
    });
  });

  describe('POST /api/auth/logout', () => {
    it('should logout user', async () => {
      const request = new NextRequest('http://localhost:3000/api/auth/logout', {
        method: 'POST',
      });

      const response = await logout(request);
      expect(response.status).toBe(200);
    });
  });
});
