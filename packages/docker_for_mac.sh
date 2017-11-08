#!/usr/bin/env bash

###############################################################################
# Docker                                                                      #
###############################################################################


		#Pull docker images to cache our basics
		Docker pull node
		Docker pull rethinkdb
		Docker pull mongo
		Docker pull drone/drone
		Docker pull plugins/slack-blame #used by drone
