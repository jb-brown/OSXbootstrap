#!/bin/bash
# Get the Username of the currently logged user
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`
if [ -e /usr/local/bin/mysides ]
then
	/usr/local/bin/mysides remove All\ My\ Files file:///System/Library/CoreServices/Finder.app/Contents/Resources/MyLibraries/myDocuments.cannedSearch/ && sleep 2
	/usr/local/bin/mysides remove iCloud x-apple-finder:icloud && sleep 2
	/usr/local/bin/mysides remove domain-AirDrop nwnode://domain-AirDrop && sleep 2
	/usr/local/bin/mysides remove Applications file:///Applications/ && sleep 2
	/usr/local/bin/mysides remove Documents file:///Users/$loggedInUser/Documents/ && sleep 2
	/usr/local/bin/mysides remove Downloads file:///Users/$loggedInUser/Downloads/ && sleep 2
	/usr/local/bin/mysides remove Dropbox file:///Users/$loggedInUser/Dropbox/ && sleep 2


fi



#hide the devices section
defaults write  com.apple.finder SidebarDevicesSectionDisclosedState -int 0

#hide the shared section
defaults write  com.apple.finder SidebarSharedSectionDisclosedState -int 0

#hide the iCloud section, but keep iCloud Desktop on so that Dekstop and Documents show in Places
defaults write  com.apple.finder SidebarShowingiCloudDesktop -int 1
defaults write  com.apple.finder SidebarSharedSectioniCloudDisclosedState -int 0

#hide Media
defaults write  com.apple.finder SidebarMediaBrowserSectionDisclosedState -int 0

#hide Tags
defaults write  com.apple.finder SidebarTagsSctionDisclosedState -int 0

#show places... this is where our Favorites show up
defaults write  com.apple.finder SidebarPlacesSectionDisclosedState -int 1


#add favorites in order from most specific to least
#Code
/usr/local/bin/mysides add "Code" file:///Users/$loggedInUser/Code/ && sleep 2

#Desktop
/usr/local/bin/mysides add "Destkop" file:///Users/$loggedInUser/Desktop && sleep 2

#Applications
/usr/local/bin/mysides add "Applications" file:///Users/$loggedInUser/Applications && sleep 2

#home directory
/usr/local/bin/mysides add $loggedInUser file:///Users/$loggedInUser/ && sleep 2

#ROOT
/usr/local/bin/mysides add "Macintosh HD" file:/// && sleep 2


touch /Users/$loggedInUser/.sidebarshortcuts

/usr/libexec/PlistBuddy -c "Add :networkbrowser:CustomListProperties:com.apple.NetworkBrowser.backToMyMacEnabled bool False" /Users/$loggedInUser/Library/Preferences/com.apple.sidebarlists.plist
/usr/libexec/PlistBuddy -c "Add :networkbrowser:CustomListProperties:com.apple.NetworkBrowser.bonjourEnabled bool False" /Users/$loggedInUser/Library/Preferences/com.apple.sidebarlists.plist
/usr/libexec/PlistBuddy -c "Add :networkbrowser:CustomListProperties:com.apple.NetworkBrowser.bconnectedComputersEnabled bool False" /Users/$loggedInUser/Library/Preferences/com.apple.sidebarlists.plist



killall Finder

killall cfprefsd
