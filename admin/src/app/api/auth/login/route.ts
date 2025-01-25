/**
 * Authentication Login API Route
 * 
 * Handles user login requests and session management.
 * 
 * Endpoint: POST /api/auth/login
 * 
 * Request Body:
 * - email: User's email address
 * - password: User's password
 * 
 * Response:
 * - 200: Returns user data and token
 * - 401: Invalid credentials
 * - 500: Server error
 * 
 * Used By:
 * - Mobile app authentication
 * - Admin dashboard login
 * 
 * Related Files:
 * - auth.test.ts: API tests
 * - auth_service.dart: Mobile app integration
 */

import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import bcrypt from 'bcryptjs';
import { z } from 'zod';
import { jwtService } from '@/lib/jwt';

const loginSchema = z.object({
  email: z.string().email(),
  password: z.string(),
});

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const validatedData = loginSchema.parse(body);
    console.log('Login attempt:', { email: validatedData.email })

    // Find user by email
    const user = await prisma.user.findUnique({
      where: { email: validatedData.email },
      select: {
        id: true,
        email: true,
        username: true,
        password: true
      }
    });
    console.log('Found user:', { user })

    if (!user) {
      return NextResponse.json(
        { error: 'Invalid credentials' },
        { status: 401 }
      );
    }

    // Verify password
    const isValidPassword = await bcrypt.compare(validatedData.password, user.password);
    console.log('Password verification:', { isValidPassword })
    
    if (!isValidPassword) {
      return NextResponse.json(
        { error: 'Invalid credentials' },
        { status: 401 }
      );
    }

    // Generate JWT token
    const token = jwtService.sign({ userId: user.id });
    console.log('Generated token:', token);
    console.log('Token payload:', { userId: user.id });

    // Return user data (excluding password) and token
    const { password: _, ...userWithoutPassword } = user;
    return NextResponse.json({
      user: userWithoutPassword,
      token
    });
  } catch (error) {
    console.error('Login error:', error);

    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input data' },
        { status: 400 }
      );
    }

    return NextResponse.json(
      { error: 'Failed to log in' },
      { status: 500 }
    );
  }
}
