# Time-stamp: <Sat 2026-09-12 15:50 svarrette>
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

# Setup script and target sysctl.d directory (user owned)
SETUP_SCRIPT = setup-kicksecure-config
SYSCTL_D     = /usr/local/lib/sysctl.d

############### Let's go ##############
.PHONY: all
all: sync

### Specific setup
.PHONY: setup
setup:
	./$(SETUP_SCRIPT) -x

### Deploy/Sync configuration on a local system sysctl.d/
.PHONY: sync deploy
sync deploy:
	mkdir -p $(SYSCTL_D)
	rsync -avzu --exclude "kicksecure-*" --exclude "990-*" *.conf "$(SYSCTL_D)/"

.PHONY: clean
clean:
	rm -f security-misc.d
	rm -f kicksecure-*.conf
