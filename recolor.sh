#!/bin/bash
for f in *.png; do convert -color-matrix '0 0 1 1 0 0 0 1 0' $f ../$1/$f; done
