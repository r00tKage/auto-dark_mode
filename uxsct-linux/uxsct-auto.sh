#!/bin/bash
# ==============================================================================
# Script Name    : uxsct-auto.sh
# Description    : Automated Blue Light Filter & Screen Temperature Manager for XFCE
# Author         : Mosab MohammedAli Adam Ahmed
# Year           : 2026 / 2027 Target
# License        : MIT (Open Source)
# ==============================================================================

set -e

echo "========= Start Linux Hardening & Screen Automation ========="

# 1. Verify and install Debian physical dependency if missing
if ! command -v xsct &> /dev/null; then
    echo "[+] Installing xsct dependency via apt package manager..."
    sudo apt update && sudo apt install -y xsct
fi

# 2. Rebuild and sanitize the Crontab file to fully automate Linux lifecycle tasks
echo "[+] Configuring Crontab matrix..."
TMP_CRON=$(mktemp)
crontab -l > "$TMP_CRON" 2>/dev/null || true
sed -i '/xsct/d' "$TMP_CRON"

# Inject core Linux crontab routines (Night Mode, Day Mode, and Safe Reboot Guard)
echo "0 18 * * * export DISPLAY=:0 && xsct 3500 # Mosab Auto Night Mode" >> "$TMP_CRON"
echo "0 5 * * * export DISPLAY=:0 && xsct 6500 # Mosab Auto Day Mode" >> "$TMP_CRON"
echo "@reboot export DISPLAY=:0 && current_hour=\$(date +%H) && if [ \$current_hour -ge 18 ] || [ \$current_hour -lt 5 ]; then xsct 3500; else xsct 6500; fi # Mosab Restart Safe Guard" >> "$TMP_CRON"

crontab "$TMP_CRON"
rm -f "$TMP_CRON"

# 3. Execution Gate: Linux system clock verification for immediate runtime execution
HOUR=$(date +%H)
if [ "$HOUR" -ge 18 ] || [ "$HOUR" -lt 5 ]; then
    echo "[+] Night time detected (18:00 - 05:00). Activating 3500K filter..."
    export DISPLAY=:0 && xsct 3500
else
    echo "[+] Day time detected (05:00 - 18:00). Resetting to 6500K default..."
    export DISPLAY=:0 && xsct 6500
fi

echo "========= Linux Automation Completed Successfully By R00tKage ========="

