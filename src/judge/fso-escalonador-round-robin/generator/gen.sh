#!/bin/bash

if [ "x$1" == "x" ]; then
    echo Uso: $0 [binario com algum solucao good]
    exit 1
fi

cat << EOF > ../tests/input/test-01
1
500
1 1
EOF
./$1 < ../tests/input/test-01 > ../tests/output/test-01

cat << EOF > ../tests/input/test-02
2
500
1 2
2 1
EOF
./$1 < ../tests/input/test-02 > ../tests/output/test-02

for i in $(seq -w 03 09); do
    N_PROC=$RANDOM
    let N_PROC=N_PROC%100
    let N_PROC=$N_PROC+1
    echo $N_PROC > ../tests/input/test-$i
    TIME_SLICE=$RANDOM
    let TIME_SLICE=TIME_SLICE%10
    let TIME_SLICE=TIME_SLICE*100
    echo $TIME_SLICE >> ../tests/input/test-$i
    ENTRIES=($(shuf -i 1-200 -n $N_PROC))
    for PROC in ${ENTRIES[@]} ; do
        TIME=$RANDOM
        let TIME=$RANDOM%10
        let TIME=$TIME+1
        echo $PROC $TIME >> ../tests/input/test-$i
    done
    ./$1 < ../tests/input/test-$i > ../tests/output/test-$i
done

cat << EOF > ../tests/input/test-10
100
1
1 10
2 20
3 30
4 40
5 50
6 60
7 70
8 80
9 90
10 100
11 110
12 120
13 130
14 140
15 150
16 160
17 170
18 180
19 190
20 200
21 210
22 220
23 230
24 240
25 250
26 260
27 270
28 280
29 290
30 300
31 310
32 320
33 330
34 340
35 350
36 360
37 370
38 380
39 390
40 400
41 410
42 420
43 430
44 440
45 450
46 460
47 470
48 480
49 490
50 500
51 510
52 520
53 530
54 540
55 550
56 560
57 570
58 580
59 590
60 600
61 610
62 620
63 630
64 640
65 650
66 660
67 670
68 680
69 690
70 700
71 710
72 720
73 730
74 740
75 750
76 760
77 770
78 780
79 790
80 800
81 810
82 820
83 830
84 840
85 850
86 860
87 870
88 880
89 890
90 900
91 910
92 920
93 930
94 940
95 950
96 960
97 970
98 980
99 990
10 1000
EOF
./$1 < ../tests/input/test-10 > ../tests/output/test-10
