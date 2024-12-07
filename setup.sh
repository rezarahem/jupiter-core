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
DOMAIN="$DOMAIN"
EMAIL="$EMAIL"
EOF

echo "Generated config.sh with the provided configuration."

# Generate the deploy.sh file
cat > deploy.sh <<'EOF'
#!/bin/bash

set -e

# Load the configuration
if [[ -f config.sh ]]; then
  source config.sh
else
  echo "Error: config.sh file not found. Please run the setup script to generate it."
  exit 1
fi

# Validate required variables
if [[ -z "$REPO" || -z "$DIR" || -z "$IMAGE" ]]; then
  echo "Error: Missing required configuration values."
  echo "Please ensure REPO, DIR, and IMAGE are defined in config.sh."
  exit 1
fi

echo "Starting deployment for $IMAGE from repository $REPO into directory $DIR..."


LAST_IMAGE_ID=$(docker images --filter=reference="$IMAGE:latest" --format "{{.ID}}")

echo "Building the Docker image..."
docker build -t "$IMAGE" .

if [ -n "$LAST_IMAGE_ID" ]; then
  docker tag "$LAST_IMAGE_ID" "$IMAGE:backup"
  echo "Backup image tagged as $IMAGE:backup"
else
  echo "No existing 'latest' image found, skipping backup."
fi

# Check if any container is running on port 3000
container_id_3000=$(docker ps --filter "publish=3000" --format "{{.ID}}")
# Check if any container is running on port 3001
container_id_3001=$(docker ps --filter "publish=3001" --format "{{.ID}}")

# If no containers are found on both ports, spin up the image
if [ -z "$container_id_3000" ] && [ -z "$container_id_3001" ]; then
  echo "No active containers on ports 3000 and 3001. Spinning up the container..."
  ~/spinup.sh
else
  # If there are active containers, call refresh with the container IDs
  echo "Active containers found on ports 3000 and/or 3001. Refreshing..."
  ~/refresh.sh 
fi
EOF


echo "Generated deploy.sh script. You can now use ./deploy.sh to start the deployment process."

# Mark scripts as executable
chmod +x docker.sh
chmod +x nginx.sh 
chmod +x spinup.sh
chmod +x refresh.sh
chmod +x deploy.sh

# Run the scripts in sequence
./docker.sh
./nginx.sh "$DOMAIN" "$EMAIL"

echo "You're all set up! 👌"




# cat <<EOF > ~/deploy.sh
# #!/bin/bash

# set -e

# # Clone the Git repository
# if [ -d "$APP" ]; then
#   echo "Directory $APP already exists. Pulling latest changes..."
#   cd "$APP" && git pull
#   sudo docker-compose down
#   sudo docker-compose up --build -d
# else
#   echo "Cloning repository from $REPO..."
#   git clone "$REPO" "$APP"
#   cd "$APP"
#   sudo docker-compose up --build -d
# fi

# # Check if Docker Compose started correctly
# if ! sudo docker-compose ps | grep "Up"; then
#   echo "Docker containers failed to start. Check logs with 'docker-compose logs'."
#   exit 1
# fi
# EOF

