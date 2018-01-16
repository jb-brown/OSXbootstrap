#!/usr/bin/env bash


################################################################################
# Install homebrew and git if they dont' exist
################################################################################
function install_package_managers(){
	#install or update homebrew
	which -s brew
	if [[ $? != 0 ]] ; then
	    # Install Homebrew
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
	else
	    brew update
	fi

	#install or update git
	if brew list -1 | grep -q "^git\$"; then
		brew upgrade git
	else
		brew install git
	fi
}

################################################################################
# Create an SSH key for GitHub
################################################################################
function create_github_ssh(){
	#Check if github SSH needs to be setup
	pbcopy < ~/.ssh/id_rsa.pub
	if [ $? -eq 1 ]
	then

		#use an empty paraphrase to silently create an key pair
		echo -e  'y\n'|ssh-keygen -q -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_rsa
		pbcopy < ~/.ssh/id_rsa.pub

		# directions of what to do on GitHub.com
		echo ""
		echo "-------------------------------------------------------------------------------"
		echo ""
		echo "Your public key has been copied to the clipboard. Next a browser will navigate"
		echo "to your github SSH Key Settings page. There may be a login gate first."
		echo "Create a 'New SSH key' with the contents of the clipboard when you get there."
		echo ""
		echo "-------------------------------------------------------------------------------"
		echo ""
		read -n 1 -s -p "Press any key to open GitHub SSH Key Settings"
		echo ""
		echo ""
		open "https://github.com/settings/keys"
		echo ""
		echo ""
		read -n 1 -s -p "SSH Key created on GitHub? Press any key to continue"
	fi
}


################################################################################
# Clone a git hub repo to a clean location following the tree structure of     #
#
# $HOME
#   -- Code
#        -- [github org/user name]
#            -- [github repo name]
################################################################################
function clone_repo(){

	local codeDir=$1
	local gitName=$2

	#clear existing work and re-create folder structure
	rm -rf "$codeDir/$gitName"
	mkdir -p "$codeDir/$gitName"

	#get a fresh copy
	git clone git@github.com:${gitName}.git "$codeDir/$gitName"

	#return the location of the repo
	echo "$codeDir/$gitName"
}

################################################################################
# Execute .sh files within a directory                                         #
################################################################################
function source_files(){
	for file in "${1}"/*.sh; do
		echo "Sourcing ${file}"
		source $file
	done;
	unset file;
}


################################################################################
# Remove roadblocks for unattended execution                                   #
################################################################################
function silence_sudo_approval(){
		# Close any open System Preferences panes, to prevent them from overriding
		# settings we’re about to change
		osascript -e 'tell application "System Preferences" to quit'

		# Ask for the administrator password upfront
		sudo -v

		# Keep-alive: update existing `sudo` time stamp until `faster_osx.sh` has finished
		while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

		# Set standby delay to 24 hours (default is 1 hour)
		sudo pmset -a standbydelay 86400
}

################################################################################
# Bootstrap OSX with sane defaults for software development                    #
################################################################################
function bootstrap(){
	local doPkgs=$1
	local doPrefs=$2
	local extras=$3

	silence_sudo_approval
	install_package_managers
	create_github_ssh

	local codeDir="$HOME/Code"
	mkdir -p $codeDir
	local gitDir=$(clone_repo $codeDir "jb-brown/OSXBootstrap")

	if $doPkgs ; then
		source_files "${gitDir}/packages"
	else
		echo "No packages being installed."
	fi;

	if $doPrefs ; then
		source_files "${gitDir}/preferences"
	else
		echo "No preferences being installed."
	fi;

	IFS=',' read -r -a array <<< "$extras"
	for repo in "${array[@]}"
	do
		source_files $(clone_repo $codeDir $repo)
	done
}


################################################################################
# Parse command line and set exectuion flags
################################################################################
force=false
prefs=true
pkgs=true

while [[ ${1} ]]; do
  case "${1}" in
      --force)
          force=true
          shift
          ;;
      --f)
          force=true
          shift
          ;;
			--noprefs)
					prefs=false
					shift
					;;
			--nopkgs)
					pkgs=false
					shift
					;;
			--extras)
					extras=${2}
					shift

					if ! shift; then
							echo 'Missing extras parameter argument.' >&2
							exit 0
					fi
					;;
      *)
          echo "Unknown parameter: ${1}" >&2
          exit 0
  esac
done


################################################################################
# Inovke Execution                                                             #
################################################################################

#execution changes the path, so store the starting point to go back at the end
startingPWD=$pwd

if [ $force == false ]; then
	read -p "This will overwrite some of your OSX preferences. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		bootstrap $pkgs $prefs $extras;
	fi;
else
		bootstrap $pkgs $prefs $extras;
fi;

#return to the starting path
cd $startingPWD

unset bootstrap;
unset prefs;
unset pkgs;
unset extras;
unset force;
