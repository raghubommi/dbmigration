#!/bin/bash

 set -e

 echo "Install spawnctl cli utility"
 curl -sL https://run.spawn.cc/install | sh > /dev/null 2>&1
 export PATH=$HOME/.spawnctl/bin:$PATH
 echo "spawnctl successfully installed"

 export SPAWN_DB_IMAGE_NAME=postgres-pagila

 echo
 
 echo "Creating DB backup Spawn data container from image '$SPAWN_DB_IMAGE_NAME'..."
 dbContainerName=$(spawnctl create data-container --image $SPAWN_DB_IMAGE_NAME --lifetime 10m --accessToken $SPAWNCTL_ACCESS_TOKEN -q)

 databaseName="pagila"
 
 dbOutputJson=$(spawnctl get data-container $dbContainerName -o json)
 pagilaHost=$(echo $dbOutputJson | jq -r '.host')
 pagilaPort=$(echo $dbOutputJson | jq -r '.port')
 pagilaUser=$(echo $dbOutputJson | jq -r '.user')
 pagilaPassword=$(echo $dbOutputJson | jq -r '.password')

 echo "Successfully created Spawn data container '$dbContainerName'"
 echo

 docker pull flyway/flyway > /dev/null 2>&1
 echo $PWD/sql:/flyway/sql
 echo
 echo "Starting migration of database with flyway"

 docker run --net=host --rm -v $PWD/sql:/flyway/sql flyway/flyway -baselineOnMigrate="true" migrate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/$databaseName" -user=$pagilaUser -password=$pagilaPassword

 echo "Successfully migrated 'Pagila' database"
 echo

 #spawnctl delete data-container $dbContainerName --accessToken $SPAWNCTL_ACCESS_TOKEN -q

 #echo "Successfully cleaned up the Spawn data container '$dbContainerName'"

 #docker run --net=host flyway/flyway -ignorePendingMigrations="true" validate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/$databaseName" -user=$pagilaUser -password=$pagilaPassword

 #echo "Successfully Validated 'Pagila' database"
 #echo
