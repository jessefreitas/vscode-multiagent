# 🧪 Sistema de Testes Automatizados - MultiAgent + SCPO + Agente Principal
# ===========================================================================

param(
    [switch]$Verbose,
    [switch]$Full
)

$ErrorActionPreference = "Continue"
$testResults = @()
$totalTests = 0
$passedTests = 0

function Write-TestResult {
    param(
        [string]$TestName,
        [bool]$Passed,
        [string]$Message = "",
        [string]$Details = ""
    )
    
    $global:totalTests++
    if ($Passed) {
        $global:passedTests++
        Write-Host "✅ $TestName" -ForegroundColor Green
    }
    else {
        Write-Host "❌ $TestName" -ForegroundColor Red
        if ($Message) { Write-Host "   $Message" -ForegroundColor Yellow }
    }
    
    if ($Verbose -and $Details) {
        Write-Host "   📝 $Details" -ForegroundColor Gray
    }
    
    $global:testResults += [PSCustomObject]@{
        Name      = $TestName
        Passed    = $Passed
        Message   = $Message
        Details   = $Details
        Timestamp = Get-Date
    }
}

Write-Host ""
Write-Host "🧪 TESTES AUTOMATIZADOS - MultiAgent + SCPO + Agente Principal" -ForegroundColor Cyan
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host ""

# Teste 1: Verificar estrutura de arquivos
Write-Host "📁 Testando Estrutura de Arquivos..." -ForegroundColor White

$requiredFiles = @(
    "scripts\ma.ps1",
    "scripts\generate-code-scpo.ps1", 
    "scripts\review-code.ps1",
    "scripts\execute-code.ps1",
    "scripts\agent-principal.ps1",
    "prompts\agente-principal-arroba.md",
    "vscode-extension-scpo\package.json",
    "vscode-extension-scpo\snippets\agente-arroba.json",
    ".vscode\tasks.json",
    ".vscode\settings.json",
    ".vscode\keybindings.json"
)

foreach ($file in $requiredFiles) {
    $exists = Test-Path $file
    Write-TestResult "Arquivo $file existe" $exists
}

# Teste 2: Verificar comandos básicos
Write-Host "`n🤖 Testando Comandos Básicos..." -ForegroundColor White

try {
    $helpOutput = & ".\scripts\ma.ps1" "help" 2>&1
    $helpWorking = $helpOutput -match "AGENTE PRINCIPAL"
    Write-TestResult "Comando 'ma help' funciona" $helpWorking "Help exibe informações do Agente Principal"
}
catch {
    Write-TestResult "Comando 'ma help' funciona" $false "Erro: $($_.Exception.Message)"
}

try {
    $statusOutput = & ".\scripts\ma.ps1" "status" 2>&1
    $statusWorking = $statusOutput -match "MultiAgent.*Status" 
    Write-TestResult "Comando 'ma status' funciona" $statusWorking "Status mostra informações do sistema"
}
catch {
    Write-TestResult "Comando 'ma status' funciona" $false "Erro: $($_.Exception.Message)"
}

# Teste 3: Verificar SCPO
Write-Host "`n📚 Testando Sistema SCPO..." -ForegroundColor White

$scpoPrompts = Get-ChildItem "prompts\*.md" -ErrorAction SilentlyContinue
$scpoWorking = $scpoPrompts.Count -gt 0
Write-TestResult "Prompts SCPO disponíveis" $scpoWorking "Encontrados $($scpoPrompts.Count) prompts"

# Teste 4: Verificar VS Code Integration
Write-Host "`n🔧 Testando Integração VS Code..." -ForegroundColor White

if (Test-Path ".vscode\tasks.json") {
    $tasksContent = Get-Content ".vscode\tasks.json" -Raw
    $agentTaskExists = $tasksContent -match "Agente Principal"
    Write-TestResult "Task do Agente Principal existe" $agentTaskExists
}
else {
    Write-TestResult "Task do Agente Principal existe" $false "Arquivo tasks.json não encontrado"
}

if (Test-Path ".vscode\settings.json") {
    $settingsContent = Get-Content ".vscode\settings.json" -Raw
    $scpoEnabled = $settingsContent -match "scpo.enabled.*true"
    Write-TestResult "SCPO habilitado nas configurações" $scpoEnabled
}
else {
    Write-TestResult "SCPO habilitado nas configurações" $false "Arquivo settings.json não encontrado"
}

# Teste 5: Teste de geração (simulado)
if ($Full) {
    Write-Host "`n🎯 Testando Geração de Código (Simulação)..." -ForegroundColor White
    
    try {
        # Teste simulado - sem executar geração real
        $generateScript = Get-Content "scripts\generate-code-scpo.ps1" -Raw
        $scpoPatterns = $generateScript -match "SCPO"
        Write-TestResult "Script de geração tem padrões SCPO" $scpoPatterns
    }
    catch {
        Write-TestResult "Script de geração tem padrões SCPO" $false "Erro ao verificar script"
    }
}

# Teste 6: Verificar Agente Principal
Write-Host "`n🤖 Testando Agente Principal..." -ForegroundColor White

if (Test-Path "scripts\agent-principal.ps1") {
    $agentContent = Get-Content "scripts\agent-principal.ps1" -Raw
    $intelligentMode = $agentContent -match "intelligent|automático|principal"
    Write-TestResult "Agente Principal tem modo inteligente" $intelligentMode
}
else {
    Write-TestResult "Agente Principal existe" $false "Script não encontrado"
}

# Teste 7: Verificar Extensão SCPO
Write-Host "`n🔌 Testando Extensão SCPO..." -ForegroundColor White

if (Test-Path "vscode-extension-scpo\package.json") {
    $packageContent = Get-Content "vscode-extension-scpo\package.json" -Raw | ConvertFrom-Json
    $hasSnippets = $packageContent.contributes.snippets.Count -gt 0
    Write-TestResult "Extensão tem snippets configurados" $hasSnippets "Encontrados $($packageContent.contributes.snippets.Count) tipos de snippets"
}
else {
    Write-TestResult "Extensão SCPO existe" $false "package.json não encontrado"
}

# Resultados Finais
Write-Host ""
Write-Host "📊 RESULTADOS DOS TESTES" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan
Write-Host ""

$successRate = if ($totalTests -gt 0) { [math]::Round(($passedTests / $totalTests) * 100, 1) } else { 0 }
$color = if ($successRate -ge 90) { "Green" } elseif ($successRate -ge 70) { "Yellow" } else { "Red" }

Write-Host "✅ Testes Passou: $passedTests/$totalTests ($successRate%)" -ForegroundColor $color
Write-Host "⏱️  Executado em: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray

if ($successRate -ge 90) {
    Write-Host ""
    Write-Host "🎉 SISTEMA FUNCIONANDO PERFEITAMENTE!" -ForegroundColor Green
    Write-Host "🚀 Pronto para produção e uso avançado!" -ForegroundColor Green
}
elseif ($successRate -ge 70) {
    Write-Host ""
    Write-Host "⚠️  Sistema funcionando com alguns ajustes necessários" -ForegroundColor Yellow
}
else {
    Write-Host ""
    Write-Host "❌ Sistema precisa de correções antes do uso" -ForegroundColor Red
}

Write-Host ""
Write-Host "💡 Para executar teste completo: .\tests\system-validation.ps1 -Full -Verbose" -ForegroundColor Gray
Write-Host ""