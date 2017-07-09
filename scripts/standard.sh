#!/bin/bash
# ====================================================================
#
# standard.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Tue Jun 27 15:12:44 2017 PDT
#
# ====================================================================

#
# Installs standard RPMs
#

# List of Standard RPMs to install
STANDARD_RPMS=('aspell'				\
	       'aspell-en'			\
 	       'curl'				\
	       'emacs-nox'			\
	       'git'				\
	       'make'				\
	       'man-pages'			\
	       'mg'				\
	       'pcre-devel'			\
	       'pkgconfig'			\
	       'rsync'				\
	       'tmux'				\
	       'screen'				\
	       'unzip'
)

# Install the epel release repository
sudo yum --assumeyes  install epel-release

inform $L1 "Installing Standard Packages"
sudo yum --assumeyes install ${STANDARD_RPMS[*]}

# Ende
