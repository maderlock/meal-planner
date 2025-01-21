# Meal Planner Application

A comprehensive meal planning application built with Flutter, Next.js, and various modern technologies.

## Tech Stack

- Frontend: Next.js, React, TypeScript
- Mobile: Flutter
- Backend: Node.js, TypeScript
- Database: PostgreSQL
- Authentication: Firebase
- AI Integration: OpenAI, Anthropic
- Infrastructure: Google Cloud Platform (GCP)
- Containerization: Docker

## Prerequisites

- Docker and Docker Compose
- Node.js (v18 or later)
- Flutter SDK
- Git

## Getting Started

1. Clone the repository:
   ```bash
   git clone [your-repository-url]
   cd meal-planner
   ```

2. Set up environment variables:
   ```bash
   cp .env.example .env
   ```
   Edit the `.env` file with your actual configuration values.

3. Start the development environment:
   ```bash
   docker-compose up -d
   ```

4. Verify the PostgreSQL database is running:
   ```bash
   docker ps
   ```

## Project Structure

```
meal-planner/
├── backend/
│   └── db/
│       └── init.sql
├── docker-compose.yml
├── .env.example
└── README.md
```

More directories and files will be added as the project grows.

## Development

Currently, the basic Docker and PostgreSQL setup is complete. The next steps will involve:

1. Setting up the Next.js frontend
2. Creating the Flutter mobile app
3. Implementing the backend API
4. Setting up Firebase authentication
5. Integrating AI services

## Contributing

[Add contribution guidelines here]

## License

[Add license information here]
