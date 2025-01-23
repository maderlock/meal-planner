import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { z } from 'zod'

const updateMealPlanSchema = z.object({
  mealId: z.string().uuid(),
  dayOfWeek: z.number().min(1).max(7),
  mealType: z.enum(['lunch', 'dinner'])
})

export async function POST(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const weeklyPlanId = params.id
    const body = await request.json()
    const validatedData = updateMealPlanSchema.parse(body)

    // Delete existing meal plan for this day if it exists
    await prisma.mealPlan.deleteMany({
      where: {
        weeklyPlanId,
        dayOfWeek: validatedData.dayOfWeek,
        mealType: validatedData.mealType
      }
    })

    // Create new meal plan
    const mealPlan = await prisma.mealPlan.create({
      data: {
        weeklyPlanId,
        mealId: validatedData.mealId,
        dayOfWeek: validatedData.dayOfWeek,
        mealType: validatedData.mealType
      },
      include: {
        meal: true
      }
    })

    return NextResponse.json(mealPlan, {
      status: 201
    })
  } catch (error) {
    console.error('Error updating meal plan:', error)
    if (error instanceof z.ZodError) {
      return NextResponse.json({ error: 'Invalid request data', details: error.errors }, {
        status: 400
      })
    }
    return NextResponse.json({ error: 'Failed to update meal plan' }, {
      status: 500
    })
  }
}

export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const weeklyPlanId = params.id
    const { searchParams } = new URL(request.url)
    const dayOfWeek = searchParams.get('dayOfWeek')
    const mealType = searchParams.get('mealType')

    if (!dayOfWeek || !mealType) {
      return NextResponse.json({ error: 'Day of week and meal type are required' }, {
        status: 400
      })
    }

    await prisma.mealPlan.deleteMany({
      where: {
        weeklyPlanId,
        dayOfWeek: parseInt(dayOfWeek),
        mealType: mealType as 'lunch' | 'dinner'
      }
    })

    return NextResponse.json(null, {
      status: 204
    })
  } catch (error) {
    console.error('Error deleting meal plan:', error)
    return NextResponse.json({ error: 'Failed to delete meal plan' }, {
      status: 500
    })
  }
}
