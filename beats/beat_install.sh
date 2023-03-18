#!/bin/bash

TYPE=$1

 if [[ $(hostname -f) == *"centos"* ]]; then
    if [ -f "$TYPE-8.6.2-x86_64.rpm" ]; then 
        echo "*** File $TYPE-8.6.2-x86_64.rpm exists ..."
    else
        echo "*** Downloading $TYPE for centos ..."
        wget https://artifacts.elastic.co/downloads/beats/$TYPE/$TYPE-8.6.2-x86_64.rpm
    fi
    echo "*** Installing $TYPE ..."
    sudo rpm -Uvh $TYPE-8.6.2-x86_64.rpm
else
    if [ -f "$TYPE-8.6.2-amd64.deb" ]; then 
        echo "*** File $TYPE-8.6.2-amd64.deb exists ..."
    else
        echo "*** Downloading $TYPE for ubuntu ..."
        wget https://artifacts.elastic.co/downloads/beats/$TYPE/$TYPE-8.6.2-amd64.deb
    fi
    echo "*** Installing $TYPE ..."
    sudo dpkg -i $TYPE-8.6.2-amd64.deb
fi
