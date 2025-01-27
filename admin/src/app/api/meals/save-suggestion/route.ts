import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import { prisma } from '@/lib/prisma';
import { verifyAuth } from '@/lib/auth';

// Schema for saving a suggested recipe
const SaveSuggestionSchema = z.object({
  name: z.string(),
  description: z.string().optional(),
  ingredients: z.array(z.string()),
  instructions: z.array(z.string()),
  cookingTime: z.number().nullable().transform(val => val?.toString() ?? null),
  sourceUrl: z.string().url().optional(),
});

export async function POST(request: NextRequest) {
  try {
    // Verify user is authenticated
    const userId = await verifyAuth(request);
    if (!userId) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Validate request body
    const body = await request.json();
    const recipe = SaveSuggestionSchema.parse(body);

    // Create meal from suggestion
    const meal = await prisma.meal.create({
      data: {
        userId: userId,
        name: recipe.name,
        description: recipe.description ?? null,
        ingredients: recipe.ingredients,
        instructions: recipe.instructions,
        cookingTime: recipe.cookingTime,
        sourceUrl: recipe.sourceUrl ?? null,
      },
    });

    return NextResponse.json(meal);
  } catch (error) {
    console.error('Error saving suggested meal:', error);
    
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input data' },
        { status: 400 }
      );
    }

    return NextResponse.json(
      { error: 'Failed to save meal' },
      { status: 500 }
    );
  }
}
