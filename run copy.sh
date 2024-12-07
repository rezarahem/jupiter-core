#!/bin/bash

# URL of the compressed archive
url="https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/scripts.tar.gz"

# Define the destination directory
destination_dir="$HOME/scripts"

# Create the destination directory if it doesn't exist
mkdir -p "$destination_dir"

echo -n "Downloading scripts archive ..."

# Download the archive
curl -s -o "$destination_dir/scripts.tar.gz" "$url" && echo -e "\r$(printf ' %.0s' {1..50})\r✔  Downloaded scripts.tar.gz"

# Extract the archive
echo "Extracting the archive..."
tar -xzf "$destination_dir/scripts.tar.gz" -C "$destination_dir" && echo "✔  Extracted scripts."

# Make setup.sh executable
chmod +x "$destination_dir/setup.sh" && echo "✔  Made setup.sh executable"

# Cleanup the archive (optional)
rm "$destination_dir/scripts.tar.gz" && echo "✔  Removed the archive"

echo "🙌 Done!"
