#!/bin/bash

TYPE=$1

if [ -f "/vagrant/beats/config/$TYPE.yml" ]; then
    echo "*** Custom configuration file $TYPE.yml found ..."
    systemctl is-active --quiet $TYPE && sudo systemctl stop $TYPE
    echo "*** Copy configuration file ..."
    sudo cp -f /vagrant/beats/config/$TYPE.yml /etc/$TYPE/$TYPE.yml
    echo "*** Test $TYPE configuration ..."
    sudo $TYPE test config || true
else 
    echo "*** Not found custom beat configuration file $TYPE.yml ..."
fi
