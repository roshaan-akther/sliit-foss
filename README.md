# SLIIT FOSS Bashaway Competition Solutions

This repository contains solutions for the SLIIT FOSS Bashaway competition challenges.

## Challenges Completed

### 1. Tempest o' tabular
**Task**: CSV aggregation with group-by and sum operations
**Solution**: Bash script using awk for efficient CSV processing
**Location**: `tempest o tabular/`

### 2. Byte Reverser
**Task**: Reverse strings character by character
**Solution**: Pure bash string manipulation with loops
**Location**: `byte reverser/`

### 3. Base64 Enigma
**Task**: Decode Base64 encoded strings
**Solution**: Uses standard Unix base64 utility
**Location**: `base64 enigma/`

### 4. API Phantom
**Task**: Fetch Bitcoin price from CoinGecko API
**Solution**: curl and jq for API interaction
**Location**: `api phantom/`

### 5. Archive Archaeologist
**Task**: Recursively extract nested tar.gz archives
**Solution**: Iterative extraction with tar command
**Location**: `archive archaeologist/`

### 6. PostgreSQL Architect
**Task**: Simulate vector database operations with pgvector
**Solution**: C program for vector calculations with bash wrapper
**Location**: `postgresql architect/`

### 7. Tyrant's law
**Task**: Convert JSON to YAML with alphabetically sorted keys
**Solution**: jq for sorting + Python for YAML conversion
**Location**: `tyrant's law/`

### 8. Omens of disaster
**Task**: Real-time system monitoring with alerts
**Solution**: Comprehensive monitoring dashboard with color-coded alerts
**Location**: `omens of disaster/`

### 9. Prime Sentinel
**Task**: Determine if a given number is prime or composite
**Solution**: Efficient primality testing using trial division algorithm
**Location**: `prime sentinel/`

### 10. Lost in the ashtray
**Task**: Convert XML with namespaces and attributes to JSON with proper data types
**Solution**: XML parsing and conversion using xmllint and Python for type preservation
**Location**: `lost in the ashtray/`

## Requirements
- Bash shell
- Standard Unix utilities (awk, sed, grep, etc.)
- jq for JSON processing
- curl for API calls
- gcc for C program compilation (PostgreSQL Architect)

## Usage
Each challenge directory contains an `execute.sh` script. Run it according to the challenge specifications.

## Repository Structure
```
.
├── Tempest o' tabular/
├── Byte Reverser/
├── Base64 Enigma/
├── API Phantom/
├── Archive Archaeologist/
├── PostgreSQL Architect/
├── Tyrant's law/
├── Omens of disaster/
└── README.md
```

## License
This project is part of the SLIIT FOSS Bashaway competition.
