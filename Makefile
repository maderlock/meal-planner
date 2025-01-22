.PHONY: help install run-api run-mobile run-web test clean list-devices

# Default target when running just 'make'
help:
	@echo "Available commands:"
	@echo "  make install              - Install all dependencies"
	@echo "  make run-api              - Run the API server"
	@echo "  make run-mobile           - Run the mobile app"
	@echo "  make run-web              - Run the web app"
	@echo "  make test                 - Run all tests"
	@echo "  make clean                - Clean all build artifacts"
	@echo "  make list-devices         - List available devices"
	@echo ""
	@echo "Mobile app commands:"
	@echo "  make clear-ios-sim        - Clear data in iOS app"
	@echo "  make run-mobile-ios       - Run iOS app"
	@echo "  make run-mobile-ios-clean - Run iOS app with clean build"
	@echo "  make run-mobile-android   - Run Android app"
	@echo "  make run-mobile-android-clean - Run Android app with clean build"

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
	@cd mobile && flutter run -d iPhone

# Run the mobile app on iOS with clean build
run-mobile-ios-clean:
	@echo "Cleaning and rebuilding iOS app..."
	@cd mobile && \
		flutter clean && \
		flutter pub get && \
		cd ios && \
		rm -rf Pods Podfile.lock && \
		export LANG=en_US.UTF-8 && \
		export LC_ALL=en_US.UTF-8 && \
		pod install --repo-update && \
		cd .. && \
		flutter run -d iPhone

# Run the mobile app on Android
run-mobile-android:
	@echo "Starting mobile app on Android..."
	@cd mobile && flutter run -d android

# Run the mobile app on Android with clean build
run-mobile-android-clean:
	@echo "Cleaning and rebuilding Android app..."
	@cd mobile && \
		flutter clean && \
		flutter pub get && \
		cd android && \
		./gradlew clean && \
		cd .. && \
		flutter run -d android

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

# List available devices
list-devices:
	@echo "Available devices:"
	@flutter devices

# Clear iOS simulation data
clear-ios-sim:
	@echo "Cleaning iOS simulation data..."
	@cd mobile && xcrun simctl spawn booted defaults write com.apple.mobilesafari WebKitWebDataStorePerOriginQuotaIncreased -bool true && xcrun simctl spawn booted defaults write com.apple.mobilesafari WebKitStorageBlockingPolicy -int 0
	@cd mobile && xcrun simctl keychain 56BFBD52-E04F-49BD-A47E-061336C860F7 reset

# Clean all build artifacts
clean:
	@echo "Cleaning API..."
	@cd api && rm -rf node_modules
	@echo "Cleaning mobile..."
	@cd mobile && flutter clean && rm -rf ios/Pods ios/Podfile.lock
	@echo "Cleaning web..."
	@cd web && rm -rf node_modules .next
	@echo "All clean!"
