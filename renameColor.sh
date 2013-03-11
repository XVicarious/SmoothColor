#!/bin/bash
find . -depth -name '*$1*' -execdir bash -c 'for f; do mv -i "$f" "${f//$1/$2}"; done' bash {} +
