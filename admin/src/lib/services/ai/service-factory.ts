import { AIService } from './types';
import { OpenAIService } from './openai-service';

export class AIServiceFactory {
  private static instance: AIService;

  static getService(): AIService {
    if (!this.instance) {
      const apiKey = process.env.OPENAI_API_KEY;
      if (!apiKey) {
        throw new Error('OpenAI API key is not configured');
      }
      this.instance = new OpenAIService(apiKey);
    }
    return this.instance;
  }

  // Method to set a different service implementation
  static setService(service: AIService) {
    this.instance = service;
  }
}
