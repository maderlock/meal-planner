# Meal Planner Application

A comprehensive meal planning application built with modern technologies.

## Tech Stack

### Frontend
- Next.js 15 with App Router
- React 18
- TypeScript
- Tailwind CSS
- Turbopack for development

### Backend
- PostgreSQL 17
- Prisma ORM
- Firebase Authentication (coming soon)
- Node.js API Routes

### Infrastructure
- Docker for development environment
- Google Cloud Platform (planned)
- Firebase (planned)

### AI Integration (planned)
- OpenAI
- Anthropic

## Project Structure

```
meal-planner/
├── frontend/
│   ├── src/
│   │   ├── app/
│   │   │   ├── api/
│   │   │   │   ├── meals/
│   │   │   │   └── users/
│   │   │   ├── meals/
│   │   │   ├── users/
│   │   │   ├── layout.tsx
│   │   │   └── page.tsx
│   │   └── components/
│   │       └── Navigation.tsx
│   ├── prisma/
│   │   ├── schema.prisma
│   │   └── migrations/
├── local_data/
│   └── .gitkeep
├── docker-compose.yml
├── .env.example
└── README.md
```

## Available Routes

### Frontend Pages
- `/` - Home page
- `/users` - User management
- `/meals` - Meal planning

### API Endpoints
- `GET /api/users` - Retrieve users
- `POST /api/users` - Create user
- `GET /api/meals` - Retrieve meals
- `POST /api/meals` - Create meal

## Getting Started

1. Clone the repository:
   ```bash
   git clone git@github.com:maderlock/meal-planner.git
   cd meal-planner
   ```

2. Set up environment variables:
   ```bash
   cp .env.example .env
   ```
   Edit the `.env` file with your configuration values.

3. Start the PostgreSQL database:
   ```bash
   docker-compose up -d
   ```

4. Set up the frontend:
   ```bash
   cd frontend
   npm install
   npx prisma generate    # Generate Prisma Client
   npx prisma migrate deploy    # Apply database migrations
   npm run dev
   ```

5. Access the application:
   - Frontend: http://localhost:3000
   - API: http://localhost:3000/api/
   - PostgreSQL: localhost:5432

## Development

### Database
The PostgreSQL database is managed through Prisma and includes:
- Prisma Schema defining the data model
- Database migrations for version control
- UUID extension for unique identifiers
- Type-safe database access
- Automatic timestamp management
- Prepared for multi-tenant architecture

### Frontend
- Modern UI with Tailwind CSS
- Type-safe development with TypeScript
- Fast refresh with Turbopack
- Server-side rendering with Next.js

## Environment Variables

Required environment variables:
```
# PostgreSQL
POSTGRES_USER=meal_planner_user
POSTGRES_PASSWORD=your_secure_password
POSTGRES_DB=meal_planner_db

# Database URL for Prisma
DATABASE_URL="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:5432/${POSTGRES_DB}"

# Firebase (coming soon)
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_auth_domain
FIREBASE_PROJECT_ID=your_project_id

# AI Integration (coming soon)
OPENAI_API_KEY=your_openai_api_key
ANTHROPIC_API_KEY=your_anthropic_api_key

# JWT Configuration
JWT_SECRET=your_jwt_secret
JWT_ACCESS_TOKEN_EXPIRES_IN=15m
JWT_REFRESH_TOKEN_EXPIRES_IN=7d
JWT_ISSUER=meal_planner_api
JWT_AUDIENCE=meal_planner_client
JWT_ALGORITHM=HS256
```

## Database Migrations

To manage database changes:

1. Make changes to `prisma/schema.prisma`
2. Create a new migration:
   ```bash
   cd frontend
   npx prisma migrate dev --name your_migration_name
   ```
3. Apply migrations to production:
   ```bash
   cd frontend
   npx prisma migrate deploy
   ```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

[Add license information here]
