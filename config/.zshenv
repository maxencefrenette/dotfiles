typeset -U path PATH
path=(
  /opt/homebrew/bin
  $HOME/.local/bin
  $path
)
export PATH
# aws-vault on macOS: use Keychain with Touch ID
export AWS_VAULT_BACKEND=keychain
export AWS_VAULT_BIOMETRICS=1
