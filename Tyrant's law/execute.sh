#!/bin/bash

# Tyrant's law: Convert JSON to YAML with alphabetically sorted keys

# Sort JSON keys recursively, then convert to YAML using Python
# tried using jq -y but it didn't sort nested keys properly
jq 'walk(if type == "object" then to_entries | sort_by(.key) | from_entries else . end)' src/data.json |
python3 -c "
import sys, yaml, json
data = json.load(sys.stdin)
yaml.dump(data, sys.stdout, default_flow_style=False, sort_keys=False)
"
