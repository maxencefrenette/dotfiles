REPO := $(HOME)/dotfiles

###############################################################################
# Linking                                                                     #
###############################################################################
CONFIG_FILES     := $(shell ls -A $(REPO)/config)
CONFIG_FILE_DEST := $(addprefix $(HOME)/,$(CONFIG_FILES))

.PHONY: link unlink
.SILENT: $(CONFIG_FILE_DEST)

link: $(CONFIG_FILE_DEST)

$(CONFIG_FILE_DEST):
	if [ -e $@ ]; then rm -v $@; fi
	ln -sv "$(REPO)/config/$(notdir $@)" "$@"

# Broken on Windows
unlink:
	@echo "Unlinking dotfiles"
	@for f in $(CONFIG_FILE_DEST); do if [ -h $$f ]; then rm -v $$f; fi ; done


###############################################################################
# Linux                                                                       #
###############################################################################
.PHONY: linux linux-install linux-zsh linux-rust
.SILENT: linux-zsh

APT_PACKAGES := build-essential cloc figlet git zsh fzf

linux: linux-install linux-zsh link

linux-install:
	sudo apt update
	sudo apt install --yes $(APT_PACKAGES)
	sudo apt upgrade --yes
	sudo apt autoclean --yes
	sudo apt autoremove --yes

linux-zsh:
	if ! [ -d "$$ZSH" ]; then \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended; \
		sudo chsh -s $$(which zsh) maxence; \
	fi

linux-rust:
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	export PATH="$$PATH:$$HOME/.cargo/bin"

	rustup install stable
	rustup install nightly

###############################################################################
# Windows                                                                     #
###############################################################################
.PHONY: windows windows-install

CHOCO_PACKAGES := googlechrome microsoft-edge firefox opera
CHOCO_PACKAGES += spotify vlc
CHOCO_PACKAGES += git vscode hackfont cloc make gsudo
CHOCO_PACKAGES += 7zip greenshot adobereader gimp treesizefree notion

# TODO: optionally install these packages
# Languages & Tools
# "nodejs"
# "yarn"
# "dotnetcore-sdk"
# "python"
# "sql-server-management-studio"
# docker-desktop
    
# Gaming
# CHOCO_PACKAGES += discord steam leagueoflegends

windows: link windows-install

windows-install:
	gsudo choco upgrade $(CHOCO_PACKAGES) --yes --limit-output 


###############################################################################
# Debugging                                                                   #
###############################################################################
.PHONY: debug

debug:
	@$(foreach V,$(sort $(.VARIABLES)),$(if $(filter-out environment% default automatic,$(origin $V)),$(warning $V=$($V) ($(value $V)))))
