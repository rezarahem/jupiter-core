#!/bin/bash

set -e

# remove run.sh
rm -f run.sh

# Prompt for variables
read -p "Enter your repo's SSH URL: " REPO
read -p "Enter your app name: " APP
read -p "Enter the domain name: " DOMAIN
read -p "Enter your email: " EMAIL

# Generate the config.sh file
cat > config.sh <<EOF
# Configuration File

REPO="$REPO"
DIR="$APP"
IMAGE="$APP"
NET="$APP"
DOMAIN="$DOMAIN"
EMAIL="$EMAIL"
EOF

echo "Generated config.sh with the provided configuration."

# Mark scripts as executable
chmod +x docker.sh
chmod +x nginx.sh 
chmod +x spinup.sh
chmod +x refresh.sh
chmod +x deploy.sh

# Run the scripts in sequence
./docker.sh
./nginx.sh

# Check if the Docker network already exists
if ! docker network inspect $APP > /dev/null 2>&1; then
  docker network create $APP
  echo "Docker network $APP created."
else
  echo "Docker network $APP already exists."
fi


echo "You're all set up! 👌"

