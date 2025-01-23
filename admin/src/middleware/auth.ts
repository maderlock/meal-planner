import { Request, Response, NextFunction } from 'express';
import { PrismaClient } from '@prisma/client';
import { auth } from 'firebase-admin';

const prisma = new PrismaClient();

declare global {
  namespace Express {
    interface Request {
      user?: {
        id: string;
        email: string;
        firebaseUid: string;
      };
    }
  }
}

export const authenticateUser = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader?.startsWith('Bearer ')) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const token = authHeader.split('Bearer ')[1];
    const decodedToken = await auth().verifyIdToken(token);

    const user = await prisma.user.findUnique({
      where: { firebaseUid: decodedToken.uid },
    });

    if (!user) {
      return res.status(401).json({ error: 'User not found' });
    }

    req.user = {
      id: user.id,
      email: user.email,
      firebaseUid: user.firebaseUid,
    };

    next();
  } catch (error) {
    console.error('Authentication error:', error);
    res.status(401).json({ error: 'Invalid token' });
  }
};
