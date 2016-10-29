#!/bin/bash
# This script should be run from inside hadoop install directory.
# It uses relative paths to dfs and yarn shutdown scripts.
# This script is tested with hadoop 2.7.3
./sbin/stop-dfs.sh
./sbin/stop-yarn.sh
sudo shutdown -h now
 
