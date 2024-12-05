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

