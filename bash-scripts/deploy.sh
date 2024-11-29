#!/bin/bash

# Script Vars
DOMAIN_NAME="ju.rahem.dev"
REPO_URL="git@github.com:rezarahem/jupiter-core.git"
APP_DIR=~/ju

# Clone the Git repository
if [ -d "$APP_DIR" ]; then
  echo "Directory $APP_DIR already exists. Pulling latest changes..."
  cd $APP_DIR && git pull
  sudo docker-compose down
  sudo docker-compose up --build -d
else
  echo "Cloning repository from $REPO_URL..."
  git clone $REPO_URL $APP_DIR
  cd $APP_DIR
  sudo docker-compose up --build -d
fi

# Check if Docker Compose started correctly
if ! sudo docker-compose ps | grep "Up"; then
  echo "Docker containers failed to start. Check logs with 'docker-compose logs'."
  exit 1
fi
