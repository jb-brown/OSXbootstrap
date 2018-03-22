#!/usr/bin/env bash

###############################################################################
# Chrome                                                                      #
###############################################################################


#install or update chrome
killall Chrome

#Set chrome as the default browser
open -a "Google Chrome" --args --make-default-browser
