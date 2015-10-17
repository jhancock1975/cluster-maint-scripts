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
while read host guest
do
  [[ "$host" =~ ^#.*$ ]] && continue
  ssh $host "VBoxHeadless --startvm $guest" &
done < $1
