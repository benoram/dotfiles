#!/usr/bin/env bash
#
# bootstrap.sh
# Bootstrap script for setting up a new Mac development environment
# Designed for macOS 26 (Sequoia)

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info "Starting dotfiles bootstrap process..."
info "Dotfiles directory: $DOTFILES_DIR"

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    error "This script is designed for macOS only."
    exit 1
fi

# Check macOS version
MACOS_VERSION=$(sw_vers -productVersion)
info "Running on macOS $MACOS_VERSION"

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    info "Homebrew is already installed"
fi

# Update Homebrew
info "Updating Homebrew..."
brew update

# Install packages from Brewfile
if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
    info "Installing packages from Brewfile..."
    brew bundle install --file="$DOTFILES_DIR/Brewfile"
else
    warn "Brewfile not found, skipping package installation"
fi

# Symlink dotfiles from config directory
if [[ -d "$DOTFILES_DIR/config" ]]; then
    info "Symlinking dotfiles..."
    for file in "$DOTFILES_DIR/config/"*; do
        if [[ -f "$file" ]]; then
            filename=$(basename "$file")
            target="$HOME/.$filename"
            
            # Backup existing file if it exists and is not a symlink
            if [[ -f "$target" && ! -L "$target" ]]; then
                warn "Backing up existing $filename to $filename.backup"
                mv "$target" "$target.backup"
            fi
            
            # Create symlink
            ln -sf "$file" "$target"
            info "Linked $filename"
        fi
    done
else
    warn "Config directory not found, skipping dotfile symlinking"
fi

# Run macOS defaults script
if [[ -f "$DOTFILES_DIR/macos/defaults.sh" ]]; then
    info "Applying macOS defaults..."
    bash "$DOTFILES_DIR/macos/defaults.sh"
else
    warn "macOS defaults script not found, skipping"
fi

# Run additional setup scripts
if [[ -d "$DOTFILES_DIR/scripts" ]]; then
    for script in "$DOTFILES_DIR/scripts/"*.sh; do
        if [[ -f "$script" && -x "$script" ]]; then
            info "Running $(basename "$script")..."
            bash "$script"
        fi
    done
fi

info "Bootstrap complete! 🎉"
info "Some changes may require a restart to take effect."
