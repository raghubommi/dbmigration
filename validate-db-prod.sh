#!/bin/bash

 set -e
 
 databaseName="pagila"
 
 dbOutputJson=$(spawnctl get data-container $dbContainerName -o json)
 pagilaHost=$(echo $dbOutputJson | jq -r '.host')
 pagilaPort=$(echo $dbOutputJson | jq -r '.port')
 pagilaUser=$(echo $dbOutputJson | jq -r '.user')
 pagilaPassword=$(echo $dbOutputJson | jq -r '.password')
 docker run --net=host flyway/flyway -ignorePendingMigrations="true" validate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/$databaseName" -user=$pagilaUser -password=$pagilaPassword

 echo "Successfully validated 'Pagila' database"
 echo

# spawnctl delete data-container $pagilaContainerName --accessToken $SPAWNCTL_ACCESS_TOKEN -q

# echo "Successfully cleaned up the Spawn data container '$pagilaContainerName'"
