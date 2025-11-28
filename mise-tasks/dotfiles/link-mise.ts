#!/usr/bin/env bun

import { $ } from 'bun';

const env = process.env;

await $`mkdir -p ${env.HOME}/.config/mise/conf.d/`;
await $`rm -fv ${env.HOME}/.config/mise/conf.d/dotfiles.toml`;
await $`ln -sv ${env.DOTFILES_REPO}/mise.toml ${env.HOME}/.config/mise/conf.d/dotfiles.toml`;

await $`mkdir -p ${env.HOME}/.config/mise/tasks/`;
await $`rm -rfv ${env.HOME}/.config/mise/tasks/dotfiles`;
await $`ln -sv ${env.DOTFILES_REPO}/mise-tasks/dotfiles/ ${env.HOME}/.config/mise/tasks/`;
