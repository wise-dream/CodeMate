#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=false

# --- Check and install Chocolatey (Windows) ---
check_choco() {
  if ! command -v choco &>/dev/null; then
    echo "⚠️  Chocolatey not found. Attempting to install..."
    powershell.exe -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; \
      [System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'; \
      iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    if ! command -v choco &>/dev/null; then
      echo "❌ Failed to install Chocolatey. Please install manually: https://chocolatey.org/install"
      exit 1
    fi
  fi
}

# --- Check if tool is installed ---
verify_installed() {
  command -v "$2" &>/dev/null
}

# --- Force uninstall (Windows) ---
force_uninstall() {
  local pkg="$1"
  echo "⚠️  Force removing $pkg..."
  rm -rf "/c/ProgramData/chocolatey/lib/$pkg" 2>/dev/null || true
  rm -rf "/c/ProgramData/chocolatey/bin/$pkg*" 2>/dev/null || true
  echo "✅ Forced removal of $pkg completed."
}

# --- Add required repos (Linux) ---
ensure_repos() {
  local tool=$1
  case $tool in
    "Docker")
      sudo install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
      ;;
    "VS Code")
      sudo install -m 0755 -d /etc/apt/keyrings
      wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/packages.microsoft.gpg >/dev/null
      echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
      ;;
  esac
}

# --- Package dictionaries ---
declare -A PKG_CHOCOLATEY=(
  ["GCC"]="mingw-w64"
  ["Make"]="make"
  ["Git"]="git"
  ["Python"]="python"
  ["Node.js"]="nodejs"
  ["Docker"]="docker-desktop"
  ["VS Code"]="vscode"
  ["curl"]="curl"
  ["wget"]="wget"
  ["PostgreSQL Client"]="postgresql"
  ["MySQL Client"]="mysql"
  ["SQLite"]="sqlite"
  ["DBeaver"]="dbeaver"
  ["Java JDK"]="temurin11"
  ["Go"]="golang"
  ["Rust"]="rust"
  ["PHP"]="php"
)

declare -A PKG_APT=(
  ["GCC"]="build-essential"
  ["Make"]="make"
  ["Git"]="git"
  ["Python"]="python3"
  ["Node.js"]="nodejs npm"
  ["Docker"]="docker-ce docker-ce-cli containerd.io"
  ["VS Code"]="code"
  ["curl"]="curl"
  ["wget"]="wget"
  ["PostgreSQL Client"]="postgresql-client"
  ["MySQL Client"]="mysql-client"
  ["SQLite"]="sqlite3"
  ["DBeaver"]="dbeaver"
  ["Java JDK"]="openjdk-11-jdk"
  ["Go"]="golang-go"
  ["Rust"]="rustc"
  ["PHP"]="php"
)

PKG_MANAGER="apt-get"
if command -v choco &>/dev/null; then
  PKG_MANAGER="choco"
fi

check_choco

# --- Menu ---
tools=( "GCC" "Make" "Git" "Python" "Node.js" "Docker" "VS Code" "curl" "wget" "PostgreSQL Client" "MySQL Client" "SQLite" "DBeaver" "Java JDK" "Go" "Rust" "PHP" )

echo "⚠️  It is recommended to run Git Bash as Administrator."
echo "⚠️  Without administrator rights, some installations/uninstallations may fail."
echo "Select tools to manage (space-separated):"
for i in "${!tools[@]}"; do echo "$i) ${tools[$i]}"; done
read -rp "> " selection

echo "Select action: (1 - Install, 2 - Uninstall)"
read -rp "> " action

for idx in $selection; do
  tool="${tools[$idx]}"
  case $action in
    1)
      if verify_installed "$tool" "$tool" || verify_installed "$tool" "${tool,,}"; then
        echo "✅ $tool is already installed."
        continue
      fi
      echo "🔹 Installing $tool..."
      case $PKG_MANAGER in
        choco) choco install -y "${PKG_CHOCOLATEY[$tool]}" ;;
        apt-get)
          ensure_repos "$tool"
          sudo apt-get update -qq
          sudo apt-get install -y ${PKG_APT[$tool]}
          ;;
      esac
      ;;
    2)
      echo "🔹 Uninstalling $tool..."
      case $PKG_MANAGER in
        choco)
          if ! choco uninstall -y "${PKG_CHOCOLATEY[$tool]}" --skip-autouninstaller; then
            force_uninstall "${PKG_CHOCOLATEY[$tool]}"
          fi
          ;;
        apt-get) sudo apt-get purge -y ${PKG_APT[$tool]} || true ;;
      esac
      ;;
  esac
done

echo "✅ Operation completed."
