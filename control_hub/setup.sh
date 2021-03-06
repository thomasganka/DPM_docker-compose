#!/bin/bash

declare -a dbs=("jobrunner" "messaging" "notification" "pipelinestore" "policy" "provisioning" "reporting" "scheduler" "sdp_classification" "security" "sla" "timeseries" "topology")

# add JDBC for the MySQL databases
for i in "${dbs[@]}"
do
    sed -i "s/^db.openjpa.ConnectionURL=/db.openjpa.ConnectionURL=jdbc\:mysql\:\/\/mysql.emea.cluster:3306\/${i}?useSSL=false/" ${DPM_CONF}/${i}-app.properties
    sed -i "s/^db.openjpa.ConnectionUserName=/db.openjpa.ConnectionUserName=admin/" ${DPM_CONF}/${i}-app.properties
    sed -i "s/^db.openjpa.ConnectionPassword=/db.openjpa.ConnectionPassword=admin/" ${DPM_CONF}/${i}-app.properties
done

# set dpm.base.instance.url in common-to-all-apps.properties
sed -i "s/.*dpm.base.instance.url=.*/dpm.base.instance.url=http\:\/\/sch01.emea.cluster:18631/" ${DPM_CONF}/common-to-all-apps.properties
for i in "${dbs[@]}"
do
    sed -i "s/.*dpm.app.${i}.url=.*/dpm.app.${i}.url=http\:\/\/localhost\:18631/" ${DPM_CONF}/common-to-all-apps.properties
done

# set dpm.base.url in common-to-all-apps.properties
sed -i "s/^dpm.base.url=/dpm.base.url=http\:\/\/sch01.emea.cluster:18631/" ${DPM_CONF}/common-to-all-apps.properties

# comment out http.load.balancer line in /etc/dpm/common-to-all-apps.properties
sed -i 's/^http.load.balancer.url=/#http.load.balancer.url=/' ${DPM_CONF}/common-to-all-apps.properties

# set mail.smtp.host in common-to-all-apps.properties
sed -i 's/^mail.smtp.host=/mail.smtp.host=smtp.gmail.com/' ${DPM_CONF}/common-to-all-apps.properties
sed -i 's/^mail.smtp.port=/mail.smtp.port=587/' ${DPM_CONF}/common-to-all-apps.properties
sed -i 's/^mail.smtps.host=/mail.smtps.host=smtp.gmail.com/' ${DPM_CONF}/common-to-all-apps.properties
sed -i 's/^mail.smtps.port=/mail.smtps.port=465/' ${DPM_CONF}/common-to-all-apps.properties

# set mail.smtp.port in common-to-all-apps.properties
sed -i 's/^mail.smtp.auth=/mail.smtp.auth=true/' ${DPM_CONF}/common-to-all-apps.properties
sed -i 's/^mail.smtps.auth=/mail.smtps.auth=true/' ${DPM_CONF}/common-to-all-apps.properties
sed -i 's/^mail.smtp.starttls.enable=/mail.smtp.starttls.enable=true/' ${DPM_CONF}/common-to-all-apps.properties
sed -i "s/^xmail.username=/xmail.username=${MAIL_ADD}/" ${DPM_CONF}/common-to-all-apps.properties
sed -i "s/^xmail.password=/xmail.password=${MAIL_PWD}/" ${DPM_CONF}/common-to-all-apps.properties
sed -i "s/^xmail.from.address=/xmail.from.address=${MAIL_ADD}/" ${DPM_CONF}/common-to-all-apps.properties

# set pipeline.designer.system.sdc.url in common-to-all-apps.properties
sed -i 's/^pipeline.designer.system.sdc.url=.*/pipeline.designer.system.sdc.url=http\:\/\/sdc01.emea.cluster\:18630/' ${DPM_CONF}/common-to-all-apps.properties

# set db.url in timeseries-app.properties
sed -i 's/^db.url=/db.url=http\:\/\/influx.emea.cluster\:8086/' ${DPM_CONF}/timeseries-app.properties

# set dpm.app.db.url in timeseries-app.properties
sed -i 's/^dpm.app.db.url=/dpm.app.db.url=http\:\/\/influx.emea.cluster\:8086/' ${DPM_CONF}/timeseries-app.properties

# set db.name in timeseries-app.properties
sed -i 's/^db.name=/db.name=sch/' ${DPM_CONF}/timeseries-app.properties

# set dpm.app.db.name in timeseries-app.properties
sed -i 's/^dpm.app.db.name=/dpm.app.db.name=sch_app/' ${DPM_CONF}/timeseries-app.properties

# set db.user in timeseries-app.properties
sed -i 's/^db.user=/db.user=root/' ${DPM_CONF}/timeseries-app.properties

# set dpm.app.db.user in timeseries-app.properties
sed -i 's/^dpm.app.db.user=/dpm.app.db.user=root/' ${DPM_CONF}/timeseries-app.properties

# set db.password in timeseries-app.properties
sed -i 's/^db.password=/db.password=influxdb/' ${DPM_CONF}/timeseries-app.properties

# set dpm.app.db.password in timeseries-app.properties
sed -i 's/^dpm.app.db.password=/dpm.app.db.password=influxdb/' ${DPM_CONF}/timeseries-app.properties

# set db.password in scheduler-app.properties
sed -i 's/^db.password=/db.password=influxdb/' ${DPM_CONF}/scheduler-app.properties

# set dpm.app.db.password in scheduler-app.properties
sed -i 's/^dpm.app.db.password=/dpm.app.db.password=influxdb/' ${DPM_CONF}/scheduler-app.properties

# set db.password in reporting-app.properties
sed -i 's/^db.password=/db.password=influxdb/' ${DPM_CONF}/scheduler-app.properties

# set dpm.app.db.password in reporting-app.properties
sed -i 's/^dpm.app.db.password=/dpm.app.db.password=influxdb/' ${DPM_CONF}/scheduler-app.properties

# symlink /opt/streamsets-dpm/etc/ to /etc/dpm/
ln -sf ${DPM_HOME}/etc /etc/dpm/