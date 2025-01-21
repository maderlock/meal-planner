#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
    echo -e "${YELLOW}==>${NC} $1"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}==>${NC} $1"
}

# Function to print error messages
print_error() {
    echo -e "${RED}==>${NC} $1"
}

# Check if Homebrew is installed
check_brew() {
    print_status "Checking if Homebrew is installed..."
    if ! command -v brew &> /dev/null; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        print_success "Homebrew is already installed"
    fi
}

# Check if Docker is installed and running
check_docker() {
    print_status "Checking if Docker is installed..."
    if ! command -v docker &> /dev/null; then
        print_status "Installing Docker..."
        brew install --cask docker
        print_status "Please open Docker.app from your Applications folder to complete the installation"
        print_status "Press any key once Docker is running..."
        read -n 1 -s
    else
        print_success "Docker is already installed"
    fi

    # Check if Docker daemon is running
    if ! docker info &> /dev/null; then
        print_error "Docker daemon is not running. Please start Docker and try again"
        exit 1
    else
        print_success "Docker daemon is running"
    fi
}

# Install Node.js
install_node() {
    print_status "Checking if Node.js is installed..."
    if ! command -v node &> /dev/null; then
        print_status "Installing Node.js..."
        brew install node@18
        print_success "Node.js installed"
    else
        NODE_VERSION=$(node -v)
        if [[ ${NODE_VERSION:1:2} -lt 18 ]]; then
            print_status "Upgrading Node.js to v18..."
            brew install node@18
        else
            print_success "Node.js v${NODE_VERSION} is already installed"
        fi
    fi
}

# Install Flutter and dependencies
install_flutter() {
    print_status "Checking if Flutter is installed..."
    if ! command -v flutter &> /dev/null; then
        print_status "Installing Flutter..."
        brew install --cask flutter
    else
        print_success "Flutter is already installed"
    fi

    # Check if Xcode is installed
    print_status "Checking if Xcode is installed..."
    if ! command -v xcodebuild &> /dev/null; then
        print_error "Xcode is not installed. Please install Xcode from the App Store"
        print_error "After installing Xcode, run:"
        print_error "sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer"
        print_error "sudo xcodebuild -runFirstLaunch"
    else
        print_success "Xcode is installed"
    fi

    # Check if CocoaPods is installed
    print_status "Checking if CocoaPods is installed..."
    if ! command -v pod &> /dev/null; then
        print_status "Installing CocoaPods..."
        sudo gem install cocoapods
    else
        print_success "CocoaPods is already installed"
    fi

    # Check if Android Studio is installed
    print_status "Checking if Android Studio is installed..."
    if [ ! -d "/Applications/Android Studio.app" ]; then
        print_error "Android Studio is not installed"
        print_error "Please download and install Android Studio from:"
        print_error "https://developer.android.com/studio"
    else
        print_success "Android Studio is installed"
    fi
}

# Setup development environment
setup_dev_env() {
    print_status "Setting up development environment..."

    # Create .env file if it doesn't exist
    if [ ! -f .env ]; then
        print_status "Creating .env file..."
        cp .env.example .env
        print_success "Created .env file. Please update it with your configuration"
    fi

    # Install admin dependencies
    print_status "Installing admin dependencies..."
    cd admin && npm install
    
    # Generate Prisma client and run migrations
    print_status "Setting up database..."
    npx prisma generate
    docker-compose up -d postgres
    sleep 5  # Wait for postgres to start
    npx prisma migrate deploy
    
    cd ..
    print_success "Development environment setup complete"
}

# Main installation process
main() {
    echo "Starting installation process for Meal Planner..."
    
    check_brew
    check_docker
    install_node
    install_flutter
    setup_dev_env
    
    print_success "Installation complete!"
    print_status "Next steps:"
    echo "1. Update the .env file with your configuration"
    echo "2. Install Xcode from the App Store if not already installed"
    echo "3. Install Android Studio if not already installed"
    echo "4. Run 'flutter doctor' to verify your Flutter installation"
    echo "5. Start the admin interface with 'cd admin && npm run dev'"
}

# Run main installation
main
