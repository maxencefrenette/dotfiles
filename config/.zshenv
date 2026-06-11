typeset -U path PATH
path=(
  $HOME/.local/bin
  $HOME/.local/share/mise/shims
  $path
)
export PATH

# Keep Workbrew ahead of Homebrew when both are installed:
# https://workbrew.com/docs/how-to-fix-conflicting-homebrew-wrapper-configuration-errors
_brew_shellenv() {
  if [[ -x /opt/workbrew/bin/brew ]]; then
    eval "$(/opt/workbrew/bin/brew shellenv)"
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

_brew_shellenv

# aws-vault on macOS: use Keychain with Touch ID
export AWS_VAULT_BACKEND=keychain
export AWS_VAULT_BIOMETRICS=1

export MISE_TRUSTED_CONFIG_PATHS=$HOME/.codex/worktrees
