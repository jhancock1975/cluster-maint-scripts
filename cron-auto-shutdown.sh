#!/bin/bash
# This is based on script listed at http://askubuntu.com/questions/607091/shutdown-on-idle-using-acpi-buitin-feature
# One should run this script as a CRON job that the root user owns.
# It will shut down the system after the system is idle for some period of time.# One can pass that period of time as a parameter to this script, otherwise
# the period will default to one hour.
# This script will help control costs of running expensive AWS instances that
# you forget to turn off because playtime is over and you need to rush
# to work.

export DISPLAY=:0
IDLE_TIME=$(xprintidle)

# default to 1 hour idle time
MAX_IDLE_TIME=3600000

# override if command line argument is passed
if [ "$#" -gt 0 ]; then
  MAX_IDLE_TIME=$1
fi

if [ "$IDLE_TIME" -ge "$MAX_IDLE_TIME" ]; then
    shutdown -h now
fi
