#!/bin/bash
# script will poll interface recive bytes
# useful for setting threshold for CloudWatch alarm
# to shut down unused instance.
# 
# give the name of the interface as the first and only argument
# to this script

function get_rx_bytes(){
	ifName=$1;
	cat /proc/net/dev | grep $ifName | awk -F '[ ]+' '{print $3}'
}

if [ $# -ne 1 ] ; then
	echo "usage : $0 interface-name"
	exit 0;
fi

ifName=$1
initial_rx_bytes=$(get_rx_bytes $ifName);
POLLING_INTERVAL=2.0;

while true; do
  sleep $POLLING_INTERVAL;
  cur_rx_bytes=$(get_rx_bytes $ifName);
  bytes_per_sec=$( bc -l <<< "($cur_rx_bytes - $initial_rx_bytes) /  $POLLING_INTERVAL" );
  echo "current data rate = " $bytes_per_sec;
  initial_rx_bytes=$cur_rx_bytes;
done;
  
