#!/usr/bin/env bash

###############################################################################
# install GNU core utilities (those that come with macOS are outdated).

if brew list -1 | grep -q "^coreutils\$"; then
	brew upgrade coreutils
else
	brew install coreutils
fi

#TODO: check existing $PATH and $MANPATH if this already happened
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
