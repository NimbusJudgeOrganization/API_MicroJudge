#!/bin/bash

ERR=0
LINE=1
while read A B; do

  INTMAX=2147483647
  INTMIN=-2147483648

  (( A > INTMAX ))  && echo "$LINE: $A > INTMAX" && ERR=1
  (( B > INTMAX ))  && echo "$LINE: $B > INTMAX" && ERR=1
  (( A < INTMIN ))  && echo "$LINE: $A < INTMIN" && ERR=1
  (( B < INTMIN ))  && echo "$LINE: $B < INTMIN" && ERR=1
  ((LINE++))
done

exit $ERR
