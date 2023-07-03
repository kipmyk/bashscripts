#!/bin/bash

domain="example.com"

creation_date=$(whois $domain | grep -i "Creation Date:" | awk -F: '{print $2}' | tr -d '[:space:]')

if [ -n "$creation_date" ]; then
    current_date=$(date +"%Y-%m-%d")
    age=$(expr $(date -d "$current_date" +%Y) - $(date -d "$creation_date" +%Y))
    echo "The domain '$domain' is $age years old."
else
    echo "Unable to retrieve the domain age."
fi
