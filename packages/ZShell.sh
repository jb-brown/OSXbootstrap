#!/usr/bin/env bash

###############################################################################
# zshell                                                                      #
###############################################################################

#Install and configure zsh & completions

if brew list -1 | grep -q "^zsh\$"; then
	brew upgrade zsh
else
	brew install zsh
fi

if brew list -1 | grep -q "^zsh-completions\$"; then
	brew upgrade zsh-completions
else
	brew install zsh-completions
	touch ~/.zshrc
	echo "fpath=(/usr/local/share/zsh-completions $fpath)" >> ~/.zshrc
	rm -f ~/.zcompdump; compinit
	chmod go-w '/usr/local/share'
fi
