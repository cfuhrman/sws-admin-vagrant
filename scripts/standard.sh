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
STANDARD_RPMS=('curl'				\
	       'emacs-nox'			\
	       'git'				\
	       'make'				\
	       'man-pages'			\
	       'pcre-devel'			\
	       'pkgconfig'			\
	       'rsync'				\
	       'unzip'
	      )


inform $L1 "Installing Standard Packages"
sudo yum --assumeyes install ${STANDARD_RPMS[*]}

# Ende
