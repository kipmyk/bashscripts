#!/bin/bash

# Prompt user for domain input
read -p "Enter the domain name: " domain

# Retrieve WHOIS information
whois_output=$(whois $domain)
echo "$whois_output"

# Extract creation date from WHOIS output using awk
creation_date=$(echo "$whois_output" | awk '/Creation Date:/ {print $NF}')

if [ -n "$creation_date" ]; then
    current_date=$(date +"%Y-%m-%d")
    
    # Debugging output
    echo "Current date: $current_date"
    echo "Creation date: $creation_date"

    # Extract year, month, and day components of the creation date
    creation_year=$(echo "$creation_date" | cut -dT -f1 | cut -d'-' -f1)
    creation_month=$(echo "$creation_date" | cut -dT -f1 | cut -d'-' -f2 | sed 's/^0//') # Remove leading zeros
    creation_day=$(echo "$creation_date" | cut -dT -f1 | cut -d'-' -f3 | sed 's/^0//')   # Remove leading zeros

    # Extract current year, month, and day components
    current_year=$(date +"%Y")
    current_month=$(date +"%m" | sed 's/^0//') # Remove leading zeros
    current_day=$(date +"%d" | sed 's/^0//')   # Remove leading zeros

    # Calculate the age of the domain
    age_years=$((current_year - creation_year))
    if [ "$current_month$current_day" -lt "$creation_month$creation_day" ]; then
        ((age_years--))
    fi

    # Calculate the remaining months and days
    remaining_months=$((current_month - creation_month))
    remaining_days=$((current_day - creation_day))

    # Adjust negative months and days
    if [ "$remaining_months" -lt 0 ]; then
        ((remaining_months += 12))
    fi
    if [ "$remaining_days" -lt 0 ]; then
        ((remaining_days += $(cal "$current_month" "$current_year" | awk 'NF {DAYS = $NF}; END {print DAYS}')))
    fi

    # Display the age
    if [ "$age_years" -gt 1 ]; then
        echo "The domain '$domain' is $age_years years old."
    elif [ "$remaining_months" -gt 0 ]; then
        echo "The domain '$domain' is $remaining_months months and $remaining_days days old."
    else
        echo "The domain '$domain' is $remaining_days days old."
    fi
else
    echo "Unable to retrieve the domain age."
fi
