<div align="left">
    <img src="https://github.com/user-attachments/assets/b6e9ee07-cad0-4c18-9277-25839b8c6af4" height="370px">
</div>

A small Windows utility to quickly copy the current folder’s tree structure to your clipboard in a clean and customizable format.

### Installation
- Clone the repository or download the ZIP and extract it into a persistent folder (for example, `Documents`).  
Do not delete or move this folder if you wish to keep the context menu working or uninstall later.  
- Right-click `AddContextMenu.bat` and select **Run as Administrator**.  

### Usage
- Right-click inside any folder and choose **Copy Directory Tree**.  
- Right-click on any folder and choose **Copy Directory Tree**.  

You may have to select 'Show more options' to see the option.  
The directory structure will be copied to your clipboard.

### Demo
<img src="https://github.com/user-attachments/assets/053f39b5-e2b8-4f63-a9a9-cb02bd7624ff" alt="demo" width="625">

### Personalizing

<ins>Modify context menu icon</ins><br>
By default, the context menu uses the standard Windows folder icon and falls back to the PowerShell icon if it is not found.  
If you want to use your own icon, place a `.ico` file in the project directory and change the path accordingly.

To change it, edit the value in `AddContextMenu.bat`: 
```powershell
set ICON_PATH=C:\Windows\System32\shell32.dll,3
```
Replace it with the path to your icon, for example:
```powershell
set ICON_PATH=%SCRIPT_DIR%\myicon.ico
```

<ins>Modify the command name in the context menu</ins><br>
The default context menu text is **"Copy Directory Tree"**.  
To change it, edit the value in `AddContextMenu.bat`:  
```powershell
set DISPLAYNAME=Copy Directory Tree
```

Replace with any name you prefer and run the `AddContextMenu.bat` script as administrator.

<ins>Change tree styles</ins><br>
You can change how the tree looks by modifying the `$style` variable at the top of `CopyDirectoryTree.ps1`.  
Available styles:

Ascii
```plaintext
Directory structure:
\---- MinecraftBuilds/
    |---- house.png
    |---- lake_with_fish.png
    \---- ben_floating_island.png
```

Pipe
```plaintext
Directory structure:
╚══ WorkFolder/
║ ╠══ secret_keys.txt
║ ╠══ contract.docx
║ ╚══ joseph_work_friend.png
```

Normal
```plaintext
Directory structure:
╰━━ CodingSessions/
┃ ┣━━ main.py
┃ ┣━━ ai_invest.py
┃ ╰━━ nuke_invest.py
```

### Compatibility
The registry structure and scripts used are only compatible with Windows 10 and 11.
