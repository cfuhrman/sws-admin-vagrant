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
                local delimiter='=='
        else
                local delimiter='--'
        fi

	echo "${delimiter}> ${msg}"
}

# --------------------------------------------------------------------

headerDisplay

source ${SCRIPTS_DIR}/standard.sh

inform ${L1} "Done"

