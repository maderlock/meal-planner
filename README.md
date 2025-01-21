# Meal Planner Application

A comprehensive meal planning application with a Flutter mobile app for customers and a Next.js admin interface.

## Tech Stack

### Mobile App (Customer-facing)
- Flutter for iOS and Android
- Dart
- Material Design 3
- Firebase Authentication

### Admin Interface
- Next.js 15 with App Router
- React 18
- TypeScript
- Tailwind CSS
- Turbopack for development

### Backend (Built into Admin)
- Next.js API Routes
- PostgreSQL 17
- Prisma ORM
- Firebase Authentication

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
├── mobile/           # Flutter mobile app for customers
│   ├── lib/         # Dart source code
│   ├── ios/         # iOS specific code
│   └── android/     # Android specific code
├── admin/           # Next.js admin interface and API
│   ├── src/
│   │   ├── app/
│   │   │   ├── api/        # API endpoints
│   │   │   │   ├── meals/
│   │   │   │   └── users/
│   │   │   ├── meals/      # Admin meal management
│   │   │   ├── users/      # Admin user management
│   │   │   ├── layout.tsx
│   │   │   └── page.tsx
│   │   └── components/
│   │       └── Navigation.tsx
│   ├── prisma/
│   │   ├── schema.prisma
│   │   └── migrations/
├── scripts/         # Development and deployment scripts
│   └── install_macos.sh  # macOS installation script
├── local_data/
│   └── .gitkeep
├── docker-compose.yml
├── .env.example
└── README.md
```

## Components

### Mobile App (Customer)
- User registration and authentication
- Meal browsing and planning
- Recipe viewing and saving
- Shopping list generation
- Dietary preferences
- Push notifications

### Admin Interface
- User management
- Meal and recipe management
- Analytics dashboard
- Content moderation
- System configuration

### API Endpoints
- `GET /api/users` - Retrieve users
- `POST /api/users` - Create user
- `GET /api/meals` - Retrieve meals
- `POST /api/meals` - Create meal

## Getting Started

### Prerequisites
- macOS for local development
- Xcode (for iOS development)
- Android Studio (for Android development)
- Node.js 18+
- Flutter SDK
- Docker Desktop
- PostgreSQL 17 (via Docker)
- Firebase project (for authentication)

### Quick Start (macOS)

1. Clone the repository:
   ```bash
   git clone git@github.com:maderlock/meal-planner.git
   cd meal-planner
   ```

2. Run the installation script:
   ```bash
   ./scripts/install_macos.sh
   ```

   The script will:
   - Install Homebrew if not present
   - Install and configure Docker
   - Install Node.js 18
   - Install Flutter and its dependencies
   - Set up the development environment
   - Create and configure the database
   - Install project dependencies

3. Complete the manual steps:
   - Install Xcode from the App Store (if not already installed)
   - Install Android Studio (if not already installed)
   - Update the `.env` file with your configuration
   - Run `flutter doctor` to verify your Flutter installation

4. Start the admin interface:
   ```bash
   cd admin && npm run dev
   ```

### Manual Setup

If you prefer to set up everything manually or are not using macOS, follow these steps:

#### Setting Up the Admin Interface

1. Install dependencies:
   - Install Docker Desktop
   - Install Node.js 18+
   - Install PostgreSQL 17 (via Docker)

2. Configure the environment:
   ```bash
   cp .env.example .env
   ```
   Edit the `.env` file with your configuration values.

3. Start the PostgreSQL database:
   ```bash
   docker-compose up -d
   ```

4. Set up the admin interface:
   ```bash
   cd admin
   npm install
   npx prisma generate    # Generate Prisma Client
   npx prisma migrate deploy    # Apply database migrations
   npm run dev
   ```

#### Setting Up the Mobile App

1. Install Flutter:
   ```bash
   # macOS
   brew install flutter

   # Other platforms
   # See https://flutter.dev/docs/get-started/install
   ```

2. Install platform-specific dependencies:
   - For iOS: Xcode and CocoaPods
   - For Android: Android Studio and Android SDK

3. Set up the mobile app:
   ```bash
   cd mobile
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Development

### Database
The PostgreSQL database is managed through Prisma and includes:
- Prisma Schema defining the data model
- Database migrations for version control
- UUID extension for unique identifiers
- Type-safe database access
- Automatic timestamp management
- Prepared for multi-tenant architecture

### Admin Interface
- Modern UI with Tailwind CSS
- Type-safe development with TypeScript
- Fast refresh with Turbopack
- Server-side rendering with Next.js

### Mobile App
- Material Design 3 for modern UI
- Offline-first architecture
- State management with Provider/Riverpod
- Local storage with SQLite
- Push notifications

## Environment Variables

Required environment variables:
```
# PostgreSQL
POSTGRES_USER=meal_planner_user
POSTGRES_PASSWORD=your_secure_password
POSTGRES_DB=meal_planner_db

# Database URL for Prisma
DATABASE_URL="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:5432/${POSTGRES_DB}"

# Firebase
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
   cd admin
   npx prisma migrate dev --name your_migration_name
   ```
3. Apply migrations to production:
   ```bash
   cd admin
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
