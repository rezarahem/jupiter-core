#!/bin/bash
url="https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/scripts.tar"

echo -n "Downloading scripts archive ..."

curl -s -o ~/scripts.tar "$url" && echo -e "\r$(printf ' %.0s' {1..50})\r✔  Downloaded scripts.tar"

tar -xzf ~/scripts.tar -C ~ && echo "✔  Extracted scripts."

chmod +x ~/setup.sh && echo "✔  Made setup.sh executable"

rm ~/scripts.tar && echo "✔  Removed the archive"

echo "🙌 Done!"
