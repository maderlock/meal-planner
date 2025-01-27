import Anthropic from '@anthropic-ai/sdk';
import { z } from 'zod';
import { AIService, Recipe, RecipeSuggestionResponse, AIServiceError, AIServiceTemporaryError } from './types';

const RecipeSchema = z.object({
  name: z.string(),
  description: z.string().optional(),
  ingredients: z.array(z.string()),
  instructions: z.array(z.string()),
  cookingTime: z.union([z.string(), z.number()]).transform((val) => {
    if (typeof val === 'string') {
      const parsed = parseInt(val, 10);
      return isNaN(parsed) ? undefined : parsed;
    }
    return val;
  }).optional(),
  sourceUrl: z.string().optional(),
});

const SuggestionsResponseSchema = z.object({
  recipes: z.array(RecipeSchema).length(5),
});

const SYSTEM_PROMPT = `You are a helpful cooking assistant. When given a meal description, suggest 5 recipes that match the criteria.
Return the response as a JSON object with a "recipes" array. Each recipe should have:
- name: string (required) - Name of the recipe
- description: string (optional) - Brief description under 200 characters
- ingredients: string[] (required) - List of ingredients as individual items
- instructions: string[] (required) - Clear, numbered steps
- cookingTime: number (optional) - Time in minutes
- sourceUrl: string (optional) - URL to source recipe, must be a real recipe website

Rules:
1. Always return exactly 5 recipes
2. If providing a sourceUrl, ensure it's a real recipe website
3. Break instructions into clear, numbered steps
4. List ingredients as individual items
5. Ensure all text is properly escaped for JSON`;

export class AnthropicService implements AIService {
  private anthropic: Anthropic;

  constructor(apiKey: string) {
    this.anthropic = new Anthropic({
      apiKey: apiKey
    });
  }

  async suggestRecipes(description: string): Promise<RecipeSuggestionResponse> {
    try {
      const completion = await this.anthropic.messages.create({
        model: "claude-3-opus-20240229",
        max_tokens: 4096,
        messages: [{
          role: "user",
          content: `${SYSTEM_PROMPT}\n\nSuggest recipes for: ${description}`
        }],
        system: "You are a cooking expert who provides recipe suggestions in JSON format.",
      });

      const firstBlock = completion.content[0];
      if (!firstBlock || firstBlock.type !== 'text') {
        throw new AIServiceError('AI service returned unexpected response format', 500);
      }

      const content = firstBlock.text;
      if (!content) {
        throw new AIServiceError('AI service returned empty response', 500);
      }

      try {
        // Extract JSON from the response (Claude might wrap it in markdown)
        const jsonMatch = content.match(/\{[\s\S]*\}/);
        if (!jsonMatch) {
          throw new Error('No JSON found in response');
        }
        
        const parsedContent = JSON.parse(jsonMatch[0]);
        const suggestions = SuggestionsResponseSchema.parse(parsedContent);
        return suggestions;
      } catch (parseError) {
        console.error('Failed to parse AI response:', parseError);
        throw new AIServiceError('Failed to process AI response', 500);
      }

    } catch (error) {
      if (error instanceof Anthropic.APIError) {
        console.error('Anthropic API Error:', {
          status: error.status,
          name: error.name,
          message: error.message
        });

        // Handle rate limiting
        if (error.status === 429) {
          throw new AIServiceTemporaryError(
            'Service is experiencing high demand. Please try again in a few minutes.',
            { cause: error }
          );
        }

        // Handle quota errors
        if (error.name === 'authentication_error' && error.message.includes('quota')) {
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
