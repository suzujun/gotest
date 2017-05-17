#!/usr/bin/env bash

set -e
echo "mode: set" > coverage.txt
SECONDS=0

for d in $(go list ./... | grep -v vendor); do
    VALENCIA_MEDIA_API_TEST=1 go test -coverprofile=coverage.out $d
    if [ -f coverage.out ]; then
        grep -vE '_gen|_mock|_slice|mode:' coverage.out >> coverage.txt
        rm coverage.out
    fi
done

echo "test elapsed time: ${SECONDS}sec"

go tool cover -html=coverage.txt -o=coverage.html

