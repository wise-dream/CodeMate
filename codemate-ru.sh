#!/bin/bash
set -e

# =========================
# CodeMate - Установка Dev-инструментов
# =========================

function info_admin_warning {
    echo "ℹ️  Рекомендуется запускать Git Bash с правами администратора для корректной работы Chocolatey."
    echo "   (Проверка прав администратора в Git Bash может быть неточной)"
    echo "👉 Как это сделать:"
    echo "   1️⃣ Закройте текущее окно Git Bash"
    echo "   2️⃣ Найдите ярлык 'Git Bash'"
    echo "   3️⃣ ПКМ → 'Запуск от имени администратора'"
    echo
    read -rp "Продолжить выполнение без подтверждения прав администратора? [y/N]: " confirm
    [[ "$confirm" != "y" && "$confirm" != "Y" ]] && exit 1
}

function ensure_choco {
    if ! command -v choco &>/dev/null; then
        echo "⚠️ Chocolatey не найден. Устанавливаю..."
        powershell.exe -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; \
        [System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'; \
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
        echo "✅ Chocolatey установлен. Пожалуйста, перезапустите Git Bash и запустите скрипт снова."
        exit 0
    else
        echo "✅ Chocolatey найден"
    fi
}

function install_choco { local pkg=$1; if choco list --local-only | grep -iq "^$pkg "; then echo "✅ $pkg уже установлен"; else choco install "$pkg" -y; fi; }
function uninstall_choco { local pkg=$1; if choco list --local-only | grep -iq "^$pkg "; then choco uninstall "$pkg" -y; else echo "⚠️ $pkg не установлен через Chocolatey"; fi; }

function install_rust { if command -v rustc &>/dev/null; then echo "✅ Rust уже установлен"; else curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; source $HOME/.cargo/env; fi; }
function uninstall_rust { if command -v rustup &>/dev/null; then rustup self uninstall -y; else echo "⚠️ Rust не найден"; fi; }

function install_go { install_choco golang; }
function uninstall_go { uninstall_choco golang; }

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

info_admin_warning
ensure_choco

echo "📦 Пакетный менеджер: windows"
echo "Выберите инструменты (например: 1 3 5):"
for i in "${!TOOLS[@]}"; do echo "$((i+1))) ${TOOLS[$i]%%:*}"; done

read -rp "Ваш выбор: " choices
read -rp $'\nВыберите действие:\n1) Установить выбранные инструменты\n2) Удалить выбранные инструменты\nВаш выбор: ' action

for num in $choices; do
    tool_name="${TOOLS[$((num-1))]%%:*}"
    tool_pkg="${TOOLS[$((num-1))]##*:}"
    echo -e "\n=== ⚙️ Обработка: $tool_name ==="
    case $tool_name in
        "Rust") [[ "$action" == "1" ]] && install_rust || uninstall_rust ;;
        "Go") [[ "$action" == "1" ]] && install_go || uninstall_go ;;
        *) [[ "$action" == "1" ]] && install_choco "$tool_pkg" || uninstall_choco "$tool_pkg" ;;
    esac
    echo "✅ Готово: $tool_name"
done

echo "🎉 Все операции завершены!"
