#!/bin/bash

function genData {
  if [ -d "$1/png" ] ; then
    echo "$1/png exists..."
  else
    echo "$1/png does not exist, aborting..."
    exit 1
  fi
  data="data:image/png;base64,"
  for f in $1/png/*.png
  do
    data+=$(base64 -w0 $f)
    ff=$(basename $f)
    echo "--Processing $f, outputting to $1/b64/$ff.b64"
    echo $data > "$1/b64/$ff.b64"
  done
}

function replaceData {
  B=($1)
  color="${B[@]^}"
  file="Smooth$color-Images.less"
  cp SmoothColor-Images.less $file
  echo "Creating $file..."
  cat images.txt | while read -r i
  do
    if grep -q "$i" "$file"
    then
      uri=$(cat $1/b64/$i)
      sed -i s@$i@$uri@g $file > $file.tmp
    fi
  done
}

if [ $# -lt 1 ]
then
  echo "Usage: $0 color"
  echo "Where color is {red,blue}"
fi

case "$1" in
red)  rm SmoothColor-Includes.less
      echo "@import \"SmoothRed-Colors\";" > tmpInclude
      echo "@import \"SmoothRed-Images\";" >> tmpInclude
      mv tmpInclude SmoothColor-Includes.less
      echo "Generated Include File..."
      lessc SmoothColor.less SmoothRed.css
      echo "Compile Completed!"
      ;;
blue) rm SmoothColor-Includes.less
      echo "@import \"SmoothBlue-Colors\";" > tmpInclude
      mv tmpInclude SmoothColor-Includes.less
      echo "Unable to build at this time"
      ;;
green) genData $1
       replaceData $1
       rm SmoothColor-Includes.less
       echo "@import \"SmoothGreen-Colors\";" > tmpInclude
       echo "@import \"SmoothGreen-Images\";" >> tmpInclude
       mv tmpInclude SmoothColor-Includes.less
       echo "Generated Include File..."
       lessc SmoothColor.less SmoothGreen.css
       echo "Compile Completed!"
       ;;
*)    echo "Unknown color $1"
      ;;
esac
