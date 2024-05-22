#!/bin/bash

cat <<EOF >/tmp/rwdir/mainfunction$RANDOM$RANDOM.c
#include <stdio.h>
float multiplicaPi(int x);

int main()
{
  int x;

  scanf("%d", &x);
  printf("%f\n", multiplicaPi(x));

  return 0;
}
EOF

exec 2>/tmp/stderrlog > /tmp/out
cd /tmp/rwdir

cat > Makefile << 'EOF'

SRC=$(wildcard *.c)
CFLAGS=-lm -O2 -static

main: ${SRC}
	@gcc ${CFLAGS} $^ -o $@ -lm
	@echo BIN=$@
EOF

unset MAKELEVEL
make
