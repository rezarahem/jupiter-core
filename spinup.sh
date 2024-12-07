#!/bin/bash

set -e


if [[ -f config.sh ]]; then
  source config.sh
else
  echo "Error: config.sh file not found. Please run the setup script to generate it."
  exit 1
fi

if [[ -z "$IMAGE" ]]; then
  echo "Error: Missing required configuration values."
  echo "Please ensure IMAGE is defined in config.sh."
  exit 1
fi


# Initialize variables to track health check results
apollo_health=true
artemis_health=true


# Get the image name from the argument
# IMAGE=$1

check_health() {
  local port=$1
  local nickname=$2
  local health_check_url="http://localhost:$port/api/health"

  # Get the container ID based on port mapping
  local container_id=$(sudo docker ps --filter "publish=$port" --format "{{.ID}}")

  if [ -z "$container_id" ]; then
    echo "No container found for port $port!"
    return 1
  fi

  echo "Checking health of container ($nickname) on port $port..."

  # Perform the health check using curl
  if curl --silent --fail "$health_check_url" > /dev/null; then
    echo "Container ($nickname) on port $port is healthy!"
    return 0
  else
    echo "Container ($nickname) on port $port is unhealthy!"
    return 1
  fi
}

# Start Apollo container on port 3000
sudo docker run --rm -d -p 3000:3000 --name apollo "$IMAGE:latest"

sleep 5

# Run health check for Apollo
if check_health 3000 "Apollo"; then
  echo "Apollo (port 3000) succeeded."
else
  apollo_health=false
  echo "Apollo (port 3000) failed."
fi

# Start Artemis container on port 3001
sudo docker run --rm -d -p 3001:3000 --name artemis "$IMAGE:latest"

sleep 5


# Run health check for Artemis
if check_health 3001 "Artemis"; then
  echo "Artemis (port 3001) succeeded."
else
  artemis_health=false
  echo "Artemis (port 3001) failed."
fi

if [ "$apollo_health" = false ] && [ "$artemis_health" = false ]; then
  echo "Both containers failed health check."
  exit 1 
fi


echo "Successful Deployment"
