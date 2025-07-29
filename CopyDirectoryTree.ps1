param([string]$TargetPath)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# ================================
# MODIFY TREE STYLE HERE
# ================================
#   - "ascii"   -> uses simple | and -- (use if formatting issues)
#   - "pipe"    -> uses pipe characters for corners and tees (looks like mario)
#   - "normal"  -> uses special line characters for corners and tees (looks like a tree)
# ================================
# Note: You can add more styles or modify the characters below, but beware of encoding issues.
# ================================
$style = "ascii"

switch ($style) {
    "ascii" {
        $char_corner = "\--"
        $char_tee    = "|--"
        $char_pipe   = "|"
        $char_dash   = "-"
    }
    "pipe" {
        $char_corner = [char]0x255A   # ╚
        $char_tee    = [char]0x2560   # ╠
        $char_pipe   = [char]0x2551   # ║
        $char_dash   = [char]0x2550   # ═
    }
    default {
        $char_corner = [char]0x2570   # ╰
        $char_tee    = [char]0x2523   # ┣
        $char_pipe   = [char]0x2503   # ┃
        $char_dash   = [char]0x2501   # ━
    }
}

function Get-Tree {
    param(
        [string]$Path,
        [string]$Prefix = ""
    )

    $items = Get-ChildItem -LiteralPath $Path | Sort-Object -Property { !$_.PsIsContainer }, Name
    $count = $items.Count

    if ($count -eq 0) {
        $global:treeLines += "$Prefix$char_corner$char_dash$char_dash (empty)"
        return
    }

    for ($i = 0; $i -lt $count; $i++) {
        $item = $items[$i]
        $isLast = ($i -eq ($count - 1))

        $branch = if ($isLast) { "$char_corner$char_dash$char_dash " } else { "$char_tee$char_dash$char_dash " }
        $isFolder = $item.PSIsContainer
        $name = if ($isFolder) { "$item/" } else { "$item" }

        $global:treeLines += "$Prefix$branch$name"

        if ($isFolder) {
            $newPrefix = if ($isLast) { "$Prefix    " } else { "$Prefix$char_pipe   " }
            Get-Tree -Path $item.FullName -Prefix $newPrefix
        }
    }
}

try {
    if ([string]::IsNullOrWhiteSpace($TargetPath)) {
        $folderPath = (Get-Location).Path
    } else {
        $folderPath = $TargetPath
    }

    if (-not (Test-Path -LiteralPath $folderPath)) {
        throw "Target path '$folderPath' does not exist."
    }

    $global:treeLines = @()
    $absPath = (Get-Item -LiteralPath $folderPath).FullName
    $global:treeLines += "Directory structure:"
    $global:treeLines += "$char_corner$char_dash$char_dash " + (Split-Path $absPath -Leaf) + "/"
    Get-Tree -Path $absPath -Prefix "    "

    $result = $treeLines -join "`r`n"

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Clipboard]::SetText($result)

} catch {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show(
        "Copy Directory Tree failed!`nError: $($_.Exception.Message)",
        "Copy Directory Tree",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
}
