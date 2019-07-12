#!/bin/bash

docker-compose down

docker run -d --rm -v sch_dpm:/tmp/dpm --entrypoint "/bin/chown"  centos:7 -R 1000:1000 /tmp/dpm

docker-compose build --no-cache

./start.sh