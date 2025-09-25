# PowerShell Script de Instalação Global
param(
    [Parameter(Mandatory=$false)]
    [string]$InstallPath = "$env:USERPROFILE\.vscode-multiagent",
    
    [Parameter(Mandatory=$false)]
    [switch]$Force
)

Write-Host "🤖 Instalando Sistema Multiagente para VS Code..." -ForegroundColor Cyan

# Verificar se VS Code está instalado
$vscodeExecutables = @("code", "code-insiders")
$vscodeFound = $false

foreach ($exe in $vscodeExecutables) {
    try {
        & $exe --version | Out-Null
        $vscodeFound = $true
        Write-Host "✅ VS Code encontrado: $exe" -ForegroundColor Green
        break
    } catch {
        continue
    }
}

if (-not $vscodeFound) {
    Write-Host "❌ VS Code não encontrado. Instale o VS Code primeiro." -ForegroundColor Red
    exit 1
}

# Criar diretório de instalação
if (Test-Path $InstallPath) {
    if ($Force) {
        Remove-Item $InstallPath -Recurse -Force
    } else {
        Write-Host "⚠️  Diretório já existe: $InstallPath" -ForegroundColor Yellow
        $response = Read-Host "Deseja sobrescrever? (y/N)"
        if ($response -ne "y" -and $response -ne "Y") {
            Write-Host "❌ Instalação cancelada." -ForegroundColor Red
            exit 1
        }
        Remove-Item $InstallPath -Recurse -Force
    }
}

New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
Write-Host "📁 Criado diretório: $InstallPath" -ForegroundColor Green

# Copiar arquivos de configuração
$sourceDir = $PSScriptRoot
Copy-Item -Path "$sourceDir\*" -Destination $InstallPath -Recurse -Force
Write-Host "📋 Arquivos copiados para $InstallPath" -ForegroundColor Green

# Instalar extensões recomendadas
Write-Host "🔧 Instalando extensões do VS Code..." -ForegroundColor Cyan

$extensions = @(
    "ms-python.python",
    "ms-python.debugpy", 
    "GitHub.copilot",
    "GitHub.copilot-chat",
    "ms-vscode.vscode-json",
    "ms-vscode.powershell",
    "ms-dotnettools.csharp",
    "ms-dotnettools.vscode-dotnet-runtime",
    "ms-vscode.extension-test-runner",
    "humao.rest-client",
    "streetsidesoftware.code-spell-checker"
)

foreach ($ext in $extensions) {
    try {
        Write-Host "  Installing $ext..." -ForegroundColor Gray
        & code --install-extension $ext --force | Out-Null
        Write-Host "  ✅ $ext instalada" -ForegroundColor Green
    } catch {
        Write-Host "  ⚠️  Erro ao instalar $ext" -ForegroundColor Yellow
    }
}

# Configurar settings.json global
$vscodeSettingsPath = "$env:APPDATA\Code\User\settings.json"
$backupPath = "$env:APPDATA\Code\User\settings.json.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"

if (Test-Path $vscodeSettingsPath) {
    Copy-Item $vscodeSettingsPath $backupPath
    Write-Host "🔄 Backup criado: $backupPath" -ForegroundColor Yellow
}

# Aplicar configurações globais
$globalSettings = Get-Content "$InstallPath\settings\global-settings.json" | ConvertFrom-Json
$currentSettings = @{}

if (Test-Path $vscodeSettingsPath) {
    $currentSettings = Get-Content $vscodeSettingsPath | ConvertFrom-Json
}

# Merge settings
foreach ($key in $globalSettings.PSObject.Properties.Name) {
    $currentSettings | Add-Member -Name $key -Value $globalSettings.$key -Force
}

$currentSettings | ConvertTo-Json -Depth 10 | Set-Content $vscodeSettingsPath
Write-Host "⚙️  Configurações globais aplicadas" -ForegroundColor Green

# Criar comando global 'ma' para acesso rápido
Write-Host "🌐 Configurando comando global 'ma'..." -ForegroundColor Cyan

# Criar script wrapper
$maWrapper = @"
# MultiAgent Quick Access Wrapper
& "$InstallPath\ma.ps1" @args
"@

$maWrapper | Set-Content "$InstallPath\ma-global.ps1"

# Criar comando tradicional também
$commandScript = @"
# MultiAgent VS Code Command  
param([string]`$Command = "help")

switch (`$Command) {
    "init" { & "`$InstallPath\scripts\init-project.ps1" }
    "generate" { 
        `$task = Read-Host "Descreva o código a gerar"
        & "`$InstallPath\scripts\generate-code.ps1" -CodeTask `$task
    }
    "review" { 
        `$file = Read-Host "Arquivo para revisar"
        & "`$InstallPath\scripts\review-code.ps1" -FilePath `$file
    }
    "execute" { 
        `$file = Read-Host "Arquivo para executar"
        & "`$InstallPath\scripts\execute-code.ps1" -FilePath `$file -DryRun
    }
    "update" { & "`$InstallPath\install.ps1" -Force }
    default { 
        Write-Host "🤖 MultiAgent System - Comandos disponíveis:"
        Write-Host ""
        Write-Host "Comando rápido (recomendado):"
        Write-Host "  ma init              - Inicializar projeto" 
        Write-Host "  ma generate 'task'   - Gerar código"
        Write-Host "  ma review arquivo.py - Revisar código"
        Write-Host "  ma execute arquivo.py- Executar código"
        Write-Host "  ma template datascience - Criar template"
        Write-Host ""
        Write-Host "Comandos tradicionais:"
        Write-Host "  multiagent init      - Inicializar projeto"
        Write-Host "  multiagent generate  - Gerar código" 
        Write-Host "  multiagent review    - Revisar código"
        Write-Host "  multiagent execute   - Executar código"
        Write-Host "  multiagent update    - Atualizar sistema"
    }
}
"@

$commandPath = "$InstallPath\multiagent.ps1"
$commandScript | Set-Content $commandPath

# Adicionar função 'ma' ao perfil do PowerShell
try {
    $profilePath = $PROFILE.CurrentUserAllHosts
    $profileDir = Split-Path $profilePath
    
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    
    $maCommand = @"

# MultiAgent System - Quick Command
function ma { 
    & "`$InstallPath\ma.ps1" @args 
}
"@
    
    if (Test-Path $profilePath) {
        $existingContent = Get-Content $profilePath -ErrorAction SilentlyContinue
        if ($existingContent -notmatch "MultiAgent System") {
            Add-Content $profilePath $maCommand
            Write-Host "✅ Comando 'ma' adicionado ao perfil" -ForegroundColor Green
        } else {
            Write-Host "✅ Comando 'ma' já existe no perfil" -ForegroundColor Green
        }
    } else {
        $maCommand | Set-Content $profilePath
        Write-Host "✅ Perfil criado com comando 'ma'" -ForegroundColor Green
    }
    
    Write-Host "💡 Reinicie o PowerShell para usar 'ma' globalmente" -ForegroundColor Cyan
} catch {
    Write-Host "⚠️  Para usar comando 'ma', execute: . '$InstallPath\ma.ps1'" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 Instalação concluída com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "Para começar:" -ForegroundColor Cyan
Write-Host "  1. Abra um projeto no VS Code" -ForegroundColor White
Write-Host "  2. Pressione Ctrl+Shift+P" -ForegroundColor White
Write-Host "  3. Digite 'MultiAgent: Initialize Project'" -ForegroundColor White
Write-Host ""
Write-Host "Ou use via PowerShell:" -ForegroundColor Cyan
Write-Host "  & '$commandPath' init" -ForegroundColor White