#!/bin/bash
s=$1;for((i=${#s}-1;i>=0;i--));do r+=${s:i:1};done;echo $r
