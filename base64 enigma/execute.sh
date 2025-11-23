#!/bin/bash

# decode base64 stuff
# linux base64 command works fine
echo "$1" | base64 -d
