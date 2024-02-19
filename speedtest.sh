#!/usr/bin/env bash
########################################################################
# Author: Kipmyk
# Date: 2023-07-03
# Description: This script tests the average page load time for a given URL. It can be set to run any number of tests and then averages the results.
# After testing, it removes the directory created during testing and its contents, ensuring no other directories are affected.
#
# Usage: ./speedtest.sh <url> <iterations>
# Example: ./speedtest.sh www.example.com 20
########################################################################

url=$1
iterations=$2
times=""

echo "Testing load times for $url"

for ((i = 1; i <= $iterations; i++)); do
    # Create a unique directory for each test iteration
    test_dir=$(mktemp -d)
    result=$(wget -P $test_dir $url 2>&1 | tail -n2 | head -n1)
    prefix="Total wall clock time: "
    time=${result#$prefix}

    if [[ $time == *m* ]]; then
        minutes=$(echo $time | awk '{print $1}' | awk -F "m" '{print $1}')
        seconds=$(echo $time | awk '{print $2}' | awk -F "s" '{print $1}')
        time=$(($minutes * 60 + $seconds))
    else
        time=$(echo $time | awk -F "s" '{print $1}')
    fi

    if [ "$times" == "" ]; then
        times=$time
    else
        times="$times $time"
    fi

    echo "Test $i loaded in $time seconds"

    # Store the directory path for cleanup
    if [ "$dirs_to_cleanup" == "" ]; then
        dirs_to_cleanup=$test_dir
    else
        dirs_to_cleanup="$dirs_to_cleanup $test_dir"
    fi
done

# Remove downloaded directories and their contents
rm -rf $dirs_to_cleanup

# Results
echo "There were $iterations page load tests for $url"

echo $times | awk '{
    min = max = sum = $1;
    sum_of_squares = $1 * $1;
    for (n = 2; n <= NF; n++) {
        if ($n < min) min = $n;
        if ($n > max) max = $n;
        sum += $n;
        sum_of_squares += $n * $n;
    }
    avg = sum / NF;
    sum2 = 0;
    for (n = 1; n <= NF; n++) {
        sum2 += ($n - avg) ^ 2;
    }
    stddev = sqrt(sum2 / NF);
    print "All values are in seconds: minimum=" min ", maximum=" max ", average=" avg ", sum=" sum ", standard deviation=" stddev;
}'