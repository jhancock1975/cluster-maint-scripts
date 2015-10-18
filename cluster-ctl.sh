#!/bin/bash
# read input file to start up virtual box virtual machines
# in headless mode
# this script assumes the virtual machines already exist
# and the current user can access all hosts via ssh with
# pki authentication 
# the format of the input file is
#
# hostname guest-name
#
# where, "hostname," is the name of the host machine
# and, "virtual-machine," is the name of the virtual box virtual 
# machine installed on said host machine
# hostname and guest-name should be separated by whitespace
# lines can begin with whitespace
function startvm {
  host=$1;
  guest=$2;
  ssh $host "VBoxHeadless --startvm $guest" &
}

contains() {
  for word in $1; do
    [[ $word = $2 ]] && return 0
  done
  return 1
}

usage_msg='usage: cluster-ctl [-f host_file] start|stop
second line';

function exit_valid_cmds_msg {
  echo $usage_msg;
  exit 1;
}

cmd=$2;
cmds='start stop';
contains cmds cmd && continue || exit_valid_cmds_msg;

while read host guest
do
  [[ "$host" =~ ^#.*$ ]] && continue
  startvm $host $guest
done < $1
