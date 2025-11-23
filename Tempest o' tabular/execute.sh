#!/bin/bash

# Ensure output directory exis
mkdir -p out

# Process Csv data: group by category and sum amounts
awk -F, 'NR>1{a[$1]+=$2}END{print"category,total_amount";for(i in a)print i","a[i]}' src/data.csv > out/result.csv
