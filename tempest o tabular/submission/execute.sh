#!/bin/bash

# make sure output folder exist
mkdir -p out

# process the csv file, group stuff and sum amounts
# awk is good for this kinda thing
awk -F, 'NR>1{a[$1]+=$2}END{print"category,total_amount";for(i in a)print i","a[i]}' src/data.csv > out/result.csv
