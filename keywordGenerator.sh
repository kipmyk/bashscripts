#!/bin/bash

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Python is not installed. Please install Python using 'brew install python'."
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "pip is not installed. Please install pip for Python using 'brew install pip'."
    exit 1
fi

# Check if googlesearch module is installed
if ! python3 -c "import googlesearch" &> /dev/null; then
    echo "googlesearch module is not installed. Installing..."
    pip3 install googlesearch-python
fi

# Prompt user for input
read -p "Enter a seed keyword to search: " seed_keyword

# Use Python script to fetch related keywords
related_keywords=$(python3 - <<END
from googlesearch import search

seed_keyword = "$seed_keyword"
related_keywords = []

for keyword in search(seed_keyword, num=10, stop=10, pause=2):
    related_keywords.append(keyword)

print("\n".join(related_keywords))
END
)

# Display related keywords
echo "Related Keywords:"
echo "$related_keywords"
