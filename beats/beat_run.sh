#!/bin/bash

TYPE=$1
ELASTICSEARCH=$2

echo "*** Installing beat template in Elasticsearch ..."
sudo $TYPE setup --index-management -E output.logstash.enabled=false -E "output.elasticsearch.hosts=[$ELASTICSEARCH]" | true

if [ $TYPE = "heartbeat" ]; then
    TYPE=$TYPE-elastic
fi

if [ $TYPE = "metricbeat" ]; then
    sudo $TYPE modules enable system
fi

echo "*** Start and enable the $TYPE service ..."
sudo systemctl daemon-reload
systemctl is-active --quiet $TYPE && sudo systemctl restart $TYPE || sudo systemctl start $TYPE 
systemctl is-enabled --quiet $TYPE || sudo systemctl enable $TYPE
