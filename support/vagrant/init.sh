#!/usr/bin/env bash
set -e
#set -x
#echo "XXX Shell: $SHELL"

source /vagrant/support/vagrant/config.sh

####################################################################################################
# Checks

[ `whoami` == 'root' ] || complain 01 \
    "This script must be run as root."

####################################################################################################
# Start services that depend on /vagrant to be mounted

#echo "Starting services now."

