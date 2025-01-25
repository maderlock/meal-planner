import { db } from '@/lib/prisma';

export async function clearTestData() {
  await db.weeklyPlan.deleteMany();
  await db.user.deleteMany();
}

export async function createMockUser(id: string) {
  return await db.user.create({
    data: {
      id,
      email: 'test@example.com',
      username: 'testuser',
      firebaseUid: 'firebase-123',
    },
  });
}
