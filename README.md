# Windows Security Audit Script (PowerShell)

This project is a PowerShell-based Windows security audit tool created by Brecon N., a cybersecurity student. The script performs a local audit of key system security settings and outputs easy-to-read results for basic hardening and awareness.

## 🔍 What It Checks

- ✅ Windows Defender Status
- 🔥 Windows Firewall (Domain, Private, Public profiles)
- 🔐 Password Policy (length, expiration, lockout)
- 👤 Local Administrator Accounts
- 🧑‍🦲 Guest Account Status
- 🖥️ Remote Desktop Access
- 🔐 BitLocker Drive Encryption (if supported)

## 🚀 How to Run

1. Open PowerShell as Administrator.
2. Navigate to the script directory (e.g. `cd ~\Desktop`).
3. Temporarily allow execution:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```
4. Run the script:
   ```powershell
   .\AuditScript.ps1
   ```

## 📋 Output Sample

Each section outputs results with ✅ (secure), ❌ (at risk), or ⚠️ (not supported). The script ends with a prompt to press ENTER so results stay visible.

## 🔐 Author

Created by Brecon N. | Cybersecurity Student @ Oakland Community College  
Project goal: Build hands-on auditing skills, system hardening awareness, and portfolio-ready tooling.
