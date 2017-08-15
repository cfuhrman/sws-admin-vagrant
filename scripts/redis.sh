#!/bin/bash
# ====================================================================
#
# redis.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Tue Aug 15 10:41:12 2017 PDT
#
# ====================================================================

#
# Installs redis
#
# Note that we are installing the stock redis version as supplied by Redhat
#

REDIS_SERVICE=redis.service

if ! rpm -q redis >/dev/null; then
	inform $L1 "Installing Redis"
	sudo yum --assumeyes install redis

	inform $L2 "Enabling and starting redis service via systemd"
	sudo systemctl enable ${REDIS_SERVICE}
	sudo systemctl start ${REDIS_SERVICE}
fi

inform $L2 "[redis] done"
