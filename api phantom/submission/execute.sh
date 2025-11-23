#!/bin/bash

npm i

# get bitcoin price from coingecko
curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" | jq -r '.bitcoin.usd'
