import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { verify } from 'jsonwebtoken';
import { cookies } from 'next/headers';
import { z } from 'zod';

const profileSchema = z.object({
  displayName: z.string().optional(),
  photoUrl: z.string().url().optional(),
});

export async function PATCH(request: NextRequest) {
  try {
    // Get token from cookie
    const token = cookies().get('auth-token')?.value;
    if (!token) {
      return NextResponse.json(
        { error: 'Not authenticated' },
        { status: 401 }
      );
    }

    // Verify token
    const decoded = verify(token, process.env.JWT_SECRET || 'default-secret') as { userId: string };
    
    // Get request body
    const body = await request.json();
    const updates = profileSchema.parse(body);

    // Update user
    const user = await prisma.user.update({
      where: { id: decoded.userId },
      data: {
        ...updates,
        updatedAt: new Date(),
      },
      select: {
        id: true,
        email: true,
        displayName: true,
        photoUrl: true,
        emailVerified: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    return NextResponse.json(user);
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid request data' },
        { status: 400 }
      );
    }
    return NextResponse.json(
      { error: 'Failed to update profile' },
      { status: 500 }
    );
  }
}
