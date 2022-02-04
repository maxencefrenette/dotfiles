#!/usr/bin/env bash

apt_packages=(
    build-essential
    cloc
    figlet
    git
    imagemagick
    lftp
    xsel
    zsh
)

### Add PPAs
# Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update
sudo apt-get install --yes $APT_PACKAGES
for package in "${apt_packages[@]}"
do
   sudo apt-get install --yes $package
done

sudo apt-get autoclean --yes
sudo apt-get autoremove --yes
