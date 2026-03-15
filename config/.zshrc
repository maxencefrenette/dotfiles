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

# Add custom scripts to PATH
export PATH="$PATH:/Users/maxence/Library/CloudStorage/GoogleDrive-maxence@dandelionhealth.ai/My Drive/scripts/bin"

eval "$(mise activate zsh)"
