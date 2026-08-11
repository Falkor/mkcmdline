# Time-stamp: <Sun 2026-04-12 16:36 svarrette>
####################################################################################
# Makefile (configuration file for GNU make - see http://www.gnu.org/software/make/)
#                     __  __       _         __ _ _
#                    |  \/  | __ _| | _____ / _(_) | ___
#                    | |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#                    | |  | | (_| |   <  __/  _| | |  __/
#                    |_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
####################################################################################
# A generic and modular Makefile piloting a project repository.
# See https://github.com/Falkor/Makefiles for more examples
#
####################################################################################
SHELL = /bin/bash

# Setup script
SETUP_SCRIPT = setup-kicksecure-config

##################### Main targets #####################
TARGETS = setup
SETUP_TARGETS = setup-kicksecure-config
CLEAN_TARGETS =
DISTCLEAN_TARGETS = clean-kicksecure-config


############### Let's go ##############
.PHONY: all
all: $(TARGETS)

.PHONY: setup clean distclean info
setup: $(SETUP_TARGETS)
clean: $(CLEAN_TARGETS)
distclean: $(DISTCLEAN_TARGETS)

### Specific setup
.PHONY: setup-kicksecure-config
setup-kicksecure-config:
	./$(SETUP_SCRIPT) -x


clean-kicksecure-config:
	rm -f security-misc.d
	rm -f kicksecure-*.cfg
