import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { z } from 'zod'

// Schema for meal creation
const createMealSchema = z.object({
  name: z.string().min(1).max(255),
  description: z.string().optional(),
  ingredients: z.array(z.string()).optional().default([]),
  instructions: z.array(z.string()).optional().default([]),
  imageUrl: z.string().optional()
})

// Schema for meal update
const updateMealSchema = z.object({
  name: z.string().min(1).max(255).optional(),
  description: z.string().optional(),
  ingredients: z.array(z.string()).optional(),
  instructions: z.array(z.string()).optional(),
  imageUrl: z.string().optional()
})

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')
    const favoritesOnly = searchParams.get('favoritesOnly') === 'true'

    let meals = await prisma.meal.findMany({
      orderBy: {
        name: 'asc'
      }
    })

    if (userId) {
      const favorites = await prisma.favoriteMeal.findMany({
        where: {
          userId
        },
        select: {
          mealId: true
        }
      })

      const favoriteMealIds = new Set(favorites.map(f => f.mealId))
      
      meals = meals.map(meal => ({
        ...meal,
        isFavorite: favoriteMealIds.has(meal.id)
      }))

      if (favoritesOnly) {
        meals = meals.filter(meal => meal.isFavorite)
      }
    }

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
      data: validatedData
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
      data: validatedData
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
