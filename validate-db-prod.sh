#!/bin/bash

 set -e

 docker run --net=host flyway/flyway -ignorePendingMigrations="true" validate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/$databaseName" -user=$pagilaUser -password=$pagilaPassword

 echo "Successfully validated 'Pagila' database"
 echo

# spawnctl delete data-container $pagilaContainerName --accessToken $SPAWNCTL_ACCESS_TOKEN -q

# echo "Successfully cleaned up the Spawn data container '$pagilaContainerName'"
