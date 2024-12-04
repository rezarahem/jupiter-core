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

## Clone the Source Code

**NOTE** You need to have [Git](https://git-scm.com/downloads) installed for the CLI to work.

To start a new Jupiter project I prepared a CLI to clone the project.

1. **Start the CLI**

   Right now, this CLI just gets your `App Title` and clones `jupiter-core` repo

   ```
   npx @rahem/jupiter
   ```

   Provide a name to create a new folder and clone the repository inside it. Use `.` to clone into the current directory. This provides a quick way to get started with your project, and I will continuously improving the CLI to include more setup options and automation features, further streamlining the development process.

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

     3. Add the First Commit (if you skip last step)

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

I'm using a VPS with Ubuntu 24.04, and I recommend renting a similar setup. However, I firmly believe the configurations we'll be setting up should also work with Ubuntu 20 and 22, though I haven't personally tested those versions.

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

   Download the necessary script using the following command

   ```bash
   curl -o ~/run.sh https://raw.githubusercontent.com/rezarahem/jupiter-core/refs/heads/sh/run.sh && chmod +x ~/run.sh && ~/run.sh
   ```

   This script downloads several files needed to set up your VPS

   - setup.sh
   - docker.sh
   - nginx.sh

   Running `setup.sh` kick-starts the setup process. It will install `Docker` and `Nginx` on your VPS and generate a `deploy.sh` script for deployment.

   Now run the `setup.sh` to set up your VPS

     ```bash
     ./setup.sh
     ```

   Usually, after this step, you won't need to do anything else. However, I personally ran into some issues with Docker that you probably won't experience. Docker imposes a pull request limit—even for first-time users. The limit is 100 pulls per six hours. If you exceed this, you'll need to wait before trying again.

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

   It might be hard to find a suitable DNS nameserver, but you can always get a clean IP for some extra cash. Also, make sure to contact your support team—they might have better solutions.

## Setup CI/CD With Github Action

GitHub Actions is a powerful CI/CD tool integrated into GitHub, enabling automated workflows for building, testing, and deploying applications. CI (Continuous Integration) ensures code changes are tested and validated automatically, while CD (Continuous Deployment) handles automated deployments to environments like production. Workflows are defined in `YAML` files under `.github/workflows`, triggered by events like `push` or `pull_request`. A typical workflow involves steps for checking out code, setting up the environment, installing dependencies, running tests, building, and deploying. Sensitive data like API keys can be securely stored as GitHub Secrets. For example, a Next.js deployment workflow might install dependencies, build the app, and deploy to production. GitHub Actions offers flexibility, reusable actions, making it ideal for automating modern development pipelines.

When setting up SSH access between your VPS and GitHub, it's important to note that you only need one SSH key pair (a public key and a private key) for each VPS. This single key pair is sufficient to authenticate the VPS with your GitHub account and can be used for all repositories associated with that account.

However, if you prefer more granular control, you can create and use a specific SSH key pair for a particular repository rather than for the entire GitHub account. This allows you to manage CI/CD processes for all repositories using one key pair or assign different keys for specific repositories as needed.

In this guide, we use the latter approach of creating and using a specific SSH key pair for a particular repository.

1. **Generate a SSH Key Pair**

   It's a good practice to choose a meaningful name for this pair like `deploy`

   ```bash
    ssh-keygen -t ed25519 -C "your_email@example.com" -f ".shh/deploy"
   ```

   Log the public key

   ```bash
   cat ~/.ssh/deploy.pub
   ```

   Copy the public key and go to your github.

   On your github repo, go to settings and under `Deploy keys` add the new public key you generated.

2. **Add Github Secret**

   Now log the private key with this command.

   ```bash
   cat .ssh/deploy
   ```

   Copy it and go back to your repository settings page, under Secrets and Variables go to Actions and add the private key with `DEPLOY_SSH_KEY` as name or any name you want.

3. **Add Github Action Workflow to the Source Code**

   GitHub Actions is a powerful tool for automating tasks within your software development lifecycle. It enables you to define custom workflows for CI/CD (Continuous Integration/Continuous Deployment), automated testing, code quality checks, and other processes.

   To make GitHub Actions work, you need to add `a workflow file` to your project. Workflow files are written in `YAML` and stored in the `.github/workflows/` directory at the root of your repository.

   Here, we aim to automate the deployment process. To achieve this, I added a command to the Jupiter CLI called deploy-workflow. You can also use the shorthand alias dw to quickly add a deployment workflow action to your project.

   ```bash
   npx @rahem/jupiter dw <secret>
   ```

   Replace `<secret>` with your SSH secret key configured in the previous step.

   This command will generate a `deploy.yml` file in your project, setting up the deployment workflow automatically.

   With these steps, whenever you push to your repository's main branch, your app on the VPS will automatically update. This action requires a bash file to be present on the VPS, which is generated when you run the ./setup script. Everything is handled for you.
