@echo off
:: BatchGotAdmin (Run as Admin code starts)
REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"
:: BatchGotAdmin (Run as Admin code ends)
:: Your codes should start from the following line
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Azure VM" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
net user VssAdministrator 01217682717Huy >nul
net user VssAdministrator /active:yes >nul
net user installer /delete
curl -o "C:\Windows\System32\Drivers\etc\hosts" https://raw.githubusercontent.com/ztvofficial/Windows2019RDP-US/main/Files/hosts > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\a.ps1" https://raw.githubusercontent.com/ngoc7sao9/Azure_RDP_Hack/main/a.ps1 > out.txt 2>&1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "C:\Users\Public\Desktop\a.ps1" > out.txt 2>&1
diskperf -Y >nul
sc config Audiosrv start= auto >nul
sc start audiosrv >nul
ICACLS C:\Windows\Temp /grant administrator:F >nul
ICACLS C:\Windows\installer /grant administrator:F >nul
echo All done! It run @HadesVN
echo User: VssAdministrator
echo Pass: 01217682717Huy
ping -n 99999999999999999999 127.0.0.1 >nul
