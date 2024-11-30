#!/bin/bash

# Mark scripts as executable
chmod +x add-docker.sh
chmod +x add-nginx.sh
chmod +x deploy.sh

# Run the scripts in sequence
./add-docker.sh
./add-nginx.sh
