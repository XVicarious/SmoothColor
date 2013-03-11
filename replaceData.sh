#!/bin/bash
cp SmoothColor-Images.less $1
cat images.txt | while read -r i
do
  if grep -q "$i" "$1"
  then
    uri=$(cat $2/b64/$i)
    sed -i s@$i@$uri@g $1 > $1.tmp
  fi
done
