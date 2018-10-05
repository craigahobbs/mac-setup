.PHONY: help
help:
	@echo "usage: make [help|copy|update|setup]"


# File copy rule function - src_path, dst_dir
define COPY_RULE_FN
$(strip $(2))/$(if $(3),$(strip $(3)),$(notdir $(1))): $(strip $(1))
	mkdir -p $$(dir $$@)
	cp $$< $$@

.PHONY: copy
copy: $(strip $(2))/$(if $(3),$(strip $(3)),$(notdir $(1)))
endef

$(eval $(call COPY_RULE_FN, _bash_profile, $(HOME), .bash_profile))
$(eval $(call COPY_RULE_FN, _bashrc,       $(HOME), .bashrc))
$(eval $(call COPY_RULE_FN, _emacs,        $(HOME), .emacs))
$(eval $(call COPY_RULE_FN, _screenrc,     $(HOME), .screenrc))
$(eval $(call COPY_RULE_FN, bin/ediff,     $(HOME)/bin))
$(eval $(call COPY_RULE_FN, bin/update,    $(HOME)/bin))


.PHONY: update
update: copy

    # homebrew packages
	brew install \
		aria2 \
		bash-completion \
		git \
		python3
	brew install aspell --with-lang-en
	brew cask install emacs
	brew install grep --with-default-names

    # Link emacs application
	ln -f -s /usr/local/opt/emacs/Emacs.app $(HOME)/Applications

    # Upgrade python3 pip and virtualenv
	python3 -m pip install --upgrade pip setuptools wheel

    # Setup git
	if ! git config --get user.name; then \
		read -p 'Enter full name for git config: ' NAME && git config --global user.name "$$NAME"; \
	fi
	if ! git config --get user.email; then \
		read -p 'Enter email for git config: ' EMAIL && git config --global user.email "$$EMAIL"; \
	fi
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
