#!/bin/bash
# ====================================================================
#
# cassandra.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Tue Aug 15 10:47:50 2017 PDT
#
# ====================================================================

#
# Installs and configures cassandra
#

CASSANDRA_SERVICE=cassandra.service

inform $L1 "Installing Cassandra"

if [ ! -f /etc/yum.repos.d/cassandra.repo ]; then
	inform $L2 "Configuring Apache Cassandra Yum repository"
	sudo bash -c "cat > /etc/yum.repos.d/cassandra.repo" <<EOF
[cassandra]
name=Apache Cassandra
baseurl=${CASSANDRA_YUM_REPO}
gpgcheck=1
repo_gpgcheck=1
gpgkey=${CASSANDRA_GPG_KEY}
EOF

fi

if ! rpm -q cassandra; then
	inform $L2 "Installing Cassandra via yum"
	sudo yum --assumeyes install cassandra

	inform $L2 "Enabling and starting Cassandra"
	sudo systemctl enable ${CASSANDRA_SERVICE}
	sudo systemctl start ${CASSANDRA_SERVICE}
fi

inform $L2 "[cassandra] done"

