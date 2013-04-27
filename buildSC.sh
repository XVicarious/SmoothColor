#!/bin/bash

Escape="\033";
CyanF="${Escape}[36m";
WhiteF="${Escape}[37m";
RedF="${Escape}[31m";
BoldOn="${Escape}[1m";
BoldOff="${Escape}[22m";
Reset="${Escape}[0m";
 
function genData {
  if [ -d "$1/png" ] ; then
    echo "Good... $1/png exists..."
    echo "Generating DataURIs from the images..."
  else
    echo -e "$1/png does not exist, ${RedF}${BoldOn}aborting${BoldOff}${Reset}..."
    exit 1
  fi
  rm $1/b64/*
  data="data:image/png;base64,"
  for f in $1/png/*.png
  do
    ff=$(basename $f)
    data=$(openssl enc -base64 -in $f | tr -d '\n' | sed -e 's/^/data:image\/png;base64,/')
    echo -e "--Processing ${CyanF}$f${Reset}, outputting to ${CyanF}$1/b64/$ff.b64${Reset}"
    echo $data > "$1/b64/$ff.b64"
  done
}

function replaceData {
  B=($1)
  color="${B[@]^}"
  file="Smooth$color-Images.less"
  cp SmoothColor-Images.less $file
  echo "Creating $file..."
  echo "Includings images in $file..."
  cat images.txt | while read -r i
  do
    if grep -q "$i" "$file"
    then
      uri=$(cat $1/b64/$i)
      sed -i s@$i@$uri@g $file > $file.tmp
      echo -e "--Inserting ${CyanF}$i${Reset}"
    fi
  done
}

function makeIncludes {
  up="${1^}"
  rm SmoothColor-Includes.less
  echo "@import \"./$1/less/Smooth$up-Colors\";" > tmpInclude
  echo "@import \"./$1/less/Smooth$up-Images\";" >> tmpInclude
  mv tmpInclude SmoothColor-Includes.less
  echo "Generated Include File..."
}

function buildThisBitch {
  up="${1^}"
  lessc SmoothColor.less $1/css/Smooth$1-uncompressed.css
  lessc -x SmoothColor.less $1/css/Smooth$1.css
  echo "Compile Completed!"
}

if [ $# -lt 1 ]
then
  echo "Usage: $0 color"
  echo "Where color is {red,blue,green}"
fi

case "$1" in
red)  genData $1
      replaceData $1
      makeIncludes $1
      buildThisBitch $1
      ;;
blue) echo "Unable to build at this time"
      ;;
green) genData $1
       replaceData $1
       rm SmoothColor-Includes.less
       makeIncludes $1
       buildThisBitch $1
       ;;
purple) genData $1
        replaceData $1
        rm SmoothColor-Includes.less
	makeIncludes $1
        buildThisBitch $1
        ;;
*)    echo "Unknown color $1"
      ;;
esac
