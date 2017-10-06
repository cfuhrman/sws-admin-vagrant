#!/bin/bash
# ====================================================================
#
# configure.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Tue Jun 27 16:03:59 2017 PDT
#
# ====================================================================

#
# Contains configuration variables
#

# Cassandra Configuration
CASSANDRA_VERSION=${CASSANDRA_VERSION:-311x}
CASSANDRA_BASE_URL=https://www.apache.org/dist/cassandra
CASSANDRA_YUM_REPO=${CASSANDRA_BASE_URL}/redhat/${CASSANDRA_VERSION}/
CASSANDRA_GPG_KEY=${CASSANDRA_BASE_URL}/KEYS

# PostgreSQL Configuration
PGSQL_VERSION=${PGSQL_VERSION:-96}

# PHP Configuration
PHP_VERSION=${PHP_VERSION:-71}
PHP_COMPOSER_VERSION=${PHP_COMPOSER_VERSION:-1.5.1}

# Kong Configuration
KONG_VERSION=${KONG_VERSION:-0.10.3}

# Can be one of the following:
#
#  1. postgres
#  2. cassandra
KONG_DATASTORE=cassandra

# Kong Dashboard Configuration
KONG_DASHBOARD_VERSION=2.0
KONG_DASHBOARD_URL=https://github.com/PGBI/kong-dashboard

