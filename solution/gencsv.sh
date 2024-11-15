#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: ./gencsv.sh <start_index> <end_index>"
    exit 1
fi

# Parse arguments
start_index=$1
end_index=$2

# Check if the arguments are integers
if ! [[ "$start_index" =~ ^-?[0-9]+$ && "$end_index" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Both arguments must be integers."
    exit 1
fi

# Ensure start_index is less than or equal to end_index
if [ "$start_index" -gt "$end_index" ]; then
    echo "Error: <start_index> must be less than or equal to <end_index>."
    exit 1
fi

# File name
output_file="inputFile"

# Generate the file content
> "$output_file"  # Clear the file if it exists
for ((i=start_index; i<=end_index; i++)); do
    random_number=$((RANDOM % 1000))  # Generate a random number between 0 and 999
    echo "$i, $random_number" >> "$output_file"
done

# Output message
echo "File '$output_file' has been generated with indices from $start_index to $end_index."
