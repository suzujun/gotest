#!/bin/bash

set -e

echo "start test.sh >>>"

#case1
echo "hogehoge" | grep -o "geho"

#case2
echo "hogehoge" | grep -o "geho" > test.txt
echo "-- start test.txt ---"
cat test.txt
echo "-- end test.txt ---"


PULL_REQUEST_NUM=`echo "${CI_PULL_REQUEST}" | grep -o '\d$'`
echo "PULL_REQUEST_NUM:${PULL_REQUEST_NUM}"

echo "end test.sh <<<"

