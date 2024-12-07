#!/bin/bash

# for url in "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/refresh.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/spinup.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/deploy.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/docker.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/nginx.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/setup.sh"  ; do echo -n "Downloading $(basename $url) ..."; curl -s -o ~/$(basename $url) "$url" && echo -e "\r$(printf ' %.0s' {1..50})\r✔  $(basename $url)"; [ "$(basename $url)" == "setup.sh" ] && chmod +x ~/setup.sh && echo "✔  Made setup.sh executable"; done; echo "🙌 Done!"


# Define an array of URLs to download
urls=(
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/refresh.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/spinup.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/deploy.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/docker.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/nginx.sh"
  "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/setup.sh"
)

# Loop through each URL
for url in "${urls[@]}"; do
  # Get the filename from the URL
  filename=$(basename "$url")

  # Start downloading the file
  echo -n "Downloading $filename ..."

  # Use curl to download the file and save it to the home directory
  curl -s -o ~/"$filename" "$url" && \

  # If the download is successful, print a success message
  echo -e "\r$(printf ' %.0s' {1..50})\r✔  $filename"

done

chmod +x ~/setup.sh

echo "🙌 Done!"
