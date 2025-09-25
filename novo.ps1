#!/usr/bin/env pwsh
# 🚀 COMANDO ULTRA SIMPLES PARA CRIAR PROJETOS NOVOS
# =================================================
# Uso: novo MeuProjeto "um site de vendas"

param(
  [Parameter(Position = 0, Mandatory = $true)]
  [string]$NomeProjeto,
    
  [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
  [string[]]$OQueVoceQuer
)

# Junta a descrição
$descricao = $OQueVoceQuer -join " "

Write-Host ""
Write-Host "🚀 CRIANDO PROJETO NOVO AUTOMATICAMENTE" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green
Write-Host ""
Write-Host "📁 Nome: $NomeProjeto" -ForegroundColor Cyan
Write-Host "💭 Descrição: $descricao" -ForegroundColor Cyan
Write-Host ""

# Verificar se pasta já existe
if (Test-Path $NomeProjeto) {
  Write-Host "⚠️  Pasta '$NomeProjeto' já existe!" -ForegroundColor Yellow
  $resposta = Read-Host "Quer sobrescrever? (s/N)"
  if ($resposta -ne "s" -and $resposta -ne "S") {
    Write-Host "❌ Operação cancelada." -ForegroundColor Red
    exit 1
  }
  Remove-Item $NomeProjeto -Recurse -Force
}

# Criar pasta do projeto
Write-Host "📁 Criando pasta do projeto..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path $NomeProjeto | Out-Null
Set-Location $NomeProjeto

# Copiar sistema MultiAgent
Write-Host "🤖 Configurando Agente Principal..." -ForegroundColor Yellow

# Copiar arquivos essenciais
$arquivosEssenciais = @(
  "$PSScriptRoot\ma.ps1",
  "$PSScriptRoot\quero.ps1", 
  "$PSScriptRoot\super-agent.ps1",
  "$PSScriptRoot\generate-code-scpo.ps1"
)

foreach ($arquivo in $arquivosEssenciais) {
  if (Test-Path $arquivo) {
    $nomeArquivo = Split-Path $arquivo -Leaf
    Copy-Item $arquivo ".\$nomeArquivo" -Force
    Write-Host "  ✅ $nomeArquivo copiado" -ForegroundColor Gray
  }
}

# Copiar prompts usando corretor automático
Write-Host "  🔧 Configurando prompts SCPO..." -ForegroundColor Yellow
& "$PSScriptRoot\corrigir-prompts.ps1" "." 2>$null
if (Test-Path "prompts") {
  $quantidadePrompts = (Get-ChildItem "prompts" -Filter "*.md").Count
  Write-Host "  ✅ $quantidadePrompts prompts SCPO instalados" -ForegroundColor Green
} else {
  Write-Host "  ⚠️ Erro ao instalar prompts" -ForegroundColor Yellow
}

# Copiar configurações
if (Test-Path "$PSScriptRoot\settings") {
  Copy-Item "$PSScriptRoot\settings" ".\settings" -Recurse -Force
  Write-Host "  ✅ Configurações copiadas" -ForegroundColor Gray
} else {
  Write-Host "  ⚠️ Configurações não encontradas, criando básicas..." -ForegroundColor Yellow
  New-Item -ItemType Directory -Path "settings" -Force | Out-Null
  
  @"
{
  "multiagent": {
    "modo": "automatico",
    "correcaoAutomatica": true,
    "validacaoTempo": true
  }
}
"@ | Set-Content "settings\global-settings.json"
  
  Write-Host "  ✅ Configurações básicas criadas" -ForegroundColor Gray
}

# Criar arquivo de projeto
@"
{
  "projeto": {
    "nome": "$NomeProjeto",
    "descricao": "$descricao",
    "criado": "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    "agente": "principal-v2",
    "modo": "ultra-automatico"
  },
  "configuracoes": {
    "autoExecutar": true,
    "autoCorrigir": true,
    "autoInstalar": true,
    "modoLeigo": true,
    "semRevisao": true
  }
}
"@ | Set-Content "projeto.json"

Write-Host ""
Write-Host "✅ Projeto configurado!" -ForegroundColor Green
Write-Host "🤖 Agora vou gerar seu código automaticamente..." -ForegroundColor Cyan
Write-Host ""

# Executar geração automática
if (Test-Path ".\quero.ps1") {
  Write-Host "🚀 Iniciando Agente Principal..." -ForegroundColor Green
  & ".\quero.ps1" $descricao
}
else {
  Write-Host "⚠️  Agente não encontrado. Execute manualmente:" -ForegroundColor Yellow
  Write-Host "   quero '$descricao'" -ForegroundColor White
}

Write-Host ""
Write-Host "🎉 PROJETO '$NomeProjeto' CRIADO COM SUCESSO!" -ForegroundColor Green
Write-Host ""
Write-Host "📁 Localização: $(Get-Location)" -ForegroundColor Gray
Write-Host "💡 Para modificar: quero 'nova funcionalidade'" -ForegroundColor Gray
Write-Host "🔧 Para otimizar: quero 'otimizar código'" -ForegroundColor Gray
Write-Host ""