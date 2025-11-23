#!/bin/bash

# extract nested tar files
# tried find command first, but this works better
# keep going until no more tar files left
mkdir -p src out
cd src
while ls *.tar.gz &>/dev/null 2>&1; do
    for archive in *.tar.gz; do
        tar -xzf "$archive"
        rm "$archive"
        # clean up as we go
    done
done
# move final files out
find . -type f -exec mv {} ../out/ \;
