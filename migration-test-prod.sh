#!/bin/bash

docker-compose -f docker-compose-pg-flyway.yml down

docker-compose -f docker-compose-pg-flyway.yml up 

docker run -it migrate /bin/sh
