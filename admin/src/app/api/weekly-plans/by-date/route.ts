/**
 * Weekly Plans By Date API
 * 
 * Handles retrieving weekly plans by their start date.
 */

import { NextRequest, NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { verifyAuth } from '@/lib/auth'
import { isValidWeekStart } from '@/lib/date-utils'

export async function GET(request: NextRequest) {
  try {
    console.log('GET /api/weekly-plans/by-date - Request received');
    
    // Verify authentication
    const userId = await verifyAuth(request);
    console.log('Authentication result:', { userId });
    
    if (!userId) {
      console.log('Unauthorized - no valid userId');
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    // Get query parameters
    const { searchParams } = new URL(request.url);
    const weekStartDate = searchParams.get('weekStartDate');
    
    if (!weekStartDate) {
      return NextResponse.json(
        { error: "weekStartDate is required" },
        { status: 400 }
      );
    }

    // Validate date
    const parsedDate = new Date(weekStartDate);
    if (isNaN(parsedDate.getTime())) {
      return NextResponse.json(
        { error: "Invalid weekStartDate" },
        { status: 400 }
      );
    }

    if (!isValidWeekStart(parsedDate)) {
      return NextResponse.json(
        { error: "weekStartDate must be a Monday at 00:00:00" },
        { status: 400 }
      );
    }

    // Get plan for specific week
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

    // Map numeric days to day names for the mobile app
    const dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const formattedPlan = {
      ...weeklyPlan,
      mealPlans: weeklyPlan.mealPlans.map(plan => ({
        ...plan,
        day: dayNames[plan.dayOfWeek],
        type: plan.mealType,
      }))
    };

    return NextResponse.json(formattedPlan);
  } catch (error) {
    console.error('Error fetching weekly plan:', error);
    return NextResponse.json(
      { error: 'Failed to fetch weekly plan' },
      { status: 500 }
    );
  }
}
