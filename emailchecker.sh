#!/bin/bash

# Function to check if the email address exists
function is_valid_email() {
    # Send an email to the address and check for delivery failure
    if mail -s "Verification" "$1" <<< "This is a test email." 2>&1 >/dev/null | grep -q "unknown user"; then
        echo "Email address does not exist: $1"
    else
        echo "Email address may exist: $1"
    fi
}

# Check if an argument is provided
if [ -z "$1" ]; then
    read -p "Enter email address: " email_address
else
    email_address="$1"
fi

# Call the function with the provided email address
is_valid_email "$email_address"
