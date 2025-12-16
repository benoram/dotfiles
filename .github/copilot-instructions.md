# GitHub Copilot Instructions for dotfiles

## Project Overview
This is a dotfiles repository for managing personal configuration files and development environment setup.

## Code Changes and Pull Request Process

### **CRITICAL: All changes MUST follow a pull request workflow**
- Never commit directly to the `main` branch
- Always create a new branch for any changes
- All pull requests require a GitHub issue - create an issue first if one doesn't exist
- Open a pull request for review before merging
- Ensure all changes are reviewed and approved

### Branch Naming Convention
Use descriptive branch names following this pattern:
- `feature/` - for new configurations or scripts
- `fix/` - for bug fixes or corrections
- `docs/` - for documentation updates
- `refactor/` - for restructuring existing configurations

## Documentation Requirements

### **Keep Documentation Up to Date**
- Update the README.md whenever:
  - Adding new configuration files
  - Introducing new installation scripts
  - Changing setup procedures
  - Adding dependencies or prerequisites
  - Modifying directory structure
- Document all configuration file purposes and usage
- Include clear installation and setup instructions
- Maintain a changelog for significant updates
- Document any platform-specific configurations (Linux, macOS, Windows)

### Documentation Standards
- Use clear, concise language
- Include code examples where applicable
- Document any environment variables or prerequisites
- Explain the purpose and impact of configuration changes
- Keep table of contents updated if present

## Best Practices for Dotfiles

### File Organization
- Group related configurations together
- Use consistent naming conventions
- Maintain clear directory structure
- Include comments in configuration files explaining non-obvious settings

### Compatibility
- Note OS-specific configurations clearly
- Test changes across supported platforms when possible
- Document any platform-specific dependencies

### Security
- Never commit sensitive information (API keys, passwords, tokens)
- Use environment variables or separate untracked files for secrets
- Add sensitive file patterns to .gitignore

## Commit Message Guidelines
- Use clear, descriptive commit messages
- Start with a verb (Add, Update, Fix, Remove, Refactor)
- Reference related issues or PRs when applicable
- Keep commits atomic and focused on single changes

## Review Checklist
Before submitting a pull request, ensure:
- [ ] Documentation is updated to reflect changes
- [ ] Configuration files include explanatory comments
- [ ] No sensitive information is committed
- [ ] Changes are tested in relevant environment(s)
- [ ] Commit messages are clear and descriptive
- [ ] Branch follows naming conventions
