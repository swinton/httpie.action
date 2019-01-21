#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Capture output
output=$( sh -c "pipenv run http $*" )

# TODO
# Separate headers from body

# Preserve output for consumption by downstream actions
echo "$output" > "${HOME}/${GITHUB_ACTION}.txt"

# Write output to STDOUT
echo "$output"
