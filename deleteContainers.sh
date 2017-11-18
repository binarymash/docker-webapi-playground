#!/usr/bin/env bash
docker ps -a -q --filter=ancestor=mywebapi | xargs -I {} docker rm {}