#!/bin/sh
set -e
# https://github.com/aptible/supercronic#reload-crontab
docker kill --signal=USR2 homelab-cron