#! /usr/bin/env bash
set -euxo pipefail
(( UID ))
(( ! $# ))
xhost +local:$USER
docker-compose up --build --force-recreate

