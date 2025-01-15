#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Start two processes concurrently
(while true; do echo "Process 1 updating file1.txt" >> file1.txt; sleep 1; done) &
(while true; do echo "Process 2 updating file2.txt" >> file2.txt; sleep 1; done) &

# Let the processes run for a few seconds
sleep 5

# Kill the processes
kill %1
kill %2

# Check the file contents
cat file1.txt
cat file2.txt