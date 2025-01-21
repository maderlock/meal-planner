# Meal Planner Mobile App

A Flutter-based mobile application for meal planning and recipe management.

## Getting Started

### Prerequisites

- Flutter SDK
- Firebase CLI
- FlutterFire CLI
- iOS/Android development environment set up

### Firebase Setup

1. Install the Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Install the FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

3. Add pub cache bin to your PATH (add to your ~/.zshrc or ~/.bashrc):
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

4. Log in to Firebase:
```bash
firebase login
```

5. Configure Firebase for the app:
```bash
flutterfire configure
```

This will:
- Create a new Firebase project or select an existing one
- Enable necessary Firebase services
- Download and add the required configuration files
- Update the necessary platform-specific files

6. Enable Authentication providers in the Firebase Console:
   - Go to https://console.firebase.google.com
   - Select your project
   - Go to Authentication > Sign-in method
   - Enable Email/Password and Google Sign-in

### Development Setup

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/               # Core functionality
│   ├── api/           # API client and services
│   ├── config/        # App configuration
│   ├── constants/     # App constants
│   ├── router/        # Navigation/routing
│   ├── storage/       # Local storage
│   └── theme/         # App theme
├── features/          # Feature modules
│   ├── auth/         # Authentication
│   ├── meals/        # Meal management
│   ├── profile/      # User profile
│   └── settings/     # App settings
├── shared/           # Shared components
│   ├── models/       # Data models
│   ├── widgets/      # Reusable widgets
│   ├── utils/        # Utility functions
│   └── services/     # Shared services
└── main.dart         # App entry point
```

## Features

- User authentication (Email/Password and Google Sign-in)
- Material Design 3 theming
- Dark mode support
- Offline-first architecture
- State management with Riverpod
- Navigation with GoRouter

## Contributing

1. Create a new branch for your feature
2. Make your changes
3. Run tests and ensure they pass
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details
