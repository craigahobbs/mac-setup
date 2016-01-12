.PHONY: help
help:
	@echo "usage: make [help|copy|update|setup]"


.PHONY: copy
copy:

# File copy rule function - src_path, dst_dir
define COPY_RULE_FN
$(strip $(2))/$(if $(3),$(strip $(3)),$(notdir $(1))): $(strip $(1))
	mkdir -p $$(dir $$@)
	cp $$< $$@

copy: $(strip $(2))/$(if $(3),$(strip $(3)),$(notdir $(1)))
endef

$(eval $(call COPY_RULE_FN, _bash_profile, $(HOME), .bash_profile))
$(eval $(call COPY_RULE_FN, _bashrc,       $(HOME), .bashrc))
$(eval $(call COPY_RULE_FN, _emacs,        $(HOME), .emacs))
$(eval $(call COPY_RULE_FN, _screenrc,     $(HOME), .screenrc))
$(eval $(call COPY_RULE_FN, bin/emacs,     $(HOME)/bin))
$(eval $(call COPY_RULE_FN, bin/update,    $(HOME)/bin))


.PHONY: update
update: copy

    # Install homembrew
	-ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # homebrew packages
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install \
		aspell --with-lang-en \
		bash-completion \
		emacs --with-cocoa \
		git \
		nvm \
		python3 \
		tree
	brew linkapps emacs
	mkdir -p "$(HOME)/.nvm"

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
