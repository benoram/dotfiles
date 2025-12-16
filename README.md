# dotfiles

Personal configuration files and development environment setup for macOS 26 (Sequoia).

## Quick Start

Run the bootstrap script to set up your Mac:

```bash
git clone https://github.com/benoram/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

The bootstrap script will:
- Install Homebrew (if not already installed)
- Install packages and applications from the Brewfile
- Symlink dotfiles from the `config/` directory to your home directory
- Apply macOS system preferences from `macos/defaults.sh`
- Run additional setup scripts from the `scripts/` directory

## Repository Structure

```
.
├── bootstrap.sh           # Main setup script
├── Brewfile              # Homebrew packages and applications
├── config/               # Dotfiles (symlinked to ~/)
│   ├── zshrc            # Zsh configuration
│   ├── gitconfig        # Git configuration
│   └── gitignore_global # Global gitignore
├── macos/
│   └── defaults.sh      # macOS system preferences
└── scripts/             # Additional setup scripts
    └── setup-dev-tools.sh
```

## Contents

### Bootstrap Script (`bootstrap.sh`)
The main setup script that orchestrates the entire setup process:
- Checks for macOS compatibility
- Installs and updates Homebrew
- Processes the Brewfile
- Creates symlinks for dotfiles
- Applies macOS defaults
- Runs additional setup scripts

### Brewfile
Defines all packages and applications to install via Homebrew:
- Command-line tools (git, vim, tmux, etc.)
- GUI applications (VS Code, iTerm2, Docker, etc.)
- Fonts (Fira Code, JetBrains Mono)

### Configuration Files (`config/`)
Dotfiles that will be symlinked to your home directory:
- **zshrc**: Zsh shell configuration with aliases and environment setup
- **gitconfig**: Git global configuration and aliases
- **gitignore_global**: Global gitignore patterns for common files

### macOS Defaults (`macos/defaults.sh`)
System preferences and settings including:
- UI/UX improvements
- Trackpad and keyboard settings
- Finder configuration
- Dock preferences
- Safari settings
- Screenshot preferences
- And more...

### Setup Scripts (`scripts/`)
Additional setup scripts for specific tasks:
- **setup-dev-tools.sh**: Configures development tools and creates project directories

### VS Code Settings
- **[.vscode/settings.json](.vscode/settings.json)** - VS Code workspace settings
  - Sets Claude Sonnet 4.5 as the default GitHub Copilot chat model

## Manual Steps

After running the bootstrap script, you may want to:

1. **Update Git configuration** with your personal information:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. **Install Oh My Zsh** (optional):
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **Restart your Mac** to apply all system preferences

4. **Sign in to applications** installed via Homebrew Cask

## Customization

### Adding More Packages
Edit `Brewfile` and run:
```bash
brew bundle install
```

### Adding More Dotfiles
1. Add your dotfile to the `config/` directory (without the leading dot)
2. Run the bootstrap script again, or manually symlink:
   ```bash
   ln -sf ~/.dotfiles/config/your-file ~/.your-file
   ```

### Adding Setup Scripts
1. Create a new `.sh` file in the `scripts/` directory
2. Make it executable: `chmod +x scripts/your-script.sh`
3. Run the bootstrap script again, or execute it manually

## Requirements

- macOS 26 (Sequoia) or compatible version
- Internet connection
- Administrator access (for some system preferences)

## Notes

- The bootstrap script creates backups of existing dotfiles with a `.backup` extension
- Some macOS defaults require logging out or restarting to take effect
- The script is idempotent - it's safe to run multiple times

## License

This is a personal dotfiles repository. Feel free to use it as inspiration for your own setup!