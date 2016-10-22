#!/bin/bash
# script to save some time
# pretty printing xml
if [ "$#" -ne 1 ] ; then
  echo "usage $0 filename"
  echo "Please note: this utility will overwrite the existing file"
  echo "with its pretty-printed equivalent."
fileName=$1
xmllint --format $1 > $1.tmp
mv $1.tmp $1
