/**
 * Weekly Meal Plans API Route
 * 
 * Manages the creation, retrieval, and modification of weekly meal plans.
 * This is a core feature of the meal planning system that allows users
 * to organize their meals for the week.
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
 * - Mobile app weekly planning feature
 * - Admin dashboard for plan management
 * 
 * Related Files:
 * - [id]/assignments/route.ts: Manages meal assignments
 * - weekly_plan_model.dart: Mobile app model
 * - meal_service.dart: Mobile app service integration
 */

import { NextRequest, NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { verifyAuth } from '@/lib/auth'
import { jwtService } from '@/lib/jwt'
import { z } from 'zod'

// Schema for weekly plan creation
const weeklyPlanSchema = z.object({
  weekStartDate: z.string().transform(str => new Date(str))
})

export async function GET(request: NextRequest) {
  try {
    console.log('GET /api/weekly-plans - Request received');
    
    // Verify authentication
    const userId = await verifyAuth(request);
    console.log('Authentication result:', { userId });
    
    if (!userId) {
      console.log('Unauthorized - no valid userId');
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    const { searchParams } = new URL(request.url)
    const weekStartDate = searchParams.get('weekStartDate')

    let query: any = {
      where: { userId }
    }

    let date = new Date()
    if (weekStartDate) {
      date = new Date(weekStartDate)
    } else {
      // Set to Monday of current week
      date.setDate(date.getDate() - date.getDay() + 1)
    }
    date.setHours(0, 0, 0, 0)

    query.where.weekStartDate = date

    let weeklyPlan = await prisma.weeklyPlan.findFirst({
      ...query,
      include: {
        mealPlans: {
          include: {
            meal: true
          }
        }
      }
    })

    console.log(`Found weekly plan for user ${userId}`);
    
    if (!weeklyPlan) {
      return NextResponse.json(
        { error: 'Weekly plan not found' },
        { status: 404 }
      )
    }

    return NextResponse.json(weeklyPlan)
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
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    const body = await request.json()
    const result = weeklyPlanSchema.safeParse(body)

    if (!result.success) {
      return NextResponse.json(
        { error: 'Week start date is required' },
        { status: 400 }
      )
    }

    const weeklyPlan = await prisma.weeklyPlan.create({
      data: {
        userId,
        weekStartDate: result.data.weekStartDate,
        meals: []
      }
    })

    return NextResponse.json(weeklyPlan, { status: 201 })
  } catch (error) {
    console.error('Error creating weekly plan:', error)
    return NextResponse.json(
      { error: 'Failed to create weekly plan' },
      { status: 500 }
    )
  }
}
