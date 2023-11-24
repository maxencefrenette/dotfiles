### Oh-my-zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fishy"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

### User Configuration
export EDITOR='vim'

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Ignore eslint errors when using CRA
export ESLINT_NO_DEV_ERRORS='true'

# TODO: only do this on mac os, for secretive
export SSH_AUTH_SOCK=/Users/maxence/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# Add custom scripts to PATH
export PATH="$PATH:/Users/maxence/Library/CloudStorage/GoogleDrive-maxence@dandelionhealth.ai/My Drive/scripts"

# Add poetry to path
export PATH="/Users/maxence/.local/bin:$PATH"
