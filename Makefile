.PHONY: help install run-api run-mobile run-web test clean

# Default target when running just 'make'
help:
	@echo "Available commands:"
	@echo "  make install     - Install all dependencies"
	@echo "  make run-api     - Run the API server"
	@echo "  make run-mobile  - Run the mobile app"
	@echo "  make run-web     - Run the web app"
	@echo "  make test        - Run all tests"
	@echo "  make clean       - Clean all build artifacts"

# Install dependencies
install:
	@echo "Installing dependencies..."
	@./scripts/install_macos.sh

# Run the API server
run-api:
	@echo "Starting API server..."
	@cd api && npm run dev

# Run the mobile app (iOS simulator by default)
run-mobile:
	@echo "Starting mobile app..."
	@cd mobile && flutter run

# Run the mobile app on iOS
run-mobile-ios:
	@echo "Starting mobile app on iOS..."
	@cd mobile && flutter run -d ios

# Run the mobile app on Android
run-mobile-android:
	@echo "Starting mobile app on Android..."
	@cd mobile && flutter run -d android

# Run the web app
run-web:
	@echo "Starting web app..."
	@cd web && npm run dev

# Run all tests
test:
	@echo "Running API tests..."
	@cd api && npm test
	@echo "Running mobile tests..."
	@cd mobile && flutter test
	@echo "Running web tests..."
	@cd web && npm test

# Clean all build artifacts
clean:
	@echo "Cleaning API..."
	@cd api && rm -rf node_modules
	@echo "Cleaning mobile..."
	@cd mobile && flutter clean
	@echo "Cleaning web..."
	@cd web && rm -rf node_modules .next

# Clean and reinstall everything
reset: clean install
