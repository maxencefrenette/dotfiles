#!/usr/bin/env bash

HOME=~
DOTFILES="$HOME/dotfiles"

# Get sudo permission right away
sudo echo
# git pull origin master

$DOTFILES/linux/init/1-apt.sh
$DOTFILES/linux/init/1-settings.sh
$DOTFILES/linux/init/2-oh-my-zsh.sh
$DOTFILES/linux/init/2-rust.sh
$DOTFILES/linux/init/2-yarn.sh

### Link files
linked_files=(
    .zshrc
)

shared_linked_files=(
    .gitconfig
    .personal-email.gitconfig
    .work-email.gitconfig
)

# TODO: link shared linked files as well. Make a function to link files and call it from 2 loops

for file in "${linked_files[@]}"
do
    source="$DOTFILES/linux/link/$file"
    dest="$HOME/$file"

    # Delete file if it already exists
    if [[ -e "$dest" ]]; then
        rm "$dest"
    fi

    ln -sv "$source" "$dest"
done

for file in "${shared_linked_files[@]}"
do
    source="$DOTFILES/shared/$file"
    dest="$HOME/$file"

    # Delete file if it already exists
    if [[ -e "$dest" ]]; then
        rm "$dest"
    fi

    ln -sv "$source" "$dest"
done
