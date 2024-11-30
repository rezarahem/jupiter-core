#!/bin/bash

# remove run.sh
rm -f run.sh

# Prompt for variables
read -p "Enter the domain name: " DOMAIN_NAME
read -p "Enter your email: " EMAIL
read -p "Enter your repo: " REPO_URL
read -p "Enter yout app name: " APP_DIR

cat <<EOF > ~/deploy.sh
#!/bin/bash

# Clone the Git repository
if [ -d "$APP_DIR" ]; then
  echo "Directory $APP_DIR already exists. Pulling latest changes..."
  cd "$APP_DIR" && git pull
  sudo docker-compose down
  sudo docker-compose up --build -d
else
  echo "Cloning repository from $REPO_URL..."
  git clone "$REPO_URL" "$APP_DIR"
  cd "$APP_DIR"
  sudo docker-compose up --build -d
fi

# Check if Docker Compose started correctly
if ! sudo docker-compose ps | grep "Up"; then
  echo "Docker containers failed to start. Check logs with 'docker-compose logs'."
  exit 1
fi
EOF


# Mark scripts as executable
chmod +x docker.sh
chmod +x nginx.sh 
chmod +x deploy.sh

Run the scripts in sequence
./docker.sh
./nginx.sh "$DOMAIN_NAME" "$EMAIL"

# echo 'You\'re all set up! 👌'

