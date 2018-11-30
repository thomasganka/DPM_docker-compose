#!/bin/bash
echo "Waiting for the database to start"

until mysql -h mysql -u admin -p'admin'  -e ";" ; do
    echo ".";
    sleep 1;
done


cd ${DPM_HOME}
if [ ! -e "/data/READY" ]; then
    
    declare -a arr=("jobrunner" "messaging" "notification" "pipelinestore" "policy" "provisioning" "reporting" "scheduler" "sdp_classification" "security" "sla" "timeseries" "topology")


    echo "Create db Schemas"

    for i in "${arr[@]}"
    do
       bin/streamsets dpmcli $i buildSchema
    done

    echo "Init security"

    dev/02-initsecurity.sh

    echo "Generate System Id"

    bin/streamsets dpmcli security systemId -c

    echo $DPM_VERSION > /data/READY
elif [ "$DPM_VERSION" != "$(cat /data/READY)" ] ;then
    echo "Update db Schemas"
    dev/01-updatedb.sh
fi 

bin/streamsets dpmcli security systemId

echo "Start DPM"

exec "${DPM_HOME}/bin/streamsets" "$@"