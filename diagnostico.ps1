# 🔍 DIAGNÓSTICO DO AGENTE PRINCIPAL
# =================================
# Verifica se tudo está funcionando corretamente

Write-Host ""
Write-Host "🔍 DIAGNÓSTICO COMPLETO - Agente Principal" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$problemas = @()
$sucesso = 0
$total = 0

function Test-Component {
    param([string]$Nome, [scriptblock]$Teste, [string]$Solucao = "")
    
    $global:total++
    try {
        $resultado = & $Teste
        if ($resultado) {
            Write-Host "✅ $Nome" -ForegroundColor Green
            $global:sucesso++
        } else {
            Write-Host "❌ $Nome" -ForegroundColor Red
            if ($Solucao) {
                Write-Host "   💡 Solução: $Solucao" -ForegroundColor Yellow
            }
            $global:problemas += $Nome
        }
    } catch {
        Write-Host "❌ $Nome - Erro: $($_.Exception.Message)" -ForegroundColor Red
        if ($Solucao) {
            Write-Host "   💡 Solução: $Solucao" -ForegroundColor Yellow
        }
        $global:problemas += $Nome
    }
}

# Testes dos arquivos essenciais
Write-Host "📁 Verificando Arquivos..." -ForegroundColor White
Test-Component "Script ma.ps1" { Test-Path "ma.ps1" } "Execute: .\install-rapido.ps1"
Test-Component "Script quero.ps1" { Test-Path "quero.ps1" } "Execute: .\install-rapido.ps1"
Test-Component "Configuração VS Code" { Test-Path ".vscode\tasks.json" } "Execute: .\install-rapido.ps1"

# Testes funcionais
Write-Host "`n🤖 Verificando Funcionalidades..." -ForegroundColor White
Test-Component "Comando ma funciona" { 
    $output = & ".\ma.ps1" "help" 2>&1
    ($output -join " ") -match "AGENTE PRINCIPAL"
} "Verifique se ma.ps1 existe e está correto"

Test-Component "PowerShell ExecutionPolicy" {
    $policy = Get-ExecutionPolicy -Scope CurrentUser
    $policy -in @("RemoteSigned", "Unrestricted", "Bypass")
} "Execute: Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"

# Testes do VS Code
Write-Host "`n🎮 Verificando Integração VS Code..." -ForegroundColor White
Test-Component "Tasks configuradas" {
    if (Test-Path ".vscode\tasks.json") {
        $tasks = Get-Content ".vscode\tasks.json" -Raw
        $tasks -match "SUPER FÁCIL|Agente Principal"
    } else { $false }
} "Execute: .\install-rapido.ps1"

Test-Component "Settings configuradas" {
    if (Test-Path ".vscode\settings.json") {
        $settings = Get-Content ".vscode\settings.json" -Raw
        $settings -match "multiagent|agente"
    } else { $false }
} "Execute: .\install-rapido.ps1"

# Teste de conectividade (se precisar baixar)
Write-Host "`n🌐 Verificando Conectividade..." -ForegroundColor White
Test-Component "Acesso à Internet" {
    try {
        $response = Invoke-WebRequest -Uri "https://www.google.com" -UseBasicParsing -TimeoutSec 5
        $response.StatusCode -eq 200
    } catch { $false }
} "Verifique sua conexão com a internet"

# Resultados
Write-Host ""
Write-Host "📊 RESULTADOS DO DIAGNÓSTICO" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

$percentual = [math]::Round(($sucesso / $total) * 100)
$cor = if ($percentual -ge 90) { "Green" } elseif ($percentual -ge 70) { "Yellow" } else { "Red" }

Write-Host ""
Write-Host "✅ Funcionando: $sucesso/$total ($percentual%)" -ForegroundColor $cor

if ($problemas.Count -eq 0) {
    Write-Host ""
    Write-Host "🎉 TUDO FUNCIONANDO PERFEITAMENTE!" -ForegroundColor Green
    Write-Host "🚀 Agente Principal pronto para usar!" -ForegroundColor Green
    Write-Host ""
    Write-Host "💡 Teste agora:" -ForegroundColor Cyan
    Write-Host "   quero \"um site simples\"" -ForegroundColor White
    Write-Host "   ma \"status\"" -ForegroundColor White
    Write-Host ""
} elseif ($problemas.Count -le 2) {
    Write-Host ""
    Write-Host "⚠️  Sistema funcionando com pequenos ajustes necessários" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🔧 SOLUÇÃO RÁPIDA:" -ForegroundColor Cyan
    Write-Host "   .\install-rapido.ps1 -Force" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ Sistema precisa de configuração" -ForegroundColor Red
    Write-Host ""
    Write-Host "🛠️  SOLUÇÃO:" -ForegroundColor Cyan
    Write-Host "   .\install-rapido.ps1 -Force" -ForegroundColor White
    Write-Host ""
}

Write-Host "📖 Para ajuda completa: ABRIR-PROJETOS-VSCODE.md" -ForegroundColor Gray
Write-Host ""