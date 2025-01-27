import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import OpenAI from 'openai';
import { prisma } from '@/lib/prisma';
import { verifyAuth } from '@/lib/auth'

// Schema for recipe suggestions
const RecipeSchema = z.object({
  name: z.string(),
  description: z.string(),
  ingredients: z.array(z.string()),
  instructions: z.array(z.string()),
  cookingTime: z.string(),
  url: z.string().url(),
});

const SuggestionsResponseSchema = z.array(RecipeSchema).length(5);

type Recipe = z.infer<typeof RecipeSchema>;

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

const SYSTEM_PROMPT = `You are a helpful cooking assistant. When given a meal description, suggest 5 recipes that match the criteria.
Your response must be valid JSON and match this TypeScript type:
type Recipe = {
  name: string;
  description: string;
  ingredients: string[];
  instructions: string[];
  cookingTime: string;
  url: string;
}[];

Rules:
1. Always return exactly 5 recipes
2. Ensure all URLs are real recipe websites
3. Keep descriptions under 200 characters
4. Break instructions into clear, numbered steps
5. List ingredients as individual items
6. Format cooking time as a string (e.g. "30 minutes", "1 hour 15 minutes")
7. Ensure all text is properly escaped for JSON
8. Never include any SQL or code in the response`;

export async function POST(request: NextRequest) {
  try {
    const userId = await verifyAuth(request);
    if (!userId) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Get and validate description from request
    const body = await request.json();
    const description = z.string().min(1).max(500).parse(body.description);

    // Generate suggestions using OpenAI
    const completion = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        { role: "system", content: SYSTEM_PROMPT },
        { role: "user", content: `Suggest recipes for: ${description}` }
      ],
      response_format: { type: "json_object" },
      temperature: 0.7,
    });

    // Parse and validate the response
    const suggestions = SuggestionsResponseSchema.parse(
      JSON.parse(completion.choices[0].message.content || '[]')
    );

    return NextResponse.json(suggestions);
  } catch (error) {
    console.error('Error suggesting recipes:', error);
    
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input data' },
        { status: 400 }
      );
    }

    // Handle OpenAI API errors
    if (error instanceof OpenAI.APIError) {
      const { status, code, message } = error;
      
      // Log detailed error information
      console.error(`OpenAI API Error:
        Status: ${status}
        Code: ${code}
        Message: ${message}
      `);

      // Handle rate limiting and quota errors
      if (status === 429 || code === 'insufficient_quota') {
        return NextResponse.json(
          { error: 'Service temporarily unavailable. Please try again later.' },
          { status: 503 }
        );
      }

      // Handle other API errors
      return NextResponse.json(
        { error: 'Recipe suggestion service is currently unavailable' },
        { status: 500 }
      );
    }

    // Handle all other errors
    return NextResponse.json(
      { error: 'Failed to suggest recipes' },
      { status: 500 }
    );
  }
}
