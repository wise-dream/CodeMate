# CodeMate – Автоматизированный установщик инструментов разработчика

CodeMate — это **простой Bash-скрипт**, который помогает **устанавливать или удалять популярные инструменты разработчика** на **Windows (через Git Bash + Chocolatey)** и **Linux (APT-пакеты)**.

Скрипт создан для **начинающих пользователей**, чтобы максимально упростить процесс настройки рабочего окружения.

---

## 🚀 Возможности

- ✅ Работает на **Windows 10/11 (Git Bash)** и **Linux Ubuntu/Debian**
- ✅ Автоматическая установка **Chocolatey** (Windows)
- ✅ Удобное **меню выбора инструментов**
- ✅ Поддержка **установки** и **удаления** программ
- ✅ Возможность **принудительного удаления** повреждённых пакетов Chocolatey
- ✅ Автоматическая настройка репозиториев (Docker, VS Code на Linux)

---

## 🛠️ Поддерживаемые инструменты

- GCC (mingw-w64 / build-essential)
- Make
- Git
- Python
- Node.js (с npm)
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

## 📋 Требования

- **Windows:**  
  - Установленный Git Bash ([скачать здесь](https://git-scm.com/downloads))  
  - Наличие PowerShell (по умолчанию есть в системе)  

- **Linux:**  
  - Дистрибутив на базе Debian/Ubuntu  
  - Права суперпользователя (`sudo`)  

---

## 📥 Установка

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/wise-dream/CodeMate
   cd CodeMate
   ```
2. Сделайте скрипт исполняемым:
   ```
   chmod +x codemate.sh
   ```
3. Запустите скрипт:
   ```
   ./codemate.sh
   ```

---

## ⚠️ Примечания

   Рекомендуется запускать Git Bash от имени администратора на Windows для корректной работы установщика.

   Некоторые программы (например, Docker, VS Code) могут потребовать перезапуска терминала или повторного входа в систему, чтобы применились изменения в PATH.

   На Linux после удаления пакетов могут оставаться зависимости. Их можно очистить командой:
   ```
   sudo apt-get autoremove -y
   ```

---

<img width="1830" height="288" alt="изображение" src="https://github.com/user-attachments/assets/d2b72139-18f5-4f6f-a995-c11957aaa5a6" />
https://www.virustotal.com/gui/file/621dfeca8d60d8c34346427067141e73197ce584907061903fd81f150491ac1c/detection
