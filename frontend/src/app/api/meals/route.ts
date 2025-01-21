import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { z } from 'zod'

// Schema for meal creation
const createMealSchema = z.object({
  name: z.string().min(1).max(255),
  description: z.string().optional(),
  userId: z.string().uuid()
})

export async function GET() {
  try {
    const meals = await prisma.meal.findMany({
      include: {
        user: {
          select: {
            username: true
          }
        }
      }
    })
    return NextResponse.json(meals, {
      status: 200
    })
  } catch (error) {
    console.error('Error fetching meals:', error)
    return NextResponse.json({ error: 'Failed to fetch meals' }, {
      status: 500
    })
  }
}

export async function POST(request: Request) {
  try {
    const body = await request.json()
    const validatedData = createMealSchema.parse(body)

    const meal = await prisma.meal.create({
      data: validatedData,
      include: {
        user: {
          select: {
            username: true
          }
        }
      }
    })

    return NextResponse.json(meal, {
      status: 201
    })
  } catch (error) {
    console.error('Error creating meal:', error)
    if (error instanceof z.ZodError) {
      return NextResponse.json({ error: 'Invalid request data', details: error.errors }, {
        status: 400
      })
    }
    return NextResponse.json({ error: 'Failed to create meal' }, {
      status: 500
    })
  }
}
