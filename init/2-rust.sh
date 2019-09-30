#!/usr/bin/env bash

curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="$PATH:$HOME/.cargo/bin"

rustup install stable
rustup install nightly
