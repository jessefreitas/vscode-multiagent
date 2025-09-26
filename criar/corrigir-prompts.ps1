#!/usr/bin/env pwsh
# 🔧 CORRETOR DE PROMPTS - Garante que todos os prompts sejam copiados
# ==================================================================

param(
  [string]$CaminhoProjeto = "."
)

$promptsOriginais = "$PSScriptRoot\prompts"
$promptsDestino = "$CaminhoProjeto\prompts"

Write-Host "🔧 CORRETOR DE PROMPTS" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host ""

# Verificar se pasta de prompts origem existe
if (-not (Test-Path $promptsOriginais)) {
  Write-Host "❌ Pasta de prompts não encontrada: $promptsOriginais" -ForegroundColor Red
  exit 1
}

# Criar pasta destino se não existir
if (-not (Test-Path $promptsDestino)) {
  New-Item -ItemType Directory -Path $promptsDestino -Force | Out-Null
  Write-Host "📁 Pasta prompts criada: $promptsDestino" -ForegroundColor Yellow
}

# Copiar todos os prompts
Write-Host "📄 Copiando prompts..." -ForegroundColor Yellow

$promptsCopiados = 0
$promptsExistentes = Get-ChildItem -Path $promptsOriginais -Filter "*.md"

foreach ($prompt in $promptsExistentes) {
  $destino = Join-Path $promptsDestino $prompt.Name
  Copy-Item $prompt.FullName $destino -Force
  Write-Host "  ✅ $($prompt.Name)" -ForegroundColor Green
  $promptsCopiados++
}

# Verificar se README.md existe
$readmePath = Join-Path $promptsDestino "README.md"
if (-not (Test-Path $readmePath)) {
  @"
# Prompts SCPO - Sistema Multiagente

Esta pasta contém os prompts especializados para diferentes tipos de desenvolvimento:

## Prompts Disponíveis:

- **agente-principal-arroba.md** - Agente principal para desenvolvimento geral
- **backend-architecture.md** - Especialista em arquitetura de backend
- **code-optimization.md** - Otimização de código e performance
- **documentation.md** - Geração de documentação técnica
- **omniforge-orchestrator-agent.md** - Orquestração de projetos complexos
- **product-strategy.md** - Estratégia de produto e features
- **testing-quality.md** - Testes e qualidade de código
- **ui-design.md** - Design de interfaces
- **web-development.md** - Desenvolvimento web frontend/backend

## Como Usar:

```powershell
# Usar prompt específico
.\ma.ps1 -Prompt "backend-architecture" -Task "criar API REST"

# Usar agente principal (padrão)
.\ma.ps1 "criar sistema de login"
```

## Personalização:

Você pode modificar qualquer prompt para se adequar às suas necessidades específicas.
"@ | Set-Content $readmePath
  Write-Host "  ✅ README.md criado" -ForegroundColor Green
  $promptsCopiados++
}

Write-Host ""
Write-Host "✅ Correção concluída!" -ForegroundColor Green
Write-Host "📊 Total de arquivos: $promptsCopiados" -ForegroundColor Cyan
Write-Host "📁 Localização: $promptsDestino" -ForegroundColor Gray
Write-Host ""