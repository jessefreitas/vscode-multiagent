# Script de Inicialização de Projeto MultiAgent
param(
  [Parameter(Mandatory = $false)]
  [string]$ProjectPath = (Get-Location).Path,
    
  [Parameter(Mandatory = $false)]
  [ValidateSet("python", "javascript", "csharp", "generic")]
  [string]$ProjectType = "generic",
    
  [Parameter(Mandatory = $false)]
  [switch]$Interactive
)

Write-Host "🤖 Inicializando Projeto MultiAgent..." -ForegroundColor Cyan
Write-Host "📁 Caminho: $ProjectPath" -ForegroundColor Gray
Write-Host "🏷️  Tipo: $ProjectType" -ForegroundColor Gray

# Verificar se é um diretório válido
if (-not (Test-Path $ProjectPath -PathType Container)) {
  Write-Host "❌ Caminho inválido: $ProjectPath" -ForegroundColor Red
  exit 1
}

Set-Location $ProjectPath

# Verificar se já foi inicializado
if (Test-Path ".vscode\settings.json") {
  $settings = Get-Content ".vscode\settings.json" | ConvertFrom-Json -ErrorAction SilentlyContinue
  if ($settings."multiagent.project.initialized" -eq $true) {
    Write-Host "⚠️  Projeto já inicializado com MultiAgent" -ForegroundColor Yellow
    $response = Read-Host "Deseja reconfigurar? (y/N)"
    if ($response -ne "y" -and $response -ne "Y") {
      Write-Host "❌ Operação cancelada." -ForegroundColor Red
      exit 0
    }
  }
}

# Modo interativo
if ($Interactive) {
  Write-Host ""
  Write-Host "🔧 Configuração Interativa" -ForegroundColor Cyan
    
  # Detectar tipo de projeto automaticamente
  $detectedType = "generic"
  if (Test-Path "*.py" -PathType Leaf) { $detectedType = "python" }
  elseif (Test-Path "package.json") { $detectedType = "javascript" }
  elseif (Test-Path "*.csproj" -PathType Leaf) { $detectedType = "csharp" }
    
  Write-Host "Tipo detectado: $detectedType" -ForegroundColor Gray
  $ProjectType = Read-Host "Confirmar tipo de projeto [$detectedType]"
  if ([string]::IsNullOrEmpty($ProjectType)) {
    $ProjectType = $detectedType
  }
}

# Obter caminho da instalação
$installPath = "$env:USERPROFILE\.vscode-multiagent"
if (-not (Test-Path $installPath)) {
  Write-Host "❌ Sistema MultiAgent não instalado. Execute install.ps1 primeiro." -ForegroundColor Red
  exit 1
}

# Criar estrutura .vscode
$vscodeDir = ".vscode"
if (-not (Test-Path $vscodeDir)) {
  New-Item -ItemType Directory -Path $vscodeDir | Out-Null
}

# Copiar configurações base
$templatePath = "$installPath\templates\project-settings"

# Settings.json
$settingsTemplate = Get-Content "$templatePath\settings.json" -ErrorAction SilentlyContinue
if ($settingsTemplate) {
  $settings = $settingsTemplate | ConvertFrom-Json
}
else {
  $settings = @{}
}

# Configurações específicas do tipo de projeto
switch ($ProjectType) {
  "python" {
    $settings | Add-Member -Name "python.defaultInterpreterPath" -Value "./venv/Scripts/python.exe" -Force
    $settings | Add-Member -Name "python.analysis.extraPaths" -Value @("./src") -Force
    $settings | Add-Member -Name "multiagent.project.language" -Value "python" -Force
  }
  "javascript" {
    $settings | Add-Member -Name "typescript.preferences.includePackageJsonAutoImports" -Value "on" -Force
    $settings | Add-Member -Name "multiagent.project.language" -Value "javascript" -Force
  }
  "csharp" {
    $settings | Add-Member -Name "dotnet.server.useOmnisharp" -Value $true -Force
    $settings | Add-Member -Name "multiagent.project.language" -Value "csharp" -Force
  }
}

# Configurações gerais do MultiAgent
$settings | Add-Member -Name "multiagent.project.initialized" -Value $true -Force
$settings | Add-Member -Name "multiagent.project.type" -Value $ProjectType -Force
$settings | Add-Member -Name "multiagent.project.createdAt" -Value (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ") -Force

$settings | ConvertTo-Json -Depth 10 | Set-Content "$vscodeDir\settings.json"
Write-Host "⚙️  Configurações aplicadas" -ForegroundColor Green

# Tasks.json
$tasksTemplate = @{
  version = "2.0.0"
  tasks   = @(
    @{
      label        = "MultiAgent: Generate Code"
      type         = "shell"
      command      = "pwsh"
      args         = @("-File", "$installPath\scripts\generate-code.ps1", "`${input:codeTask}")
      group        = "build"
      presentation = @{
        echo   = $true
        reveal = "always"
        focus  = $false
        panel  = "shared"
      }
    },
    @{
      label   = "MultiAgent: Review Code"
      type    = "shell"
      command = "pwsh"
      args    = @("-File", "$installPath\scripts\review-code.ps1", "`${file}")
      group   = "test"
    },
    @{
      label   = "MultiAgent: Execute Safely"
      type    = "shell"
      command = "pwsh"
      args    = @("-File", "$installPath\scripts\execute-code.ps1", "`${file}")
      group   = "build"
    }
  )
  inputs  = @(
    @{
      id          = "codeTask"
      description = "Descreva o código que deseja gerar"
      type        = "promptString"
    }
  )
}

$tasksTemplate | ConvertTo-Json -Depth 10 | Set-Content "$vscodeDir\tasks.json"
Write-Host "📋 Tasks configuradas" -ForegroundColor Green

# Launch.json (apenas para debug)
$launchTemplate = @{
  version        = "0.2.0"
  configurations = @()
}

switch ($ProjectType) {
  "python" {
    $launchTemplate.configurations += @{
      name    = "Python: Current File"
      type    = "debugpy"
      request = "launch"
      program = "`${file}"
      console = "integratedTerminal"
    }
  }
  "csharp" {
    $launchTemplate.configurations += @{
      name        = ".NET Core Launch"
      type        = "coreclr"
      request     = "launch"
      program     = "`${workspaceFolder}/bin/Debug/net6.0/`${workspaceFolderBasename}.dll"
      args        = @()
      cwd         = "`${workspaceFolder}"
      console     = "internalConsole"
      stopAtEntry = $false
    }
  }
}

if ($launchTemplate.configurations.Count -gt 0) {
  $launchTemplate | ConvertTo-Json -Depth 10 | Set-Content "$vscodeDir\launch.json"
  Write-Host "🐛 Debug configurado" -ForegroundColor Green
}

# Criar arquivo de configuração do MultiAgent
$multiagentConfig = @{
  version = "1.0"
  project = @{
    name        = (Split-Path $ProjectPath -Leaf)
    type        = $ProjectType
    initialized = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
  }
  agents  = @{
    enabled   = @("coder", "reviewer", "executor")
    workflows = @("code-generation", "bug-fixing", "code-review")
  }
  safety  = @{
    sandboxEnabled    = $true
    maxExecutionTime  = 30000
    allowedOperations = @("read", "write", "execute")
  }
}

$multiagentConfig | ConvertTo-Json -Depth 10 | Set-Content "multiagent.json"
Write-Host "🤖 Configuração MultiAgent criada" -ForegroundColor Green

# Criar arquivo .gitignore com entradas do MultiAgent
$gitignoreContent = @"
# MultiAgent System
.multiagent-cache/
multiagent-logs/
*.multiagent-temp
"@

if (Test-Path ".gitignore") {
  Add-Content ".gitignore" "`n$gitignoreContent"
}
else {
  $gitignoreContent | Set-Content ".gitignore"
}

Write-Host "📝 .gitignore atualizado" -ForegroundColor Green

# Criar script de exemplo
$exampleScript = @"
# Exemplo de uso do Sistema MultiAgent
# Execute este script para testar a configuração

Write-Host "🤖 Testando Sistema MultiAgent..." -ForegroundColor Cyan

# Verificar se está configurado
if (-not (Test-Path "multiagent.json")) {
    Write-Host "❌ Sistema não configurado neste projeto" -ForegroundColor Red
    exit 1
}

# Carregar configuração
`$config = Get-Content "multiagent.json" | ConvertFrom-Json
Write-Host "✅ Projeto: `$(`$config.project.name)" -ForegroundColor Green
Write-Host "✅ Tipo: `$(`$config.project.type)" -ForegroundColor Green
Write-Host "✅ Agentes habilitados: `$(`$config.agents.enabled -join ', ')" -ForegroundColor Green

Write-Host ""
Write-Host "Para usar o sistema:" -ForegroundColor Cyan
Write-Host "1. Pressione Ctrl+Shift+P" -ForegroundColor White
Write-Host "2. Digite 'Tasks: Run Task'" -ForegroundColor White  
Write-Host "3. Selecione uma tarefa MultiAgent" -ForegroundColor White
"@

$exampleScript | Set-Content "test-multiagent.ps1"
Write-Host "🧪 Script de teste criado" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Projeto inicializado com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos passos:" -ForegroundColor Cyan
Write-Host "1. Reinicie o VS Code para carregar as configurações" -ForegroundColor White
Write-Host "2. Pressione Ctrl+Shift+P e digite 'MultiAgent'" -ForegroundColor White
Write-Host "3. Execute './test-multiagent.ps1' para testar" -ForegroundColor White
Write-Host ""
Write-Host "Tarefas disponíveis:" -ForegroundColor Cyan
Write-Host "• MultiAgent: Generate Code - Gerar código com IA" -ForegroundColor White
Write-Host "• MultiAgent: Review Code - Revisar código atual" -ForegroundColor White
Write-Host "• MultiAgent: Execute Safely - Executar código em sandbox" -ForegroundColor White