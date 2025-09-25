#!/usr/bin/env pwsh
# 🚀 INICIALIZADOR AUTOMÁTICO - Configura projeto após clone
# ========================================================
# Este script é executado automaticamente para configurar tudo

Write-Host ""
Write-Host "🚀 CONFIGURANDO PROJETO MULTIAGENT" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host ""

# Detectar se estamos no diretório correto
$projetoJson = "projeto.json"
$multiagentJson = "multiagent.json"

if ((Test-Path $projetoJson) -or (Test-Path $multiagentJson)) {
  Write-Host "✅ Projeto MultiAgent detectado!" -ForegroundColor Green
}
else {
  Write-Host "⚠️  Criando configuração básica..." -ForegroundColor Yellow
  
  # Criar projeto.json básico
  @"
{
  "projeto": {
    "nome": "$(Split-Path (Get-Location) -Leaf)",
    "descricao": "Projeto MultiAgent",
    "criado": "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    "agente": "principal-v2",
    "modo": "automatico"
  },
  "configuracoes": {
    "autoExecutar": true,
    "autoCorrigir": true,
    "validacaoTempo": true
  }
}
"@ | Set-Content $projetoJson
  
  Write-Host "  ✅ projeto.json criado" -ForegroundColor Gray
}

# Verificar e corrigir prompts
Write-Host "🔧 Verificando prompts SCPO..." -ForegroundColor Yellow

if (Test-Path ".\corrigir-prompts.ps1") {
  & ".\corrigir-prompts.ps1" "." 2>$null
}
else {
  Write-Host "  ⚠️  Script de correção não encontrado, copiando manualmente..." -ForegroundColor Yellow
  
  # Verificar se pasta prompts existe
  if (-not (Test-Path "prompts")) {
    New-Item -ItemType Directory -Path "prompts" -Force | Out-Null
    Write-Host "  📁 Pasta prompts criada" -ForegroundColor Gray
  }
  
  # Contar prompts existentes
  $promptsExistentes = @()
  if (Test-Path "prompts") {
    $promptsExistentes = Get-ChildItem "prompts" -Filter "*.md"
  }
  
  Write-Host "  📊 $($promptsExistentes.Count) prompts encontrados" -ForegroundColor Cyan
}

# Verificar scripts essenciais
Write-Host "🔧 Verificando scripts essenciais..." -ForegroundColor Yellow
$scriptsEssenciais = @(
  "ma.ps1",
  "anti-erros.ps1", 
  "validacao-tempo-real.ps1",
  "gerar-codigo-seguro.ps1",
  "sistema-anti-erros.ps1"
)

$scriptsEncontrados = 0
foreach ($script in $scriptsEssenciais) {
  if (Test-Path $script) {
    Write-Host "  ✅ $script" -ForegroundColor Green
    $scriptsEncontrados++
  }
  else {
    Write-Host "  ❌ $script (faltando)" -ForegroundColor Red
  }
}

# Verificar configurações
Write-Host "🔧 Verificando configurações..." -ForegroundColor Yellow
if (Test-Path "settings") {
  Write-Host "  ✅ Configurações encontradas" -ForegroundColor Green
}
else {
  Write-Host "  ⚠️  Criando configurações básicas..." -ForegroundColor Yellow
  New-Item -ItemType Directory -Path "settings" -Force | Out-Null
  
  @"
{
  "multiagent": {
    "modo": "automatico",
    "correcaoAutomatica": true,
    "validacaoTempo": true,
    "modoLeigo": true
  },
  "agentes": {
    "principal": {
      "ativo": true,
      "autoExecucao": true
    }
  }
}
"@ | Set-Content "settings\global-settings.json"
  
  Write-Host "  ✅ Configurações básicas criadas" -ForegroundColor Gray
}

Write-Host ""
Write-Host "📊 RELATÓRIO DE INICIALIZAÇÃO" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan
Write-Host "  🔧 Scripts: $scriptsEncontrados/$($scriptsEssenciais.Count)" -ForegroundColor White
Write-Host "  📄 Prompts: $((Get-ChildItem 'prompts' -Filter '*.md' -ErrorAction SilentlyContinue).Count) disponíveis" -ForegroundColor White
Write-Host "  ⚙️  Configurações: $(if (Test-Path 'settings') { '✅' } else { '❌' })" -ForegroundColor White
Write-Host ""

if ($scriptsEncontrados -eq $scriptsEssenciais.Count) {
  Write-Host "🎉 PROJETO TOTALMENTE CONFIGURADO!" -ForegroundColor Green
  Write-Host ""
  Write-Host "💡 Comandos disponíveis:" -ForegroundColor Cyan
  Write-Host "  .\ma.ps1 check          - Verificar sistema" -ForegroundColor Gray
  Write-Host "  .\gerar-codigo-seguro.ps1 - Gerar código" -ForegroundColor Gray
  Write-Host "  .\reparar-projeto.ps1   - Reparar se necessário" -ForegroundColor Gray
}
else {
  Write-Host "⚠️  CONFIGURAÇÃO INCOMPLETA" -ForegroundColor Yellow
  Write-Host ""
  Write-Host "💡 Para reparar, execute:" -ForegroundColor Cyan
  Write-Host "  .\reparar-projeto.ps1" -ForegroundColor Gray
}

Write-Host ""