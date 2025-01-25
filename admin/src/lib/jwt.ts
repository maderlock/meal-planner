import * as jwt from 'jsonwebtoken';

export interface JWTService {
  sign(payload: any): string;
  verify(token: string): any;
}

export class DefaultJWTService implements JWTService {
  constructor(private secret: string) {
    console.log('JWT Service initialized with secret length:', secret.length);
  }
  
  sign(payload: any): string {
    console.log('Signing JWT with payload:', payload);
    const token = jwt.sign(payload, this.secret, { expiresIn: '7d' });
    console.log('Generated JWT:', token);
    return token;
  }
  
  verify(token: string): any {
    try {
      console.log('Verifying JWT:', token);
      const decoded = jwt.verify(token, this.secret);
      console.log('JWT verification successful:', decoded);
      return decoded;
    } catch (error) {
      console.error('JWT verification failed:', error);
      throw error;
    }
  }
}

// Production instance
const secret = process.env.JWT_SECRET || 'default-secret';
console.log('Using JWT secret:', secret.substring(0, 3) + '...');
export const jwtService = new DefaultJWTService(secret);
