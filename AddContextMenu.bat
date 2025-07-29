@echo off
setlocal

:: --- Optionally define a command name ---
set DISPLAYNAME=Copy Directory Tree

set SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%

:: --- Check for admin ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Please run this script as Administrator to add registry tweaks.
    echo Press any key to continue...
    pause >nul
    exit /b
)

:: --- Set icon path to folder or powershell ---
if exist "C:\Windows\System32\shell32.dll" (
    set ICON_PATH=C:\Windows\System32\shell32.dll,3
) else (
    set ICON_PATH=powershell.exe
)

echo Adding Copy Directory Tree...

:: --- Add background right-click key ---
reg add "HKCR\Directory\Background\shell\CopyDirectoryTree" /ve /d "%DISPLAYNAME%" /f >nul
reg add "HKCR\Directory\Background\shell\CopyDirectoryTree" /v Icon /d "%ICON_PATH%" /f >nul
reg add "HKCR\Directory\Background\shell\CopyDirectoryTree\command" /ve /d "wscript.exe \"%SCRIPT_DIR%\RunCopyTree.vbs\"" /f >nul

:: --- Add folder right-click key ---
reg add "HKCR\Directory\shell\CopyDirectoryTree" /ve /d "%DISPLAYNAME%" /f >nul
reg add "HKCR\Directory\shell\CopyDirectoryTree" /v Icon /d "%ICON_PATH%" /f >nul
reg add "HKCR\Directory\shell\CopyDirectoryTree\command" /ve /d "wscript.exe \"%SCRIPT_DIR%\RunCopyTree.vbs\" \"%%1\"" /f >nul

:: --- Verify keys added ---
set BACK_OK=1
set FOLDER_OK=1

reg query "HKCR\Directory\Background\shell\CopyDirectoryTree" >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Failed to add the background context menu entry.
    set BACK_OK=0
) else (
    echo [+] Background context menu entry added successfully.
)

reg query "HKCR\Directory\shell\CopyDirectoryTree" >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Failed to add the folder context menu entry.
    set FOLDER_OK=0
) else (
    echo [+] Folder context menu entry added successfully.
)

echo.

if %BACK_OK%==0 set WARN=1
if %FOLDER_OK%==0 set WARN=1

if defined WARN (
    echo [!] One or more registry keys failed to add. Some functionality may not work.
    echo     It is recommended to run RemoveContextMenu.bat and try again.
) else (
    echo [+] Done! Right-click ^> Show more options ^> %DISPLAYNAME% to use.
)

pause
