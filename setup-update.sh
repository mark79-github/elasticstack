#!/bin/bash

echo "*** Updating repository info ..."
if [[ $(hostname -f) == *"ubuntu"* ]]; then
    sudo apt-get update -y && sudo apt-get upgrade -y
else
    sudo dnf update -y && sudo dnf upgrade -y
fi
