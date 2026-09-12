# Time-stamp: <Sat 2026-09-12 15:22 svarrette>
####################################################################################
# Makefile (configuration file for GNU make - see http://www.gnu.org/software/make/)
#                     __  __       _         __ _ _
#                    |  \/  | __ _| | _____ / _(_) | ___
#                    | |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#                    | |  | | (_| |   <  __/  _| | |  __/
#                    |_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
####################################################################################
SHELL = /bin/bash
# Setup script
SETUP_SCRIPT = setup-kicksecure-config

############### Let's go ##############
.PHONY: all
all: setup

### Specific setup
.PHONY: setup clean
setup:
	./$(SETUP_SCRIPT) -x

clean:
	rm -f security-misc.d
	rm -f kicksecure-*.cfg
