#!/bin/bash

#docker-compose -f docker-compose-pg-flyway.yml down

docker-compose -f docker-compose-pg-flyway.yml up 

#docker pull flyway/flyway > /dev/null 2>&1

#docker pull postgres > /dev/null 2>&1

#docker network create foo
#docker run -d --rm --name=postgres --network=foo postgres:latest
#docker run -d --rm --name=flyway --network=foo flyway/flyway

#docker run --network=foo --rm -v $PWD/sql:/flyway/sql flyway/flyway -baselineOnMigrate="true" migrate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/$databaseName" -user=$pagilaUser -password=$pagilaPassword

echo "completed running docker"

#docker run -it migrate /bin/sh -ignorePendingMigrations=true migrate 
