#!/usr/bin/env bun

import { $ } from 'bun';
import { readdir } from 'node:fs/promises';
import path from 'node:path';

const env = process.env;

const files = await readdir(`${env.DOTFILES_REPO}/config`);
for (const file of files) {
    const src = path.join(env.DOTFILES_REPO, 'config', file);
    const dest = path.join(env.HOME, file);

    await $`rm -fv ${dest}`;
    await $`ln -sv ${src} ${dest}`;
}
