1. **Download the Setup Scripts**
```bash
for file_url in "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/add-docker.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/add-nginx.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/deploy.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/setup.sh"; do echo -n "Downloading $file_url... "; curl -s -o ~/$(basename $file_url) "$file_url" & pid=$!; while kill -0 $pid 2>/dev/null; do for s in / - \\ \|; do echo -n "$s"; sleep 0.1; echo -ne "\b"; done; done; echo "Done!"; done
```

