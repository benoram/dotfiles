#!/usr/bin/env bash
#
# scripts/setup-touchid-sudo.sh
# Enable Touch ID for sudo authentication in Terminal

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

# Add Touch ID support at the top of the file (after comments)
# This will allow Touch ID authentication for sudo commands
sudo sed -i '' '2i\
'"$TOUCHID_LINE"'
' "$PAM_FILE"

if sudo grep -q "pam_tid.so" "$PAM_FILE"; then
    echo "✓ Touch ID for sudo configured successfully"
    echo "  You can now use Touch ID when running sudo commands in Terminal"
else
    echo "✗ Failed to configure Touch ID for sudo"
    exit 1
fi
