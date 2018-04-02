#!/usr/bin/env bash

###############################################################################
# Atom                     #
###############################################################################


#install or update atom
if brew cask list -1 | grep -q "^atom\$"; then
	brew cask update atom
else
	brew cask install atom
fi

killall Atom

#JS/React packages
apm install atom-beautify
apm install autocomplete-modules
apm install editorconfig
apm install file-icons
apm install git-time-machine
apm install highlight-selected
apm install language-babel
apm install linter
apm install linter-eslint
apm install minimap
apm install pane-layout-plus
apm install set-syntax
apm install sort-lines
apm install sublime-block-comment
apm install sublime-style-column-selection
apm install goto-definition
apm install platformio-ide-terminal
