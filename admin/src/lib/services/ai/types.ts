export interface Recipe {
  name: string;
  description?: string;
  ingredients: string[];
  instructions: string[];
  cookingTime?: number;
  sourceUrl?: string;
}

export interface RecipeSuggestionResponse {
  recipes: Recipe[];
}

export class AIServiceError extends Error {
  constructor(
    message: string, 
    public readonly statusCode: number,
    options?: { cause?: Error }
  ) {
    super(message, options);
    this.name = 'AIServiceError';
    // Restore prototype chain
    Object.setPrototypeOf(this, new.target.prototype);
  }
}

export class AIServiceTemporaryError extends AIServiceError {
  constructor(message: string, options?: { cause?: Error }) {
    super(message, 503, options);
    this.name = 'AIServiceTemporaryError';
    // Restore prototype chain
    Object.setPrototypeOf(this, new.target.prototype);
  }
}

export interface AIService {
  suggestRecipes(description: string): Promise<RecipeSuggestionResponse>;
}
