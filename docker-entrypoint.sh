#!/bin/bash
echo "Waiting for the database to start"
sleep 10

cd ${DPM_HOME}
if [ ! -e "./READY" ]; then
    
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

    touch READY
else
    bin/streamsets dpmcli security systemId
fi 

echo "Start DPM"

exec "${DPM_HOME}/bin/streamsets" "$@"