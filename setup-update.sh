#!/bin/bash

echo "*** Updating repository info ..."
if [[ $(hostname -f) == *"ubuntu"* ]]; then
    sudo apt-get update -y
else
    sudo dnf update -y
fi
