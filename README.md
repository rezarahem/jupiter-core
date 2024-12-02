# Jupiter

Jupiter is a work-in-progress repository designed to simplify the process of building, deploying, and managing modern web applications. Built on top of Next.js and a carefully selected stack of powerful libraries, Jupiter provides a solid foundation for developers looking to kickstart their projects with essential features like authentication, database integration, and more.

Jupiter doesn’t just focus on development—it streamlines deployment and automation too. With tools like a CLI to quickly set up the source code and pre-configured bash scripts for configuring your VPS, Jupiter ensures that getting your application live is as effortless as possible. Additionally, Jupiter supports automated deployment workflows, making it easy to keep your application updated with CI/CD pipelines.

While Jupiter is still under development, its vision is clear: to empower developers with an efficient and scalable way to build, deploy, and manage web applications. Stay tuned as we continue to enhance its capabilities!

## Clone the Source Code

<span style="color: yellow;">NOTE</span> You need to have [git](https://git-scm.com/downloads) installed for the cli to work.

For starting a new Jupiter project I prepared a CLI to clone the project.

1. **Start the CLI**

   Right now this cli just gets your `App Title` and clone `jupiter-core` repo

   ```
   npx @rahem/jupiter
   ```

   Provide a name to create a new folder and clone the repository inside it. Use `.` to clone into the current directory. This provides a quick way to get started with your project, and I’ll be continuously improving the CLI to include more setup options and automation features to streamline the development process.

2. **Initialize a Git Repository**

   Open the terminal (`Ctrl +` or View > Terminal) and run the following command to initialize a Git repository.

   ```bash
   git init
   ```

   Add your files

   ```bash
   git add .
   ```

   Commit the changes

   ```bash
   git commit -m "Init"
   ```

3. **Publish Your Repo on Github**

   There are two ways to publish your repository: either automatically through `VS Code's Source Control` or manually.

   - **Method 1: Automatically Publish Through VS Code's Source Control (Recommended)**

     1. Open Source Control

        Click on the Source Control icon in the Activity Bar or press `Ctrl + Shift + G`

     2. Initialize Git

        If Git is not initialized, you’ll see an option to `Initialize Repository`. Click it.\
        This will create a `.git` folder and initialize the repository. (We actually did this in the previous step, so you can skip this step. Still, it's good to know.)

     3. Add the First Commit

        In the Source Control panel, stage your changes by clicking the + icon next to the file names or the Stage All Changes button.\
        In the message box at the top, type a commit message, such as `init`.\
        Click the ✔ Commit button or press `Ctrl + Enter` to commit the changes.

     4. Sign in to GitHub

        If prompted, sign in to your GitHub account. You may need to authorize VS Code to access GitHub.

     5. Publish Repository

        Click the Publish Repository button in the Source Control panel.\
        Select GitHub as the provider.\
        Choose whether to make the repository public or private.

     6. Confirm and Publish

        VS Code will create a new repository on GitHub and push your local changes automatically. Once done, a notification will confirm the repository has been published, and you can view it on GitHub.

   - **Method 2: Manually Create a Repository on Github**

     1. Create a Repository on GitHub

        Go to GitHub and create a new repository.\
        Copy the repository URL (HTTPS or SSH).

     2. Link Local Repository to GitHub

        ```bash
        git remote add origin <repository-url>
        ```

     3. Push your code to GitHub

        ```bash
        git branch -M main
        git push -u origin main
        ```

## Setup the VPS

This guide is written with the assumption that you're using the root user. If you're working with a non-root user, ensure the appropriate permissions are granted.

1. **Login to your VPS with root user**

   ```bash
   ssh root@your_vps_ip
   ```

2. **Update the packages**

   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

3. **Login with SSH key**

   First you need to generate a `SSH key`.

   <span style="color: yellow;">NOTE</span> You should generate your public/private ssh key pair on your local machine

   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

   <span style="color: yellow;">NOTE</span> Consider the public key has a `.pub` extension. You can safely share this key, but never ever expose your private key.

   Read your ssh public key with this command, then get a copy of it.

   ```bash
   cat /path/to/you/public/id_ed25519.pub
   ```

   [Use this link for more on SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

   Make a directory called .ssh

   ```bash
   mkdir ~/ .ssh
   ```

   Make a file in this directory called `authorized_keys`

   ```bash
   nano ~/.ssh/authorized_keys
   ```

   This command opens a file called `authorized_keys` in a text editor.

   Add the public ssh key to `authorized_keys` with nano text editor. Then save the file with `ctrl+x` followed by `Y` and finally `enter`.

   Now your ssh key is ready. next time you log in, you don't need to enter your password.

4. **Disable Login with Password (Optional)**

   ...

5. **Setup CI/CD With Github Action**

   - First generate a SSH key on you VPS for connection to your github account

     ```bash
     ssh-keygen -t ed25519 -C "your-email@example.com"
     ```

     Log the public key

     ```bash
     cat ~/.ssh/id_ed25519.pub
     ```

     Copy the public key and go to your github.
     On your github, go to settings and under the SSH and GPG keys click on New SSH Key and add the key.

     then on your VPS you can test the connection with this command.

     ```bash
     ssh -T git@github.com
     ```

     If successful, you would see a log like this.

     `Hi username! You've successfully authenticated, but GitHub does not provide shell access.`

   - Second use github Secrets for automations

     generate another pair of ssh keys, consider to name this pair meaningful like `deploy` or whatever you want.

     ```bash
     ssh-keygen -t ed25519 -C "deploy" -f ~/.ssh/deploy_key
     ```

     Now on the repository you want CI/CD, go to the Settings under Deploy Keys add the new public key you generated

     You can read the key with this command

     ```bash
     cat .ssh/deploy_key.pub
     ```

     Now go to your repository settings page, under Secrets and Variables go to Actions and add the private key with `DEPLOY_SSH_KEY` as name or any name you want.

     Read the private key like this

     ```bash
     cat .ssh/deploy_key
     ```

   - Finally in your repo make a directory like this `/.github/workflows`. inside the workflows make a yml file. Name it whatever you want.

     `deploy.yml`

     ```
     name: Deploy to VPS

     on:
     push:
         branches:
             - main

     jobs:
     deploy:
         runs-on: your_linux_version
         steps:
             - name: Checkout code
             uses: actions/checkout@v3
             with:
                 fetch-depth: 0

             - name: Set up SSH
             run: |
                 mkdir -p ~/.ssh
                 echo "${{ secrets.DEPLOY_SSH_KEY }}" > ~/.ssh/id_ed25519
                 chmod 600 ~/.ssh/id_ed25519
                 ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
                 ssh-keyscan you_vps_ip >> ~/.ssh/known_hosts

             - name: Run deploy script on VPS
             run: |
                 ssh username@you_vps_ip "~/deploy.sh"
     ```

     With these steps whenever pushed to your repos main branch. Your VPS automatically gets updated.
     This action need a bash file to be present on the VPS to work. We add in the next step.

6. **Download the scripts**

   - Download the necessary script with this command

     ```bash
     curl -o ~/run.sh https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/run.sh && chmod +x ~/run.sh && ~/run.sh
     ```

   - Now run the `setup.sh` to set up your VPS

     ```bash
     ./setup.sh
     ```
