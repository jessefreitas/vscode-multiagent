#!/usr/bin/env pwsh
# 🔄 MONITOR DE CONTEXTO COPILOT
# =============================
# Mantém o contexto do Copilot sempre atualizado

param(
  [switch]$Daemon = $false,
  [int]$Interval = 300  # 5 minutos
)

Write-Host "🔄 MONITOR DE CONTEXTO COPILOT" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

if ($Daemon) {
  Write-Host "🚀 Iniciando em modo daemon (a cada $Interval segundos)" -ForegroundColor Green
  Write-Host "   Pressione Ctrl+C para parar" -ForegroundColor Gray
  Write-Host ""
    
  while ($true) {
    try {
      # Atualizar contexto silenciosamente
      & ".\carregar-contexto-copilot.ps1" -Silent
            
      # Atualizar arquivo de contexto ativo
      $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
      $conteudo = Get-Content ".copilot-contexto-ativo.md" -Raw
      $conteudo = $conteudo -replace '\*\*Última atualização\*\*: .*', "**Última atualização**: $timestamp"
      $conteudo | Set-Content ".copilot-contexto-ativo.md"
            
      Write-Host "✅ Contexto atualizado em $timestamp" -ForegroundColor Green
            
      Start-Sleep -Seconds $Interval
    }
    catch {
      Write-Host "❌ Erro no monitor: $($_.Exception.Message)" -ForegroundColor Red
      Start-Sleep -Seconds 30
    }
  }
}
else {
  Write-Host "📊 Verificando contexto atual..." -ForegroundColor Yellow
    
  # Verificar se arquivos essenciais existem
  $arquivos = @(
    ".copilot-instructions.md",
    ".copilot-contexto-ativo.md", 
    "CONTEXTO-COPILOT.md",
    ".copilot-context-cache.md"
  )
    
  foreach ($arquivo in $arquivos) {
    if (Test-Path $arquivo) {
      Write-Host "  ✅ $arquivo" -ForegroundColor Green
    }
    else {
      Write-Host "  ❌ $arquivo (FALTANDO)" -ForegroundColor Red
    }
  }
    
  Write-Host ""
  Write-Host "🔧 Para manter contexto sempre atualizado:" -ForegroundColor Cyan
  Write-Host "   .\monitor-contexto-copilot.ps1 -Daemon" -ForegroundColor Gray
  Write-Host ""
  Write-Host "🎯 Para atualizar manualmente:" -ForegroundColor Cyan
  Write-Host "   .\carregar-contexto-copilot.ps1" -ForegroundColor Gray
}