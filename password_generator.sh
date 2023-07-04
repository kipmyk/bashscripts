#!/bin/bash
########################################################################
# Password generator script
# Author: Kipmyk
# Date: 2023-07-04
# Description: This script tests the average page load time for a given URL. It can be set to run any number of tests and then averages the results.
#
# Usage: To use this script, simply save it to a file (e.g., password_generator.sh), make it executable  (chmod +x password_generator.sh), and then run it (./password_generator.sh)
# Example: ./password_generator.sh 
########################################################################

# Define the characters that can be used in the password
CHARACTERS="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-="

# Prompt the user for the desired password length
echo "Enter the desired password length:"
read LENGTH

# Generate the password
PASSWORD=""
for ((i=0; i<LENGTH; i++)); do
    PASSWORD="${PASSWORD}${CHARACTERS:RANDOM%${#CHARACTERS}:1}"
done

# Print the generated password
echo "Generated Password: $PASSWORD"
