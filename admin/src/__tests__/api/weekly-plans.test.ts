import { describe, expect, it, beforeEach, afterEach } from '@jest/globals';
import { GET, POST, PUT, DELETE } from '@/app/api/weekly-plans/route';
import { verifyAuth } from '@/lib/auth';
import { prisma } from '@/lib/prisma';
import { clearTestData, createMockUser, createMockRequest } from '../utils/test-utils';
import { prismaMock } from '../../../jest.setup';

// Mock auth
jest.mock('@/lib/auth');
const mockVerifyAuth = verifyAuth as jest.MockedFunction<typeof verifyAuth>;

describe('Weekly Plans API', () => {
  const userId = '123e4567-e89b-12d3-a456-426614174000';
  const weekStartDate = new Date('2025-01-20'); // A Monday

  beforeEach(async () => {
    await clearTestData();
    await createMockUser(userId);
    mockVerifyAuth.mockResolvedValue(userId);
  });

  afterEach(async () => {
    await clearTestData();
    jest.clearAllMocks();
  });

  describe('GET /api/weekly-plans', () => {
    it('should get weekly plan for specific date', async () => {
      // Create a test weekly plan
      const plan = {
        id: 'plan-123',
        userId,
        weekStartDate,
        mealPlans: [],
      };
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(plan);

      const req = createMockRequest(
        new URL(`http://localhost:3000/api/weekly-plans?weekStartDate=${weekStartDate.toISOString()}`)
      );
      const res = await GET(req);
      const data = await res.json();

      expect(res.status).toBe(200);
      expect(data).toBeDefined();
      expect(data.id).toBe(plan.id);
      expect(new Date(data.weekStartDate)).toEqual(weekStartDate);
    });

    it('should return 404 if no plan exists for date', async () => {
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(null);

      const req = createMockRequest(
        new URL(`http://localhost:3000/api/weekly-plans?weekStartDate=${weekStartDate.toISOString()}`)
      );
      const res = await GET(req);

      expect(res.status).toBe(404);
    });

    it('should return 401 if not authenticated', async () => {
      mockVerifyAuth.mockResolvedValueOnce(null);

      const req = createMockRequest(
        new URL(`http://localhost:3000/api/weekly-plans?weekStartDate=${weekStartDate.toISOString()}`)
      );
      const res = await GET(req);

      expect(res.status).toBe(401);
    });
  });

  describe('POST /api/weekly-plans', () => {
    it('should create a new weekly plan', async () => {
      const plan = {
        id: 'plan-123',
        userId,
        weekStartDate,
        mealPlans: [],
      };
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(null);
      prismaMock.weeklyPlan.create.mockResolvedValue(plan);

      const req = createMockRequest('http://localhost:3000/api/weekly-plans', {
        method: 'POST',
        body: JSON.stringify({
          weekStartDate: weekStartDate.toISOString(),
        }),
      });
      const res = await POST(req);
      const data = await res.json();

      expect(res.status).toBe(200);
      expect(data).toBeDefined();
      expect(data.userId).toBe(userId);
      expect(new Date(data.weekStartDate)).toEqual(weekStartDate);
    });

    it('should return 409 if plan already exists for week', async () => {
      const existingPlan = {
        id: 'plan-123',
        userId,
        weekStartDate,
        mealPlans: [],
      };
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(existingPlan);

      const req = createMockRequest('http://localhost:3000/api/weekly-plans', {
        method: 'POST',
        body: JSON.stringify({
          weekStartDate: weekStartDate.toISOString(),
        }),
      });
      const res = await POST(req);

      expect(res.status).toBe(409);
    });

    it('should return 401 if not authenticated', async () => {
      mockVerifyAuth.mockResolvedValueOnce(null);

      const req = createMockRequest('http://localhost:3000/api/weekly-plans', {
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
      const plan = {
        id: 'plan-123',
        userId,
        weekStartDate,
        mealPlans: [],
      };
      const newStartDate = new Date('2025-01-27'); // Next Monday
      const updatedPlan = { ...plan, weekStartDate: newStartDate };
      
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(plan);
      prismaMock.weeklyPlan.update.mockResolvedValue(updatedPlan);

      const req = createMockRequest('http://localhost:3000/api/weekly-plans', {
        method: 'PUT',
        body: JSON.stringify({
          id: plan.id,
          weekStartDate: newStartDate.toISOString(),
        }),
      });
      const res = await PUT(req);
      const data = await res.json();

      expect(res.status).toBe(200);
      expect(data).toBeDefined();
      expect(data.id).toBe(plan.id);
      expect(new Date(data.weekStartDate)).toEqual(newStartDate);
    });

    it('should return 404 if plan not found', async () => {
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(null);

      const req = createMockRequest('http://localhost:3000/api/weekly-plans', {
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
      mockVerifyAuth.mockResolvedValueOnce(null);

      const req = createMockRequest('http://localhost:3000/api/weekly-plans', {
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
      const plan = {
        id: 'plan-123',
        userId,
        weekStartDate,
        mealPlans: [],
      };
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(plan);
      prismaMock.weeklyPlan.delete.mockResolvedValue(plan);

      const req = createMockRequest(
        new URL(`http://localhost:3000/api/weekly-plans?id=${plan.id}`)
      );
      const res = await DELETE(req);

      expect(res.status).toBe(200);
    });

    it('should return 404 if plan not found', async () => {
      prismaMock.weeklyPlan.findFirst.mockResolvedValue(null);

      const req = createMockRequest(
        new URL('http://localhost:3000/api/weekly-plans?id=non-existent-id')
      );
      const res = await DELETE(req);

      expect(res.status).toBe(404);
    });

    it('should return 401 if not authenticated', async () => {
      mockVerifyAuth.mockResolvedValueOnce(null);

      const req = createMockRequest(
        new URL('http://localhost:3000/api/weekly-plans?id=some-id')
      );
      const res = await DELETE(req);

      expect(res.status).toBe(401);
    });
  });
});
