#!/usr/bin/env bash
#
# scripts/macos-setup-touchid-sudo.sh
# Enable Touch ID for sudo authentication in Terminal (macOS only)

echo "Setting up Touch ID for sudo..."

PAM_FILE="/etc/pam.d/sudo"
TOUCHID_LINE="auth       sufficient     pam_tid.so"

# Check if already configured
if sudo grep -q "pam_tid.so" "$PAM_FILE" 2>/dev/null; then
    echo "✓ Touch ID for sudo is already configured"
    exit 0
fi

# Backup the original file
if [[ ! -f "$PAM_FILE.backup" ]]; then
    sudo cp "$PAM_FILE" "$PAM_FILE.backup"
    echo "✓ Created backup of $PAM_FILE"
fi

# Add Touch ID support after the first non-comment line
# This will allow Touch ID authentication for sudo commands
# Use a more robust approach that finds the first 'auth' line and inserts before it
if sudo grep -q "^auth" "$PAM_FILE"; then
    # Insert before the first auth line
    sudo sed -i '' "/^auth/i\\
$TOUCHID_LINE
" "$PAM_FILE"
else
    # Fallback: insert after comment block (after first non-comment, non-empty line)
    sudo sed -i '' "1a\\
$TOUCHID_LINE
" "$PAM_FILE"
fi

if sudo grep -q "pam_tid.so" "$PAM_FILE"; then
    echo "✓ Touch ID for sudo configured successfully"
    echo "  You can now use Touch ID when running sudo commands in Terminal"
else
    echo "✗ Failed to configure Touch ID for sudo"
    exit 1
fi
