#!/usr/bin/env pwsh
# 🚀 CRIAR PROJETO RÁPIDO - Comando super simples
# ===============================================
# Uso: .\criar-projeto.ps1 MeuProjeto

param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$NomeProjeto,
    
    [Parameter(Position = 1)]
    [string]$Descricao = "Projeto criado automaticamente"
)

Write-Host ""
Write-Host "🚀 CRIANDO PROJETO: $NomeProjeto" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green
Write-Host ""

# Verificar se já existe
if (Test-Path $NomeProjeto) {
    Write-Host "⚠️ Projeto '$NomeProjeto' já existe!" -ForegroundColor Yellow
    $resposta = Read-Host "Sobrescrever? (s/N)"
    if ($resposta -ne "s" -and $resposta -ne "S") {
        Write-Host "❌ Cancelado." -ForegroundColor Red
        exit 0
    }
    Remove-Item $NomeProjeto -Recurse -Force
}

# Criar pasta
New-Item -ItemType Directory -Path $NomeProjeto -Force | Out-Null
Set-Location $NomeProjeto

Write-Host "📁 Pasta criada: $NomeProjeto" -ForegroundColor Cyan

# Copiar arquivos essenciais
$arquivos = @(
    "ma.ps1",
    "anti-erros.ps1", 
    "validacao-tempo-real.ps1",
    "gerar-codigo-seguro.ps1",
    "sistema-anti-erros.ps1",
    "corrigir-prompts.ps1"
)

Write-Host "📋 Copiando sistema MultiAgent..." -ForegroundColor Yellow

foreach ($arquivo in $arquivos) {
    $origem = "$PSScriptRoot\$arquivo"
    if (Test-Path $origem) {
        Copy-Item $origem ".\$arquivo" -Force
        Write-Host "  ✅ $arquivo" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️ $arquivo não encontrado" -ForegroundColor Yellow
    }
}

# Instalar prompts
Write-Host "🔧 Instalando prompts SCPO..." -ForegroundColor Yellow
$corretorOriginal = "$PSScriptRoot\corrigir-prompts.ps1"
& $corretorOriginal "." 2>$null | Out-Null

$quantidadePrompts = 0
if (Test-Path "prompts") {
    $quantidadePrompts = (Get-ChildItem "prompts" -Filter "*.md").Count
}

Write-Host "  ✅ $quantidadePrompts prompts instalados" -ForegroundColor Green

# Copiar configurações
if (Test-Path "$PSScriptRoot\settings") {
    Copy-Item "$PSScriptRoot\settings" ".\settings" -Recurse -Force
    Write-Host "  ✅ Configurações copiadas" -ForegroundColor Green
}

# Criar arquivo de projeto
@"
{
  "projeto": {
    "nome": "$NomeProjeto",
    "descricao": "$Descricao", 
    "criado": "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    "sistema": "MultiAgent v2.1",
    "prompts": $quantidadePrompts
  },
  "configuracoes": {
    "autoCorrecao": true,
    "validacaoTempo": true,
    "templates": true,
    "antiErros": true
  }
}
"@ | Set-Content "projeto.json"

# Criar README básico
@"
# $NomeProjeto

$Descricao

## Como usar:

```powershell
# Gerar código seguro
.\ma.ps1 safe-code MinhaFuncao -Type js

# Verificar qualidade
.\ma.ps1 check

# Corrigir problemas
.\ma.ps1 fix
```

## Sistema instalado:
- ✅ MultiAgent v2.1
- ✅ $quantidadePrompts prompts SCPO  
- ✅ Sistema anti-erros
- ✅ Validação tempo real
- ✅ Templates inteligentes

Criado automaticamente em $(Get-Date -Format 'dd/MM/yyyy HH:mm')
"@ | Set-Content "README.md"

Write-Host ""
Write-Host "🎉 PROJETO '$NomeProjeto' CRIADO COM SUCESSO!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Resumo:" -ForegroundColor Cyan
Write-Host "  📁 Localização: $(Get-Location)" -ForegroundColor Gray
Write-Host "  🔧 Arquivos: $($arquivos.Count) scripts copiados" -ForegroundColor Gray
Write-Host "  📄 Prompts: $quantidadePrompts prompts SCPO" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 Próximos passos:" -ForegroundColor Yellow
Write-Host "  1. cd $NomeProjeto" -ForegroundColor White
Write-Host "  2. .\ma.ps1 safe-code MeuArquivo -Type js" -ForegroundColor White
Write-Host "  3. .\ma.ps1 check" -ForegroundColor White
Write-Host ""