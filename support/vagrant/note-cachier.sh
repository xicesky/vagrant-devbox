#!/usr/bin/env bash
set -e
#set -x
source /vagrant/support/vagrant/config.sh

if $SUPPORT_OLD_BOX ; then
    # Notify the user at the end of the bootstrap process
    (
        echo   "-------------------------------------------------------------------------------"
        echo   "Hello dear devbox user,"
        echo   ""
        echo   "you don't have the vagrant-cachier plugin installed. This plugin is really"
        echo   "really really recommended, it'll save you lots of time when bootstrapping"
        echo   "your vagrant box\! To install it, try this command:"
        echo   "    vagrant plugin install vagrant-cachier"
        echo   "-------------------------------------------------------------------------------"
    ) 1>&2
fi
