#!/bin/bash

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
*)    echo "Unknown color $1"
      ;;
esac
