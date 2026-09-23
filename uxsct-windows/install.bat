@echo off
:: ==============================================================================
:: Script Name    : install.bat
:: Description    : Production-Grade Windows Task Scheduler Installer for UXsct
:: Author         : Mosab MohammedAli Adam Ahmed "R00tkage"
:: License        : MIT (Open Source)
:: ==============================================================================

echo "============================================================="
echo "[+] Initializing UXsct Deployment Pipeline..."
echo "[+] Registering automation trigger with Windows Task Scheduler..."
echo "============================================================="

:: Create a native system task triggered automatically at User Logon
:: Running in background using absolute current directory pointer (%~dp0)
schtasks /create /tn "UXsct_Auto_Screen" /tr "%~dp0uxsct-win.bat" /sc onlogon /f

echo.
echo "============================================================="
echo "[+] Deployment Success: UXsct Task Registered Permanently."
echo "============================================================="
pause

