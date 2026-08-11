# Time-stamp: <Tue 2026-08-11 23:44 svarrette>
####################################################################################
# Makefile (configuration file for GNU make - see http://www.gnu.org/software/make/)
#                     __  __       _         __ _ _
#                    |  \/  | __ _| | _____ / _(_) | ___
#                    | |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#                    | |  | | (_| |   <  __/  _| | |  __/
#                    |_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
####################################################################################
# Piloting cmdline generation
# Note: https://github.com/Falkor/Makefiles for examples of generic Makefiles
#       serving different purposes
###################################################################################
SHELL = /bin/bash

# Check commands needed for this project - complete as needed (space separated)
EXECUTABLES = curl
$(foreach exec,$(EXECUTABLES),\
	$(if $(shell command -v $(exec) 2>/dev/null),,$(error "$(exec) not available in PATH")))

# Local variables
KERNEL_DIR ?= /etc/kernel
CMDLINE    ?= cmdline
CMDLINE_D  ?= cmdline.d
GRUB_D     ?= grub.d
# generator script
MKCMDLINE   = mkcmdline
CONVERT_GRUB_CONFIG = convert-grub-config

##################### Main targets #####################
TARGETS = local
SETUP_TARGETS = setup-grub-config
CLEAN_TARGETS = clean-cmdline
INFO_TARGETS  = info-make info-cmdline

# local hook, meant to be git ignored...
ifneq ("$(wildcard .Makefile.custom)","")
include .Makefile.custom
endif

############### Let's go ##############
.PHONY: all
all: $(TARGETS)

### general help: list all available make directives
.PHONY: help
help:
	@echo "=> available directives: "
	@grep -EHn '^[a-z0-9_-]+[^:]*:' $(MAKEFILE_LIST) | grep -v '=' | awk -F: '{print $$3}' | xargs -n1 echo | sort | uniq | awk '{printf "\033[36m   make %-30s\033[0m\n", $$1}'

### Git Repository management
ifneq ("$(wildcard .Makefile.git)","")
include .Makefile.git
INFO_TARGETS  += info-git info-version
endif


### Specific setup; grub configs
.PHONY: setup-grub-config
setup-grub-config:
	$(MAKE) -C $(GRUB_D) setup

### local generation
.PHONY: local
local:
	@echo "=> generating **local** cmdline"
	./$(MKCMDLINE) --check -o $(CMDLINE) -x

### generate /etc/kernel/cmdline
.PHONY: system sync kernel-cmdline
system sync kernel-cmdline: local
	@echo "=> generating system cmdline $(KERNEL_DIR)/$(CMDLINE)"
	sudo cp $(CMDLINE) $(KERNEL_DIR)/$(CMDLINE)

### [re]generate UKI / kernel to integrate the new cmdline
.PHONY: uki kernel-install
uki kernel-install: kernel-cmdline
	sudo kernel-install -v add $(shell uname -r) /boot/vmlinuz-$(shell uname -r)

### convert grud.d/[0-9]*.cfg configs to corresponding *.cfg
# .PHONY: convert
# convert:
# 	@echo => convert grub configs under $(GRUB_D)/ in the current directory
# 	./$(CONVERT_GRUB_CONFIG) -x

### cleanup
.PHONY: clean-cmdline
clean-cmdline:
	rm -f $(CMDLINE)

### debug
.PHONY: info-cmdline
info-cmdline:
	@echo "========= cmdline generation ========"
	@echo "KERNEL_DIR = $(KERNEL_DIR)"
	@echo "CMDLINE    = $(CMDLINE)"
	@echo "MKCMDLINE  = $(MKCMDLINE)"

###################################
.PHONY: setup clean info
setup: $(SETUP_TARGETS)
clean: $(CLEAN_TARGETS)
info:  $(INFO_TARGETS)
