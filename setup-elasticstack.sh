#!/bin/bash

echo "*** Limit on mmap counts equal to 262,144 or more ..."
sudo sysctl -w vm.max_map_count=262144

echo "*** Build and run elasticstack in docker ..."
cd /vagrant/elasticstack
docker compose down
docker compose up -d

counter=60
while true ; do
    sleep 5
    if [ $counter -eq 0 ]; then
        break
    else
        echo "*** Waiting for Elasticsearch to be up and running ... $counter seconds left"
        counter=$((counter-5))
    fi
done
