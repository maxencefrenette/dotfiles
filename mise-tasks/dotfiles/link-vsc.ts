#!/usr/bin/env bun

import { $ } from 'bun';

const env = process.env;

// VSCode
await $`rm -fv "${env.HOME}/Library/Application Support/Code/User/settings.json"`;
await $`rm -fv "${env.HOME}/Library/Application Support/Code/User/keybindings.json"`;
await $`ln -sv ${env.DOTFILES_REPO}/vscode/settings.json "${env.HOME}/Library/Application Support/Code/User/settings.json"`;
await $`ln -sv ${env.DOTFILES_REPO}/vscode/keybindings.json "${env.HOME}/Library/Application Support/Code/User/keybindings.json"`;

// Cursor
await $`rm -fv "${env.HOME}/Library/Application Support/Cursor/User/settings.json"`;
await $`rm -fv "${env.HOME}/Library/Application Support/Cursor/User/keybindings.json"`;
await $`ln -sv ${env.DOTFILES_REPO}/vscode/settings.json "${env.HOME}/Library/Application Support/Cursor/User/settings.json"`;
await $`ln -sv ${env.DOTFILES_REPO}/vscode/keybindings.json "${env.HOME}/Library/Application Support/Cursor/User/keybindings.json"`;
