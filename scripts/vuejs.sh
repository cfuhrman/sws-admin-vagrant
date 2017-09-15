#!/bin/bash
# ====================================================================
#
# vuejs.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Fri Sep 15 11:53:05 2017 PDT
#
# ====================================================================

#
# Installs and configures vue
#

inform $L1 "Installing vue via npm"
sudo npm install --global vue

inform $L1 "Installing vue-cli via npm (this will take a while)"
sudo npm install --global vue-cli

inform $L2 "[vue] done"

