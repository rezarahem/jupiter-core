## Setup the VPS

This guide assumes you are using the root user. Provided you are using a non-root user, you should grant the appropriate permissions to that user.

### Prerequisites

1. Purchase a domain name
2. Purchase a Linux Ubuntu server
3. Create an `A` DNS record pointing to your server IPv4 address


### Setup

1. **Download the scripts**

    ```bash
    for url in "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/docker.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/nginx.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/deploy.sh" "https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/setup.sh"; do echo -n "Downloading $(basename $url) ..."; curl -s -o ~/$(basename $url) "$url" && echo -e "\r$(printf ' %.0s' {1..50})\r✔  $(basename $url)"; [ "$(basename $url)" == "setup.sh" ] && chmod +x ~/setup.sh && echo "✔  Made setup.sh executable"; done; echo "🙌 Done!"
    ```

2. **Run the `setup` script**

    ```bash
    ./setpu.sh
    ```



