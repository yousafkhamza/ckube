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

# Set up custom autocompletion
echo "Setting up shell autocompletion..."

# Create custom completion script for Bash
if [ -d "$COMPLETION_DIR" ] || sudo mkdir -p "$COMPLETION_DIR" 2>/dev/null; then
  echo "Setting up Bash completion..."
  
  # Create a basic completion script
  cat << 'EOF' | sudo tee "$COMPLETION_DIR/ckube" > /dev/null
#!/bin/bash

_ckube_completions()
{
  local cur prev opts
  COMPRECEPTY=${COMP_CWORD}
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  
  # Main command options
  opts="help version"
  
  # Get ckube commands from help output
  if [ ${COMP_CWORD} -eq 1 ]; then
    local cmds=$(ckube --help 2>/dev/null | grep -oE '^\s+[a-zA-Z0-9_-]+' | tr -d ' ' | sort)
    if [ -n "$cmds" ]; then
      opts="$opts $cmds"
    fi
  fi
  
  # Complete the arguments
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _ckube_completions ckube
EOF

  chmod +x "$COMPLETION_DIR/ckube"
  echo "Bash completion installed at $COMPLETION_DIR/ckube"
else
  echo "WARNING: Could not set up Bash completion. Directory $COMPLETION_DIR is not writable."
fi

# Create custom completion script for Zsh
if [ -d "$ZSH_COMPLETION_DIR" ] || sudo mkdir -p "$ZSH_COMPLETION_DIR" 2>/dev/null; then
  echo "Setting up Zsh completion..."
  
  # Create a basic completion script for Zsh
  cat << 'EOF' | sudo tee "$ZSH_COMPLETION_DIR/_ckube" > /dev/null
#compdef ckube

_ckube() {
  local -a commands
  
  # Get ckube commands from help output
  commands=($(ckube --help 2>/dev/null | grep -oE '^\s+[a-zA-Z0-9_-]+' | tr -d ' ' | sort))
  
  # Add standard options
  commands+=(
    'help:Show help information'
    'version:Show version information'
  )
  
  _describe 'command' commands
}

_ckube "$@"
EOF

  chmod +x "$ZSH_COMPLETION_DIR/_ckube"
  echo "Zsh completion installed at $ZSH_COMPLETION_DIR/_ckube"
else
  echo "WARNING: Could not set up Zsh completion. Directory $ZSH_COMPLETION_DIR is not writable."
fi

# Instructions for fish shell
echo "If you use fish shell, you can set up completions with:"
cat << 'EOF'
mkdir -p ~/.config/fish/completions
cat > ~/.config/fish/completions/ckube.fish << 'FISHEOF'
function __fish_ckube_commands
    ckube --help 2>/dev/null | grep -oE '^\s+[a-zA-Z0-9_-]+' | tr -d ' '
end

complete -f -c ckube -n "not __fish_seen_subcommand_from (__fish_ckube_commands)" -a "(__fish_ckube_commands)"
complete -f -c ckube -n "not __fish_seen_subcommand_from (__fish_ckube_commands)" -a "help" -d "Show help information"
complete -f -c ckube -n "not __fish_seen_subcommand_from (__fish_ckube_commands)" -a "version" -d "Show version information"
FISHEOF
EOF

# Clean up
rm -rf "${TMP_DIR}"

echo "ckube has been installed to ${INSTALL_DIR}/ckube"
echo "You can now use it by running 'ckube'"
echo ""
echo "NOTE: You may need to restart your shell or source your shell config file to enable completions"
echo "For bash: source ~/.bashrc or start a new terminal session"
echo "For zsh: source ~/.zshrc or start a new terminal session"