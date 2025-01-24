import { Request, RequestInit } from 'node-fetch'

export class MockRequest extends Request {
  constructor(url: string | URL, init?: RequestInit) {
    super(new Request(url, init))
  }
}

export function createTestRequest(
  method: string,
  path: string,
  body: any = {},
  headers: Record<string, string> = {}
): Request {
  const url = new URL(path, 'http://localhost')
  return new Request(url, {
    method,
    headers: {
      'Content-Type': 'application/json',
      ...headers
    },
    body: method !== 'GET' ? JSON.stringify(body) : undefined
  })
}
