# TODO: check if running as administrator
# TODO: installl chocolatey if not installed

$packages = @(
    # Browsers
    "googlechrome"
    "microsoft-edge"
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
    "cloc"
    # "sql-server-management-studio"

    # Tools
    "7zip"
    "greenshot"
    "adobereader"
    "gimp"
    "treesizefree"

    # Gaming
    # "steam"
    # "leagueoflegends"
)

choco upgrade @packages --yes --limit-output

# TODO: use same git settings as on Linux
