#!/bin/bash
set -e

# Set variables
GITHUB_USER="yousafkhamza"
REPO="ckube"
INSTALL_DIR="/usr/local/bin"
RELEASE_URL="https://github.com/${GITHUB_USER}/${REPO}/releases/latest/download"

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
curl -L "${BINARY_URL}" -o "${TMP_DIR}/ckube"

# Make executable and move to path
chmod +x "${TMP_DIR}/ckube"
sudo mv "${TMP_DIR}/ckube" "${INSTALL_DIR}/"

# Clean up
rm -rf "${TMP_DIR}"

echo "ckube has been installed to ${INSTALL_DIR}/ckube"
echo "You can now use it by running 'ckube'"