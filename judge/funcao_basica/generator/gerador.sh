#!/bin/bash

gcc -o main main.c ../sols/good/sundfeld.c

echo "Processando entrada 1"
echo 1 > ../tests/input/file1
./main < ../tests/input/file1 > ../tests/output/file1
echo "Processando entrada 2"
echo 2 > ../tests/input/file2
./main < ../tests/input/file2 > ../tests/output/file2

for (( i=3; i<=20; i++ ))
do
    NUM=$RANDOM%1000
    let NUM=$NUM+2
    echo "Processando entrada $i ($NUM)"
    echo $NUM > ../tests/input/file$i
    ./main < ../tests/input/file$i > ../tests/output/file$i
done

rm main
