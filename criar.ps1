#!/usr/bin/env pwsh
# 🚀 COMANDO RÁPIDO - Criar projeto novo com clone do GitHub
# ========================================================
# Uso: .\criar.ps1 NomeProjeto "descrição"

param(
  [Parameter(Position = 0, Mandatory = $true)]
  [string]$Nome,
  
  [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
  [string[]]$Descricao
)

$desc = if ($Descricao) { $Descricao -join " " } else { "Projeto criado automaticamente" }

Write-Host "🚀 CRIANDO PROJETO: $Nome" -ForegroundColor Green
Write-Host "💭 Descrição: $desc" -ForegroundColor Cyan
Write-Host ""

# Executar sexta-feira
& ".\sexta-feira.ps1" $Nome $desc