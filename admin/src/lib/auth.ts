import { NextRequest } from 'next/server'
import { jwtService } from './jwt'

/**
 * Verifies the authentication token from the request headers
 * Returns the userId if valid, null otherwise
 */
export async function verifyAuth(
  request: NextRequest,
): Promise<string | null> {
  try {
    console.log('Headers:', Object.fromEntries(request.headers.entries()));
    const authHeader = request.headers.get('Authorization');
    console.log('Auth header:', authHeader);
    
    if (!authHeader?.startsWith('Bearer ')) {
      console.log('No Bearer token found in header');
      return null;
    }

    const token = authHeader.split(' ')[1];
    console.log('Extracted token:', token.substring(0, 20) + '...');
    
    try {
      const decoded = jwtService.verify(token) as { userId: string };
      console.log('Token verified successfully for user:', decoded.userId);
      return decoded.userId;
    } catch (jwtError) {
      console.error('JWT verification failed:', jwtError);
      return null;
    }
  } catch (error) {
    console.error('Auth verification error:', error);
    return null;
  }
}
