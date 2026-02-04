### Oh-my-zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fishy"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
CORRECT_IGNORE_FILE="test|tests|test."
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git mise)

source $ZSH/oh-my-zsh.sh

### User Configuration
export EDITOR='vim'

# TODO: only do this on mac os, for secretive
export SSH_AUTH_SOCK=/Users/maxence/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# Add custom scripts to PATH
export PATH="$PATH:/Users/maxence/Library/CloudStorage/GoogleDrive-maxence@dandelionhealth.ai/My Drive/scripts/bin"
export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/Users/maxence/.bun/_bun" ] && source "/Users/maxence/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(mise activate zsh)"

# Temp fix for claude code https://github.com/anthropics/claude-code/issues/21654
export CLAUDE_CODE_TMPDIR=/tmp/claude
