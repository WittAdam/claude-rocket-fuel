# Installs the /rocket-fuel skill into ~/.claude for all projects (Windows).
# Also checks whether Claude Code (which runs commands through git-bash) can find Codex,
# and offers to install the small shim that fixes it.
$ErrorActionPreference = 'Stop'

$here = $PSScriptRoot
$claudeHome = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME '.claude' }
$dest = Join-Path $claudeHome 'skills\rocket-fuel'
$src = Join-Path $here 'skills\rocket-fuel'

# 1. Codex present?
if (-not (Get-Command codex -ErrorAction SilentlyContinue)) {
    Write-Host "Warning: 'codex' isn't installed yet. If you have the Codex desktop app, open it once;"
    Write-Host "otherwise: npm i -g @openai/codex@latest ; codex login"
} else {
    Write-Host "Found Codex: $(codex --version)"
    Write-Host "(If it came from the Codex desktop app, do NOT also install it with npm.)"
}

# 2. Install the skill, backing up a different existing copy.
if (Test-Path $dest) {
    $same = $true
    foreach ($f in Get-ChildItem $src -Filter *.md) {
        $other = Join-Path $dest $f.Name
        if (-not (Test-Path $other) -or (Get-FileHash $f.FullName).Hash -ne (Get-FileHash $other).Hash) { $same = $false }
    }
    if (-not $same) {
        # Back up OUTSIDE skills\, or Claude Code would load the backup as a second skill.
        $backupDir = Join-Path $claudeHome 'skill-backups'
        New-Item -ItemType Directory -Force $backupDir | Out-Null
        $backup = Join-Path $backupDir "rocket-fuel.bak-$(Get-Date -Format yyyyMMdd-HHmmss)"
        Move-Item $dest $backup
        Write-Host "You already had a different rocket-fuel skill. Moved it to $backup"
    }
}
New-Item -ItemType Directory -Force $dest | Out-Null
Copy-Item (Join-Path $src '*.md') $dest -Force
Write-Host "Installed /rocket-fuel -> $dest"

# 3. Can git-bash see codex? (This is what Claude Code actually uses.)
$bash = @(
    (Join-Path $env:ProgramFiles 'Git\bin\bash.exe'),
    (Join-Path $env:LOCALAPPDATA 'Programs\Git\bin\bash.exe')
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $bash) {
    Write-Host "Couldn't find Git Bash, so skipped the git-bash check. See docs/field-notes.md, Trap 1."
} else {
    & $bash -lc 'command -v codex >/dev/null 2>&1 && codex --version >/dev/null 2>&1'
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Git Bash can run codex. Good."
    } else {
        Write-Host ""
        Write-Host "Git Bash can't run 'codex' (normal on Windows, see docs/field-notes.md, Trap 1)."
        $answer = Read-Host "Install the fix (copies windows\codex to $HOME\bin)? [Y/n]"
        if ($answer -eq '' -or $answer -match '^[Yy]') {
            $bin = Join-Path $HOME 'bin'
            New-Item -ItemType Directory -Force $bin | Out-Null
            Copy-Item (Join-Path $here 'windows\codex') (Join-Path $bin 'codex') -Force
            & $bash -lc 'codex --version'
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Fixed: Git Bash can now run codex."
            } else {
                Write-Host "Copied the shim to $bin, but Git Bash still can't run it."
                Write-Host "Check that ~/bin is on Git Bash's PATH (it is by default), then restart Claude Code."
            }
        }
    }
}

Write-Host "Done. Restart Claude Code, then type /rocket-fuel."
