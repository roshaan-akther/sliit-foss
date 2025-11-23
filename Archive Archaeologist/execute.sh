#!/bin/bash
mkdir -p src out
cd src
while ls *.tar.gz &>/dev/null 2>&1; do
    for archive in *.tar.gz; do
        tar -xzf "$archive"
        rm "$archive"
    done
done
find . -type f -exec mv {} ../out/ \;
