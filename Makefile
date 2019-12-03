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
		aspell \
		bash \
		bash-completion@2 \
		git \
		grep \
		python3
	brew cask install emacs

    # Upgrade python3 pip and friends
	python3 -m pip install --upgrade pip setuptools wheel


.PHONY: homebrew
homebrew:

    # Install homembrew
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


.PHONY: setup
setup: homebrew update

    # Set homebrew bash as the default shell
	if ! grep -q "$$(brew --prefix)/bin/bash" /etc/shells; \
		then echo "$$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells; \
	fi
	chsh -s "$$(brew --prefix)/bin/bash"

    # Set the launcher path (requires reboot)
	sudo launchctl config user path "$(PATH)"
