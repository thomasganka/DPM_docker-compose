Control Hub on Docker
=====================

Current default version:
* Data Collector 3.8.0
* Control Hub 3.8.0

## Prerequisits

You need to have docker installed.  
Make sure you run `docker login` and you have access to our private docker hub

## How to start

```
git clone https://github.com/streamsets/DPM_docker-compose.git
cd DPM_docker-compose
```

Create a gmail application password here https://myaccount.google.com/apppasswords and save it


Create a `.env` file at the root of the directory and add the following lines

```
MAIL_ADD=<user>@streamsets.com
MAIL_PWD=<application password>
DPM_URL=dpm.cluster:18631
```

Start the cluster

```
sudo ./start.sh
```

When the setup is complet thos different ports are available: 
* Control Hub: [localhost:18631](localhost:18631)
* Data Collector: [localhost:18630](localhost:18630)
* Edge: [localhost:18633](localhost:18633)
* Transfomer: [localhost:19630](localhost:19630)

To stop everithing run `docker-compose down`

If you need to restart from scratch, make sure to run `docker-compose down -v` to reset any volume.

You can add user libraries directly in the local sdcUserLibraries and restart the data collectors

You can add resources by droping them in the resources folder