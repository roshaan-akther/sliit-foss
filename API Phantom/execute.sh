#!/bin/bash

# fetch bitcoin price from CoinGecko API
# TODO: add error handling for network issues or API limits
curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" | jq -r '.bitcoin.usd'
