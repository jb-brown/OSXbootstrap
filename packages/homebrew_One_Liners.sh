#!/usr/bin/env bash

###############################################################################
# Homebrew packages                      #
###############################################################################

doUpgrade=false;

#Install packages if they aren't already
declare -a pkgs=(	git
									node
									#wget
									terraform
									jq
									#python
									python3
									#certbot
									#opencv3 --with-contrib --with-python3 --3.2.0
									git-lfs
									thefuck
									#awscli
									#yarn
									#geckodriver
								)

for pkg in "${pkgs[@]}"; do
#    if brew list -1 | grep -q "^${pkg}\$"; then
#			brew upgrade $pkg
#		else
			brew install $pkg
#    fi
done


ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null ; brew install caskroom/cask/brew-cask 2> /dev/null

#Install casks if they aren't already
declare -a casks=(	google-drive-file-stream
										slack
										zoomus				#video conference
										dropbox
										macdown				#mark down editor
										paralells
										google-chrome
										docker

									)

for cask in "${casks[@]}"; do
#    if brew cask list -1 | grep -q "^${cask}\$"; then
#			brew upgrade $cask
#		else
			brew install $cask
#    fi
done


#Uninstall stuff that I don't use, but may be installed by OSXBootstrap
#https://github.com/PelotonTechIO/OSXbootstrap
declare -a uncasks=(
										firefox
										intellij-idea #java ide
										skype
									)


for cask in "${uncasks[@]}"; do
#    if brew cask list -1 | grep -q "^${cask}\$"; then
			brew uninstall $cask
#		fi
done
