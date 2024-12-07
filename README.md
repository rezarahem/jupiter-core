# Jupiter

**Jupiter** is a work-in-progress repository designed to simplify the process of building, deploying, and managing modern web applications. Built on top of Next.js and a carefully selected stack of powerful libraries, Jupiter provides a solid foundation for developers looking to kickstart their projects with essential features like authentication, database integration, and more.

Jupiter doesn't just focus on development—it also aims to simplify and automate the self-hosting process. With tools like a CLI to quickly set up the source code, pre-configured bash scripts for VPS configuration, and support for automated deployment workflows, Jupiter ensures that both hosting and deployment are as effortless as possible. By streamlining these processes, developers can focus on building their applications without getting bogged down by infrastructure complexities.

While Jupiter is still under development, its vision is clear: to empower developers with an efficient, scalable, and self-hosting-friendly way to build, deploy, and manage web applications. Stay tuned as we continue to enhance its capabilities!

**Disclaimer** This is a work-in-progress document. I'm testing and writing as I go, so there's a good chance you might encounter conflicts or inaccuracies. Please be patient—I'll ensure everything is properly finalized soon!

## Prerequisite

- **A VPS (ubuntu-24.04)**
- **A domain name with DNS configured to point to your VPS IP (or you can use the VPS IP directly)**

Note: A VPS and domain are not strictly required, but Jupiter relies on an email service for its authentication system, so you'll need to set up your own email service. Additionally, many other planned features will require a VPS for hosting. This guide assumes you're interested in self-hosting.

The rest of this document guides you through setting up a Jupiter project, from cloning the source code to configuring fully automated infrastructure for future development.

## Setup the VPS

I'm using a VPS with Ubuntu 24.04, and I recommend renting a similar setup. However, this setup should work with Ubuntu 20 and 22, though I haven't personally tested those versions.

This guide is written with the assumption that you're using the root user. If you're working with a non-root user, ensure the appropriate permissions are granted.

1. **Login to your VPS as root user**

   ```bash
   ssh root@your_vps_ip
   ```

2. **Update the packages**

   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

3. **Login with SSH key (Optional)**

   First, you need to generate a `SSH key`.

   **NOTE** You should generate your public/private SSH key pair on your local machine

   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

   **NOTE** Consider the public key has a `.pub` extension. You can safely share this key, but never ever expose your private key.

   Log your SSH public key with this command, then get a copy of it.

   ```bash
   cat /path/to/you/public/id_ed25519.pub
   ```

   [Use this link for more on SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

   Make a directory called .ssh in your VPS

   ```bash
   mkdir ~/ .ssh
   ```

   Make a file in this directory called `authorized_keys`

   ```bash
   nano ~/.ssh/authorized_keys
   ```

   This command opens a file called `authorized_keys` in a text editor.

   Add the public SSH key to `authorized_keys` using the nano text editor. Then save the file with `ctrl+x` followed by `Y` and finally `enter`.

   Now your SSH key is ready. next time you log in, you won't need to enter your password.

4. **Download the scripts**

   Clone the necessary script using the following command

   ```bash
   curl -o ~/run.sh https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/run.sh && chmod +x ~/run.sh && ~/run.sh
   ```

   This script clones a `sh` branch form jupiter-core needed to set up your VPS. It includes:

   - setup.sh
   - docker.sh
   - nginx.sh
   - spinup.sh
   - refresh.sh
   - deploy.sh

   Running `setup.sh` initiates the setup process. It will install `Docker` and `Nginx` on your `VPS`, and generates a `config.sh` file to manage container setup and future deployments.

   Now run the `setup.sh` to set up your `VPS`

   ```bash
   ./setup.sh
   ```

   Immediately after running `setup.sh`, several inputs will appear in the `Terminal`. These are basic variables required for setting up your `VPS`:

   - Enter your repo's SSH URL: <YOUR_REPO_SSH>
   - Enter your app name: <YOUR_APP_NAME>
   - Enter the domain name: <YOUR_DOMAIN>
   - Enter your email: <YOUR_EMAIL>

   **Solving Docker Pull Limit Issues with DNS Server Configuration**

   Usually, after this step, you won't need to do anything else. However, I personally ran into some issues with Docker that you probably won't experience. Docker imposes a pull request limit—even for all users. The limit is 100 pulls per six hours. If you exceed this, you'll need to wait before trying again.

   You can log in to your Docker account to increase the limit to 200 pulls, but I couldn't even log in. Every attempt resulted in a 429 Too Many Requests error, indicating I had made too many requests.

   I suspect this issue occurs because I'm using a shared machine with those long IP addresses, meaning all requests from this machine collectively exceed the 100-pull limit. This is likely why I couldn't access Docker.

   I could get one of those cool, expensive machines with a clean IP address, but the machine I'm using is ridiculously cheap. One of my main reasons for starting the Jupiter project was to keep expenses low.

   If you're like me and can't log in, try setting up a new pair of DNS servers. This solved my problem easily. I honestly need to dive deeper into understanding how this works, but it just fixes the issue. You don't even need to log in to Docker with this solution.

   Open the `resolv.conf` file with this command

   ```bash
   sudo nano /etc/resolv.conf
   ```

   And add your DNS namesevers

   ```
   nameserver 0.0.0.0
   nameserver 0.0.0.0
   ```

   It might be hard to find a suitable DNS nameserver, but you can always get a clean IP for some extra cash. Also, make sure to contact your support team, they might have better solutions.

5. **Deploayment**

   You can start the deployment by running the deploy.sh script that you generated in the previous step:

   ```bash
   ./deploy.sh
   ```

   This script will pull the source code from your GitHub repository and start building the production version of your Next.js app.

   To update your application, simply run the script again. It will pull the latest changes from the repository.

   Note: This script will only pull from the main branch of your repository.

   That's it! Your Next.js application is now ready at your domain 🚀.
