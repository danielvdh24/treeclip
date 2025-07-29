Set objShell = CreateObject("Wscript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
scriptPath = fso.GetParentFolderName(WScript.ScriptFullName)

Set args = WScript.Arguments
targetPath = ""
If args.Count > 0 Then targetPath = " """ & args(0) & """"

command = "powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & scriptPath & "\CopyDirectoryTree.ps1""" & targetPath
objShell.Run command, 0, False