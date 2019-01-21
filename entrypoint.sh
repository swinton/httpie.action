#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Capture output
output=$( sh -c "pipenv run http $*" )

# Preserve response for consumption by downstream actions
response="${HOME}/${GITHUB_ACTION}.response"
echo "${output}" > "${response}"

# Separate headers from body
headers="${response}.headers"
body="${response}.body"
dest="${headers}"

# Read each line from response
while IFS="" read -r line || [ -n "${line}" ]
do
  # Write response line to destination file
  printf '%s\n' "${line}" >> "${dest}"

  # Start writing to body when first zero-length string is found.
  len=$( "${#line}" | wc -c )
  if [ "${len}" -eq 1 ]; then
    dest="${body}"
  fi
done < "${response}"

# Write entire response to STDOUT
cat "${response}"
