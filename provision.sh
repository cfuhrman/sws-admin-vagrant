#!/bin/bash
# ====================================================================
#
# provision.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Tue Jun 27 13:32:00 2017 PDT
#
# ====================================================================

set -o errexit

COPYRIGHT='Copyright (c) 2017 Shipwire, Inc.'
PROVISION_VERSION='1.1'
VAGRANT_FOLDER='/vagrant'
SCRIPTS_DIR="${VAGRANT_FOLDER}/scripts"

# Read only constants
readonly L1=1
readonly L2=2

source ${VAGRANT_FOLDER}/configure.sh

#
# Functions
#

##
# Display program header information
#
headerDisplay ()
{
        # Header information
        echo '------------------------------------------------------------------------'
        echo "SWS-Admin Provisioning Script"
        echo Version ${PROVISION_VERSION}
        echo ''
        echo ${COPYRIGHT}
        echo '------------------------------------------------------------------------'

}

##
# Function: inform
#
# Displays a message on STDOUT
#
# Parameters:
#
#   level   : 1 or 2
#   msg     : Message to display

inform ()
{
        local level=$1
        local msg=$2

        if [[ $level -eq $L1 ]]; then
                local delimiter='==='
        else
                local delimiter='---'
        fi

	echo "${delimiter}> ${msg}"
}

# --------------------------------------------------------------------

headerDisplay

source ${SCRIPTS_DIR}/standard.sh

# Install our preferred data store
case $KONG_DATASTORE in

postgres )
	inform $L1 "PostgreSQL will be the datastore"
	source ${SCRIPTS_DIR}/postgresql.sh
	;;

cassandra )
	inform $L1 "Cassandra will be the datastore"
	source ${SCRIPTS_DIR}/cassandra.sh
	;;

* )
	inform $L1 "Using default ${KONG_DEFAULT_DATASTORE} instance"
	source ${SCRIPTS_DIR}/${KONG_DEFAULT_DATASTORE}.sh
	;;

esac

source ${SCRIPTS_DIR}/redis.sh
source ${SCRIPTS_DIR}/kong.sh
source ${SCRIPTS_DIR}/php7.sh
source ${SCRIPTS_DIR}/laravel.sh
source ${SCRIPTS_DIR}/npm.sh
source ${SCRIPTS_DIR}/vuejs.sh
source ${SCRIPTS_DIR}/kong-dashboard.sh

inform ${L1} "Done with Provisioning.  Now it's time to have fun! 🍻"

