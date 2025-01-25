import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { jwtService } from '@/lib/jwt';

export async function GET(request: NextRequest) {
  try {
    // Get token from Authorization header
    const authHeader = request.headers.get('Authorization');
    console.log('Auth header:', authHeader);
    
    if (!authHeader?.startsWith('Bearer ')) {
      console.log('Invalid auth header format');
      return NextResponse.json(
        { error: 'Not authenticated - Invalid header format' },
        { status: 401 }
      );
    }

    const token = authHeader.split(' ')[1];
    console.log('Extracted token:', token);
    
    try {
      // Verify token
      const decoded = jwtService.verify(token) as { userId: string };
      console.log('Decoded token:', decoded);
      
      // Get user
      const user = await prisma.user.findUnique({
        where: { id: decoded.userId },
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

      console.log('Found user:', user ? 'yes' : 'no');

      if (!user) {
        console.log('User not found for id:', decoded.userId);
        return NextResponse.json(
          { error: 'User not found' },
          { status: 401 }
        );
      }

      return NextResponse.json(user, { status: 200 });
    } catch (verifyError) {
      console.error('Token verification failed:', verifyError);
      return NextResponse.json(
        { error: 'Invalid token' },
        { status: 401 }
      );
    }
  } catch (error) {
    console.error('Unexpected error in /me endpoint:', error);
    return NextResponse.json(
      { error: 'Not authenticated - Server error' },
      { status: 401 }
    );
  }
}
