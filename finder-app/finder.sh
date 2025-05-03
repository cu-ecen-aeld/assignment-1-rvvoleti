#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Error: Two arguments are required: <filesdir> <searchstr>"
  exit 1
fi

# Store the arguments in variables
filesdir="$1"
searchstr="$2"

# Check if filesdir is a directory
if [ ! -d "$filesdir" ]; then
  echo "Error: '$filesdir' is not a directory"
  exit 1
fi

# Initialize counters
file_count=0
line_count=0

# Use find to recursively find files in the directory and its subdirectories
find "$filesdir" -type f -print0 | while IFS= read -r -d $'\0' file; do
  # Increment file count for each file found
  ((file_count++))

  # Use grep to count the number of lines containing the search string
  matches=$(grep -F -o "$searchstr" "$file" | wc -l)

  # Add the number of matches to the total line count
  ((line_count+=matches))
done

# Print the results
echo "The number of files are $file_count and the number of matching lines are $line_count"

exit 0

