#!/usr/bin/env bash

if [ -d "$ZSH" ]; then
    exit 0
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
sudo chsh -s $(which zsh) maxence
