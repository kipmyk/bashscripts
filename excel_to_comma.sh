#!/bin/bash

# Check if filename is provided as argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename.xlsx>"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# Convert Excel (.xlsx) to CSV
csv_file=$(xlsx2csv "$1" | head -n 1)

# Using awk to extract the first column and join lines with commas
awk -F ',' '{print $1}' "$csv_file" | paste -s -d ',' -

# Explanation of commands:
# 1. xlsx2csv "$1" | head -n 1: Converts the Excel file to CSV format and gets the first line (header)
# 2. awk -F ',' '{print $1}' "$csv_file": Extracts the first column using comma (,) as the delimiter
# 3. paste -s -d ',' -: Joins the lines using comma (,) as the delimiter
#    - -s: Concatenate all lines
#    - -d ',': Use comma as the delimiter
#    - -: Read from standard input (output of awk)

# Example usage:
# ./process_excel.sh /path/to/your/excel_file.xlsx