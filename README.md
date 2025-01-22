# Meal Planner

A comprehensive meal planning application with mobile, web, and API components.

## Prerequisites

- macOS 12.0 or later
- [Homebrew](https://brew.sh/)
- [Node.js](https://nodejs.org/) 20.x or later
- [Flutter](https://flutter.dev/) 3.x
- [Docker](https://docker.com/)
- [Xcode](https://developer.apple.com/xcode/) 14.0 or later (for iOS development)
- [Android Studio](https://developer.android.com/studio) (for Android development)

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/meal-planner.git
   cd meal-planner
   ```

2. Install dependencies:
   ```bash
   make install
   ```

3. Update the `.env` file with your configuration:
   ```bash
   cp .env.example .env
   # Edit .env with your preferred editor
   ```

4. Start the services:
   ```bash
   # Start the API server
   make run-api

   # Start the mobile app (in a new terminal)
   make run-mobile

   # Start the web app (in a new terminal)
   make run-web
   ```

## Development

### Available Commands

- `make help` - Show all available commands
- `make install` - Install all dependencies
- `make run-api` - Run the API server
- `make run-mobile` - Run the mobile app
- `make run-web` - Run the web app
- `make test` - Run all tests
- `make clean` - Clean all build artifacts
- `make reset` - Clean and reinstall everything

### Mobile App Development

The mobile app is built with Flutter and can be run on both iOS and Android:

```bash
# Run on iOS simulator
make run-mobile-ios

# Run on Android emulator
make run-mobile-android

# Run tests
cd mobile && flutter test
```

#### iOS-specific Setup

1. Install Xcode from the App Store
2. Install the iOS simulator:
   ```bash
   xcode-select --install
   ```
3. Open Xcode and accept the license agreement
4. Install CocoaPods dependencies:
   ```bash
   cd mobile/ios && pod install
   ```

#### Android-specific Setup

1. Install Android Studio
2. Install the Android SDK:
   ```bash
   sdkmanager "platform-tools" "platforms;android-33"
   ```
3. Accept Android licenses:
   ```bash
   flutter doctor --android-licenses
   ```

### Web Development

The web interface is built with Next.js and can be started with:

```bash
make run-web
```

### API Development

The API server uses Node.js and can be started with:

```bash
make run-api
```

### Troubleshooting

#### Common Issues

1. **Pod install fails**
   ```bash
   cd mobile/ios
   rm -rf Pods Podfile.lock
   pod install
   ```

2. **Flutter build fails**
   ```bash
   flutter clean
   flutter pub get
   ```

3. **Database connection issues**
   ```bash
   docker-compose down
   docker-compose up -d
   ```

4. **CocoaPods encoding issues**
   ```bash
   export LANG=en_US.UTF-8
   export LC_ALL=en_US.UTF-8
   cd mobile/ios && pod install
   ```

## Project Structure

```
meal-planner/
├── api/            # Node.js API server
├── mobile/         # Flutter mobile app
├── web/            # Next.js web interface
├── scripts/        # Installation and utility scripts
├── Makefile        # Project automation
└── docker-compose.yml
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
