#!/bin/bash

# Validate command line arguments
if [[ $# -ne 2 ]]; then
    printf "Usage: %s <ssid> <wordlist-file>\n", $0
    exit 1
fi
