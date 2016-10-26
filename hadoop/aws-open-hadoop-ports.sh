#!/bin/bash
if [ $# -ne 3 ] ; then
  echo 'usage: $0 "security-group-id" "cidr"'
  echo 'where "security-group-id" is the AWS security group that the'
  echo 'NameNode and ResourceManager belong to - they should belong'
  echo 'to the same security group in order to use this script.'
  echo 'And cidr is the subnet id followed by a "/" followed by the'
  echo 'subnet mask.'
  echo 'The subnet is the subnet that you will access the NameNode'
  echo 'and ResourceManager from.'
  exit 0;
fi

security_group=$1
cidr=$2
port_list=50070 8088

for port_num in $port_list ; do
  aws ec2 authorize-security-group-ingress --group-id $security_group --protocol tcp --port 50070 --cidr $cidr 
done
