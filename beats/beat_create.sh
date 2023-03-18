#!/bin/bash

TYPE=$1
ELASTICSEARCH="192.168.34.201:9200"

sudo bash /vagrant/beats/beat_install.sh $TYPE 
sudo bash /vagrant/beats/beat_configure.sh $TYPE
sudo bash /vagrant/beats/beat_run.sh $TYPE $ELASTICSEARCH
