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
$(eval $(call COPY_RULE_FN, bin/update,    $(HOME)/bin))


.PHONY: update
update: copy

    # homebrew packages
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install aria2
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install aspell --with-lang-en
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install bash-completion
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install emacs --with-cocoa
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install git
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install homebrew/dupes/grep --with-default-names
	HOMEBREW_BUILD_FROM_SOURCE=1 brew install python3
	brew linkapps emacs
	pip3 install --upgrade pip
	pip3 install --upgrade virtualenv

    # Setup git
	git config --global push.default "simple"
	git config --global core.editor "emacs -nw"


.PHONY: homebrew
homebrew:

    # Install homembrew
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


.PHONY: setup
setup: homebrew update

    # Set the launcher path (requires reboot)
	sudo launchctl config user path "$(PATH)"
	@echo Reboot required to use homebrew applications in Cocoa apps.
