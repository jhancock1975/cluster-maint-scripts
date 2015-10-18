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
startvm() {
  host=$1;
  guest=$2;
  ssh $host "VBoxHeadless --startvm $guest" &
}

freezeVm(){
    host=$1;
    guest=$2;
    ssh $host "VBoxManage controlvm $guest savestate" &
}

iterate_hosts(){
    cmd=$1;
    input_file=$2;
    while read host guest
    do
	[[ "$host" =~ ^#.*$ ]] && continue
	$cmd $host $guest
    done < $input_file
}

start() {
    iterate_hosts startvm $1
}

freeze(){
    iterate_hosts freezeVm $1
}

case "$2" in
  start)
    start $1
    ;;
  freeze)
    freeze $1
    ;;
  *)
    echo "Usage: $0 filename {start|freeze}"
esac
