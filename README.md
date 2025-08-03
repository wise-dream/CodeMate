# CodeMate – Automated Developer Tools Installer

CodeMate is a **simple Bash script** that helps you **install or uninstall common developer tools** on **Windows (via Git Bash + Chocolatey)** and **Linux (APT-based)** systems.

It is designed for **beginners** who want to set up their development environment with minimal manual steps.

---

## 🚀 Features

- ✅ Works on **Windows 10/11 (Git Bash)** and **Linux Ubuntu/Debian**
- ✅ Automatic **Chocolatey installation** (Windows)
- ✅ Easy **tool selection menu**
- ✅ Supports **install** and **uninstall** actions
- ✅ Includes **force uninstall** option for broken Chocolatey packages
- ✅ Handles required repositories (Docker, VS Code on Linux)

---

## 🛠️ Supported Tools

- GCC (mingw-w64 / build-essential)
- Make
- Git
- Python
- Node.js (with npm)
- Docker
- Visual Studio Code
- curl
- wget
- PostgreSQL Client
- MySQL Client
- SQLite
- DBeaver
- Java JDK (Temurin/OpenJDK 11)
- Go
- Rust
- PHP

---

## 📋 Requirements

- **Windows:**  
  - Git Bash installed ([download here](https://git-scm.com/downloads))  
  - PowerShell available (default in Windows)  

- **Linux:**  
  - Debian/Ubuntu-based distribution  
  - `sudo` privileges  

---

## 📥 Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/wise-dream/CodeMate
   cd CodeMate
   ```
2. Make the script executable:
   ```
   chmod +x codemate_en.sh
   ```
4. Run the script:
   ```
   ./codemate_en.sh
   ```

## ⚠️ Notes
   It is recommended to run Git Bash as Administrator on Windows for smooth installation.

   Some tools (like Docker, VS Code) may require you to restart the terminal or log out and in for PATH changes to take effect.

   On Linux, dependencies may remain after uninstall (you can manually run):

   ```sudo apt-get autoremove -y```


