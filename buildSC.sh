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

if [ $# -lt 1 ]
then
  echo "Usage: $0 color"
  echo "Where color is {red,blue,green}"
fi

case "$1" in
red)  genData $1
      replaceData $1
      rm SmoothColor-Includes.less
      echo "@import \"SmoothRed-Colors\";" > tmpInclude
      echo "@import \"SmoothRed-Images\";" >> tmpInclude
      mv tmpInclude SmoothColor-Includes.less
      echo "Generated Include File..."
      ./lessc SmoothColor.less SmoothRed-uncompressed.css
      ./lessc -x SmoothColor.less SmoothRed.css
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
       ./lessc SmoothColor.less SmoothGreen-uncompressed.css
       ./lessc -x SmoothColor.less SmoothGreen.css
       echo "Compile Completed!"
       ;;
purple) genData $1
        replaceData $1
        rm SmoothColor-Includes.less
        echo "@import \"SmoothPurple-Colors\";" > tmpInclude
        echo "@import \"SmoothPurple-Images\";" >> tmpInclude
        mv tmpInclude SmoothColor-Includes.less
        echo "Generated Include File..."
        ./lessc SmoothColor.less SmoothPurple-uncompressed.css
        ./lessc -x SmoothColor.less SmoothPurple.css
        echo "Compile Completed!"
        ;;
*)    echo "Unknown color $1"
      ;;
esac
