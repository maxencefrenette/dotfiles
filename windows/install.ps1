# TODO: check if running as administrator
# TODO: installl chocolatey if not installed

### Define variables ###
$dotfiles = "$($home)\Repos\dotfiles"

### Install Packages ###
$packages = @(
    # Browsers
    "googlechrome"
    "microsoft-edge"
    "firefox"
    "opera"

    # Entertainment
    "spotify"
    "vlc"

    # Dev (General)
    "git"
    "vscode"
    "hackfont"
    "cloc"

    # Languages & Tools
    "nodejs"
    "yarn"
    "dotnetcore-sdk"
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

### Copy setting files ###
Copy-Item -Path $dotfiles\shared\.gitconfig -Destination $home\.gitconfig
