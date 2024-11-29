#!/bin/bash

DOMAIN_NAME="ju.rahem.dev"
EMAIL="reza.rahem224@gmail.com" 

# Install Nginx
sudo apt install nginx -y

# Remove old Nginx config (if it exists)
sudo rm -f /etc/nginx/sites-available/myapp
sudo rm -f /etc/nginx/sites-enabled/myapp

# Stop Nginx temporarily to allow Certbot to run in standalone mode
sudo systemctl stop nginx

# Obtain SSL certificate using Certbot standalone mode
sudo apt install certbot -y
sudo certbot certonly --standalone -d $DOMAIN_NAME --non-interactive --agree-tos -m $EMAIL

# Ensure SSL files exist or generate them
if [ ! -f /etc/letsencrypt/options-ssl-nginx.conf ]; then
  sudo wget https://raw.githubusercontent.com/certbot/certbot/main/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf -P /etc/letsencrypt/
fi

if [ ! -f /etc/letsencrypt/ssl-dhparams.pem ]; then
  sudo openssl dhparam -out /etc/letsencrypt/ssl-dhparams.pem 2048
fi

# Adjust permissions for the live directory and the archived certificates
sudo chown -R root:www-data /etc/letsencrypt/live/$DOMAIN_NAME /etc/letsencrypt/archive/$DOMAIN_NAME
sudo chmod 750 /etc/letsencrypt/live
sudo chmod 750 /etc/letsencrypt/archive
sudo chmod 640 /etc/letsencrypt/live/$DOMAIN_NAME/*
sudo chmod 640 /etc/letsencrypt/archive/$DOMAIN_NAME/*

# Make sure parent directories are accessible
sudo chmod 755 /etc/letsencrypt
sudo chmod 755 /etc/letsencrypt/live
sudo chmod 755 /etc/letsencrypt/archive


# Create Nginx config with reverse proxy, SSL support, rate limiting, and streaming support
sudo bash -c "cat > /etc/nginx/sites-available/myapp <<'EOL'
limit_req_zone \$binary_remote_addr zone=mylimit:10m rate=10r/s;

server {
    listen 80;
    server_name $DOMAIN_NAME;

    # Redirect all HTTP requests to HTTPS
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name $DOMAIN_NAME;

    ssl_certificate /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    # Enable rate limiting
    limit_req zone=mylimit burst=20 nodelay;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;

        # Disable buffering for streaming support
        proxy_buffering off;
        proxy_set_header X-Accel-Buffering no;
    }
}
EOL"


# sudo -s cat > /etc/nginx/sites-available/myapp <<'EOL'
# limit_req_zone \$binary_remote_addr zone=mylimit:10m rate=10r/s;

# server {
#     listen 80;
#     server_name $DOMAIN_NAME;

#     # Redirect all HTTP requests to HTTPS
#     return 301 https://\$host\$request_uri;
# }

# server {
#     listen 443 ssl;
#     server_name $DOMAIN_NAME;

#     ssl_certificate /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem;
#     ssl_certificate_key /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem;
#     include /etc/letsencrypt/options-ssl-nginx.conf;
#     ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

#     # Enable rate limiting
#     limit_req zone=mylimit burst=20 nodelay;

#     location / {
#         proxy_pass http://localhost:3000;
#         proxy_http_version 1.1;
#         proxy_set_header Upgrade \$http_upgrade;
#         proxy_set_header Connection 'upgrade';
#         proxy_set_header Host \$host;
#         proxy_cache_bypass \$http_upgrade;

#         # Disable buffering for streaming support
#         proxy_buffering off;
#         proxy_set_header X-Accel-Buffering no;
#     }
# }
# EOL

# Create symbolic link if it doesn't already exist
sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/myapp

# Restart Nginx to apply the new configuration
sudo systemctl restart nginx


