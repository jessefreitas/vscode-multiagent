# 🔍 SEXTA-FEIRA DIAGNÓSTICO COMPLETO
# ====================================
# Verifica se tudo está funcionando perfeitamente

Write-Host ""
Write-Host "🔍 SEXTA-FEIRA DIAGNÓSTICO COMPLETO" -ForegroundColor Magenta
Write-Host "====================================" -ForegroundColor Magenta
Write-Host ""

$tudo_ok = $true

# 1. VERIFICAR POWERSHELL
Write-Host "1. ✓ PowerShell..." -NoNewline
$ps_version = $PSVersionTable.PSVersion
if ($ps_version.Major -ge 5) {
  Write-Host " OK (v$($ps_version))" -ForegroundColor Green
}
else {
  Write-Host " ❌ Versão muito antiga: $ps_version" -ForegroundColor Red
  $tudo_ok = $false
}

# 2. VERIFICAR GIT
Write-Host "2. ✓ Git..." -NoNewline
try {
  $git_version = git --version 2>$null
  if ($git_version) {
    Write-Host " OK ($git_version)" -ForegroundColor Green
  }
  else {
    Write-Host " ❌ Não instalado" -ForegroundColor Red
    $tudo_ok = $false
  }
}
catch {
  Write-Host " ❌ Não encontrado" -ForegroundColor Red
  $tudo_ok = $false
}

# 3. VERIFICAR GITHUB CLI
Write-Host "3. ✓ GitHub CLI..." -NoNewline
try {
  $gh_version = gh --version 2>$null | Select-String "gh version"
  if ($gh_version) {
    Write-Host " OK ($($gh_version.Line))" -ForegroundColor Green
  }
  else {
    Write-Host " ⚠️  Opcional (para repos automáticos)" -ForegroundColor Yellow
  }
}
catch {
  Write-Host " ⚠️  Não instalado (opcional)" -ForegroundColor Yellow
}

# 4. VERIFICAR PASTA BASE
Write-Host "4. ✓ Pasta C:\vscode..." -NoNewline
$pasta_base = "C:\vscode"
if (Test-Path $pasta_base) {
  $projetos = Get-ChildItem $pasta_base -Directory | Measure-Object
  Write-Host " OK ($($projetos.Count) projetos)" -ForegroundColor Green
}
else {
  Write-Host " ⚠️  Será criada automaticamente" -ForegroundColor Yellow
}

# 5. VERIFICAR SCRIPTS DO SISTEMA
Write-Host "5. ✓ Scripts do sistema..." -NoNewline
$scripts_obrigatorios = @("ma.ps1", "quero.ps1", "sexta-feira.ps1")
$scripts_faltando = @()

foreach ($script in $scripts_obrigatorios) {
  if (-not (Test-Path $script)) {
    $scripts_faltando += $script
  }
}

if ($scripts_faltando.Count -eq 0) {
  Write-Host " OK (todos presentes)" -ForegroundColor Green
}
else {
  Write-Host " ❌ Faltando: $($scripts_faltando -join ', ')" -ForegroundColor Red
  $tudo_ok = $false
}

# 6. VERIFICAR ALIAS GLOBAL
Write-Host "6. ✓ Alias 'Sexta-Feira'..." -NoNewline
$alias_existe = Get-Alias "Sexta-Feira" -ErrorAction SilentlyContinue
if ($alias_existe) {
  Write-Host " OK (instalado globalmente)" -ForegroundColor Green
}
else {
  Write-Host " ⚠️  Use: .\instalar-sexta-global.ps1" -ForegroundColor Yellow
}

# 7. VERIFICAR EXTENSÕES VS CODE (se VS Code estiver instalado)
Write-Host "7. ✓ VS Code..." -NoNewline
try {
  $code_version = code --version 2>$null | Select-Object -First 1
  if ($code_version) {
    Write-Host " OK (v$code_version)" -ForegroundColor Green
  }
  else {
    Write-Host " ⚠️  Não encontrado (opcional)" -ForegroundColor Yellow
  }
}
catch {
  Write-Host " ⚠️  Não instalado (opcional)" -ForegroundColor Yellow
}

# 8. TESTE DE CONEXÃO
Write-Host "8. ✓ Conexão Internet..." -NoNewline
try {
  $teste = Test-Connection "github.com" -Count 1 -Quiet -ErrorAction SilentlyContinue
  if ($teste) {
    Write-Host " OK" -ForegroundColor Green
  }
  else {
    Write-Host " ❌ Sem internet" -ForegroundColor Red
    $tudo_ok = $false
  }
}
catch {
  Write-Host " ❌ Erro de rede" -ForegroundColor Red
  $tudo_ok = $false
}

Write-Host ""

# RESULTADO FINAL
if ($tudo_ok) {
  Write-Host "🎉 SISTEMA PERFEITO! Tudo funcionando 100%" -ForegroundColor Green
  Write-Host ""
  Write-Host "🚀 Comandos disponíveis:" -ForegroundColor Cyan
  Write-Host "   Sexta-Feira NomeProjeto 'descrição'  # Criar projeto completo" -ForegroundColor White
  Write-Host "   .\quero.ps1 'tarefa'                 # Agente automático" -ForegroundColor White
  Write-Host "   .\ma.ps1 'comando'                   # Sistema completo" -ForegroundColor White
  Write-Host ""
  Write-Host "💡 Dica: Use F5 no VS Code para acesso rápido ao agente!" -ForegroundColor Yellow
}
else {
  Write-Host "⚠️  SISTEMA COM PROBLEMAS - Instale os itens em vermelho" -ForegroundColor Yellow
  Write-Host ""
  Write-Host "🔧 Para corrigir:" -ForegroundColor Cyan
  Write-Host "   1. Execute: .\install-rapido.ps1" -ForegroundColor White
  Write-Host "   2. Reinicie o PowerShell" -ForegroundColor White
  Write-Host "   3. Execute novamente este diagnóstico" -ForegroundColor White
}

Write-Host ""
Write-Host "📊 Diagnóstico concluído em $(Get-Date -Format 'dd/MM/yyyy HH:mm')" -ForegroundColor Gray