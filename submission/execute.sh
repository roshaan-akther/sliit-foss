#!/bin/bash

# get bitcoin price from coingecko
# api might be slow sometimes
# TODO: maybe cache the result or something
curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" | jq -r '.bitcoin.usd'
