@echo off
setlocal

:: --- Check for admin ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Please run this script as Administrator to remove registry tweaks.
    echo Press any key to continue...
    pause >nul
    exit /b
)

echo Removing Copy Directory Tree...

set BACK_REMOVED=1
set FOLDER_REMOVED=1

:: --- Check and delete background key ---
reg query "HKCR\Directory\Background\shell\CopyDirectoryTree" >nul 2>&1
if %errorlevel%==0 (
    reg delete "HKCR\Directory\Background\shell\CopyDirectoryTree" /f >nul
    echo [+] Background context menu entry removed.
) else (
    echo [!] Background context menu entry was not found.
    set BACK_REMOVED=0
)

:: --- Check and delete folder key ---
reg query "HKCR\Directory\shell\CopyDirectoryTree" >nul 2>&1
if %errorlevel%==0 (
    reg delete "HKCR\Directory\shell\CopyDirectoryTree" /f >nul
    echo [+] Folder context menu entry removed.
) else (
    echo [!] Folder context menu entry was not found.
    set FOLDER_REMOVED=0
)

echo.

if %BACK_REMOVED%==0 set WARN=1
if %FOLDER_REMOVED%==0 set WARN=1

if defined WARN (
    echo [!] One or more entries were not removed.
    echo     Please open Regedit and manually check:
    echo       - HKEY_CLASSES_ROOT\Directory\Background\shell\CopyDirectoryTree
    echo       - HKEY_CLASSES_ROOT\Directory\shell\CopyDirectoryTree
    echo     and delete them manually if still present.
) else (
    echo [+] Copy Directory Tree has been removed.
)

pause
