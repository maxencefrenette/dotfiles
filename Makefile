REPO             := $(HOME)/Repos/dotfiles
CONFIG_FILES     := $(shell ls -A $(REPO)/config)
CONFIG_FILE_DEST := $(addprefix $(HOME)/,$(CONFIG_FILES))


###############################################################################
# Linking                                                                     #
###############################################################################
.PHONY: link unlink

link: $(CONFIG_FILE_DEST)

$(CONFIG_FILE_DEST):
	ln -sv "$(REPO)/config/$(notdir $@)" $@

# Broken on Windows
unlink:
	@echo "Unlinking dotfiles"
	@for f in $(CONFIG_FILE_DEST); do if [ -h $$f ]; then rm -i $$f; fi ; done


###############################################################################
# Windows  																      #
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
    
# Gaming
# "discord"
# "steam"
# "leagueoflegends"

windows: link windows-install

windows-install:
	gsudo choco upgrade $(CHOCO_PACKAGES) --yes --limit-output 


###############################################################################
# Debugging                                                                   #
###############################################################################
.PHONY: debug

debug:
	@$(foreach V,$(sort $(.VARIABLES)),$(if $(filter-out environment% default automatic,$(origin $V)),$(warning $V=$($V) ($(value $V)))))
