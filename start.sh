#!/bin/bash

docker-compose up -d

declare -a nodes=("sdc.cluster" "dpm.cluster")
processfile=/etc/hosts
tmpfile=$processfile.tmp
cp $processfile $tmpfile

for servicename in "${nodes[@]}"
do
    ipaddress=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $servicename`
    if [ ! -z $ipaddress ] &&  [ ! -z $servicename ] ;
    then
        sed -i.back "/${servicename}$/d" $tmpfile
        echo -e $ipaddress '\t' $servicename  >> $tmpfile
    fi
done
mv $tmpfile $processfile