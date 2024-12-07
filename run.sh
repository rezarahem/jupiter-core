#!/bin/bash

# List of URLs to download
urls=(
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/refresh.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/spinup.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/deploy.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/docker.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/nginx.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/setup.sh"
)

# Function to download files with a timeout and error handling
download_file() {
  url="$1"
  filename=$(basename "$url")
  
  # Download the file with a timeout (30 seconds max)
  echo -n "Downloading $filename ..."
  curl -s --max-time 30 -o ~/"$filename" "$url"
  
  if [ $? -ne 0 ]; then
    echo -e "\rError downloading $filename"
  else
    echo -e "\r$(printf ' %.0s' {1..50})\r✔  $filename"
  fi
  
  # Make setup.sh executable if it's downloaded
  if [ "$filename" == "setup.sh" ]; then
    chmod +x ~/setup.sh && echo "✔  Made setup.sh executable"
  fi
}

# Export the function so it can be used by parallel
export -f download_file

# Use xargs to run downloads in parallel (up to 6 at a time)
echo "Starting downloads..."
echo "${urls[@]}" | xargs -n 1 -P 6 -I {} bash -c 'download_file "{}"'

echo "🙌 Done!"
