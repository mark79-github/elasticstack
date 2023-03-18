#!/bin/bash

KIBANA_HOST=192.168.34.201:5601

for TYPE in "$@"; do
  STATUS=$(curl --silent POST -H "Content-Type: application/json" -H "Accept: application/json" -H "kbn-xsrf: reporting" \
  -d '{"data_view":{"title": "'$TYPE'-8.6.2-*","name": "'$TYPE'"}}' \
  $KIBANA_HOST/api/data_views/data_view)
    if [[ "${STATUS}" == *"statusCode"* ]]; then
        echo "*** Error creating data view $TYPE ... response is $STATUS"
    else
        echo "*** Data view $TYPE created successfully ..."
    fi
done
