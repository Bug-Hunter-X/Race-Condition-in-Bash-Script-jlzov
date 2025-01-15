#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create two files
touch file1.txt
touch file2.txt

# Function to update a file safely
update_file() {
  local file=$1
  local message=$2
  flock -n "$file.lock" || exit 1  # Acquire an exclusive lock
  echo "$message" >> "$file"
  echo "Process finished updating $file" 
flock -u "$file.lock"  # Release the lock
}

# Start two processes concurrently
(while true; do update_file file1.txt "Process 1 updating file1.txt"; sleep 1; done) &
(while true; do update_file file2.txt "Process 2 updating file2.txt"; sleep 1; done) &

# Let the processes run for a few seconds
sleep 5

# Kill the processes
kill %1
kill %2

# Check the file contents
cat file1.txt
cat file2.txt

# Clean up lock files
rm file1.txt.lock
rm file2.txt.lock