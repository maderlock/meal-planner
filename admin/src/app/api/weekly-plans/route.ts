import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { z } from 'zod'

// Schema for weekly plan creation
const createWeeklyPlanSchema = z.object({
  userId: z.string().uuid(),
  weekStartDate: z.coerce.date()
})

// Schema for meal plan update
const updateMealPlanSchema = z.object({
  mealId: z.string().uuid(),
  mealType: z.enum(['lunch', 'dinner'])
})

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')
    const weekStartDate = searchParams.get('weekStartDate')

    if (!userId) {
      return NextResponse.json({ error: 'User ID is required' }, {
        status: 400
      })
    }

    let date = new Date()
    if (weekStartDate) {
      date = new Date(weekStartDate)
    } else {
      // Set to Monday of current week
      date.setDate(date.getDate() - date.getDay() + 1)
    }
    date.setHours(0, 0, 0, 0)

    let weeklyPlan = await prisma.weeklyPlan.findFirst({
      where: {
        userId,
        weekStartDate: date
      },
      include: {
        mealPlans: {
          include: {
            meal: true
          }
        }
      }
    })

    if (!weeklyPlan) {
      // Create new weekly plan if none exists
      weeklyPlan = await prisma.weeklyPlan.create({
        data: {
          userId,
          weekStartDate: date
        },
        include: {
          mealPlans: {
            include: {
              meal: true
            }
          }
        }
      })
    }

    return NextResponse.json(weeklyPlan, {
      status: 200
    })
  } catch (error) {
    console.error('Error fetching weekly plan:', error)
    return NextResponse.json({ error: 'Failed to fetch weekly plan' }, {
      status: 500
    })
  }
}

export async function POST(request: Request) {
  try {
    const body = await request.json()
    const validatedData = createWeeklyPlanSchema.parse(body)

    const weeklyPlan = await prisma.weeklyPlan.create({
      data: validatedData,
      include: {
        mealPlans: {
          include: {
            meal: true
          }
        }
      }
    })

    return NextResponse.json(weeklyPlan, {
      status: 201
    })
  } catch (error) {
    console.error('Error creating weekly plan:', error)
    if (error instanceof z.ZodError) {
      return NextResponse.json({ error: 'Invalid request data', details: error.errors }, {
        status: 400
      })
    }
    return NextResponse.json({ error: 'Failed to create weekly plan' }, {
      status: 500
    })
  }
}
