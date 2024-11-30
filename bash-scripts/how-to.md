1. **Download the Setup Scripts**
```bash
for file_url in "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/add-docker.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/add-nginx.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/deploy.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/setup.sh"; do 
    echo -n "Downloading $(basename $file_url)"
    
    # Animate the dots, cycle them
    while true; do
        for dots in "." ".." "..."; do
            echo -ne "\rDownloading $(basename $file_url) $dots"
            sleep 0.5
        done
        break  # Break after one full cycle
    done
    
    # Now download the file and replace the line with the checkmark
    curl -s -o ~/$(basename $file_url) "$file_url" && echo -e "\r$(printf '%.0s ' {1..50})\r✔  $(basename $file_url)"
done; 
echo "Done!"
```

