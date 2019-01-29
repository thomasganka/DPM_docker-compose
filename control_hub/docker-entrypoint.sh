#!/bin/bash
echo "Waiting for the database to start"
sleep 30;



cd ${DPM_DIST}
if [ ! -e "$DPM_CONF/READY" ]; then
    
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

    echo $DPM_VERSION > $DPM_CONF/READY
elif [ "$DPM_VERSION" != "$(cat $DPM_CONF/READY)" ] ;then
    echo "Update db Schemas"
    dev/01-updatedb.sh
fi 

bin/streamsets dpmcli security systemId

echo "Start DPM"

exec "${DPM_DIST}/bin/streamsets" "$@"