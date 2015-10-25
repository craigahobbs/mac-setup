.PHONY: help
help:
	@echo "usage: make [help|setup|update]"


# File copy rules - src_path, dst_dir
define COPY_RULE
$(strip $(2))/$(if $(3),$(strip $(3)),$(notdir $(1))): $(1)
	mkdir -p $(2)
	cp $(1) $(strip $(2))/$(if $(3),$(strip $(3)),$(notdir $(1)))

COPY = $(COPY) $(strip $(2))/$(if $(3),$(strip $(3)),$(notdir $(1)))
endef

$(eval $(call COPY_RULE, _bash_profile, $(HOME), .bash_profile))
$(eval $(call COPY_RULE, _bashrc,       $(HOME), .bashrc))
$(eval $(call COPY_RULE, _emacs,        $(HOME), .emacs))
$(eval $(call COPY_RULE, _screenrc,     $(HOME), .screenrc))
$(eval $(call COPY_RULE, bin/emacs,     $(HOME)/bin))


.PHONY: update
update: $(COPY)

    # Install homembrew
	-ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# homebrew packages
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install bash-completion
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install emacs --with-cocoa
	HOMEBREW_BUILD_FROM_SOURCE=1 brew linkapps emacs
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install git
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install python3

    # Add personal terminal profile
	osascript \
		-e 'tell application "Terminal"' \
		-e '    set _w to front window' \
		-e '    open "$(abspath export/MyProfile.terminal)"' \
		-e '    set frontmost of _w to true' \
		-e '    set default settings to settings set "MyProfile"' \
		-e '    set startup settings to settings set "MyProfile"' \
		-e 'end tell'


.PHONY: setup
setup: update

    # Set the launcher path (requires reboot)
	sudo launchctl config user path "$(PATH)"
	sudo reboot
