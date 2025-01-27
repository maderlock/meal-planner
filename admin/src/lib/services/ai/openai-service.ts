import OpenAI from 'openai';
import { z } from 'zod';
import { AIService, Recipe, RecipeSuggestionResponse, AIServiceError, AIServiceTemporaryError } from './types';

const RecipeSchema = z.object({
  name: z.string(),
  description: z.string().optional(),
  ingredients: z.array(z.string()),
  instructions: z.array(z.string()),
  cookingTime: z.number().optional(),
  sourceUrl: z.string().optional(),
});

const SuggestionsResponseSchema = z.object({
  recipes: z.array(RecipeSchema),
});

const SYSTEM_PROMPT = `You are a helpful cooking assistant. When given a meal description, suggest 5 recipes that match the criteria.
Return the response as a JSON object with a "recipes" array. Each recipe should have:
- name: string (required)
- description: string (optional)
- ingredients: string[] (required)
- instructions: string[] (required)
- cookingTime: number in minutes (optional)
- sourceUrl: string (optional)`;

export class OpenAIService implements AIService {
  private openai: OpenAI;

  constructor(apiKey: string) {
    this.openai = new OpenAI({ apiKey });
  }

  async suggestRecipes(description: string): Promise<RecipeSuggestionResponse> {
    try {
      const completion = await this.openai.chat.completions.create({
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: SYSTEM_PROMPT },
          { role: "user", content: `Suggest recipes for: ${description}` }
        ],
        response_format: { type: "json_object" },
        temperature: 0.7,
      });

      const content = completion.choices[0].message.content;
      if (!content) {
        throw new AIServiceError('AI service returned empty response', 500);
      }

      try {
        const parsedContent = JSON.parse(content);
        const suggestions = SuggestionsResponseSchema.parse(parsedContent);
        return suggestions;
      } catch (parseError) {
        console.error('Failed to parse AI response:', parseError);
        throw new AIServiceError('Failed to process AI response', 500);
      }

    } catch (error) {
      if (error instanceof OpenAI.APIError) {
        console.error('OpenAI API Error:', {
          status: error.status,
          code: error.code,
          message: error.message
        });

        // Handle rate limiting and quota errors
        if (error.status === 429) {
          throw new AIServiceTemporaryError(
            'Service is experiencing high demand. Please try again in a few minutes.',
            { cause: error }
          );
        }
        
        if (error.code === 'insufficient_quota') {
          throw new AIServiceTemporaryError(
            'Service is temporarily unavailable due to quota limits. Please try again later.',
            { cause: error }
          );
        }

        // Handle other API errors
        throw new AIServiceError(
          'Recipe suggestion service encountered an error',
          500,
          { cause: error }
        );
      }

      if (error instanceof AIServiceError) {
        throw error;
      }

      // Handle unexpected errors
      console.error('Unexpected error in AI service:', error);
      throw new AIServiceError(
        'An unexpected error occurred',
        500,
        { cause: error instanceof Error ? error : undefined }
      );
    }
  }
}
