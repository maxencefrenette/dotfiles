#!/usr/bin/env bash

# Increase the file watcher limit (node & vscode)
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
