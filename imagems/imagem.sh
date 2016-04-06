#!/bin/bash

URL=$(curl -s $1 | grep -i "powered_test.png")
if [ -z $URL ];
  then
    echo "Domain $1 does NOT have the image on website.";
else
  echo "Domain $1 HAS the image on website";
fi
