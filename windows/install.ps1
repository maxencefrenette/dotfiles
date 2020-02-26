# TODO: check if running as administrator
# TODO: installl chocolatey if not installed

$packages = @(
    # Browsers
    "googlechrome"
    "firefox"
    "opera"

    # Entertainment
    "spotify"
    "vlc"

    # Dev
    "git"
    "vscode"
    "nodejs"
    "yarn"

    # Tools
    "7zip"
    "greenshot"
)

choco upgrade @packages --yes --limit-output

# TODO: use same git settings as on Linux
