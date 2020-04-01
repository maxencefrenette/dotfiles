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
    "python"
    # "sql-server-management-studio"

    # Tools
    "7zip"
    "greenshot"
    "adobereader"
    "gimp"
    "treesizefree"
    
    # Gaming
    # "discord"
    # "steam"
    # "leagueoflegends"
)

choco upgrade @packages --yes --limit-output

### Copy setting files ###
Write-Output $dotfiles
# TODO: auto-detect files to be linked
# TODO: loop instead of repeating this
Copy-Item -Path $dotfiles\shared\.gitconfig -Destination $home\.gitconfig
Copy-Item -Path $dotfiles\shared\.personal-email.gitconfig -Destination $home\.personal-email.gitconfig
Copy-Item -Path $dotfiles\shared\.work-email.gitconfig -Destination $home\.work-email.gitconfig
