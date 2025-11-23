#!/bin/bash

# Tyrant's Law: Convert JSON to YAML with Alphabetically Sorted Keys

# Sort JSON keys recursively, then convert to YAML using Python
# Tested jq -y but it didn't properly sort nested object keys
jq 'walk(if type == "object" then to_entries | sort_by(.key) | from_entries else . end)' src/data.json |
python3 -c "
import sys, yaml, json
data = json.load(sys.stdin)
yaml.dump(data, sys.stdout, default_flow_style=False, sort_keys=False)
"
