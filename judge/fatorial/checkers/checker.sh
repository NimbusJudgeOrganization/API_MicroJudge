#!/bin/bash

function runchecker()
{
  printf "$1 "
  if ! bash $1 < $file; then
    tput setab 7
    tput setaf 0
    echo -n FAIL
    tput sgr 0
    echo
  else
    echo Ok
  fi
  echo
}

tput bold
echo "# Check INTMAX and INTMIN"
tput sgr 0

for file in ../tests/input/*; do
  echo "## $file"
  runchecker check-INT-MAX.sh
done
