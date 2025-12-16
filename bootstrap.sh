#!/usr/bin/env bash
#
# bootstrap.sh
# Bootstrap script for setting up a development environment
# Compatible with macOS and Linux

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

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info "Starting dotfiles bootstrap process..."
info "Dotfiles directory: $DOTFILES_DIR"

# Detect and display OS
OS_TYPE=$(detect_os)
info "Detected OS: $OS_TYPE"

# Warn if OS is not explicitly supported
if [[ "$OS_TYPE" == "unknown" ]]; then
    warn "Unknown operating system detected. Some setup steps may be skipped or unsupported."
fi
# Check macOS version if on macOS
if [[ "$OS_TYPE" == "macos" ]]; then
    MACOS_VERSION=$(sw_vers -productVersion)
    info "Running on macOS $MACOS_VERSION"
elif [[ "$OS_TYPE" == "linux" ]]; then
    if [[ -f /etc/os-release ]]; then
        LINUX_DISTRO=$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
        info "Running on Linux: $LINUX_DISTRO"
    else
        info "Running on Linux"
    fi
fi

# Install Homebrew on macOS if not already installed
if [[ "$OS_TYPE" == "macos" ]]; then
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
else
    info "Skipping Homebrew installation (not on macOS)"
    
    # On Linux, install Starship and suggest other packages
    if [[ "$OS_TYPE" == "linux" ]]; then
        # Install Starship prompt automatically
        if ! command -v starship &> /dev/null; then
            info "Installing Starship prompt..."
            if curl -fsSL https://starship.rs/install.sh | sh -s -- -y; then
                info "Starship installed successfully"
            else
                warn "Failed to install Starship. You can install it manually later:"
                warn "  curl -fsSL https://starship.rs/install.sh | sh"
            fi
        else
            info "Starship is already installed"
        fi
        
        info "Other packages you may want to install manually:"
        info "  - git, zsh, curl, wget, htop, tree, jq"
        info "  - Node.js, Python, GitHub CLI (gh)"
    fi
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

# Run macOS defaults script (macOS only)
if [[ "$OS_TYPE" == "macos" ]]; then
    if [[ -f "$DOTFILES_DIR/macos/defaults.sh" ]]; then
        info "Applying macOS defaults..."
        bash "$DOTFILES_DIR/macos/defaults.sh"
    else
        warn "macOS defaults script not found, skipping"
    fi
else
    info "Skipping macOS defaults (not on macOS)"
fi

# Run additional setup scripts
if [[ -d "$DOTFILES_DIR/scripts" ]]; then
    for script in "$DOTFILES_DIR/scripts/"*.sh; do
        if [[ -f "$script" ]]; then
            script_name=$(basename "$script")
            
            # Skip macOS-specific scripts on Linux
            if [[ "$OS_TYPE" != "macos" && "$script_name" == "setup-touchid-sudo.sh" ]]; then
                info "Skipping $script_name (macOS only)"
                continue
            fi
            
            info "Running $script_name..."
            bash "$script"
        fi
    done
fi

info "Bootstrap complete! 🎉"
info "Some changes may require a restart to take effect."
