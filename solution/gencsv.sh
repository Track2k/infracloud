#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: ./gencsv.sh <start_index> <end_index>"
    exit 1
fi

start=$1
end=$2

# Clear or create the inputFile
> inputFile

# Generate entries from start to end index
for i in $(seq $start $end); do
    random_number=$((RANDOM % 1000))
    echo "$i, $random_number" >> inputFile
done
