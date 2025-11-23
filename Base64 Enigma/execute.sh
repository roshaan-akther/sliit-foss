#!/bin/bash

# base64 decoding - straightforward with the standard tool
echo "$1" | base64 -d
