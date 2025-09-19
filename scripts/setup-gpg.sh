#!/bin/bash
# GPG Setup Wizard for Dotfiles
# Configures GPG signing keys for personal and work git identities

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Check if GPG is installed
check_gpg_installation() {
  log_info "Checking GPG installation..."

  if ! command -v gpg &>/dev/null; then
    log_error "GPG is not installed. Please install it first:"
    log_info "  brew install gnupg"
    exit 1
  fi

  if ! command -v pinentry-mac &>/dev/null; then
    log_warning "pinentry-mac not found. Installing via brew..."
    brew install pinentry-mac
  fi

  log_success "GPG installation verified"
}

# Get all available GPG keys
get_gpg_keys() {
  local temp_file
  temp_file=$(mktemp)
  gpg --list-secret-keys --keyid-format LONG >"$temp_file"

  local current_key=""
  while IFS= read -r line; do
    if echo "$line" | grep -q "^sec.*rsa.*/"; then
      current_key=$(echo "$line" | sed -n 's/.*\/\([A-F0-9]\{16\}\).*/\1/p')
    elif echo "$line" | grep -q "uid.*<.*@.*>" && [[ -n "$current_key" ]]; then
      local email
      email=$(echo "$line" | sed -n 's/.*<\([^>]*\)>.*/\1/p')
      if [[ -n "$email" ]]; then
        echo "$current_key:$email"
        current_key=""
      fi
    fi
  done <"$temp_file"

  rm -f "$temp_file"
}

# Extract email from GPG key
extract_email_from_key() {
  local key_id="$1"
  gpg --list-secret-keys --keyid-format LONG "$key_id" 2>/dev/null |
    grep -E "uid.*<.*@.*>" |
    head -1 |
    sed 's/.*<\(.*@.*\)>.*/\1/'
}

# Find GPG key for specific email
find_key_for_email() {
  local target_email="$1"
  local keys_info
  keys_info=$(get_gpg_keys)

  while IFS=':' read -r key_id email; do
    if [[ "$email" == "$target_email" ]]; then
      echo "$key_id"
      return 0
    fi
  done <<<"$keys_info"

  return 1
}

# Validate key can sign
validate_key_can_sign() {
  local key_id="$1"
  echo "test" | gpg --local-user "$key_id" --sign --armor >/dev/null 2>&1
}

# Configure signing key in gitconfig
configure_signing_key() {
  local config_file="$1"
  local email="$2"
  local key_id="$3"

  log_info "Configuring signing key for $config_file (email: $email)"

  # Validate key can actually sign
  if ! validate_key_can_sign "$key_id"; then
    log_error "Key $key_id cannot sign. Check key trust and capabilities."
    return 1
  fi

  # Check if signing key already exists
  if grep -q "signingkey" "$config_file" 2>/dev/null; then
    log_warning "Signing key already exists in $config_file"
    read -r -p "Do you want to replace it? (y/N): " replace
    if [[ ! "$replace" =~ ^[Yy]$ ]]; then
      log_info "Skipping $config_file"
      return 0
    fi

    # Remove existing signing key
    sed -i '' '/signingkey/d' "$config_file"
    sed -i '' '/gpgsign/d' "$config_file"
  fi

  # Add commit section if it doesn't exist
  if ! grep -q "\[commit\]" "$config_file"; then
    echo "" >>"$config_file"
    echo "[commit]" >>"$config_file"
  fi

  # Add signing configuration after [commit] section
  sed -i '' '/\[commit\]/a\
	gpgsign = true\
	signingkey = '"$key_id"'' "$config_file"

  log_success "Configured signing key $key_id for $config_file"
}

# Test GPG signing
test_gpg_signing() {
  local test_dir="/tmp/gpg-test-$$"
  local success=true

  log_info "Testing GPG signing functionality..."

  mkdir -p "$test_dir"
  cd "$test_dir"

  # Initialize a test git repo
  git init --quiet

  # Test personal config
  log_info "Testing personal identity..."
  cp "$DOTFILES_DIR/gitconfig.personal" .gitconfig
  echo "test file" >test.md
  git add -f test.md # Force add to bypass gitignore

  if git commit -S -m "Test commit for personal identity" --quiet 2>/dev/null; then
    log_success "Personal identity signing works"
  else
    log_error "Personal identity signing failed"
    success=false
  fi

  # Clean up and test work config
  rm -rf .git
  git init --quiet

  log_info "Testing work identity..."
  cp "$DOTFILES_DIR/gitconfig.work" .gitconfig
  echo "test file 2" >test2.md
  git add -f test2.md # Force add to bypass gitignore

  if git commit -S -m "Test commit for work identity" --quiet 2>/dev/null; then
    log_success "Work identity signing works"
  else
    log_error "Work identity signing failed"
    success=false
  fi

  # Cleanup
  cd - >/dev/null
  rm -rf "$test_dir"

  if $success; then
    log_success "All GPG signing tests passed!"
  else
    log_error "Some GPG signing tests failed. Check your configuration."
    return 1
  fi
}

# Main setup function
main() {
  echo "=================================="
  echo "    GPG Setup Wizard for Dotfiles"
  echo "=================================="
  echo

  check_gpg_installation

  log_info "Detecting existing GPG keys..."
  local keys_info
  keys_info=$(get_gpg_keys)

  if [[ -z "$keys_info" ]]; then
    log_error "No GPG keys found!"
    log_info "Please generate GPG keys first:"
    log_info "  gpg --full-generate-key"
    log_info "Then run this script again."
    exit 1
  fi

  echo
  log_info "Found GPG keys:"
  while IFS=':' read -r key_id email; do
    echo "  $key_id -> $email"
  done <<<"$keys_info"
  echo

  # Configure personal identity
  local personal_email="justin@larsen.dev"
  local personal_key
  if personal_key=$(find_key_for_email "$personal_email"); then
    log_info "Found key for personal email ($personal_email): $personal_key"
    configure_signing_key "$DOTFILES_DIR/gitconfig.personal" "$personal_email" "$personal_key"
  else
    log_warning "No GPG key found for personal email: $personal_email"
    log_info "Available keys:"
    while IFS=':' read -r key_id email; do
      echo "  $key_id -> $email"
    done <<<"$keys_info"
  fi

  # Configure work identity
  local work_email="jlarsen@traeger.com"
  local work_key
  if work_key=$(find_key_for_email "$work_email"); then
    log_info "Found key for work email ($work_email): $work_key"
    configure_signing_key "$DOTFILES_DIR/gitconfig.work" "$work_email" "$work_key"
  else
    log_warning "No GPG key found for work email: $work_email"
    log_info "Available keys:"
    while IFS=':' read -r key_id email; do
      echo "  $key_id -> $email"
    done <<<"$keys_info"
  fi

  echo
  log_info "GPG configuration complete!"

  # Test signing if requested
  read -r -p "Do you want to test GPG signing? (Y/n): " test_signing
  if [[ ! "$test_signing" =~ ^[Nn]$ ]]; then
    echo
    test_gpg_signing
  fi

  echo
  log_success "GPG setup wizard completed successfully!"
  log_info "Your git repositories in ~/development/personal/ will now use personal GPG signing"
  log_info "Your git repositories in ~/development/work/ will now use work GPG signing"
}

# Run the main function
main "$@"
