#!/usr/bin/env pwsh
# 🔧 REPARAR PROJETO - Corrige qualquer problema em projetos MultiAgent
# ====================================================================
# Uso: .\reparar-projeto.ps1 [CaminhoProjeto]

param(
    [string]$CaminhoProjeto = "."
)

Write-Host ""
Write-Host "🔧 REPARANDO PROJETO MULTIAGENT" -ForegroundColor Cyan
Write-Host "===============================" -ForegroundColor Cyan
Write-Host ""

$caminhoCompleto = Resolve-Path $CaminhoProjeto -ErrorAction SilentlyContinue
if (-not $caminhoCompleto) {
    Write-Host "❌ Caminho não encontrado: $CaminhoProjeto" -ForegroundColor Red
    exit 1
}

Set-Location $caminhoCompleto
Write-Host "📁 Reparando: $caminhoCompleto" -ForegroundColor Yellow
Write-Host ""

# 1. Verificar e reparar prompts
Write-Host "🔧 Verificando prompts SCPO..." -ForegroundColor Yellow

$sistemaRoot = Split-Path $PSCommandPath -Parent
$corretorPrompts = Join-Path $sistemaRoot "corrigir-prompts.ps1"

if (Test-Path $corretorPrompts) {
    & $corretorPrompts "." 2>$null | Out-Null
    
    if (Test-Path "prompts") {
        $quantidadePrompts = (Get-ChildItem "prompts" -Filter "*.md").Count
        Write-Host "  ✅ $quantidadePrompts prompts verificados" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Erro ao instalar prompts" -ForegroundColor Red
    }
} else {
    Write-Host "  ⚠️ Corretor de prompts não encontrado" -ForegroundColor Yellow
}

# 2. Verificar arquivos essenciais
Write-Host "🔧 Verificando arquivos essenciais..." -ForegroundColor Yellow

$arquivosEssenciais = @(
    "ma.ps1",
    "anti-erros.ps1",
    "validacao-tempo-real.ps1", 
    "gerar-codigo-seguro.ps1",
    "sistema-anti-erros.ps1"
)

$arquivosFaltando = @()
foreach ($arquivo in $arquivosEssenciais) {
    if (-not (Test-Path $arquivo)) {
        $origem = Join-Path $sistemaRoot $arquivo
        if (Test-Path $origem) {
            Copy-Item $origem ".\$arquivo" -Force
            Write-Host "  ✅ $arquivo copiado" -ForegroundColor Green
        } else {
            $arquivosFaltando += $arquivo
            Write-Host "  ❌ $arquivo não encontrado" -ForegroundColor Red
        }
    } else {
        Write-Host "  ✓ $arquivo existe" -ForegroundColor Gray
    }
}

# 3. Verificar configurações
Write-Host "🔧 Verificando configurações..." -ForegroundColor Yellow

if (-not (Test-Path "settings")) {
    $settingsOrigem = Join-Path $sistemaRoot "settings"
    if (Test-Path $settingsOrigem) {
        Copy-Item $settingsOrigem ".\settings" -Recurse -Force
        Write-Host "  ✅ Configurações copiadas" -ForegroundColor Green
    } else {
        New-Item -ItemType Directory -Path "settings" -Force | Out-Null
        @"
{
  "multiagent": {
    "modo": "automatico",
    "correcaoAutomatica": true,
    "validacaoTempo": true,
    "templates": true
  }
}
"@ | Set-Content "settings\global-settings.json"
        Write-Host "  ✅ Configurações básicas criadas" -ForegroundColor Green
    }
} else {
    Write-Host "  ✓ Configurações existem" -ForegroundColor Gray
}

# 4. Criar/atualizar arquivo de projeto
Write-Host "🔧 Verificando arquivo de projeto..." -ForegroundColor Yellow

if (-not (Test-Path "projeto.json")) {
    $nomeProjeto = Split-Path (Get-Location) -Leaf
    @"
{
  "projeto": {
    "nome": "$nomeProjeto",
    "descricao": "Projeto MultiAgent reparado automaticamente",
    "reparado": "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    "sistema": "MultiAgent v2.1"
  },
  "configuracoes": {
    "autoCorrecao": true,
    "validacaoTempo": true,
    "templates": true,
    "antiErros": true
  }
}
"@ | Set-Content "projeto.json"
    Write-Host "  ✅ Arquivo de projeto criado" -ForegroundColor Green
} else {
    Write-Host "  ✓ Arquivo de projeto existe" -ForegroundColor Gray
}

# 5. Relatório final
Write-Host ""
Write-Host "📊 RELATÓRIO DE REPARAÇÃO" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan

$promptsCount = if (Test-Path "prompts") { (Get-ChildItem "prompts" -Filter "*.md").Count } else { 0 }
$arquivosCount = 0
foreach ($arquivo in $arquivosEssenciais) {
    if (Test-Path $arquivo) { $arquivosCount++ }
}

Write-Host "  📄 Prompts SCPO: $promptsCount/10" -ForegroundColor $(if($promptsCount -ge 10) {"Green"} else {"Yellow"})
Write-Host "  🔧 Scripts: $arquivosCount/$($arquivosEssenciais.Count)" -ForegroundColor $(if($arquivosCount -eq $arquivosEssenciais.Count) {"Green"} else {"Yellow"})
Write-Host "  ⚙️ Configurações: $(if(Test-Path "settings") {"✅"} else {"❌"})" -ForegroundColor $(if(Test-Path "settings") {"Green"} else {"Red"})
Write-Host "  📋 Projeto: $(if(Test-Path "projeto.json") {"✅"} else {"❌"})" -ForegroundColor $(if(Test-Path "projeto.json") {"Green"} else {"Red"})

if ($arquivosFaltando.Count -eq 0 -and $promptsCount -ge 10) {
    Write-Host ""
    Write-Host "🎉 PROJETO TOTALMENTE REPARADO!" -ForegroundColor Green
    Write-Host ""
    Write-Host "💡 Teste agora:" -ForegroundColor Yellow
    Write-Host "  .\ma.ps1 safe-code MeuArquivo -Type js" -ForegroundColor White
    Write-Host "  .\ma.ps1 check" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "⚠️ REPARAÇÃO PARCIAL" -ForegroundColor Yellow
    if ($arquivosFaltando.Count -gt 0) {
        Write-Host "❌ Arquivos faltando: $($arquivosFaltando -join ', ')" -ForegroundColor Red
    }
    if ($promptsCount -lt 10) {
        Write-Host "❌ Prompts incompletos: $promptsCount/10" -ForegroundColor Red
    }
}

Write-Host ""