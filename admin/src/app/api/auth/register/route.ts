import { Request, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import bcrypt from 'bcryptjs';
import { z } from 'zod';
import { jwtService, JWTService } from '@/lib/jwt';

const registerSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  username: z.string().optional(),
});

export async function POST(
  request: Request,
  jwtSvc: JWTService = jwtService
) {
  try {
    const body = await request.json();
    const validatedData = registerSchema.parse(body);

    // Check if user already exists
    const existingUser = await prisma.user.findUnique({
      where: { email: validatedData.email }
    });

    if (existingUser) {
      return NextResponse.json(
        { error: 'Email already exists' },
        { status: 409 }
      );
    }

    // Generate username from email if not provided
    if (!validatedData.username) {
      validatedData.username = validatedData.email.split('@')[0];
    }

    // Hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(validatedData.password, salt);

    // Create user
    const user = await prisma.user.create({
      data: {
        email: validatedData.email,
        username: validatedData.username,
        password: hashedPassword,
        displayName: validatedData.username,
        firebaseUid: null,
      },
      select: {
        id: true,
        email: true,
        username: true,
        displayName: true,
        firebaseUid: true,
      }
    });

    // Generate JWT token
    const token = jwtSvc.sign({ userId: user.id });

    // Return user data (excluding password) and token
    return NextResponse.json(
      {
        user: {
          ...user,
          password: undefined
        },
        token
      },
      { status: 201 }
    );
  } catch (error) {
    console.error('Registration error:', error);

    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input data' },
        { status: 400 }
      );
    }

    return NextResponse.json(
      { error: 'Failed to register user' },
      { status: 500 }
    );
  }
}
