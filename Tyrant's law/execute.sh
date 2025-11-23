#!/bin/bash

# Tyrant's Law: Convert JSON to YAML with Alphabetically Sorted Keys

# sort json keys recursively, then convert to yaml
# tried using jq -y first but it didnt sort nested keys properly
# this way works though
jq 'walk(if type == "object" then to_entries | sort_by(.key) | from_entries else . end)' src/data.json |
python3 -c "
import sys, yaml, json
data = json.load(sys.stdin)
yaml.dump(data, sys.stdout, default_flow_style=False, sort_keys=False)
"
