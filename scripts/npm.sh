#!/bin/bash
# ====================================================================
#
# npm.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Fri Sep 15 11:50:21 2017 PDT
#
# ====================================================================

#
# Installs and configures npm
#

inform $L1 "Installing npm package manager"
sudo yum --assumeyes install npm

inform $L2 "[npm] done"
