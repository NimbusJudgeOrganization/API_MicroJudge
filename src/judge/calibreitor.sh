#!/bin/bash
#This file is part of CD-MOJ.
#
#CD-MOJ is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#Foobar is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with Foobar.  If not, see <http://www.gnu.org/licenses/>.


#bash build-and-test.sh cpp ribas-ac.cpp sample-problem/
TEMP=$(mktemp)
TOREMOVE=

function sai()
{
  rm $TEMP
  rm -f $TEMP.*
  rm -rf $TOREMOVE
}

trap sai EXIT


PROBLEMDIR=$(realpath $1)

cd $(dirname $0)

if [[ ! -e build-and-test.sh ]]; then
  stat build-and-test.sh
  exit 1
fi

declare -A ULIMITS TLMOD
[[ -e $PROBLEMDIR/conf ]] && source $PROBLEMDIR/conf

#create dummy TL file, must be removed later
[[ -z "$CALIBRATIONTL" ]] && CALIBRATIONTL=5
echo "TL[default]=$CALIBRATIONTL" > $PROBLEMDIR/tl

# find -ac solutions
WORSTTIME=0.01
declare -A WORSTTIMEPERLANG

echo "AC solutions:"
for AC in $PROBLEMDIR/sols/good/*; do
  echo "${AC##*/}:"
  LANG=${AC##*.}
  [[ ! -n "${WORSTTIMEPERLANG[$LANG]}" ]] && WORSTTIMEPERLANG[$LANG]=0.01

  mkfifo $TEMP.coprocout
  export ALLOWPARALLELTEST=n
  coproc bash build-and-test.sh ${AC##*.} $AC $PROBLEMDIR $ALLOWTLEDURINGCALIBRATION &>$TEMP.coprocout
  #read -u ${COPROC[0]} T
  exec 7<$TEMP.coprocout
  read -u 7 T
  while read L; do
    [[ "$L" =~ "EXECTIME" ]] || continue;
    read l l ET SMALLRESP <<< "$L"
    printf " $ET"
    [[ "$SMALLRESP" != "AC" ]] && printf "($SMALLRESP)"
    if [[ "$SMALLRESP" == "AC" ]] && echo "$ET > ${WORSTTIMEPERLANG[$LANG]}"|bc |grep -q 1; then
      WORSTTIMEPERLANG[$LANG]=$ET
    fi
  done <<< $(tail -f --pid=$COPROC_PID $T/build-and-test.log)
  echo

  read -u 7 A
  if [[ "${A}" != "Accepted,100p" ]]; then
    if [[ "${A}" =~ "Time Limit Exceeded" &&
            "$ALLOWTLEDURINGCALIBRATION" == "y" ]]; then
      true
    else
      echo "$AC got '${A}', was waiting Accepted. Check ${T}"
      exit 1
    fi
  fi
  TOREMOVE+=" ${T}"
  exec 7<&-
  rm -f $TEMP.coprocout
done

TLMULT=1.35

[[ -n "${TLMOD[calibrafactor]}" ]] && TLMULT=${TLMOD[calibrafactor]}

BESTTIME=10000

rm $PROBLEMDIR/tl
echo "#Generated by calibreitor" > $PROBLEMDIR/tl

for t in ${!WORSTTIMEPERLANG[@]}; do

  WORSTTIMEPERLANG[$t]="$(echo "$TLMULT * ${WORSTTIMEPERLANG[$t]} + 0.02"|bc -l)"
  echo "TL[$t]=${WORSTTIMEPERLANG[$t]}" >> $PROBLEMDIR/tl
  if echo "${WORSTTIMEPERLANG[$t]} < $BESTTIME"|bc|grep -q 1; then
    BESTTIME=${WORSTTIMEPERLANG[$t]}
  fi
done

echo "TL[default]=$BESTTIME" >> $PROBLEMDIR/tl

echo "Calibrated TL:"
tail -n+1 $PROBLEMDIR/tl

for OTHERSOL in pass slow wrong; do
  [[ ! -d "$PROBLEMDIR/sols/$OTHERSOL" ]] && continue
  echo
  echo "${OTHERSOL^^} solutions:"
  for TLs in $PROBLEMDIR/sols/$OTHERSOL/*; do
    if [[ ! -e $TLs ]]; then echo none; continue;fi
    echo "${TLs##*/}:"
    LANG="${TLs##*.}"
    mkfifo $TEMP.coproc
    coproc bash build-and-test.sh ${TLs##*.} $TLs $PROBLEMDIR runnall >$TEMP.coproc
    exec 7<$TEMP.coproc
    read -u 7 T
    tail -f --pid=$COPROC_PID $T/build-and-test.log|
      while read L; do
        [[ "$L" =~ "EXECTIME" ]] || continue;
        read l l ET SMALLRESP <<< "$L"
        printf "$ET($SMALLRESP) "
      done
    echo
    read -u 7 BIGRESP
    exec 7<&-
    rm -f $TEMP.coproc
    TOREMOVE+=" ${T}"
  done
done