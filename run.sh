#!/bin/bash

# URL of the compressed archive
url="https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/scripts.tar.gz"

# Download the archive to the user's home directory
echo -n "Downloading scripts archive ..."

# Download the archive to ~/scripts.tar.gz
curl -s -o ~/scripts.tar.gz "$url" && echo -e "\r$(printf ' %.0s' {1..50})\r✔  Downloaded scripts.tar.gz"

# Extract the archive to the home directory
echo "Extracting the archive..."
tar -xzf ~/scripts.tar.gz -C ~ && echo "✔  Extracted scripts."

# Make setup.sh executable
chmod +x ~/setup.sh && echo "✔  Made setup.sh executable"

# Cleanup the archive (optional)
rm ~/scripts.tar.gz && echo "✔  Removed the archive"

echo "🙌 Done!"
