#!/bin/bash
set -e

# Set variables
GITHUB_USER="yousafkhamza"
REPO="kubectl-columns"
INSTALL_DIR="/usr/local/bin"
RELEASE_URL="https://github.com/${GITHUB_USER}/${REPO}/releases/latest/download"

echo "Installing kubectl-columns..."

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
BINARY_URL="${RELEASE_URL}/kubectl-columns_${OS}_${ARCH}"
curl -L "${BINARY_URL}" -o "${TMP_DIR}/kubectl-columns"

# Make executable and move to path
chmod +x "${TMP_DIR}/kubectl-columns"
sudo mv "${TMP_DIR}/kubectl-columns" "${INSTALL_DIR}/"

# Clean up
rm -rf "${TMP_DIR}"

echo "kubectl-columns has been installed to ${INSTALL_DIR}/kubectl-columns"
echo "You can now use it by running 'kubectl-columns'"