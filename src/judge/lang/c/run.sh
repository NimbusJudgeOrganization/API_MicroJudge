#!/bin/bash

exec &>/tmp/stderrlog

#ulimit -a
cd /tmp/dir
TEST_PATH=$1
source binfile.sh

exec ./$BIN < /tmp/$TEST_PATH/in > /tmp/$TEST_PATH/out
