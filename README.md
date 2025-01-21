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

## Development Setup

### Prerequisites

- Node.js (v18 or later)
- Docker and Docker Compose
- Flutter SDK
- Firebase CLI
- FlutterFire CLI

### macOS Installation

1. Install Homebrew if not already installed:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install system dependencies:
```bash
brew install node docker docker-compose flutter
```

3. Install Firebase tools:
```bash
npm install -g firebase-tools
```

4. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

5. Add pub cache bin to your PATH (add to your ~/.zshrc or ~/.bashrc):
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

6. Clone the repository:
```bash
git clone https://github.com/yourusername/meal-planner.git
cd meal-planner
```

7. Set up Firebase:
```bash
# Log in to Firebase
firebase login

# Configure Firebase for the mobile app
cd mobile
flutterfire configure
```

8. Install dependencies:
```bash
# Backend dependencies
cd backend
npm install

# Mobile dependencies
cd ../mobile
flutter pub get
```

### Running the Project

1. Start the backend services:
```bash
docker-compose up -d
cd backend
npm run dev
```

2. Run the mobile app:
```bash
cd mobile
flutter run
```

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
