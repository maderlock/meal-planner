import { NextResponse } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'

// Schema for meal assignment creation
const mealAssignmentSchema = z.object({
  mealId: z.string().uuid(),
  dayOfWeek: z.number().min(0).max(6),
  mealType: z.enum(['breakfast', 'lunch', 'dinner', 'snack']),
  note: z.string().optional()
})

export async function POST(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const body = await request.json()
    const validatedData = mealAssignmentSchema.parse(body)

    // Ensure params.id exists and is a string
    if (!params?.id || typeof params.id !== 'string') {
      return NextResponse.json(
        { error: 'Invalid weekly plan ID' },
        { status: 400 }
      )
    }

    const weeklyPlanId = params.id

    const assignment = await prisma.mealPlan.upsert({
      where: {
        weeklyPlanId_dayOfWeek_mealType: {
          weeklyPlanId,
          dayOfWeek: validatedData.dayOfWeek,
          mealType: validatedData.mealType,
        },
      },
      create: {
        weeklyPlanId,
        mealId: validatedData.mealId,
        dayOfWeek: validatedData.dayOfWeek,
        mealType: validatedData.mealType,
      },
      update: {
        mealId: validatedData.mealId,
      },
      include: {
        meal: true
      }
    })

    // Map numeric day to day name for mobile app
    const dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const formattedAssignment = {
      ...assignment,
      day: dayNames[assignment.dayOfWeek],
      type: assignment.mealType,
    };

    return NextResponse.json(formattedAssignment, { status: 201 })
  } catch (error) {
    console.error('Error creating meal assignment:', error)
    if (error instanceof z.ZodError) {
      return NextResponse.json({ error: 'Invalid request data', details: error.errors }, { status: 400 })
    }
    return NextResponse.json(
      { error: 'Failed to create meal assignment' },
      { status: 500 }
    )
  }
}

export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const { searchParams } = new URL(request.url)
    const assignmentId = searchParams.get('assignmentId')

    // Ensure params.id exists and is a string
    if (!params?.id || typeof params.id !== 'string') {
      return NextResponse.json(
        { error: 'Invalid weekly plan ID' },
        { status: 400 }
      )
    }

    if (!assignmentId) {
      return NextResponse.json(
        { error: 'Assignment ID is required' },
        { status: 400 }
      )
    }

    await prisma.mealPlan.delete({
      where: {
        id: assignmentId,
        weeklyPlanId: params.id
      }
    })

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error deleting meal assignment:', error)
    return NextResponse.json(
      { error: 'Failed to delete meal assignment' },
      { status: 500 }
    )
  }
}
