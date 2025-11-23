#!/bin/bash

# Retrieve Bitcoin price from coingecko Api

curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" | jq -r '.bitcoin.usd'
