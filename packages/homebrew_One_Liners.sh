#!/usr/bin/env bash

###############################################################################
# Homebrew packages                      #
###############################################################################

doUpgrade=false;

#Install packages if they aren't already
declare -a pkgs=(	git
									node
									wget
									terraform
									jq
									python
									python3
									certbot
									opencv3 --with-contrib --with-python3 --3.2.0
									git-lfs
									thefuck
									awscli
									yarn
									geckodriver
								)

for pkg in "${pkgs[@]}"; do
    if brew list -1 | grep -q "^${pkg}\$"; then
			brew upgrade $pkg
		else
			brew install $pkg
    fi
done


ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null ; brew install caskroom/cask/brew-cask 2> /dev/null

#Install casks if they aren't already
declare -a casks=(	google-drive-file-stream
										slack
										zoomus				#video conference
										skype
										caffeine
										dropbox
										macdown				#mark down editor
										intellij-idea #java ide
										paralells
										google-chrome
										docker
										firefox
									)

for cask in "${casks[@]}"; do
    if brew cask list -1 | grep -q "^${cask}\$"; then
			brew cask upgrade $cask
		else
			brew cask install $cask
    fi
done
