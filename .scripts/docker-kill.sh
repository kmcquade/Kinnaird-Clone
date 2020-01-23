#!/usr/bin/env bash
set -x

docker stop $(docker ps -a -q)
yes | docker system prune
yes | docker system prune --volumes
docker rm $(docker ps -a -q)
docker images -q --filter "dangling=true" | xargs docker rmi
docker rmi $(docker images -q)
