#!/bin/bash
url="https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/scripts.tar"

echo -n "Downloading scripts archive ..."

curl -s -o ~/scripts.tar.gz "$url" && echo -e "\r$(printf ' %.0s' {1..50})\r✔  Downloaded scripts.tar.gz"

tar -xzf ~/scripts.tar.gz -C ~ && echo "✔  Extracted scripts."

chmod +x ~/setup.sh && echo "✔  Made setup.sh executable"

rm ~/scripts.tar.gz && echo "✔  Removed the archive"

echo "🙌 Done!"
