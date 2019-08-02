#!/usr/bin/env bash

HOME=~
DOTFILES="$HOME/dotfiles"

# Get sudo permission right away
sudo echo
# git pull origin master

$DOTFILES/init/1-apt.sh
$DOTFILES/init/2-oh-my-zsh.sh
$DOTFILES/init/2-rust.sh
$DOTFILES/init/2-yarn.sh

### Link files
linked_files=(
    .zshrc
    .gitconfig
)

for file in "${linked_files[@]}"
do
    source="$DOTFILES/link/$file"
    dest="$HOME/$file"

    # Delete file if it already exists
    if [[ -e "$dest" ]]; then
        rm "$dest"
    fi

    ln -sv "$source" "$dest"
done
