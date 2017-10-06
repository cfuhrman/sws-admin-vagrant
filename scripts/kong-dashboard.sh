#!/bin/bash
# ====================================================================
#
# kong-dashboard.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Fri Oct  6 12:07:35 2017 PDT
#
# ====================================================================

#
# Provisions Kong Dashboard
#

inform $L1 "Installing Kong Dashboard"

# Pull git repository
if [ ! -d kong-dashboard ]; then
	inform $L2 "Cloning kong-dashboard from ${KONG_DASHBOARD_URL}"
	git clone -b ${KONG_DASHBOARD_VERSION} ${KONG_DASHBOARD_URL}
fi

cd kong-dashboard

# Grab the latest tag name for this branch
KONG_DASHBOARD_TAG=$(git describe --abbrev=0 --tags)

# Build the dashboard
inform $L2 "Installing Kong Dashboard ${KONG_DASHBOARD_TAG} via npm (this may take a while)"
npm install
npm run build

inform $L2 "[kong-dashboard] done"

