#!/bin/bash
# ====================================================================
#
# kong.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Wed Jun 28 14:49:17 2017 PDT
#
# ====================================================================

#
# Installs and configures Kong
#

# Kong Download Directory
KONG_DOWNLOAD_DIRECTORY=`mktemp -d /tmp/${0##*/}.XXXXXX`
KONG_SOURCE_URL=${KONG_SOURCE_URL:=https://github.com/Mashape/kong/releases/download/$KONG_VERSION/kong-$KONG_VERSION.el7.noarch.rpm}

# Download package from Kong website.  Note that this *requires* the epel-release repository which is installed in
# standard.sh

if ! rpm -q kong >/dev/null; then
	inform $L1 "Installing Kong"
	cd $KONG_DOWNLOAD_DIRECTORY;
	curl -O -J -L $KONG_SOURCE_URL
	sudo yum --assumeyes install kong-$KONG_VERSION.el7.noarch.rpm --nogpgcheck
fi

if [ ${KONG_DATASTORE} == "postgres" ]; then

	# PostgreSQL configuration
	inform $L1 "Configurating PostgreSQL for kong environment"
	cd $PGSQL_HOME

	KONG_USER_EXISTS=`sudo -u $PGSQL_USER psql $PGSQL_USER -tAc "SELECT 1 FROM pg_roles WHERE rolname='kong'"`

	if [[ $KONG_USER_EXISTS != 1 ]]; then
		inform $L2 "Creating kong user"
		sudo -u $PGSQL_USER createuser kong
	fi

	if ! sudo -u $PGSQL_USER psql -lqt | cut -d \| -f 1 | grep -qw kong >/dev/null; then
		inform $L2 "Creating kong data base"
		sudo -u $PGSQL_USER createdb -O kong kong "The Kong Open Source API Gateway"
	fi

fi

inform $L2 "[kong] done"

# Ende
