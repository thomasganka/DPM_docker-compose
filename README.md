Control Hub on Docker
=====================

Current version 3.7.1

## Prerequisits

You need to have docker installed.  
Make sure you run `docker login` and you have access to our private docker hub

## How to start

```
git clone https://github.com/streamsets/DPM_docker-compose.git
cd DPM_docker-compose
docker-compose build && docker-compose up -d
```

When the setup is complet thos different ports are available: 
* Control Hub: [localhost:18631](localhost:18631)
* Data Colector: [localhost:18630](localhost:18630)
* Mysql: [localhost:3306](localhost:3306) 
* Influx: [localhost:8086](localhost:8086), [localhost:8083](localhost:8083) 

To stop everithing run `docker-compose down`

If you need to restart from scratch, make sure to run `docker volume prune` to reset any volume.

## WARNING

SMTP server is currently not working so please edit `setup.sh` smtp sections with your own smtp server

