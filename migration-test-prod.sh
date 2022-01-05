#!/bin/bash

#docker-compose -f docker-compose-pg-flyway.yml down

#docker-compose -f docker-compose-pg-flyway.yml up 

docker network create foo
docker run -d --rm --name=postgres --network=foo postgres
docker run -d --rm --name=flyway --network=foo flyway

echo "completed running docker"

#docker run -it migrate /bin/sh -ignorePendingMigrations=true migrate 
