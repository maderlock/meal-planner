import { describe, expect, it, beforeEach, afterEach } from '@jest/globals';
import { GET, POST, PUT, DELETE } from '@/app/api/weekly-plans/route';
import { NextRequest } from 'next/server';
import { auth } from '@/lib/auth';
import { db } from '@/lib/prisma';
import { clearTestData, createMockUser } from '../utils/test-utils';

// Mock auth
jest.mock('@/lib/auth');
const mockAuth = auth as jest.MockedFunction<typeof auth>;

describe('Weekly Plans API', () => {
  const userId = '123e4567-e89b-12d3-a456-426614174000';
  const weekStartDate = new Date('2025-01-20'); // A Monday

  beforeEach(async () => {
    await clearTestData();
    await createMockUser(userId);
    mockAuth.mockResolvedValue({
      user: { id: userId, email: 'test@example.com' },
    });
  });

  afterEach(async () => {
    await clearTestData();
    jest.clearAllMocks();
  });

  describe('GET /api/weekly-plans', () => {
    it('should get weekly plan for specific date', async () => {
      // Create a test plan
      const plan = await db.weeklyPlan.create({
        data: {
          userId,
          weekStartDate,
        },
      });

      const req = new NextRequest(
        new URL(`http://localhost:3000/api/weekly-plans?weekStartDate=${weekStartDate.toISOString()}`)
      );
      const res = await GET(req);
      const data = await res.json();

      expect(res.status).toBe(200);
      expect(data.id).toBe(plan.id);
      expect(new Date(data.weekStartDate)).toEqual(weekStartDate);
    });

    it('should return 404 if no plan exists for date', async () => {
      const req = new NextRequest(
        new URL(`http://localhost:3000/api/weekly-plans?weekStartDate=${weekStartDate.toISOString()}`)
      );
      const res = await GET(req);

      expect(res.status).toBe(404);
    });

    it('should return 401 if not authenticated', async () => {
      mockAuth.mockResolvedValueOnce(null);

      const req = new NextRequest(
        new URL(`http://localhost:3000/api/weekly-plans?weekStartDate=${weekStartDate.toISOString()}`)
      );
      const res = await GET(req);

      expect(res.status).toBe(401);
    });
  });

  describe('POST /api/weekly-plans', () => {
    it('should create a new weekly plan', async () => {
      const req = new NextRequest('http://localhost:3000/api/weekly-plans', {
        method: 'POST',
        body: JSON.stringify({
          weekStartDate: weekStartDate.toISOString(),
        }),
      });

      const res = await POST(req);
      const data = await res.json();

      expect(res.status).toBe(200);
      expect(data.userId).toBe(userId);
      expect(new Date(data.weekStartDate)).toEqual(weekStartDate);
    });

    it('should return 409 if plan already exists for week', async () => {
      // Create initial plan
      await db.weeklyPlan.create({
        data: {
          userId,
          weekStartDate,
        },
      });

      const req = new NextRequest('http://localhost:3000/api/weekly-plans', {
        method: 'POST',
        body: JSON.stringify({
          weekStartDate: weekStartDate.toISOString(),
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(409);
    });

    it('should return 401 if not authenticated', async () => {
      mockAuth.mockResolvedValueOnce(null);

      const req = new NextRequest('http://localhost:3000/api/weekly-plans', {
        method: 'POST',
        body: JSON.stringify({
          weekStartDate: weekStartDate.toISOString(),
        }),
      });

      const res = await POST(req);
      expect(res.status).toBe(401);
    });
  });

  describe('PUT /api/weekly-plans', () => {
    it('should update weekly plan', async () => {
      // Create a test plan
      const plan = await db.weeklyPlan.create({
        data: {
          userId,
          weekStartDate,
        },
      });

      const newStartDate = new Date('2025-01-27'); // Next week
      const req = new NextRequest('http://localhost:3000/api/weekly-plans', {
        method: 'PUT',
        body: JSON.stringify({
          id: plan.id,
          weekStartDate: newStartDate.toISOString(),
        }),
      });

      const res = await PUT(req);
      const data = await res.json();

      expect(res.status).toBe(200);
      expect(new Date(data.weekStartDate)).toEqual(newStartDate);
    });

    it('should return 404 if plan not found', async () => {
      const req = new NextRequest('http://localhost:3000/api/weekly-plans', {
        method: 'PUT',
        body: JSON.stringify({
          id: 'non-existent-id',
          weekStartDate: weekStartDate.toISOString(),
        }),
      });

      const res = await PUT(req);
      expect(res.status).toBe(404);
    });

    it('should return 401 if not authenticated', async () => {
      mockAuth.mockResolvedValueOnce(null);

      const req = new NextRequest('http://localhost:3000/api/weekly-plans', {
        method: 'PUT',
        body: JSON.stringify({
          id: 'some-id',
          weekStartDate: weekStartDate.toISOString(),
        }),
      });

      const res = await PUT(req);
      expect(res.status).toBe(401);
    });
  });

  describe('DELETE /api/weekly-plans', () => {
    it('should delete weekly plan', async () => {
      // Create a test plan
      const plan = await db.weeklyPlan.create({
        data: {
          userId,
          weekStartDate,
        },
      });

      const req = new NextRequest(
        new URL(`http://localhost:3000/api/weekly-plans?id=${plan.id}`)
      );
      const res = await DELETE(req);

      expect(res.status).toBe(200);
      const deletedPlan = await db.weeklyPlan.findUnique({
        where: { id: plan.id },
      });
      expect(deletedPlan).toBeNull();
    });

    it('should return 404 if plan not found', async () => {
      const req = new NextRequest(
        new URL('http://localhost:3000/api/weekly-plans?id=non-existent-id')
      );
      const res = await DELETE(req);

      expect(res.status).toBe(404);
    });

    it('should return 401 if not authenticated', async () => {
      mockAuth.mockResolvedValueOnce(null);

      const req = new NextRequest(
        new URL('http://localhost:3000/api/weekly-plans?id=some-id')
      );
      const res = await DELETE(req);

      expect(res.status).toBe(401);
    });
  });
});
