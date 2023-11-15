REPO := $(HOME)/dotfiles

###############################################################################
# Shared                                                                      #
###############################################################################
CONFIG_FILES     := $(shell ls -A $(REPO)/config)
CONFIG_FILE_DEST := $(addprefix $(HOME)/,$(CONFIG_FILES))

.PHONY: link unlink oh-my-zsh
.SILENT: $(CONFIG_FILE_DEST)

link: $(CONFIG_FILE_DEST)

$(CONFIG_FILE_DEST):
	if [ -e $@ ]; then rm -v $@; fi
	ln -sv "$(REPO)/config/$(notdir $@)" "$@"

# Broken on Windows
unlink:
	@echo "Unlinking dotfiles"
	@for f in $(CONFIG_FILE_DEST); do if [ -h $$f ]; then rm -v $$f; fi ; done

oh-my-zsh:
	if ! [ -d "$$ZSH" ]; then \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended; \
		sudo chsh -s $$(which zsh) maxence; \
	fi

###############################################################################
# Linux                                                                       #
###############################################################################
.PHONY: linux linux-install linux-rust
.SILENT: linux-zsh

APT_PACKAGES := build-essential cloc figlet git zsh fzf

linux: linux-install linux-zsh link

linux-install:
	sudo apt update
	sudo apt install --yes $(APT_PACKAGES)
	sudo apt upgrade --yes
	sudo apt autoclean --yes
	sudo apt autoremove --yes

linux-rust:
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	export PATH="$$PATH:$$HOME/.cargo/bin"

	rustup install stable
	rustup install nightly

###############################################################################
# Mac Os                                                                      #
###############################################################################
.PHONY: macos macos-install macos-poetry

BREW_FORMULAE := cloc figlet fzf git zsh
BREW_FORMULAE += lastpass-cli
BREW_FORMULAE += pyenv poetry

BREW_CASKS := raycast itsycal warp iina google-drive

macos: macos-install oh-my-zsh link

macos-install:
	brew update
	brew upgrade
	brew install --formulae $(BREW_FORMULAE)
	brew install --casks $(BREW_CASKS)

macos-poetry:
	curl -sSL https://install.python-poetry.org | python3 -

###############################################################################
# Windows                                                                     #
###############################################################################
.PHONY: windows windows-install

CHOCO_PACKAGES := googlechrome firefox opera
CHOCO_PACKAGES += spotify vlc  notion
CHOCO_PACKAGES += git vscode hackfont cloc make gsudo microsoft-windows-terminal tortoisegit
CHOCO_PACKAGES += 7zip greenshot adobereader gimp treesizefree windirstat notepadplusplus
CHOCO_PACKAGES += nodejs yarn # webdev
CHOCO_PACKAGES += python # python

# TODO: optionally install these packages
# Languages & Tools
# "dotnetcore-sdk"
# docker-desktop

windows: link windows-install

windows-install:
	gsudo choco upgrade $(CHOCO_PACKAGES) --yes --limit-output 

windows-gaming:
	gsudo choco upgrade discord steam leagueoflegends --yes --limit-output

windows-rust:
	gsudo choco upgrade rust --yes --limit-output
	rustup install stable

###############################################################################
# Debugging                                                                   #
###############################################################################
.PHONY: debug

debug:
	@$(foreach V,$(sort $(.VARIABLES)),$(if $(filter-out environment% default automatic,$(origin $V)),$(warning $V=$($V) ($(value $V)))))
