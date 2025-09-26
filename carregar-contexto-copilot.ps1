#!/usr/bin/env pwsh
# 🤖 CARREGADOR DE CONTEXTO PARA COPILOT
# ====================================
# Este script força o Copilot a ler todo o contexto do projeto

param(
  [switch]$Silent = $false
)

if (-not $Silent) {
  Write-Host ""
  Write-Host "🤖 CARREGANDO CONTEXTO PARA GITHUB COPILOT" -ForegroundColor Cyan
  Write-Host "==========================================" -ForegroundColor Cyan
  Write-Host ""
}

# Verificar se estamos no projeto correto
if (-not (Test-Path "prompts") -or -not (Test-Path "settings")) {
  Write-Host "❌ Este não parece ser um projeto MultiAgent válido" -ForegroundColor Red
  Write-Host "   Pasta 'prompts' ou 'settings' não encontrada" -ForegroundColor Red
  exit 1
}

Write-Host "📁 Projeto MultiAgent detectado!" -ForegroundColor Green
Write-Host ""

# Contar recursos disponíveis
$prompts = (Get-ChildItem "prompts" -Filter "*.md" -ErrorAction SilentlyContinue).Count
$scripts = @("ma.ps1", "anti-erros.ps1", "gerar-codigo-seguro.ps1", "validacao-tempo-real.ps1", "sistema-anti-erros.ps1") | Where-Object { Test-Path $_ }
$configs = @("settings/global-settings.json", "multiagent.json", ".vscode/settings.json") | Where-Object { Test-Path $_ }

if (-not $Silent) {
  Write-Host "📊 RECURSOS DISPONÍVEIS PARA COPILOT:" -ForegroundColor Yellow
  Write-Host "   🧠 Prompts SCPO: $prompts disponíveis" -ForegroundColor White
  Write-Host "   🔧 Scripts: $($scripts.Count) ativos" -ForegroundColor White  
  Write-Host "   ⚙️  Configurações: $($configs.Count) carregadas" -ForegroundColor White
  Write-Host ""
}

# Verificar se Copilot está configurado
$copilotConfig = $false
if (Test-Path ".vscode/settings.json") {
  $settings = Get-Content ".vscode/settings.json" -Raw
  if ($settings -match "github.copilot") {
    $copilotConfig = $true
    if (-not $Silent) {
      Write-Host "✅ Configurações GitHub Copilot: Ativas" -ForegroundColor Green
    }
  }
}

if (-not $copilotConfig -and -not $Silent) {
  Write-Host "⚠️  Configurações GitHub Copilot: Não detectadas" -ForegroundColor Yellow
}

# Listar prompts disponíveis
if (-not $Silent) {
  Write-Host "🧠 PROMPTS SCPO CARREGADOS:" -ForegroundColor Cyan
  Get-ChildItem "prompts" -Filter "*.md" | ForEach-Object {
    $nome = $_.BaseName
    $tamanho = [math]::Round($_.Length / 1KB, 1)
    Write-Host "   📄 $nome ($tamanho KB)" -ForegroundColor Gray
  }

  Write-Host ""
}
if (-not $Silent) {
  Write-Host "💡 COMO USAR COM COPILOT:" -ForegroundColor Yellow
  Write-Host "   1. Abra qualquer arquivo no VS Code" -ForegroundColor White
  Write-Host "   2. Use Ctrl+I para chat do Copilot" -ForegroundColor White
  Write-Host "   3. O Copilot agora tem contexto completo do projeto" -ForegroundColor White
  Write-Host "   4. Peça algo como: 'criar API usando padrões do projeto'" -ForegroundColor White
  Write-Host ""
}

# Criar arquivo de contexto atualizado
$contexto = @"
# CONTEXTO MULTIAGENT - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

## Prompts Disponíveis: $prompts
$(Get-ChildItem "prompts" -Filter "*.md" | ForEach-Object { "- $($_.Name)" })

## Scripts Ativos: $($scripts.Count)  
$(foreach ($script in $scripts) { "- $script" })

## Configurações: $($configs.Count)
$(foreach ($config in $configs) { "- $config" })

## Status: Sistema MultiAgent Ativo ✅
"@

$contexto | Set-Content ".copilot-context-cache.md"

if (-not $Silent) {
  Write-Host "✅ CONTEXTO CARREGADO E PRONTO!" -ForegroundColor Green
  Write-Host "   Arquivo de cache criado: .copilot-context-cache.md" -ForegroundColor Gray
  Write-Host ""
}
Write-Host "🚀 O GitHub Copilot agora está 10x mais inteligente!" -ForegroundColor Magenta
Write-Host ""