#!/bin/bash

URL="https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/scripts.tar.gz"
OUTPUT_FILE="scripts.tar.gz"

# Download the tar.gz file
echo "Downloading $URL..."
curl -o "$OUTPUT_FILE" -L "$URL"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Downloaded successfully to $OUTPUT_FILE."
else
    echo "Failed to download file."
    exit 1
fi

# Extract the tar.gz file into the current directory
echo "Extracting $OUTPUT_FILE to the current directory..."
tar -xzf "$OUTPUT_FILE"

# Check if the extraction was successful
if [ $? -eq 0 ]; then
    echo "Extraction completed successfully."
else
    echo "Extraction failed."
    exit 1
fi

chmod +x ~/setup.sh

echo "🙌 Done!"

