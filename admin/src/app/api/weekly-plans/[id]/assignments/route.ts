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

    const weeklyPlanId = params.id

    const assignment = await prisma.mealAssignment.create({
      data: {
        weeklyPlanId,
        ...validatedData
      },
      include: {
        meal: true
      }
    })

    return NextResponse.json(assignment, { status: 201 })
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

    if (!assignmentId) {
      return NextResponse.json(
        { error: 'Assignment ID is required' },
        { status: 400 }
      )
    }

    await prisma.mealAssignment.delete({
      where: {
        id: assignmentId,
        weeklyPlanId: params.id
      }
    })

    return new Response(null, { status: 204 })
  } catch (error) {
    console.error('Error deleting meal assignment:', error)
    return NextResponse.json(
      { error: 'Failed to delete meal assignment' },
      { status: 500 }
    )
  }
}
