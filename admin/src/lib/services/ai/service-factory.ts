import { AIService } from './types';
import { OpenAIService } from './openai-service';
import { AnthropicService } from './anthropic-service';

export type AIProvider = 'anthropic' | 'openai';

export class AIServiceFactory {
  private static instance?: AIService;
  private static currentProvider: AIProvider = 'anthropic';

  static getService(provider?: AIProvider): AIService {
    const requestedProvider = provider || this.currentProvider;

    if (this.instance && requestedProvider === this.currentProvider) {
      return this.instance;
    }

    if (requestedProvider === 'anthropic') {
      const apiKey = process.env.ANTHROPIC_API_KEY;
      if (!apiKey) {
        throw new Error('Anthropic API key is not configured');
      }
      this.instance = new AnthropicService(apiKey);
      this.currentProvider = 'anthropic';
    } else if (requestedProvider === 'openai') {
      const apiKey = process.env.OPENAI_API_KEY;
      if (!apiKey) {
        throw new Error('OpenAI API key is not configured');
      }
      this.instance = new OpenAIService(apiKey);
      this.currentProvider = 'openai';
    } else {
      throw new Error(`Unsupported AI provider: ${requestedProvider}`);
    }

    return this.instance;
  }

  // Method to set a different service implementation
  static setService(service: AIService) {
    this.instance = service;
  }

  // Method to switch between providers
  static setProvider(provider: AIProvider) {
    this.currentProvider = provider;
    this.instance = undefined; // Force recreation with new provider
  }
}
