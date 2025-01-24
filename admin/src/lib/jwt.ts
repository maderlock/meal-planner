import * as jwt from 'jsonwebtoken';

export interface JWTService {
  sign(payload: any): string;
  verify(token: string): any;
}

export class DefaultJWTService implements JWTService {
  constructor(private secret: string) {}
  
  sign(payload: any): string {
    return jwt.sign(payload, this.secret, { expiresIn: '7d' });
  }
  
  verify(token: string): any {
    return jwt.verify(token, this.secret);
  }
}

// Production instance
export const jwtService = new DefaultJWTService(process.env.JWT_SECRET || 'default-secret');
