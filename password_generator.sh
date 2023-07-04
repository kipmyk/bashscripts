#!/bin/bash

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
