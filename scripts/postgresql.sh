#!/bin/bash
# -*- mode: sh -*-
# ====================================================================
#
# postgresql.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Wed Jun 28 15:05:50 2017 PDT
#
# ====================================================================

#
# Installs and configures PostgreSQL data base engine
#

PGSQL_DOWNLOAD_DIRECTORY=`mktemp -d /tmp/${0##*/}.XXXXXX`
PGSQL_VERSION=96
PGSQL_DOT_VERSION=${PGSQL_VERSION:0:1}.${PGSQL_VERSION:1:1}
PGSQL_RPM_VERSION=${PGSQL_DOT_VERSION}-3
PGSQL_SOURCE_URL=${PGSQL_SOURCE_URL:=https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos$PGSQL_VERSION-$PGSQL_RPM_VERSION.noarch.rpm}
PGSQL_HOME=/usr/pgsql-$PGSQL_DOT_VERSION
PGSQL_BIN=${PGSQL_HOME}/bin
PGSQL_VARLIB=/var/lib/pgsql/${PGSQL_DOT_VERSION}
PGSQL_DATADIR=${PGSQL_VARLIB}/data
PGSQL_USER=postgres

PGSQL_RPMS=(
	"postgresql$PGSQL_VERSION"		\
	"postgresql$PGSQL_VERSION-service"	\
	"postgresql$PGSQL_VERSION-docs"		\
	"pg_top$PGSQL_VERSION"
)

# Configure Postgres
if ! sudo yum repolist | grep "^pgdg${PGSQL_VERSION}"; then
	inform $L1 "Installing PostgreSQL RPM Repository"
	cd ${PGSQL_DOWNLOAD_DIRECTORY}
	curl -O $PGSQL_SOURCE_URL
	sudo yum --assumeyes install pgdg-centos${PGSQL_VERSION}-$PGSQL_RPM_VERSION.noarch.rpm
	inform $L2 "done"
else
	inform $L1 "PostgreSQL RPM Repository is already installed"
fi

inform $L1 "Installing Postgresql & associated programs"
sudo yum --assumeyes install ${PGSQL_RPMS[*]}
inform $L2 "done"

inform $L1 "Enabling & Starting PostgreSQL"

if [ ! -e $PGSQL_VARLIB/initdb.log ]; then
	inform $L2 "Initializing the PostgreSQL data base for the first time"
	sudo ${PGSQL_BIN}/postgresql${PGSQL_VERSION}-setup initdb
fi

inform $L1 "Setting up appropriate access controls"
NOW=date
sudo bash -c "cat > $PGSQL_DATADIR/pg_hba.conf" << EOL
# PostgreSQL Client Authentication Configuration File
# ===================================================
#
# Refer to the "Client Authentication" section in the PostgreSQL
# documentation for a complete description of this file.  A short
# synopsis follows.
#
# Last Regenerated $NOW

local   all             all                                     trust
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
EOL

sudo systemctl enable postgresql-${PGSQL_DOT_VERSION}.service
sudo systemctl start postgresql-${PGSQL_DOT_VERSION}.service
inform $L2 "done"

# Ende
