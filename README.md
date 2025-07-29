Copy your folder structure instantly  
<div align="center">
    <img src="placeholder" height="370px">
</div>
A small Windows utility to quickly copy the current folder’s tree structure to your clipboard in a clean and customizable format.

### Installation
- Clone the repository or download the ZIP and extract it into a persistent folder (for example, `Documents\Tree Directory Copy`).  
Do not delete or move this folder if you wish to keep the context menu working or uninstall later.  
- Right-click `AddContextMenu.bat` and select **Run as Administrator**.  

### Usage
- Right-click inside any folder and choose **Copy Directory Tree**.  
- Right-click on any folder and choose **Copy Directory Tree**.  
The directory structure will be copied to your clipboard.

### Personalizing

<ins>Modify the command name in the context menu</ins>
The default context menu text is **"Copy Directory Tree"**.  
To change it, edit the value in `AddContextMenu.bat`:  
```powershell
set DISPLAYNAME=Copy Directory Tree
```

Replace with any name you prefer and re-run the script as administrator.

<ins>Change tree styles</ins>
You can change how the tree looks by modifying the `$style` variable at the top of `CopyDirectoryTree.ps1`.  
Available styles:

**Ascii**
```plaintext
Directory structure:
\---- Tree Directory Copy/
    |---- AddContextMenu.bat
    |---- CopyDirectoryTree.ps1
    |---- README.md
    |---- RemoveContextMenu.bat
    \---- RunCopyTree.vbs
```

**Pipe**
```plaintext
Directory structure:
╚══ Tree Directory Copy/
║ ╠══ AddContextMenu.bat
║ ╠══ CopyDirectoryTree.ps1
║ ╠══ RemoveContextMenu.bat
║ ╚══ RunCopyTree.vbs
```

**Normal**  
```plaintext
Directory structure:
╰━━ Tree Directory Copy/
┃ ┣━━ AddContextMenu.bat
┃ ┣━━ CopyDirectoryTree.ps1
┃ ┣━━ RemoveContextMenu.bat
┃ ╰━━ RunCopyTree.vbs
```

For reference, the style configuration is located at the top of the script:

### Compatibility
The registry structure and scripts used are only compatible with Windows 10 and 11.