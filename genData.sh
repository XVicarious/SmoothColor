#!/bin/bash
data="data:image/png;base64,"
for f in *.png
do
  data+=$(base64 -w0 $f)
  echo "Processing $f"
  echo $data > $f.b64
done
