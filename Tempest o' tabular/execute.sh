#!/bin/bash
mkdir -p out
awk -F, '
NR>1{a[$1]+=$2}
END{print"category,total_amount"
for(i in a)print i","a[i]}
' src/data.csv>out/result.csv
