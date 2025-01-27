import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import { prisma } from '@/lib/prisma';
import { verifyAuth } from '@/lib/auth';
import { AIServiceFactory } from '@/lib/services/ai/service-factory';
import { AIServiceError, AIServiceTemporaryError } from '@/lib/services/ai/types';

// Set the maximum duration to 240 seconds for AI processing
export const runtime = 'nodejs';
export const maxDuration = 240;

// Schema for recipe suggestions
const RecipeSchema = z.object({
  name: z.string(),
  description: z.string().optional(),
  ingredients: z.array(z.string()),
  instructions: z.array(z.string()),
  cookingTime: z.union([z.string(), z.number()]).optional(),
  url: z.string().url().optional(),
  sourceUrl: z.string().url().optional(),
});

// Update schema to match AI service response format
const SuggestionsResponseSchema = z.object({
  recipes: z.array(RecipeSchema).length(5)
});

const requestSchema = z.object({
  description: z.string().min(1).max(500)
});

const SYSTEM_PROMPT = `You are a helpful cooking assistant. When given a meal description, suggest 5 recipes that match the criteria.
Your response must be valid JSON and match this TypeScript type:
type Recipe = {
  name: string;           // Required: Name of the recipe
  description?: string;   // Optional: Brief description
  ingredients: string[];  // Required: List of ingredients
  instructions: string[]; // Required: List of steps
  cookingTime?: number;   // Optional: Time in minutes
  sourceUrl?: string;     // Optional: URL to source recipe
}`;

export async function POST(request: NextRequest) {
  try {
    console.log('[/api/meals/suggest] Starting recipe suggestion request');
    
    const userId = await verifyAuth(request);
    if (!userId) {
      console.error('[/api/meals/suggest] Auth failed: Unauthorized');
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const body = await request.json();
    console.log('[/api/meals/suggest] Request body:', body);
    
    const parsed = requestSchema.safeParse(body);
    if (!parsed.success) {
      console.error('[/api/meals/suggest] Schema validation failed:', parsed.error);
      return NextResponse.json(
        { error: 'Invalid request body' },
        { status: 400 }
      );
    }

    const aiService = AIServiceFactory.getService();
    console.log('[/api/meals/suggest] Requesting suggestions from AI service');
    
    const suggestions = await aiService.suggestRecipes(parsed.data.description);
    console.log('[/api/meals/suggest] Got suggestions from AI:', suggestions);

    const validatedSuggestions = SuggestionsResponseSchema.safeParse(suggestions);
    if (!validatedSuggestions.success) {
      console.error('[/api/meals/suggest] AI response validation failed:', validatedSuggestions.error);
      return NextResponse.json(
        { error: 'Invalid AI response format' },
        { status: 500 }
      );
    }

    console.log('[/api/meals/suggest] Successfully validated suggestions');
    // Return just the recipes array to maintain compatibility with the mobile app
    return NextResponse.json(validatedSuggestions.data.recipes);
  } catch (error) {
    console.error('[/api/meals/suggest] Error processing request:', error);
    if (error instanceof AIServiceTemporaryError) {
      return NextResponse.json(
        { error: 'AI service temporarily unavailable' },
        { status: 503 }
      );
    }
    if (error instanceof AIServiceError) {
      return NextResponse.json(
        { error: 'AI service error' },
        { status: 500 }
      );
    }
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
