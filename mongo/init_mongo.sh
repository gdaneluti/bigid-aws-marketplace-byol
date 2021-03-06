#!/usr/bin/env bash
echo "Initializing BigID MongoDB"
set -e
docker volume create --name bigid-mongo-data
docker run -d -p 27017:27017 -v bigid-mongo-data:/data/db --name bigid-mongo mongo:3.4
sleep 5

# Get mongo credentials
MONGO_USER=${1:-admin}
MONGO_PWD=${2:-password}

docker exec bigid-mongo mongo admin --eval "printjson(db.createUser({user:'$MONGO_USER',pwd:'$MONGO_PWD',roles:['root']}));"
docker stop bigid-mongo
docker rm bigid-mongo
