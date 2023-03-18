#!/bin/bash

for TYPE in $*; do 
    echo "*** Create $TYPE ..." 
    sudo bash /vagrant/beats/beat_create.sh $TYPE
done
