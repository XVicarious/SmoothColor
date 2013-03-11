#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Usage: $0 color"
  echo "Where color is capital"
fi

case "$1" in
Red)  echo "@import \"SmoothRed-Colors\"" > tmpInclude
      echo "@import \"SmoothRed-Images\"" >> tmpInclude
      cat SmoothColor-Includes.less >> tmpInclude
      mv tmpInclude SmoothColor-Includes.less