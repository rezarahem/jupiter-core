1. **Download the Setup Scripts**
```bash
for file_url in "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/add-docker.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/add-nginx.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/deploy.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/setup.sh"; do echo "Downloading $(basename $file_url)..."; curl -s -o ~/$(basename $file_url) "$file_url" && echo "✔ $(basename $file_url)"; done; echo "Done!"
```

