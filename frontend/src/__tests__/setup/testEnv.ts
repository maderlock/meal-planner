import { TextEncoder, TextDecoder } from 'util'

class MockResponse {
  body: any
  init: ResponseInit
  
  constructor(body: any, init?: ResponseInit) {
    this.body = body
    this.init = init || {}
  }

  async json() {
    return JSON.parse(this.body)
  }

  get status() {
    return this.init.status || 200
  }

  static json(data: any, init?: ResponseInit) {
    return new MockResponse(JSON.stringify(data), init)
  }
}

const NextResponse = {
  json(data: any, init?: ResponseInit) {
    return new MockResponse(JSON.stringify(data), init)
  }
}

class MockRequest {
  private body: any
  private url: string
  private method: string
  cookies: Map<string, string>

  constructor(input: string, init?: any) {
    this.url = input
    this.method = init?.method || 'GET'
    this.body = init?.body
    this.cookies = new Map()
  }

  async json() {
    return JSON.parse(this.body)
  }
}

// Set up globals for Next.js API routes
global.Response = MockResponse as any
global.Request = MockRequest as any
global.Headers = class {
  append() {}
  delete() {}
  get() {}
  has() {}
  set() {}
  forEach() {}
} as any

// Mock next/server
jest.mock('next/server', () => ({
  NextResponse
}))

global.TextEncoder = TextEncoder
global.TextDecoder = TextDecoder as any
