typeset -U path PATH
path=(
  /opt/homebrew/bin
  $HOME/.local/bin
  $path
)
export PATH