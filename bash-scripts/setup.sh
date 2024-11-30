#!/bin/bash

# Prompt for variables
read -p "Enter the domain name: " DOMAIN_NAME
read -p "Enter your email: " EMAIL

# Check if inputs are empty
if [[ -z "$DOMAIN_NAME" || -z "$EMAIL" ]]; then
  echo "Error: Missing domain or email."
  exit 1
fi


# Mark scripts as executable
chmod +x docker.sh
chmod +x nginx.sh 
chmod +x deploy.sh

# Run the scripts in sequence
./docker.sh
./nginx.sh "$DOMAIN_NAME" "$EMAIL"

echo 'You're all set up! 👌'

