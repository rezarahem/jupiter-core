1. **Download the Setup Scripts**
```bash
for file_url in "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/docker.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/nginx.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/deploy.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/setup.sh"; do 

    echo -n "Downloading $(basename $file_url)"
    
    # Animate a spinner
    spinner="/-\|"
    while true; do
        for i in {0..3}; do
            echo -ne "\rDownloading $(basename $file_url) ${spinner:$i:1}"
            sleep 0.1
        done
        break  # Break after one full cycle
    done
    
    # Now download the file and replace the line with the checkmark
    curl -s -o ~/$(basename $file_url) "$file_url" && echo -e "\r$(printf '%.0s ' {1..50})\r✔  $(basename $file_url)"

     # Make setup.sh executable
    if [ "$(basename $file_url)" == "setup.sh" ]; then
        chmod +x ~/setup.sh
        echo "Made setup.sh executable"
    fi

done; 
echo "Done!"
```

