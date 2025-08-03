#!/bin/bash
set -e

# =========================
# CodeMate - Dev Tools Installer
# =========================

# --- Functions ---
function info_admin_warning {
    echo "ℹ️  It is recommended to run Git Bash as Administrator for proper Chocolatey functionality."
    echo "   (Admin rights check may be inaccurate in Git Bash)"
    echo "👉 How to do it:"
    echo "   1️⃣ Close this Git Bash window"
    echo "   2️⃣ Find the 'Git Bash' shortcut"
    echo "   3️⃣ Right-click → 'Run as administrator'"
    echo
    read -rp "Continue without confirmed admin rights? [y/N]: " confirm
    [[ "$confirm" != "y" && "$confirm" != "Y" ]] && exit 1
}

function ensure_choco {
    if ! command -v choco &>/dev/null; then
        echo "⚠️ Chocolatey not found. Installing..."
        powershell.exe -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; \
        [System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'; \
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
        echo "✅ Chocolatey installed. Please restart Git Bash and re-run this script."
        exit 0
    else
        echo "✅ Chocolatey found"
    fi
}

function install_choco {
    local pkg=$1
    if choco list --local-only | grep -iq "^$pkg "; then
        echo "✅ $pkg already installed"
    else
        choco install "$pkg" -y
    fi
}

function uninstall_choco {
    local pkg=$1
    if choco list --local-only | grep -iq "^$pkg "; then
        choco uninstall "$pkg" -y
    else
        echo "⚠️ $pkg is not installed via Chocolatey"
    fi
}

function install_rust {
    if command -v rustc &>/dev/null; then
        echo "✅ Rust already installed"
    else
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source $HOME/.cargo/env
    fi
}

function uninstall_rust {
    if command -v rustup &>/dev/null; then
        rustup self uninstall -y
    else
        echo "⚠️ Rust not found"
    fi
}

function install_go {
    install_choco golang
}

function uninstall_go {
    uninstall_choco golang
}

# --- Tools list ---
TOOLS=(
    "GCC:gcc"
    "Make:make"
    "Git:git"
    "Python:python"
    "Node.js:nodejs-lts"
    "Docker:docker-desktop"
    "VS Code:visualstudiocode"
    "curl/wget:curl"
    "PostgreSQL Client:postgresql"
    "MySQL Client:mysql"
    "SQLite:sqlite"
    "DBeaver:dbeaver"
    "Java JDK:openjdk"
    "Go:golang"
    "Rust:rustup"
    "PHP:php"
)

# --- Script start ---
info_admin_warning
ensure_choco

echo "📦 Package manager: windows"
echo "Choose tools (example: 1 3 5):"
for i in "${!TOOLS[@]}"; do
    echo "$((i+1))) ${TOOLS[$i]%%:*}"
done

read -rp "Your choice: " choices
read -rp $'\nChoose action:\n1) Install selected tools\n2) Uninstall selected tools\nYour choice: ' action

for num in $choices; do
    tool_name="${TOOLS[$((num-1))]%%:*}"
    tool_pkg="${TOOLS[$((num-1))]##*:}"
    echo -e "\n=== ⚙️ Processing: $tool_name ==="
    case $tool_name in
        "Rust")
            [[ "$action" == "1" ]] && install_rust || uninstall_rust
            ;;
        "Go")
            [[ "$action" == "1" ]] && install_go || uninstall_go
            ;;
        *)
            [[ "$action" == "1" ]] && install_choco "$tool_pkg" || uninstall_choco "$tool_pkg"
            ;;
    esac
    echo "✅ Done: $tool_name"
done

echo "🎉 All operations completed!"
