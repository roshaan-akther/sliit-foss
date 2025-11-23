#!/bin/bash

# reverse the string, simple way
# loop from end to start, build new string
s=$1
for((i=${#s}-1;i>=0;i--));do
    r+=${s:i:1}
    # this builds it backwards
done
echo $r
