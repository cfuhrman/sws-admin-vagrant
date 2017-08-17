#!/bin/bash
# ====================================================================
#
# laravel.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Wed Aug 16 15:59:31 2017 PDT
#
# ====================================================================

#
# Installs and configures laravel
#

# Convenience variable
BASE=${PHP_RPM_BASE}

LARAVEL_RPMS=("${BASE}-pdo"			\
	      "${BASE}-mbstring"		\
	      "${BASE}-xml"
)

inform $L1 "Installing Laravel and Dependencies"

inform $L2 "Installing prerequisite RPMs"
sudo yum --assumeyes install ${LARAVEL_RPMS[*]}

cd ~vagrant
if [ ! -e ${COMPOSER_VENDOR_BIN}/laravel ]; then
	inform $L2 "Installing laravel via composer"
	sudo -u vagrant ${COMPOSER_BIN} global require "laravel/installer"
fi

inform $L2 "[laravel] done"
