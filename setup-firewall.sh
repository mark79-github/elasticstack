#!/bin/bash

# echo "*** Firewall - disable ..."
# sudo systemctl stop firewalld
# sudo systemctl disable --now firewalld
# # OR
echo "*** Firewall - open needed ports ..."
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --permanent --add-port 5601/tcp # Kibana
sudo firewall-cmd --permanent --add-port 9200/tcp # Elasticsearch requests
sudo firewall-cmd --permanent --add-port 9300/tcp # Elasticsearch communication between nodes within the cluster
sudo firewall-cmd --permanent --add-port=5044/tcp # Beats port
sudo firewall-cmd --permanent --add-port 5000/tcp # Logstash
sudo firewall-cmd --reload
