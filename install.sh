#!/bin/bash
set -e

# Set variables
GITHUB_USER="yousafkhamza"
REPO="ckube"
INSTALL_DIR="/usr/local/bin"
RELEASE_URL="https://github.com/${GITHUB_USER}/${REPO}/releases/latest/download"
COMPLETION_DIR="/etc/bash_completion.d"
ZSH_COMPLETION_DIR="/usr/local/share/zsh/site-functions"

echo "Installing ckube..."

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  ARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
  ARCH="arm64"
fi

# Download binary
TMP_DIR=$(mktemp -d)
BINARY_URL="${RELEASE_URL}/ckube_${OS}_${ARCH}"
echo "Downloading from ${BINARY_URL}..."
curl -L "${BINARY_URL}" -o "${TMP_DIR}/ckube"

# Make executable and move to path
chmod +x "${TMP_DIR}/ckube"
sudo mv "${TMP_DIR}/ckube" "${INSTALL_DIR}/"

# Set up autocompletion
echo "Setting up shell autocompletion..."

# Generate autocompletion scripts
if [ -x "${INSTALL_DIR}/ckube" ]; then
  # Bash completion
  if [ -d "$COMPLETION_DIR" ] || sudo mkdir -p "$COMPLETION_DIR" 2>/dev/null; then
    echo "Setting up Bash completion..."
    "${INSTALL_DIR}/ckube" completion bash | sudo tee "$COMPLETION_DIR/ckube" > /dev/null
    echo "Bash completion installed at $COMPLETION_DIR/ckube"
  else
    echo "WARNING: Could not set up Bash completion. Directory $COMPLETION_DIR is not writable."
  fi
  
  # ZSH completion
  if [ -d "$ZSH_COMPLETION_DIR" ] || sudo mkdir -p "$ZSH_COMPLETION_DIR" 2>/dev/null; then
    echo "Setting up Zsh completion..."
    "${INSTALL_DIR}/ckube" completion zsh | sudo tee "$ZSH_COMPLETION_DIR/_ckube" > /dev/null
    echo "Zsh completion installed at $ZSH_COMPLETION_DIR/_ckube"
  else
    echo "WARNING: Could not set up Zsh completion. Directory $ZSH_COMPLETION_DIR is not writable."
  fi
  
  # Instructions for fish shell
  echo "If you use fish shell, you can set up completions with:"
  echo "  ${INSTALL_DIR}/ckube completion fish > ~/.config/fish/completions/ckube.fish"
fi

# Clean up
rm -rf "${TMP_DIR}"

echo "ckube has been installed to ${INSTALL_DIR}/ckube"
echo "You can now use it by running 'ckube'"
echo ""
echo "NOTE: You may need to restart your shell or source your shell config file to enable completions"
echo "For bash: source ~/.bashrc"
echo "For zsh: source ~/.zshrc"