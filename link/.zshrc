# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

### Oh-my-zsh Configuration
export ZSH="/home/maxence/.oh-my-zsh"
ZSH_THEME="fishy"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

### User Configuration
export EDITOR='vim'

# Yarn
export PATH="$PATH:`yarn global bin`"
