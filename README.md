# Verilog Remote Development Container

> This project aims to create an easy to use verilog development workflow without having to mess with a bunch of dependencies or ancient software.

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Installation Via VS Code GUI](#installation-via-vs-code-gui)
  - [Installation Via Command line](#installation-via-command-line)
- [Updating Repo](#updating-your-repo-to-get-new-features-or-bug-fixes)
- [VS Code Tasks](#vs-code-tasks)
  

---

## Overview

Using VS Code Dev Containers, this project makes setting up an environment for developing verilog super simple.

---

## Features

- Fully reproducible VS Code Dev Container
- Tools for verilog development and simulation pre-installed
    - **Icarus Verilog** – simulation compilation and linting
    - **GTKWave** – waveform viewing
    - **Verible** – formatting & language server
- Project-based workflow:
    - Create multiple projects, each having seperate folders for modules, tests, and testbenches
- Makefile-driven builds and simulation (no commandline needed)
- VS Code tasks for:
    - Creating new projects
    - Adding modules and testbenches
    - Building and simulating selected projects
    - Opening waveforms

---

## Installation

### Prerequisites:

Before starting, make sure you have:

- **Docker** installed and running  
  - https://www.docker.com/products/docker-desktop/
- **Visual Studio Code**
  - https://code.visualstudio.com/
- **VS Code Dev Containers extension**
  - Open VS Code
  - Go to Extensions (`Ctrl+Shift+X`)
  - Search for **“Dev Containers”**
  - Install the extension by Microsoft

---

### Installation Via VS Code GUI:

#### Step 0: Create a New Project from the Template
1. Go to the template repository on github: https://github.com/JayrodHarv/verilog-devcontainer-template.git
2. Click the **Use this Template** button on top right
3. Choose:
  * Repository Name
  * Visibility (Public or Private)
4. Click **Create repository**

This creates a new repository with no Git history connection to the template.

#### Step 1: Clone the Newly Created Repository from VS Code

1. Open **VS Code**
2. Press: **ctrl+shift+p**
3. Type and select **Git: Clone**
4. Copy Github repository URL by clicking the **Code** button and Paste the GitHub repository URL: **https://github.com/{your-github-profile-name}/{your-github-repo-name}.git**
5. Choose a folder on your computer where the repo should go
6. When prompted, select: **Open**

VS Code will open the repository after cloning.

---

#### Step 2: Reopen the Project in the Dev Container

Once the repository is open:

1. VS Code should detect the `.devcontainer/` folder automatically  
If it does, you’ll see a popup in the bottom-right corner: **Reopen in Container**, press it
2. If that popup doesn't appear, press **ctrl+shift+p** and type and select the option: **Dev Containers: Reopen in Container**. If that option doesn't show up, make sure that you have the **Dev Containers** VS Code extension installed and try again.

---

#### Step 3: Wait for the Container to Build

VS Code will now:

- Build the Docker image
- Install all required Verilog tools
- Configure the development environment

This can take **a few minutes the first time**, later reopening of the container is very quick.

You can watch progress in:
- The VS Code terminal
- The “Dev Containers” output panel

Once finished, VS Code will automatically reload **inside the container**.

---


### Installation Via Command line:

```bash
git clone https://github.com/JayrodHarv/{your-repo-name}.git
cd {your-repo-name}
```

## Updating Your Repo to Get New Features or Bug Fixes

```bash
git remote add template https://github.com/JayrodHarv/verilog-devcontainer-template.git
git fetch template
git merge template/main
```

You may need to resolve merge conflicts if you modified environment files.

## VS Code Tasks

### To Build Project, Run Simulation, or Add New Modules, Tests, Testbenches:

From the command palette(ctrl+shift+p), search for **Run Task** and select from:

- **Build & Simulate** – Builds project and compiles a simulation
- **Waveform Viewer** – Opens generated simulation in GTKWave
- **New Module** – creates a new RTL module file using template
- **New Test** – creates a new test file using template
- **New Testbench** – creates a new testbench file using template

Files are generated from templates and placed into the correct project folder.

---
