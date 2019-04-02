#!/bin/bash

export HOSTNAME=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)

docker-compose up -d

declare -a nodes=("sdc.cluster" "dpm.cluster" "sdt.cluster")
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