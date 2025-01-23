import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { z } from 'zod'

// Schema for meal creation
const createMealSchema = z.object({
  name: z.string().min(1).max(255),
  description: z.string().optional(),
  userId: z.string().uuid(),
  isFavorite: z.boolean().optional().default(false)
})

// Schema for meal update
const updateMealSchema = z.object({
  name: z.string().min(1).max(255).optional(),
  description: z.string().optional(),
  isFavorite: z.boolean().optional()
})

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')
    const favoritesOnly = searchParams.get('favoritesOnly') === 'true'

    const where = {
      ...(userId && { userId }),
      ...(favoritesOnly && { isFavorite: true })
    }

    const meals = await prisma.meal.findMany({
      where,
      include: {
        user: {
          select: {
            username: true
          }
        }
      },
      orderBy: {
        name: 'asc'
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

export async function PATCH(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const id = searchParams.get('id')

    if (!id) {
      return NextResponse.json({ error: 'Meal ID is required' }, {
        status: 400
      })
    }

    const body = await request.json()
    const validatedData = updateMealSchema.parse(body)

    const meal = await prisma.meal.update({
      where: { id },
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
      status: 200
    })
  } catch (error) {
    console.error('Error updating meal:', error)
    if (error instanceof z.ZodError) {
      return NextResponse.json({ error: 'Invalid request data', details: error.errors }, {
        status: 400
      })
    }
    return NextResponse.json({ error: 'Failed to update meal' }, {
      status: 500
    })
  }
}
