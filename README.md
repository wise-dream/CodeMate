# 🚀 CodeMate

CodeMate is a simple, beginner-friendly script that helps you quickly install essential developer tools on Windows using Git Bash and Chocolatey.

It supports installing and uninstalling popular tools like GCC (C++), Python, Node.js, Docker, Java JDK, and more. Perfect for new developers who want to set up their environment without complex instructions.

---

## 📌 Features

- ✅ Installs common programming tools in a few clicks
- ✅ Works via Chocolatey package manager
- ✅ Option to uninstall tools
- ✅ Friendly interface for beginners
- ✅ Includes alternative download methods for tools not available in Chocolatey

---

## 🛠️ Tools Available

1. GCC (C++ compiler)
2. Make (build automation tool)
3. Git (version control)
4. Python
5. Node.js
6. Docker
7. Visual Studio Code
8. curl / wget
9. PostgreSQL Client (psql)
10. MySQL Client
11. SQLite
12. DBeaver (GUI for databases)
13. Java JDK
14. Go
15. Rust (via rustup installer)
16. PHP

---

## 📥 Installation

### 1️⃣ Install Git Bash

Make sure Git Bash is installed (it comes with Git for Windows).  
Download Git here: https://git-scm.com/download/win

---

### 2️⃣ Download CodeMate

Open Git Bash and run:

```bash
git clone https://github.com/wise-dream/CodeMate
cd CodeMate
```

---

### 3️⃣ Run the script

English version:

```bash
./codemate.sh
```

Russian version:

```bash
./codemate-ru.sh
```

> ⚠️ Tip:  
> It's recommended to run Git Bash as Administrator to allow Chocolatey to install tools properly.  
> If you don't, some installations may fail with "Access Denied" errors.

---

## ⚙️ Usage

1. Launch the script
2. Select the tools you want to install (e.g., `1 4 5`)
3. Choose an action:
   - 1) Install selected tools
   - 2) Uninstall selected tools
4. Wait until installation is complete

---

## ❌ Uninstalling Tools

You can run the script again and select:

```bash
2) Uninstall selected tools
```

> If a tool was installed manually (not via Chocolatey), CodeMate tries to remove it using alternative uninstall commands.

---

## 💡 Notes

- Some tools (e.g., Rust) are installed via official installers instead of Chocolatey.
- You may need to restart Git Bash or your PC after installing certain tools for PATH changes to apply.
- If a tool is already installed, CodeMate will skip it.

---

## 🤝 Contributing

Feel free to fork this project and submit pull requests with:
- New tools
- Bug fixes
- UX improvements

---

## 📜 License

MIT License – free to use and modify.
