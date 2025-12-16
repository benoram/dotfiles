#!/usr/bin/env bash
#
# scripts/setup-dev-tools.sh
# Additional setup for development tools and configurations

echo "Setting up development tools..."

# Configure Git to use the global gitignore
if [[ -f "$HOME/.gitignore_global" ]]; then
    git config --global core.excludesfile ~/.gitignore_global
    echo "✓ Configured global gitignore"
fi

# Install Oh My Zsh (optional)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Oh My Zsh not found. To install, run:"
    echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
else
    echo "✓ Oh My Zsh already installed"
fi

# Create common development directories
mkdir -p ~/Projects
mkdir -p ~/Projects/personal
mkdir -p ~/Projects/work
echo "✓ Created development directories"

echo "Development tools setup complete!"
