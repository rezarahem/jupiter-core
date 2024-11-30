#!/bin/bash

# Mark scripts as executable
chmod +x docker.sh
chmod +x nginx.sh
chmod +x deploy.sh

# Run the scripts in sequence
./add-docker.sh
./add-nginx.sh
