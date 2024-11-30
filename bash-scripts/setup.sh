#!/bin/bash

# Prompt for variables
read -p "Enter the domain name: " DOMAIN_NAME
read -p "Enter the server port: " EMAIL


# Mark scripts as executable
chmod +x docker.sh
chmod +x nginx.sh 
chmod +x deploy.sh

# Run the scripts in sequence
./docker.sh
./nginx.sh "$DOMAIN" "$PORT"

echo 'You're all set up! 👌'

