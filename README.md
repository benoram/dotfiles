# dotfiles

Personal configuration files and development environment setup for macOS 26 (Sequoia).

## One-Line Install

Deploy these dotfiles to a new machine with a single command:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/benoram/dotfiles/main/bootstrap.sh)"
```

## Quick Start

For more control, clone and run the bootstrap script manually:

```bash
git clone https://github.com/benoram/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

**What it does:**
- Installs Homebrew (if needed)
- Installs packages and applications from Brewfile
- Symlinks dotfiles from `config/` to your home directory
- Applies macOS system preferences
- Runs additional setup scripts

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

### Bootstrap Script
Main setup script that orchestrates the entire installation process.

### Brewfile
Defines packages and applications to install via Homebrew including command-line tools (git, zsh, node, python, etc.), GUI applications (VS Code), and fonts.

### Configuration Files (`config/`)
Dotfiles symlinked to your home directory:
- **zshrc** - Zsh shell configuration
- **gitconfig** - Git global configuration and aliases
- **gitignore_global** - Global gitignore patterns

### macOS Defaults (`macos/defaults.sh`)
System preferences: UI/UX improvements, trackpad/keyboard settings, Finder, Dock, Safari, screenshots, and more.

### Setup Scripts (`scripts/`)
- **setup-dev-tools.sh** - Configures development tools and creates project directories
- **setup-touchid-sudo.sh** - Enables Touch ID for sudo commands

### VS Code Settings
- **[.vscode/settings.json](.vscode/settings.json)** - Sets Claude Sonnet 4.5 as default GitHub Copilot chat model

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