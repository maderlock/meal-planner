import { TextEncoder, TextDecoder } from 'util'

class MockResponse {
  private body: any
  private init: ResponseInit
  
  constructor(body: any, init?: ResponseInit) {
    this.body = body
    this.init = init || {}
  }

  async json() {
    return typeof this.body === 'string' ? JSON.parse(this.body) : this.body
  }

  get status() {
    return this.init.status || 200
  }

  static json(data: any, init?: ResponseInit) {
    return new MockResponse(data, init)
  }
}

const NextResponse = {
  json(data: any, init?: ResponseInit) {
    return new MockResponse(data, init)
  }
}

class MockRequest {
  private body: any
  private url: string
  private method: string
  private searchParams: URLSearchParams
  cookies: Map<string, string>

  constructor(input: string, init?: any) {
    this.url = input
    this.method = init?.method || 'GET'
    this.body = init?.body
    this.cookies = new Map()
    
    try {
      const url = new URL(input)
      this.searchParams = url.searchParams
    } catch (e) {
      // If URL parsing fails, create an empty URLSearchParams object
      this.searchParams = new URLSearchParams()
    }
  }

  async json() {
    return typeof this.body === 'string' ? JSON.parse(this.body) : this.body
  }

  get nextUrl() {
    return {
      searchParams: this.searchParams
    }
  }
}

// Mock TextEncoder/TextDecoder if not available
if (typeof global.TextEncoder === 'undefined') {
  global.TextEncoder = TextEncoder
}
if (typeof global.TextDecoder === 'undefined') {
  global.TextDecoder = TextDecoder as any
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
