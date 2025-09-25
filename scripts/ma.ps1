# MultiAgent + SCPO: Unified Command Interface
param(
  [Parameter(Position = 0)]
  [ValidateSet("init", "generate", "review", "execute", "config", "status", "help", "clean", "backup", "scpo", "prompts")]
  [string]$Command = "help",
    
  [Parameter(Position = 1)]
  [string]$Target = "",
    
  [Parameter(Position = 2)]
  [string]$Options = "",
    
  [switch]$DryRun = $false,
  [switch]$Force = $false,
  [switch]$SCPO = $false
)

# Cores e emojis para output
$Colors = @{
  Success = "Green"
  Warning = "Yellow"
  Error   = "Red"
  Info    = "Cyan"
  Debug   = "Gray"
}

function Write-MALog {
  param($Message, $Level = "Info", $Emoji = "🤖")
    
  $color = $Colors[$Level]
  $timestamp = Get-Date -Format "HH:mm:ss"
    
  if ($VerbosePreference -eq 'Continue' -or $Level -ne "Debug") {
    Write-Host "$Emoji [$timestamp] $Message" -ForegroundColor $color
  }
}

function Show-Help {
  Write-Host ""
  Write-Host "🤖 MultiAgent + SCPO - Unified Development Assistant" -ForegroundColor Cyan
  Write-Host "===================================================" -ForegroundColor Cyan
  Write-Host ""
  Write-Host "USAGE:" -ForegroundColor White
  Write-Host "  ma <command> [target] [options]" -ForegroundColor Gray
  Write-Host ""
  Write-Host "COMMANDS:" -ForegroundColor White
  Write-Host "  init       Initialize MultiAgent project" -ForegroundColor Green
  Write-Host "  generate   Generate code using SCPO patterns" -ForegroundColor Green
  Write-Host "  review     Review code with SCPO analysis" -ForegroundColor Green
  Write-Host "  execute    Execute generated code safely" -ForegroundColor Green
  Write-Host "  scpo       Access SCPO-specific commands" -ForegroundColor Yellow
  Write-Host "  prompts    Browse and use SCPO prompts" -ForegroundColor Yellow
  Write-Host "  config     Manage project configuration" -ForegroundColor Blue
  Write-Host "  status     Show project and SCPO status" -ForegroundColor Blue
  Write-Host "  backup     Backup project with versioning" -ForegroundColor Blue
  Write-Host "  clean      Clean cache and temp files" -ForegroundColor Red
  Write-Host "  help       Show this help" -ForegroundColor Gray
  Write-Host ""
  Write-Host "SCPO INTEGRATION:" -ForegroundColor Yellow
  Write-Host "  --scpo     Enable SCPO mode for commands" -ForegroundColor Gray
  Write-Host "  --verbose  Show detailed SCPO processing" -ForegroundColor Gray
  Write-Host ""
  Write-Host "EXAMPLES:" -ForegroundColor White
  Write-Host "  ma init --scpo                    # Initialize with SCPO" -ForegroundColor Gray
  Write-Host "  ma generate 'Create API' backend  # Generate with SCPO backend patterns" -ForegroundColor Gray
  Write-Host "  ma scpo list                     # List available SCPO prompts" -ForegroundColor Gray
  Write-Host "  ma prompts search optimization   # Search optimization prompts" -ForegroundColor Gray
  Write-Host "  ma review code.py --scpo         # Review with SCPO analysis" -ForegroundColor Gray
  Write-Host ""
}

function Invoke-Init {
  Write-MALog "Initializing MultiAgent + SCPO project..." "Info" "🚀"
    
  $scriptDir = $PSScriptRoot
  $initScript = Join-Path $scriptDir "init-project.ps1"
    
  if (Test-Path $initScript) {
    if ($SCPO) {
      & $initScript -EnableSCPO
    }
    else {
      & $initScript
    }
  }
  else {
    Write-MALog "Init script not found: $initScript" "Error" "❌"
    return $false
  }
    
  return $true
}

function Invoke-Generate {
  Write-MALog "Generating code with SCPO integration..." "Info" "⚡"
    
  if ([string]::IsNullOrEmpty($Target)) {
    Write-MALog "Please specify what to generate: ma generate 'task description' [domain]" "Warning" "⚠️"
    return $false
  }
    
  $scriptDir = $PSScriptRoot
  $generateScript = Join-Path $scriptDir "generate-code-scpo.ps1"
    
  if (Test-Path $generateScript) {
    $params = @{
      CodeTask = $Target
      UseSCPO  = $true
    }
        
    # Parse domain from options
    if (-not [string]::IsNullOrEmpty($Options)) {
      $validDomains = @("backend", "frontend", "testing", "optimization", "documentation", "mobile", "database")
      if ($Options -in $validDomains) {
        $params.Domain = $Options
      }
    }
        
    & $generateScript @params
  }
  else {
    Write-MALog "Generate script not found: $generateScript" "Error" "❌"
    return $false
  }
    
  return $true
}

function Invoke-Review {
  Write-MALog "Reviewing code with SCPO analysis..." "Info" "🔍"
    
  if ([string]::IsNullOrEmpty($Target)) {
    Write-MALog "Please specify file to review: ma review <filename>" "Warning" "⚠️"
    return $false
  }
    
  if (-not (Test-Path $Target)) {
    Write-MALog "File not found: $Target" "Error" "❌"
    return $false
  }
    
  $scriptDir = $PSScriptRoot
  $reviewScript = Join-Path $scriptDir "review-code.ps1"
    
  if (Test-Path $reviewScript) {
    & $reviewScript -FilePath $Target -UseSCPO:$SCPO
  }
  else {
    Write-MALog "Review script not found: $reviewScript" "Error" "❌"
    return $false
  }
    
  return $true
}

function Invoke-Execute {
  Write-MALog "Executing code safely..." "Info" "🏃"
    
  if ([string]::IsNullOrEmpty($Target)) {
    Write-MALog "Please specify file to execute: ma execute <filename>" "Warning" "⚠️"
    return $false
  }
    
  if (-not (Test-Path $Target)) {
    Write-MALog "File not found: $Target" "Error" "❌"
    return $false
  }
    
  $scriptDir = $PSScriptRoot
  $executeScript = Join-Path $scriptDir "execute-code.ps1"
    
  if (Test-Path $executeScript) {
    & $executeScript -FilePath $Target -DryRun:$DryRun
  }
  else {
    Write-MALog "Execute script not found: $executeScript" "Error" "❌"
    return $false
  }
    
  return $true
}

function Invoke-SCPO {
  Write-MALog "SCPO Command Interface..." "Info" "🧠"
    
  switch ($Target.ToLower()) {
    "list" {
      Show-SCPOPrompts
    }
    "search" {
      if ([string]::IsNullOrEmpty($Options)) {
        Write-MALog "Please specify search term: ma scpo search <term>" "Warning" "⚠️"
        return $false
      }
      Search-SCPOPrompts $Options
    }
    "docs" {
      Open-SCPODocumentation
    }
    "extension" {
      Install-SCPOExtension
    }
    default {
      Write-Host ""
      Write-Host "🧠 SCPO Commands:" -ForegroundColor Yellow
      Write-Host "  ma scpo list                 # List all SCPO prompts" -ForegroundColor Gray
      Write-Host "  ma scpo search <term>        # Search SCPO prompts" -ForegroundColor Gray
      Write-Host "  ma scpo docs                 # Open SCPO documentation" -ForegroundColor Gray
      Write-Host "  ma scpo extension            # Install VS Code extension" -ForegroundColor Gray
      Write-Host ""
    }
  }
    
  return $true
}

function Show-SCPOPrompts {
  Write-MALog "Available SCPO Prompts:" "Info" "📚"
    
  $promptsDir = "prompts"
  if (-not (Test-Path $promptsDir)) {
    $promptsDir = "$env:USERPROFILE\.vscode-multiagent\prompts"
  }
    
  if (Test-Path $promptsDir) {
    $prompts = Get-ChildItem $promptsDir -Filter "*.md" | Sort-Object Name
        
    Write-Host ""
    Write-Host "📂 SCPO Prompt Library:" -ForegroundColor Cyan
    Write-Host "======================" -ForegroundColor Cyan
        
    foreach ($prompt in $prompts) {
      $name = $prompt.BaseName -replace '-', ' ' | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) }
      Write-Host "  📄 $name" -ForegroundColor White
      Write-Host "     File: $($prompt.Name)" -ForegroundColor Gray
      Write-Host ""
    }
        
    Write-Host "Usage: ma prompts view <name> or ma generate 'task' <domain>" -ForegroundColor Yellow
  }
  else {
    Write-MALog "SCPO prompts directory not found. Run 'ma init --scpo' first." "Warning" "⚠️"
  }
}

function Search-SCPOPrompts {
  param($SearchTerm)
    
  Write-MALog "Searching SCPO prompts for: $SearchTerm" "Info" "🔍"
    
  $promptsDir = "prompts"
  if (-not (Test-Path $promptsDir)) {
    $promptsDir = "$env:USERPROFILE\.vscode-multiagent\prompts"
  }
    
  if (Test-Path $promptsDir) {
    $results = Get-ChildItem $promptsDir -Filter "*.md" | 
    Where-Object { $_.Name -match $SearchTerm -or (Get-Content $_.FullName -Raw) -match $SearchTerm }
        
    if ($results) {
      Write-Host ""
      Write-Host "🎯 Search Results for '$SearchTerm':" -ForegroundColor Green
      Write-Host "===================================" -ForegroundColor Green
            
      foreach ($result in $results) {
        Write-Host "  ✅ $($result.BaseName)" -ForegroundColor White
        Write-Host "     $($result.FullName)" -ForegroundColor Gray
        Write-Host ""
      }
    }
    else {
      Write-MALog "No SCPO prompts found matching: $SearchTerm" "Warning" "⚠️"
    }
  }
  else {
    Write-MALog "SCPO prompts directory not found." "Error" "❌"
  }
}

function Invoke-Prompts {
  Write-MALog "SCPO Prompts Manager..." "Info" "📚"
    
  switch ($Target.ToLower()) {
    "list" { Show-SCPOPrompts }
    "view" {
      if ([string]::IsNullOrEmpty($Options)) {
        Write-MALog "Please specify prompt name: ma prompts view <name>" "Warning" "⚠️"
        return $false
      }
      Show-PromptContent $Options
    }
    "search" {
      if ([string]::IsNullOrEmpty($Options)) {
        Write-MALog "Please specify search term: ma prompts search <term>" "Warning" "⚠️"
        return $false
      }
      Search-SCPOPrompts $Options
    }
    default {
      Show-SCPOPrompts
    }
  }
    
  return $true
}

function Show-PromptContent {
  param($PromptName)
    
  $promptsDir = "prompts"
  if (-not (Test-Path $promptsDir)) {
    $promptsDir = "$env:USERPROFILE\.vscode-multiagent\prompts"
  }
    
  $promptFile = Get-ChildItem $promptsDir -Filter "*.md" | 
  Where-Object { $_.BaseName -match $PromptName } | 
  Select-Object -First 1
    
  if ($promptFile) {
    Write-Host ""
    Write-Host "📄 SCPO Prompt: $($promptFile.BaseName)" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Cyan
    Write-Host ""
        
    $content = Get-Content $promptFile.FullName -Raw
    Write-Host $content -ForegroundColor White
        
    Write-Host ""
    Write-Host "💡 To use this prompt:" -ForegroundColor Yellow
    Write-Host "   ma generate 'your task' $($promptFile.BaseName -replace '-.*', '')" -ForegroundColor Gray
  }
  else {
    Write-MALog "Prompt not found: $PromptName" "Error" "❌"
  }
}

function Show-Status {
  Write-MALog "MultiAgent + SCPO Status:" "Info" "📊"
    
  Write-Host ""
  Write-Host "📊 MultiAgent + SCPO Status" -ForegroundColor Cyan
  Write-Host "===========================" -ForegroundColor Cyan
    
  # Project status
  if (Test-Path "multiagent.json") {
    $config = Get-Content "multiagent.json" | ConvertFrom-Json
    Write-Host "✅ MultiAgent Project: $($config.project.name)" -ForegroundColor Green
    Write-Host "   Type: $($config.project.type)" -ForegroundColor Gray
    Write-Host "   Version: $($config.version)" -ForegroundColor Gray
  }
  else {
    Write-Host "⚠️  No MultiAgent project detected" -ForegroundColor Yellow
  }
    
  # SCPO status
  $promptsDir = "prompts"
  if (Test-Path $promptsDir) {
    $promptCount = (Get-ChildItem $promptsDir -Filter "*.md").Count
    Write-Host "✅ SCPO Prompts: $promptCount available" -ForegroundColor Green
  }
  else {
    Write-Host "⚠️  SCPO prompts not installed" -ForegroundColor Yellow
  }
    
  # Extension status
  $extensionDir = "vscode-extension-scpo"
  if (Test-Path $extensionDir) {
    Write-Host "✅ SCPO VS Code Extension: Available" -ForegroundColor Green
  }
  else {
    Write-Host "⚠️  SCPO extension not installed" -ForegroundColor Yellow
  }
    
  # Cache status
  if (Test-Path ".multiagent-cache") {
    $cacheFiles = (Get-ChildItem ".multiagent-cache").Count
    Write-Host "📁 Cache: $cacheFiles files" -ForegroundColor Gray
  }
    
  Write-Host ""
}

function Invoke-Config {
  Write-MALog "Configuration manager..." "Info" "⚙️"
    
  if (-not (Test-Path "multiagent.json")) {
    Write-MALog "No MultiAgent project found. Run 'ma init' first." "Warning" "⚠️"
    return $false
  }
    
  $config = Get-Content "multiagent.json" | ConvertFrom-Json
    
  Write-Host ""
  Write-Host "⚙️  MultiAgent + SCPO Configuration" -ForegroundColor Cyan
  Write-Host "===================================" -ForegroundColor Cyan
  Write-Host ""
  Write-Host ($config | ConvertTo-Json -Depth 10) -ForegroundColor White
  Write-Host ""
}

function Invoke-Clean {
  Write-MALog "Cleaning cache and temporary files..." "Info" "🧹"
    
  $cleaned = 0
    
  # Clean cache
  if (Test-Path ".multiagent-cache") {
    $cacheFiles = Get-ChildItem ".multiagent-cache" | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) }
    if ($cacheFiles) {
      $cacheFiles | Remove-Item -Force
      $cleaned += $cacheFiles.Count
    }
  }
    
  # Clean temp files
  $tempFiles = Get-ChildItem -Filter "*.tmp" -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-1) }
  if ($tempFiles) {
    $tempFiles | Remove-Item -Force
    $cleaned += $tempFiles.Count
  }
    
  Write-MALog "Cleaned $cleaned files" "Success" "✅"
  return $true
}

function Invoke-Backup {
  Write-MALog "Creating project backup..." "Info" "💾"
    
  $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
  $backupName = "multiagent-backup-$timestamp.zip"
    
  try {
    $excludePatterns = @("*.tmp", "node_modules", ".git", ".multiagent-cache")
        
    # Create backup (simplified for PowerShell compatibility)
    Compress-Archive -Path "." -DestinationPath $backupName -Force
        
    Write-MALog "Backup created: $backupName" "Success" "✅"
    return $true
  }
  catch {
    Write-MALog "Backup failed: $($_.Exception.Message)" "Error" "❌"
    return $false
  }
}

# Main execution
Write-Host ""
Write-Host "🤖 MultiAgent + SCPO v1.0" -ForegroundColor Cyan

$success = switch ($Command.ToLower()) {
  "init" { Invoke-Init }
  "generate" { Invoke-Generate }
  "review" { Invoke-Review }
  "execute" { Invoke-Execute }
  "scpo" { Invoke-SCPO }
  "prompts" { Invoke-Prompts }
  "config" { Invoke-Config }
  "status" { Show-Status; $true }
  "clean" { Invoke-Clean }
  "backup" { Invoke-Backup }
  "help" { Show-Help; $true }
  default { 
    Write-MALog "Unknown command: $Command" "Error" "❌"
    Show-Help
    $false
  }
}

if ($success) {
  Write-MALog "Command completed successfully" "Success" "✅"
}
else {
  Write-MALog "Command failed" "Error" "❌"
  exit 1
}

Write-Host ""