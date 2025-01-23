# Meal Planner Admin

A Next.js application for managing meal plans, recipes, and user preferences.

## Features

- User Management
- Meal/Recipe Management
- Weekly Meal Planning
- Favorites System
- API Endpoints with TypeScript and Prisma

## Tech Stack

- Next.js 13+ (App Router)
- TypeScript
- Prisma ORM
- PostgreSQL
- Zod for Validation
- Jest for Testing

## Getting Started

### Prerequisites

- Node.js 18+
- PostgreSQL
- npm or yarn

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd meal-planner/admin
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.example .env
```
Edit `.env` with your database credentials and other configuration.

4. Run database migrations:
```bash
npx prisma migrate dev
```

5. Start the development server:
```bash
npm run dev
```

## API Documentation

### Users API

- `GET /api/users` - Get all users
- `POST /api/users` - Create a new user

### Meals API

- `GET /api/meals` - Get all meals
- `POST /api/meals` - Create a new meal
- `PATCH /api/meals` - Update a meal

### Weekly Plans API

- `GET /api/weekly-plans` - Get weekly plan for a user
- `POST /api/weekly-plans` - Create a new weekly plan

### Favorites API

- `GET /api/favorites` - Get favorite meals for a user
- `POST /api/favorites` - Add a meal to favorites
- `DELETE /api/favorites` - Remove a meal from favorites

## Testing

The project uses Jest for testing with a centralized Prisma mock setup for consistent and type-safe testing.

### Running Tests

```bash
npm test                 # Run all tests
npm test -- --watch     # Run tests in watch mode
npm test -- <filename>  # Run specific test file
```

### Test Structure

Tests are organized by API endpoint in the `__tests__/api` directory. Each test file follows a consistent pattern:

1. Success cases
2. Validation error cases
3. Database error cases

### Prisma Mocking

We use `jest-mock-extended` for type-safe Prisma client mocking. The mock is centralized in `jest.setup.ts`:

```typescript
import { PrismaClient } from '@prisma/client'
import { mockDeep, DeepMockProxy } from 'jest-mock-extended'

export const prismaMock = mockDeep<PrismaClient>()

jest.mock('@/lib/prisma', () => ({
  __esModule: true,
  prisma: prismaMock
}))

beforeEach(() => {
  mockReset(prismaMock)
})
```

Example test using the mock:

```typescript
import { prismaMock } from '../../../jest.setup'

describe('API Test', () => {
  it('should handle success case', async () => {
    prismaMock.user.findMany.mockResolvedValue([mockUser])
    // Test implementation
  })
})
```

## Project Structure

```
src/
├── app/                    # Next.js app directory
│   ├── api/               # API routes
│   └── ...                # Other app routes
├── __tests__/             # Test files
│   ├── api/               # API tests
│   └── helpers/           # Test helpers
├── lib/                   # Shared libraries
│   └── prisma.ts         # Prisma client
└── types/                 # TypeScript types
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests: `npm test`
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
