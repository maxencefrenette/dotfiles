#!/usr/bin/env node
// Adapted from https://dev.to/0916dhkim/sync-cursor-settings-the-dotfiles-way-20c9

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

const env = process.env;

const ignored_extensions = {
    code: new Set([]),
    cursor: new Set([
        'github.codespaces',
        'github.copilot',
        'github.copilot-chat',
        'ms-azuretools.vscode-azureterraform',
        'ms-toolsai.datawrangler',
    ]),
};

function main() {
    console.log('🔄 VSCode/Cursor Extension Sync - Auto-detecting sync direction...');

    sync_editor('code', `${env.DOTFILES_REPO}/vscode/extensions.txt`);
    sync_editor('cursor', `${env.DOTFILES_REPO}/vscode/extensions.txt`);

    console.log('✅ Extension sync complete!');
}

/**
 * @param {string} command - Editor command ("code" or "cursor")
 * @param {string} list_file - Relative path to extension list file
 */
function sync_editor(command: 'code' | 'cursor', list_file_path: string) {
    console.log(`📋 ${command.toUpperCase()}:`);
    const command_path = get_command_path(command);

    if (!fs.existsSync(list_file_path)) {
        console.log(`   ⚠️  Extensions list not found. Skipping extensions sync.`);
        return;
    }

    if (command_path == null) {
        console.log(`   ⚠️  Missing ${command} CLI. Skipping extension sync.`);
        return;
    }

    const sync_direction = determine_sync_direction(command, list_file_path);

    switch (sync_direction) {
        case 'push-to-list':
            console.log(`   → Extensions are newer, pushing to list file...`);
            push_to_extensions_list(command_path, list_file_path);
            break;
        case 'pull-from-list':
            console.log(`   → List file is newer, pulling from list...`);
            pull_from_extensions_list(command_path, list_file_path, ignored_extensions[command]);
            break;
    }
}

/**
 * Determine whether to pull from list or push to list based on timestamps
 * @param editor - "code" or "cursor"
 * @param list_file_path - Path to the list.txt file
 * @returns Action to take
 */
function determine_sync_direction(editor: string, list_file_path: string): 'pull-from-list' | 'push-to-list' {
    const extension_timestamp = get_extension_timestamp(editor);
    const list_timestamp = get_list_file_timestamp(list_file_path);

    console.log(
        `   Extension timestamp: ${extension_timestamp ? new Date(extension_timestamp).toLocaleString() : 'N/A'}`
    );
    console.log(`   List file timestamp: ${list_timestamp ? new Date(list_timestamp).toLocaleString() : 'N/A'}`);

    return extension_timestamp > list_timestamp ? 'push-to-list' : 'pull-from-list';
}

/**
 * Update the extension list file with currently installed extensions
 * @param command_path - Full path to editor CLI command
 * @param list_file_path - Full path to the list.txt file
 */
function push_to_extensions_list(command_path: string, list_file_path: string) {
    const installed_extensions = get_installed_extensions(command_path);
    write_list(list_file_path, installed_extensions);
}

/**
 * Sync local extensions to match the extension list file
 * @param command_path - Full path to editor CLI command
 * @param list_file_path - Full path to the list.txt file
 */
function pull_from_extensions_list(command_path: string, list_file_path: string, ignored_extensions: Set<string>) {
    // Read desired extensions from file
    const desired_extensions = new Set(read_list(list_file_path));
    const installed_extensions = new Set(get_installed_extensions(command_path));

    const to_install = [...desired_extensions].filter(
        (ext) => !installed_extensions.has(ext) && !ignored_extensions.has(ext)
    );
    const to_uninstall = [...installed_extensions].filter((ext) => !desired_extensions.has(ext));

    install_extensions(command_path, to_install);
    uninstall_extensions(command_path, to_uninstall);

    if (to_install.length > 0 || to_uninstall.length > 0) {
        console.log(`   ✅ Sync complete: ${to_install.length} installed, ${to_uninstall.length} uninstalled`);
    } else {
        console.log(`   ✅ Already in sync: ${installed_extensions.size} extensions`);
    }
}

function get_command_path(command: string): string | null {
    try {
        const result = execSync(`command -v ${command}`, {
            encoding: 'utf-8',
            stdio: ['ignore', 'pipe', 'ignore'],
        }).trim();
        return result || null;
    } catch {
        return null;
    }
}

/**
 * @param command_path - Full path to editor CLI command
 */
function get_installed_extensions(command_path: string): string[] {
    return execSync(`${command_path} --list-extensions`, {
        encoding: 'utf-8',
    })
        .trim()
        .split('\n')
        .filter(Boolean)
        .sort();
}

/**
 * @param command_path - Full path to editor CLI command
 * @param extensions - Extensions to install
 */
function install_extensions(command_path: string, extensions: string[]) {
    if (extensions.length === 0) {
        return;
    }
    execSync(`${command_path} ${extensions.map((ext) => `--install-extension ${ext}`).join(' ')}`, {
        stdio: 'inherit',
    });
}

/**
 * @param command_path - Full path to editor CLI command
 * @param extensions - Extensions to uninstall
 */
function uninstall_extensions(command_path: string, extensions: string[]) {
    if (extensions.length === 0) {
        return;
    }
    execSync(`${command_path} ${extensions.map((ext) => `--uninstall_extension ${ext}`).join(' ')}`, {
        stdio: 'inherit',
    });
}

/**
 * Update the extension list file with currently installed extensions
 * @param list_file_path - Full path to the list.txt file
 */
function read_list(list_file_path: string): string[] {
    return fs.readFileSync(list_file_path, 'utf-8').trim().split('\n').filter(Boolean);
}

/**
 * Update the extension list file with currently installed extensions
 * @param {string} list_file_path - Full path to the list.txt file
 * @param {string[]} extensions
 */
function write_list(list_file_path: string, extensions: string[]) {
    fs.writeFileSync(list_file_path, extensions.join('\n') + '\n');
    console.log(
        `   ✅ List updated: ${extensions.length} extensions written to ${path.relative(__dirname, list_file_path)}`
    );
}

/**
 * Get the modification timestamp of the extensions.json file
 * @param {string} editor - "code" or "cursor"
 * @returns {number} - Timestamp in milliseconds, 0 if file doesn't exist
 */
function get_extension_timestamp(editor: string): number {
    const extensions_json_path =
        editor === 'code'
            ? path.join(os.homedir(), '.vscode/extensions/extensions.json')
            : path.join(os.homedir(), '.cursor/extensions/extensions.json');

    if (!fs.existsSync(extensions_json_path)) return 0;
    return fs.statSync(extensions_json_path).mtime.getTime();
}

/**
 * Get the modification timestamp of the extension list file
 * @param {string} list_file_path - Path to the list.txt file
 * @returns {number} - Timestamp in milliseconds, 0 if file doesn't exist
 */
function get_list_file_timestamp(list_file_path: string): number {
    if (!fs.existsSync(list_file_path)) return 0;
    return fs.statSync(list_file_path).mtime.getTime();
}

main();
