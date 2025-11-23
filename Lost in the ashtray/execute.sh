#!/bin/bash

# Lost in the ashtray - XML detective work
# gotta parse this XML mess and turn it into clean JSON

# convert XML to JSON with proper types
xml_to_json() {
    # get XML content from file or stdin
    local xml_content
    if [ -f "$1" ]; then
        xml_content=$(cat "$1")
    else
        xml_content=$(cat)
    fi

    # use xmllint to clean up the XML first
    echo "$xml_content" | xmllint --format - 2>/dev/null | python3 -c "
import sys
import xml.etree.ElementTree as ET
import json
import re

def xml_element_to_dict(element):
    '''turn XML element into dict, keeping types straight'''
    result = {}

    # handle attributes with @ prefix
    if element.attrib:
        for key, value in element.attrib.items():
            # figure out the right type
            if value.lower() in ('true', 'false'):
                result['@' + key] = value.lower() == 'true'
            elif re.match(r'^-?\d+$', value):
                result['@' + key] = int(value)
            elif re.match(r'^-?\d*\.\d+$', value):
                result['@' + key] = float(value)
            else:
                result['@' + key] = value

    # handle text content
    if element.text and element.text.strip():
        text = element.text.strip()
        # convert to right type again
        if text.lower() in ('true', 'false'):
            result['#text'] = text.lower() == 'true'
        elif re.match(r'^-?\d+$', text):
            result['#text'] = int(text)
        elif re.match(r'^-?\d*\.\d+$', text):
            result['#text'] = float(text)
        else:
            result['#text'] = text

    # handle child elements
    kids = {}
    for child in element:
        child_data = xml_element_to_dict(child)
        # strip namespace from tag
        tag = child.tag.split('}')[-1]

        if tag in kids:
            if not isinstance(kids[tag], list):
                kids[tag] = [kids[tag]]
            kids[tag].append(child_data)
        else:
            kids[tag] = child_data

    result.update(kids)

    # simplify if it's just text
    if len(result) == 1 and '#text' in result:
        return result['#text']

    return result

# parse the XML
xml_data = sys.stdin.read()
try:
    root = ET.fromstring(xml_data)
    result = {root.tag.split('}')[-1]: xml_element_to_dict(root)}
    print(json.dumps(result, indent=2))
except ET.ParseError as e:
    print(f'Error parsing XML: {e}', file=sys.stderr)
    sys.exit(1)
"
}

# main stuff
if [ $# -eq 0 ] && [ -t 0 ]; then
    echo "Usage: $0 [xml_file]"
    echo "Or: echo '<xml>...</xml>' | $0"
    exit 1
fi

xml_to_json "$1"
