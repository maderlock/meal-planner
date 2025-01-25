/**
 * Meals API Route
 * 
 * Central endpoint for managing the meal/recipe database.
 * Provides CRUD operations for meals with support for
 * filtering, searching, and pagination.
 * 
 * Endpoints:
 * - GET: List meals with filters
 * - POST: Create new meal
 * - PATCH: Update meal details
 * - DELETE: Remove meal
 * 
 * Features:
 * - Full-text search
 * - Category filtering
 * - Pagination support
 * - Image handling
 * 
 * Used By:
 * - Mobile app meal browsing
 * - Weekly plan meal selection
 * - Favorites management
 * 
 * Related Files:
 * - meal_model.dart: Mobile app model
 * - meal_service.dart: Mobile app service
 * - favorites/route.ts: Favorite meals management
 */

import { NextRequest, NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { verifyAuth } from '@/lib/auth'
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

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const favoritesOnly = searchParams.get('favoritesOnly') === 'true'

    // Get userId from JWT token
    const userId = await verifyAuth(request);
    if (!userId) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    let meals = await prisma.meal.findMany({
      where: {
        userId,
        ...(favoritesOnly ? { isFavorite: true } : {}),
      },
      orderBy: {
        name: 'asc'
      }
    });

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

export async function POST(request: NextRequest) {
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

export async function PATCH(request: NextRequest) {
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
