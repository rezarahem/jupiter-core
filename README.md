## Setup the VPS

This guide assumes you are using the root user. Provided you are using a non-root user, you should grant the appropriate permissions to that user.

### Prerequisites

1. Purchase a domain name
2. Purchase a Linux Ubuntu server
3. Create an `A` DNS record pointing to your server IPv4 address

### Setup

1. **Download the scripts**

   ```bash
   curl -o ~/run.sh https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/main/bash-scripts/run.sh && chmod +x ~/run.sh && ~/run.sh
   ```

1. **Run the `setup` script**

   ```bash
   ./setpu.sh
   ```
