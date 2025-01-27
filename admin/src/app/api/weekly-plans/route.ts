/**
 * Weekly Plans API
 * 
 * Handles weekly meal planning functionality.
 * Supports CRUD operations for weekly plans.
 * 
 * Endpoints:
 * - GET: Retrieves user's weekly plans
 * - POST: Creates a new weekly plan
 * - PUT: Updates an existing plan
 * - DELETE: Removes a plan
 * 
 * Features:
 * - Automatic date range calculation
 * - Meal assignment validation
 * - User-specific plan isolation
 * 
 * Used By:
 * - WeeklyPlansPage: Admin dashboard weekly planning interface
 * - meal_planner.dart: Mobile app weekly plan view
 * - meal_service.dart: Mobile app service integration
 */

import { NextRequest, NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { verifyAuth } from '@/lib/auth'
import { jwtService } from '@/lib/jwt'
import { z } from 'zod'
import { isValidWeekStart, getWeekStart, toMidnightIsoString } from '@/lib/date-utils'

// Schema for weekly plan creation
const weeklyPlanSchema = z.object({
  weekStartDate: z.coerce.date().refine(
    (date) => isValidWeekStart(date),
    { message: "weekStartDate must be a Monday at 00:00:00" }
  ),
})

const mealAssignmentSchema = z.object({
  mealId: z.string().uuid(),
  day: z.string(),
  type: z.enum(["breakfast", "lunch", "dinner"]),
  notes: z.string().optional(),
})

export async function GET(request: NextRequest) {
  try {
    console.log('GET /api/weekly-plans - Request received');
    
    // Verify authentication
    const userId = await verifyAuth(request);
    console.log('Authentication result:', { userId });
    
    if (!userId) {
      console.log('Unauthorized - no valid userId');
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    // Get query parameters
    const url = new URL(request.url);
    const weekStartDateParam = url.searchParams.get('weekStartDate');
    
    // If weekStartDate is provided, validate it
    if (weekStartDateParam) {
      const date = new Date(weekStartDateParam);
      if (!isValidWeekStart(date)) {
        return NextResponse.json(
          { error: "weekStartDate must be a Monday at 00:00:00" },
          { status: 400 }
        );
      }
    }

    const { searchParams } = new URL(request.url)
    const weekStartDate = searchParams.get('weekStartDate')

    if (weekStartDate) {
      // Get plan for specific week
      const parsedDate = new Date(weekStartDate);
      if (isNaN(parsedDate.getTime())) {
        return NextResponse.json(
          { error: "Invalid weekStartDate" },
          { status: 400 }
        );
      }

      const weeklyPlan = await prisma.weeklyPlan.findFirst({
        where: {
          userId,
          weekStartDate: parsedDate,
        },
        include: {
          mealPlans: {
            include: {
              meal: true
            }
          }
        }
      });

      if (!weeklyPlan) {
        return NextResponse.json(
          { error: "Weekly plan not found" },
          { status: 404 }
        );
      }

      return NextResponse.json(weeklyPlan);
    }

    // Get all plans
    const weeklyPlans = await prisma.weeklyPlan.findMany({
      where: {
        userId
      },
      include: {
        mealPlans: {
          include: {
            meal: true
          }
        }
      },
      orderBy: {
        weekStartDate: "desc",
      },
    });

    return NextResponse.json(weeklyPlans);
  } catch (error) {
    console.error('Error fetching weekly plan:', error)
    return NextResponse.json(
      { error: 'Failed to fetch weekly plan' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    // Verify authentication
    const userId = await verifyAuth(request)
    if (!userId) {
      console.log('POST /api/weekly-plans: No session found');
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    console.log('POST /api/weekly-plans: Session user:', userId);

    try {
      const body = await request.json();
      console.log('POST /api/weekly-plans: Request body:', body);
      
      // Parse and validate weekStartDate
      const { weekStartDate } = weeklyPlanSchema.parse(body);
      console.log('POST /api/weekly-plans: Parsed weekStartDate:', weekStartDate);

      // Additional validation to ensure it's a Monday at midnight
      if (!isValidWeekStart(weekStartDate)) {
        return NextResponse.json(
          { error: "weekStartDate must be a Monday at 00:00:00" },
          { status: 400 }
        );
      }

      // Verify user exists
      console.log('POST /api/weekly-plans: Looking up user with ID:', userId);
      const user = await prisma.user.findUnique({
        where: { id: userId }
      });

      if (!user) {
        console.log('POST /api/weekly-plans: User not found:', userId);
        return NextResponse.json(
          { error: "User not found" },
          { status: 404 }
        );
      }

      // Check if plan already exists for this week
      const existingPlan = await prisma.weeklyPlan.findFirst({
        where: {
          userId,
          weekStartDate,
        },
      });

      console.log('POST /api/weekly-plans: Existing plan check:', existingPlan);

      if (existingPlan) {
        return NextResponse.json(
          { error: "Plan already exists for this week" },
          { status: 409 }
        );
      }

      // Create new plan with validated date
      const weeklyPlan = await prisma.weeklyPlan.create({
        data: {
          userId,
          weekStartDate: toMidnightIsoString(weekStartDate),
        },
        include: {
          mealPlans: {
            include: {
              meal: true
            }
          }
        },
      });

      console.log('POST /api/weekly-plans: Created plan:', weeklyPlan);

      return NextResponse.json(weeklyPlan);
    } catch (error) {
      if (error instanceof z.ZodError) {
        console.error('POST /api/weekly-plans: Validation error:', error.errors);
        return NextResponse.json({ error: error.errors }, { status: 400 });
      }
      console.error('POST /api/weekly-plans: Database error:', error);
      return NextResponse.json(
        { error: "Failed to create weekly plan", details: error instanceof Error ? error.message : String(error) },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error('POST /api/weekly-plans: Unexpected error:', error);
    return NextResponse.json(
      { error: "Internal server error", details: error instanceof Error ? error.message : String(error) },
      { status: 500 }
    );
  }
}

export async function PUT(request: NextRequest) {
  try {
    const userId = await verifyAuth(request)
    if (!userId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    const body = await request.json()
    const { id } = body;

    if (!id) {
      return NextResponse.json({ error: "Missing id" }, { status: 400 });
    }

    // Verify plan exists and belongs to user
    const existingPlan = await prisma.weeklyPlan.findFirst({
      where: {
        id,
        userId
      },
    });

    if (!existingPlan) {
      return NextResponse.json(
        { error: "Weekly plan not found" },
        { status: 404 }
      );
    }

    // Update plan
    const weeklyPlan = await prisma.weeklyPlan.update({
      where: { id },
      data: {
        weekStartDate: body.weekStartDate || undefined,
      },
      include: {
        mealPlans: {
          include: {
            meal: true
          }
        }
      },
    });

    return NextResponse.json(weeklyPlan)
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json({ error: error.errors }, { status: 400 });
    }
    return NextResponse.json(
      { error: "Failed to update weekly plan" },
      { status: 500 }
    )
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const userId = await verifyAuth(request)
    if (!userId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    const { searchParams } = new URL(request.url)
    const id = searchParams.get('id')

    if (!id) {
      return NextResponse.json({ error: "Missing id" }, { status: 400 });
    }

    try {
      // Verify plan exists and belongs to user
      const existingPlan = await prisma.weeklyPlan.findFirst({
        where: {
          id,
          userId
        },
      });

      if (!existingPlan) {
        return NextResponse.json(
          { error: "Weekly plan not found" },
          { status: 404 }
        );
      }

      // Delete plan
      await prisma.weeklyPlan.delete({
        where: { id },
      });

      return NextResponse.json({ success: true });
    } catch (error) {
      return NextResponse.json(
        { error: "Failed to delete weekly plan" },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error('Error deleting weekly plan:', error)
    return NextResponse.json(
      { error: 'Failed to delete weekly plan' },
      { status: 500 }
    )
  }
}
