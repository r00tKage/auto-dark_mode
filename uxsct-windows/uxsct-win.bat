@echo off
:: ==============================================================================
# Script Name    : uxsct-win.bat
# Description    : Clean Automated Screen Matrix (Safe from Defender)
# Author         : Mosab MohammedAli Adam Ahmed "R00tkage"
# ==============================================================================

for /f "tokens=1 delims=:" %%a in ("%time%") do set /a HOUR=%%a

if %HOUR% geq 18 (goto :NIGHT)
if %HOUR% lss 5 (goto :NIGHT)
goto :DAY

:NIGHT
powershell -Command "(Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(0, 35)"
exit

:DAY
powershell -Command "(Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(0, 90)"
exit

