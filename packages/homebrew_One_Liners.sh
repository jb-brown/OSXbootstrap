#!/usr/bin/env bash

###############################################################################
# Homebrew packages that have no aditional configuration                      #
###############################################################################

doUpgrade=false;

#Install packages if they aren't already
declare -a pkgs=(	git
									node
									wget
									terraform
									jq
									python3
								)

for pkg in "${pkgs[@]}"; do
    if brew list -1 | grep -q "^${pkg}\$"; then
			doUpgrade=true;
		else
			brew install $pkg
    fi
done


#Install casks if they aren't already
declare -a casks=(	insync				#mount & sync multiple google drive accounts
										google-drive
										slack
										zoomus				#video conference
										skype
										twitterrific
										caffeine
										dropbox
										1password
										lastpass
										screenhero		#remote pair programming
										macdown				#mark down editor
										intellij-idea #java ide

									)

for cask in "${casks[@]}"; do
    if brew cask list -1 | grep -q "^${cask}\$"; then
			doUpgrade=true;
		else
			brew cask install $cask
    fi
done

#Update any of the packages or casks that were previously installed
if [ doUpgrade ]; then
	brew upgrade
fi
