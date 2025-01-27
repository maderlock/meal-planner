import Anthropic from '@anthropic-ai/sdk';

const client = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY || '',
});

async function testTypes() {
  const message = await client.messages.create({
    max_tokens: 1024,
    messages: [{ role: 'user', content: 'Hello' }],
    model: 'claude-3-opus-20240229',
  });

  // Let TypeScript infer and show us the type
  const content = message.content[0];
  console.log(content);
}
