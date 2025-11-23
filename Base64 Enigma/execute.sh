#!/bin/bash

# Perform Base64 decoding using standard Unix utility
echo "$1" | base64 -d
