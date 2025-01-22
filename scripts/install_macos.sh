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
        
        # Add Homebrew to PATH
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
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
    fi
    print_success "Docker is running"
}

# Install Node.js and npm
install_node() {
    print_status "Checking Node.js installation..."
    if ! command -v node &> /dev/null; then
        print_status "Installing Node.js..."
        brew install node@20
        print_success "Node.js installed"
    else
        print_success "Node.js is already installed"
    fi

    # Install pnpm
    print_status "Installing pnpm..."
    npm install -g pnpm
}

# Install Flutter and dependencies
install_flutter() {
    print_status "Checking Flutter installation..."
    if ! command -v flutter &> /dev/null; then
        print_status "Installing Flutter..."
        brew install --cask flutter
    else
        print_success "Flutter is already installed"
    fi

    # Install CocoaPods
    print_status "Installing CocoaPods..."
    if ! command -v pod &> /dev/null; then
        brew install cocoapods
    fi
    
    # Install Ruby (required for CocoaPods)
    print_status "Installing Ruby..."
    if ! command -v rbenv &> /dev/null; then
        brew install rbenv ruby-build
        echo 'eval "$(rbenv init -)"' >> ~/.zshrc
        source ~/.zshrc
        rbenv install 3.4.1
        rbenv global 3.4.1
    fi

    # Set up Flutter
    print_status "Setting up Flutter..."
    flutter config --no-analytics
    flutter doctor
    
    # Accept Android licenses
    print_status "Accepting Android licenses..."
    flutter doctor --android-licenses
}

# Setup development environment
setup_dev_env() {
    print_status "Setting up development environment..."

    # Install PostgreSQL
    print_status "Installing PostgreSQL..."
    if ! command -v psql &> /dev/null; then
        brew install postgresql@14
        brew services start postgresql@14
    fi

    # Install development tools
    print_status "Installing development tools..."
    brew install git watchman

    # Set up environment variables
    print_status "Setting up environment variables..."
    if [ ! -f .env ]; then
        cp .env.example .env
        print_status "Created .env file from .env.example"
        print_status "Please update the .env file with your configuration"
    fi

    # Create mobile app symlink for .env
    if [ ! -f mobile/.env ]; then
        cd mobile && ln -s ../.env .env && cd ..
        print_status "Created .env symlink in mobile directory"
    fi

    # Install project dependencies
    print_status "Installing project dependencies..."
    pnpm install
    cd mobile && flutter pub get && cd ..
    cd api && pnpm install && cd ..
    cd web && pnpm install && cd ..
}

# Main installation process
main() {
    print_status "Starting installation process..."
    
    # Check system requirements
    check_brew
    check_docker
    
    # Install main dependencies
    install_node
    install_flutter
    
    # Setup development environment
    setup_dev_env
    
    print_success "Installation complete!"
    print_status "Please restart your terminal for all changes to take effect"
    print_status "Run 'make help' to see available commands"
}

# Set environment variables for CocoaPods
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Run main installation
main
