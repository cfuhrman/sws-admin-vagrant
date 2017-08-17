#!/bin/bash
# ====================================================================
#
# php7.sh
#
# Copyright (c) 2017 Shipwire, Inc.
# All rights reserved
#
# Created Wed Aug 16 15:48:47 2017 PDT
#
# ====================================================================

#
# Installs php 7* for RHEL/CentOS
#

WEBTATIC_REPO_BASE=https://mirror.webtatic.com/yum/el7

COMPOSER_DOWNLOAD_DIRECTORY=`mktemp -d /tmp/${0##*/}.XXXXXX`
COMPOSER_LOCATION=https://getcomposer.org/download/${PHP_COMPOSER_VERSION}/composer.phar
COMPOSER_BIN=/usr/local/bin/composer
COMPOSER_VENDOR_BIN=.composer/vendor/bin

PHP_RPM_BASE=php${PHP_VERSION}w

PHP_RPMS=("${PHP_RPM_BASE}-cli"
)

inform $L1 "Installing PHP ${PHP_VERSION}"

# Set up webtatic repository
if [ ! -f /etc/yum.repos.d/webtatic.repo ]; then
	inform $L2 "Enabling webtatic repository"
	sudo rpm -Uvh ${WEBTATIC_REPO_BASE}/webtatic-release.rpm
fi

inform $L2 "Installing PHP Common RPM"
sudo yum install --assumeyes ${PHP_RPMS[*]}

if [ ! -e /usr/local/bin/composer ]; then
	inform $L2 "Installing composer from ${COMPOSER_LOCATION}"
	cd $COMPOSER_DOWNLOAD_DIRECTORY
	curl -O $COMPOSER_LOCATION
	sudo install -o root -g root -m 775 composer.phar ${COMPOSER_BIN}
fi
 
sudo su - vagrant
cd ~vagrant

if ! grep "^PATH.*\.composer/vendor/bin" .bash_profile; then
	inform $L2 "Updating user vagrant PATH to add ${COMPOSER_VENDOR_BIN} directory"
	sudo -u vagrant sed -i~ 's/^\(PATH.*\)/\1:$HOME\/.composer\/vendor\/bin/' ~vagrant/.bash_profile
fi

inform $L2 "[php7] done"
