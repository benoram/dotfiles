# dotfiles

Personal configuration files and development environment setup for macOS and Linux.

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
- **On macOS:**
  - Installs Homebrew (if needed)
  - Installs packages and applications from Brewfile
  - Applies macOS system preferences
  - Runs Touch ID setup for sudo
- **On Linux:**
  - Installs Starship prompt automatically
  - Skips macOS-specific installations
  - Provides guidance for other manual package installations
- **On both platforms:**
  - Symlinks dotfiles from `config/` to your home directory
  - Runs common setup scripts

## Repository Structure

```
.
├── bootstrap.sh           # Main setup script
├── Brewfile              # Homebrew packages and applications
├── config/               # Dotfiles (symlinked to ~/)
│   ├── zshrc            # Zsh configuration with Starship
│   ├── bashrc           # Bash configuration with Starship
│   ├── gitconfig        # Git configuration
│   └── gitignore_global # Global gitignore
├── macos/
│   └── defaults.sh      # macOS system preferences
└── scripts/             # Additional setup scripts
    └── setup-dev-tools.sh
```

## Contents

### Bootstrap Script
Main setup script that orchestrates the entire installation process. Automatically detects the operating system and runs appropriate setup steps for macOS or Linux.

### Brewfile (macOS only)
Defines packages and applications to install via Homebrew on macOS including:
- **Command-line tools** - git, zsh, node, python, gh (GitHub CLI), starship (cross-shell prompt), and more
- **GUI applications** - VS Code, OrbStack, GitHub Desktop, Tailscale, Yubico Authenticator
- **Mac App Store apps** - 1Password for Safari, Drafts, Magnet, Soulver 3, Todoist, Things, Windows App, Pages, Xcode
- **Fonts** - Fira Code, JetBrains Mono, Meslo LG Nerd Font

### Configuration Files (`config/`)
Dotfiles symlinked to your home directory (compatible with both macOS and Linux):
- **zshrc** - Zsh shell configuration with Starship prompt
- **bashrc** - Bash shell configuration with Starship prompt
- **gitconfig** - Git global configuration and aliases
- **gitignore_global** - Global gitignore patterns

### macOS Defaults (`macos/defaults.sh`) - macOS only
System preferences: UI/UX improvements, trackpad/keyboard settings, Finder, Dock, Safari, screenshots, and more. Automatically skipped on Linux.

### Setup Scripts (`scripts/`)
- **setup-dev-tools.sh** - Configures development tools and creates project directories (works on both macOS and Linux)
- **setup-touchid-sudo.sh** - Enables Touch ID for sudo commands (macOS only, automatically skipped on Linux)

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

### Customizing Starship Prompt
Starship can be customized by creating a configuration file at `~/.config/starship.toml`. This allows you to modify the prompt appearance, modules, and behavior to suit your preferences.

To customize your Starship prompt:
1. Create the configuration directory and file:
   ```bash
   mkdir -p ~/.config
   touch ~/.config/starship.toml
   ```
2. Add your customizations to `~/.config/starship.toml`
3. Refer to the [Starship Configuration Documentation](https://starship.rs/config/) for available options and examples

## Requirements

### For macOS:
- macOS 26 (Sequoia) or compatible version
- Internet connection
- Administrator access (for system preferences and Homebrew installation)
- Signed in to the Mac App Store (for Mac App Store app installations via `mas`)

### For Linux:
- Linux distribution (tested on Ubuntu)
- Internet connection
- Basic command-line tools (bash, curl, git)
- Administrator access (for some configurations)

### Recommended for Linux:
Before running the bootstrap script, consider manually installing:
- **Essential tools**: git, zsh, curl, wget, htop, tree, jq
- **Development tools**: Node.js, Python, GitHub CLI (gh)

Note: The bootstrap script automatically installs Starship prompt on Linux.

## Notes

- The bootstrap script creates backups of existing dotfiles with a `.backup` extension
- The script automatically detects your operating system and runs appropriate setup steps
- On macOS: Some defaults require logging out or restarting to take effect
- On Linux: macOS-specific features (Homebrew, system preferences, Touch ID) are automatically skipped
- The script is idempotent - it's safe to run multiple times
- For GitHub Codespaces: The devcontainer automatically runs the bootstrap script on creation

## License

This is a personal dotfiles repository. Feel free to use it as inspiration for your own setup!