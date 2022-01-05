#!/bin/bash

docker-compose -f docker-compose-pg-flyway.yml down

docker-compose -f docker-compose-pg-flyway.yml up 

echo "completed running docker"

docker run -it migrate /bin/sh -ignorePendingMigrations=true migrate 
