#!/bin/bash

export DPM_DIST=/opt/streamsets-dpm

if [ ! -e "./READY" ]; then
    
    declare -a arr=("jobrunner" "messaging" "notification" "pipelinestore" "policy" "provisioning" "reporting" "scheduler" "sdp_classification" "security" "sla" "timeseries" "topology")

    for i in "${arr[@]}"
    do
        /opt/streamsets-dpm/bin/streamsets dpmcli $i buildSchema
    done

    /opt/streamsets-dpm/dev/02-initsecurity.sh

    touch READY
fi 

exec "${DPM_DIST}/bin/streamsets" "$@"