#!/bin/bash
export HOST="${HOST:-chiz.work.gd}"

echo ⚠️⚠️⚠️ $HOST

docker compose -f /srv/docker/compose.yml up --build -d
