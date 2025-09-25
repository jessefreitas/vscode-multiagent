#!/usr/bin/env pwsh
# 🤖 COMANDO ULTRA SIMPLES PARA LEIGOS
# ===================================
# Você não precisa entender NADA de código!
# Só use: quero "o que você quer"

param(
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$Request
)

# Junta todas as palavras em uma frase
$fullRequest = $Request -join " "

if (-not $fullRequest) {
    Write-Host ""
    Write-Host "😊 Olá! Eu sou seu assistente automático de programação!" -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "💬 Me diga o que você quer e eu faço TUDO para você:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   quero um site de vendas" -ForegroundColor Yellow
    Write-Host "   quero uma API para meu negócio" -ForegroundColor Yellow  
    Write-Host "   quero um app mobile" -ForegroundColor Yellow
    Write-Host "   quero otimizar meu código" -ForegroundColor Yellow
    Write-Host "   quero uma loja online" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🤖 Exemplo: quero ""fazer um site de receitas""" -ForegroundColor White
    Write-Host ""
    Write-Host "😊 Você NÃO precisa saber programação!" -ForegroundColor Green
    Write-Host "   Eu cuido de TUDO: código, testes, instalação, configuração!" -ForegroundColor Gray
    Write-Host ""
    return
}

# Limpa a frase para o agente entender melhor
$cleanRequest = $fullRequest -replace "^(eu |quero |preciso |fazer |criar )", ""

Write-Host ""
Write-Host "🤖 Perfeito! Entendi que você quer:" -ForegroundColor Cyan
Write-Host "   ""$cleanRequest""" -ForegroundColor Yellow
Write-Host ""
Write-Host "😊 Relaxe! Vou fazer TUDO automaticamente para você!" -ForegroundColor Green
Write-Host "   • Não precisa revisar nada" -ForegroundColor Gray
Write-Host "   • Não precisa instalar nada" -ForegroundColor Gray  
Write-Host "   • Não precisa entender código" -ForegroundColor Gray
Write-Host "   • EU CUIDO DE TUDO!" -ForegroundColor Green
Write-Host ""

# Chama o agente principal em modo automático
& "$PSScriptRoot\ma.ps1" $cleanRequest