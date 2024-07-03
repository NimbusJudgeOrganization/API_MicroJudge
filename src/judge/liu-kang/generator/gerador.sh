#!/bin/bash

BASEDIR=$(dirname $0)

bash $BASEDIR/gerador-edge.sh 1 > $BASEDIR/../tests/in1
bash $BASEDIR/gerador-edge.sh 2 > $BASEDIR/../tests/in2
bash $BASEDIR/gerador-edge.sh 3 > $BASEDIR/../tests/in3
bash $BASEDIR/gerador-edge.sh 3 > $BASEDIR/../tests/in4

for((i=5;i<15;i++)); do
  bash $BASEDIR/gerador-random.sh 10 20 4 30 > $BASEDIR/../tests/in$i
done

for((i=15;i<25;i++)); do
  bash $BASEDIR/gerador-random.sh 1000 44000 4 20 > $BASEDIR/../tests/in$i
done
