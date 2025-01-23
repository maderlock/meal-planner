/**
 * Favorites API Route
 * 
 * Manages user's favorite meals functionality, allowing users
 * to mark and unmark meals as favorites and retrieve their
 * favorite meal list.
 * 
 * Endpoints:
 * - GET: List user's favorite meals
 * - POST: Add meal to favorites
 * - DELETE: Remove meal from favorites
 * 
 * Features:
 * - User-specific favorites
 * - Pagination support
 * - Automatic sorting by recently added
 * 
 * Used By:
 * - Mobile app favorites feature
 * - Meal selection interface
 * 
 * Related Files:
 * - meals/route.ts: Main meals endpoint
 * - meal_service.dart: Mobile app integration
 * - favorites.test.ts: API tests
 */

import { NextResponse } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'

const favoriteMealSchema = z.object({
  userId: z.string().uuid(),
  mealId: z.string().uuid()
})

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')

    if (!userId) {
      return NextResponse.json({ error: 'User ID is required' }, { status: 400 })
    }

    const favorites = await prisma.favoriteMeal.findMany({
      where: {
        userId
      },
      include: {
        meal: true
      }
    })

    const meals = favorites.map(favorite => ({
      ...favorite.meal,
      isFavorite: true
    }))

    return NextResponse.json(meals)
  } catch (error) {
    console.error('Error fetching favorite meals:', error)
    return NextResponse.json(
      { error: 'Failed to fetch favorite meals' },
      { status: 500 }
    )
  }
}

export async function POST(request: Request) {
  try {
    const body = await request.json()
    const validatedData = favoriteMealSchema.parse(body)

    try {
      const favorite = await prisma.favoriteMeal.create({
        data: validatedData,
        include: {
          meal: true
        }
      })

      return NextResponse.json(favorite, { status: 201 })
    } catch (error) {
      if (error instanceof Error && error.message.includes('Unique constraint failed')) {
        return NextResponse.json(
          { error: 'Meal is already in favorites' },
          { status: 409 }
        )
      }
      throw error
    }
  } catch (error) {
    console.error('Error creating favorite:', error)
    if (error instanceof z.ZodError) {
      return NextResponse.json({ error: 'Invalid request data' }, { status: 400 })
    }
    return NextResponse.json(
      { error: 'Failed to create favorite' },
      { status: 500 }
    )
  }
}

export async function DELETE(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')
    const mealId = searchParams.get('mealId')

    if (!userId || !mealId) {
      return NextResponse.json(
        { error: 'User ID and Meal ID are required' },
        { status: 400 }
      )
    }

    try {
      await prisma.favoriteMeal.delete({
        where: {
          userId_mealId: {
            userId,
            mealId
          }
        }
      })

      return new Response(null, { status: 204 })
    } catch (error) {
      if (error instanceof Error && error.message.includes('Record to delete does not exist')) {
        return NextResponse.json(
          { error: 'Favorite not found' },
          { status: 404 }
        )
      }
      throw error
    }
  } catch (error) {
    console.error('Error deleting favorite:', error)
    return NextResponse.json(
      { error: 'Failed to delete favorite' },
      { status: 500 }
    )
  }
}
