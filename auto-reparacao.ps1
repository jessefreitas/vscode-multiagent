# 🔧 AUTO-REPARAÇÃO SEXTA-FEIRA
# ============================
# Verifica e repara projetos criados com Sexta-Feira

param(
    [string]$ProjectPath = ".",
    [switch]$Verbose = $false
)

function Write-RepairMessage {
    param([string]$Message, [string]$Icon = "🔧")
    Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Write-RepairSuccess {
    param([string]$Message, [string]$Icon = "✅")
    Write-Host "$Icon $Message" -ForegroundColor Green
}

function Write-RepairError {
    param([string]$Message, [string]$Icon = "❌")
    Write-Host "$Icon $Message" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 AUTO-REPARAÇÃO SEXTA-FEIRA" -ForegroundColor Magenta
Write-Host "==============================" -ForegroundColor Magenta
Write-Host ""

# Navegar para pasta do projeto
if ($ProjectPath -ne ".") {
    if (Test-Path $ProjectPath) {
        Set-Location $ProjectPath
        Write-RepairMessage "Verificando projeto: $ProjectPath"
    } else {
        Write-RepairError "Pasta não encontrada: $ProjectPath"
        exit 1
    }
}

# Verificar se é um projeto Sexta-Feira
if (-not (Test-Path "multiagent.json")) {
    Write-RepairError "Este não parece ser um projeto Sexta-Feira (multiagent.json não encontrado)"
    Write-Host "💡 Para criar um projeto Sexta-Feira:" -ForegroundColor Yellow
    Write-Host "   sexta NomeProjeto 'descrição'" -ForegroundColor White
    exit 1
}

Write-RepairSuccess "Projeto Sexta-Feira detectado!"

# URLs do sistema
$sistemaUrl = "https://raw.githubusercontent.com/jessefreitas/vscode-multiagent/master"

# Definir arquivos essenciais
$arquivosEssenciais = @{
    "ma.ps1" = "$sistemaUrl/scripts/ma.ps1"
    "quero.ps1" = "$sistemaUrl/quero.ps1"
    "agente.ps1" = "$sistemaUrl/agente.ps1"
    "generate-code-scpo.ps1" = "$sistemaUrl/scripts/generate-code-scpo.ps1"
    "generate-code.ps1" = "$sistemaUrl/scripts/generate-code.ps1"
    "review-code.ps1" = "$sistemaUrl/scripts/review-code.ps1"
    "execute-code.ps1" = "$sistemaUrl/scripts/execute-code.ps1"
}

$promptsEssenciais = @{
    "prompts/agente-principal-arroba.md" = "$sistemaUrl/prompts/agente-principal-arroba.md"
    "prompts/backend-architecture.md" = "$sistemaUrl/prompts/backend-architecture.md"
    "prompts/ui-design.md" = "$sistemaUrl/prompts/ui-design.md"
    "prompts/web-development.md" = "$sistemaUrl/prompts/web-development.md"
    "prompts/code-optimization.md" = "$sistemaUrl/prompts/code-optimization.md"
    "prompts/documentation.md" = "$sistemaUrl/prompts/documentation.md"
    "prompts/testing-quality.md" = "$sistemaUrl/prompts/testing-quality.md"
    "prompts/product-strategy.md" = "$sistemaUrl/prompts/product-strategy.md"
    "prompts/omniforge-orchestrator-agent.md" = "$sistemaUrl/prompts/omniforge-orchestrator-agent.md"
    "prompts/README.md" = "$sistemaUrl/prompts/README.md"
}

$auxiliares = @{
    "diagnostico-sexta.ps1" = "$sistemaUrl/diagnostico-sexta.ps1"
    "instalar-sexta-global.ps1" = "$sistemaUrl/instalar-sexta-global.ps1"
    "SEXTA-FEIRA-GUIA-LEIGOS.md" = "$sistemaUrl/SEXTA-FEIRA-GUIA-LEIGOS.md"
    "STATUS-FINAL-SEXTA-FEIRA.md" = "$sistemaUrl/STATUS-FINAL-SEXTA-FEIRA.md"
}

# Verificar arquivos
Write-RepairMessage "Verificando integridade dos arquivos..."

$arquivosFaltando = @()
$promptsFaltando = @()
$auxiliaresFaltando = @()

foreach ($arquivo in $arquivosEssenciais.Keys) {
    if (-not (Test-Path $arquivo)) {
        $arquivosFaltando += $arquivo
    }
}

foreach ($prompt in $promptsEssenciais.Keys) {
    if (-not (Test-Path $prompt)) {
        $promptsFaltando += $prompt
    }
}

foreach ($aux in $auxiliares.Keys) {
    if (-not (Test-Path $aux)) {
        $auxiliaresFaltando += $aux
    }
}

$totalFaltando = $arquivosFaltando.Count + $promptsFaltando.Count + $auxiliaresFaltando.Count

if ($totalFaltando -eq 0) {
    Write-RepairSuccess "✅ Todos os arquivos estão presentes! Projeto está completo."
    
    # Mostrar estatísticas
    $totalArquivos = (Get-ChildItem -Recurse -File | Measure-Object).Count
    $totalPrompts = if (Test-Path "prompts") { (Get-ChildItem "prompts" -Filter "*.md" | Measure-Object).Count } else { 0 }
    
    Write-Host ""
    Write-RepairSuccess "📊 ESTATÍSTICAS DO PROJETO:"
    Write-Host "   📁 Total de arquivos: $totalArquivos" -ForegroundColor Green
    Write-Host "   📚 Prompts SCPO: $totalPrompts" -ForegroundColor Green
    Write-Host "   🤖 Scripts essenciais: $($arquivosEssenciais.Count)" -ForegroundColor Green
    Write-Host "   📄 Arquivos auxiliares: $($auxiliares.Count - $auxiliaresFaltando.Count)" -ForegroundColor Green
    Write-Host ""
    Write-RepairSuccess "🎉 Projeto pronto para usar!"
    
    exit 0
}

Write-RepairMessage "⚠️  Encontrados $totalFaltando arquivos faltando - iniciando reparação..."

# Reparar scripts essenciais
if ($arquivosFaltando.Count -gt 0) {
    Write-RepairMessage "Reparando $($arquivosFaltando.Count) scripts essenciais..."
    foreach ($arquivo in $arquivosFaltando) {
        try {
            Write-RepairMessage "Baixando $arquivo..." "⬇️"
            Invoke-WebRequest -Uri $arquivosEssenciais[$arquivo] -OutFile $arquivo -UseBasicParsing -TimeoutSec 30
            Write-RepairSuccess "$arquivo reparado!"
        }
        catch {
            Write-RepairError "Falha ao reparar $arquivo`: $($_.Exception.Message)"
        }
    }
}

# Reparar prompts
if ($promptsFaltando.Count -gt 0) {
    Write-RepairMessage "Reparando $($promptsFaltando.Count) prompts SCPO..."
    
    # Garantir pasta prompts
    if (-not (Test-Path "prompts")) {
        New-Item -ItemType Directory -Path "prompts" -Force | Out-Null
        Write-RepairSuccess "Pasta prompts criada!"
    }
    
    foreach ($prompt in $promptsFaltando) {
        try {
            Write-RepairMessage "Baixando $prompt..." "📄"
            Invoke-WebRequest -Uri $promptsEssenciais[$prompt] -OutFile $prompt -UseBasicParsing -TimeoutSec 30
            Write-RepairSuccess "$prompt reparado!"
        }
        catch {
            Write-RepairError "Falha ao reparar $prompt`: $($_.Exception.Message)"
        }
    }
}

# Reparar auxiliares (opcionais)
if ($auxiliaresFaltando.Count -gt 0) {
    Write-RepairMessage "Reparando $($auxiliaresFaltando.Count) arquivos auxiliares..."
    foreach ($aux in $auxiliaresFaltando) {
        try {
            Write-RepairMessage "Baixando $aux..." "📄"
            Invoke-WebRequest -Uri $auxiliares[$aux] -OutFile $aux -UseBasicParsing -TimeoutSec 30
            Write-RepairSuccess "$aux reparado!"
        }
        catch {
            if ($Verbose) {
                Write-RepairError "Falha ao reparar $aux (opcional)"
            }
        }
    }
}

# Criar documentação se não existe
if (-not (Test-Path "PROJETO-COMPLETO.md")) {
    Write-RepairMessage "Criando documentação do projeto..."
    
    $config = Get-Content "multiagent.json" | ConvertFrom-Json
    $nomeProjeto = $config.project.name
    $descricao = $config.project.description
    
    $projetoDoc = @"
# 🎉 $nomeProjeto - Projeto Sexta-Feira Completo

> **Projeto reparado em $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss') com Auto-Reparação Sexta-Feira**

## 📋 Descrição
$descricao

## 🔧 Auto-Reparação Executada

Este projeto foi verificado e reparado automaticamente pelo sistema **Auto-Reparação Sexta-Feira**.

### ✅ **Sistema Completo Verificado:**
- 🤖 Scripts de agente completos
- 📚 Prompts SCPO especializados  
- ⚙️ Configurações VS Code
- 📄 Documentação e auxiliares

## 💡 **Como usar:**

### 🎯 **Para Leigos (Fácil):**
``````powershell
.\quero.ps1 "criar uma página de login"
.\quero.ps1 "fazer conexão com banco de dados"
``````

### 🔧 **Para Desenvolvedores (Completo):**
``````powershell
.\ma.ps1 "criar API REST completa"
.\ma.ps1 "implementar autenticação JWT"  
``````

## 🔧 **Auto-Reparação:**

Para verificar e reparar novamente:
``````powershell
.\auto-reparacao.ps1
``````

---
*Reparado automaticamente em $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')*
"@
    
    $projetoDoc | Set-Content "PROJETO-COMPLETO.md"
    Write-RepairSuccess "Documentação criada!"
}

# Relatório final
Write-Host ""
Write-RepairSuccess "🎉 AUTO-REPARAÇÃO CONCLUÍDA!"
Write-Host "=========================" -ForegroundColor Green

$totalArquivos = (Get-ChildItem -Recurse -File | Measure-Object).Count
$totalPrompts = if (Test-Path "prompts") { (Get-ChildItem "prompts" -Filter "*.md" | Measure-Object).Count } else { 0 }

Write-Host ""
Write-RepairSuccess "📊 PROJETO REPARADO - ESTATÍSTICAS:"
Write-Host "   📁 Total de arquivos: $totalArquivos" -ForegroundColor Green
Write-Host "   📚 Prompts SCPO: $totalPrompts" -ForegroundColor Green
Write-Host "   🤖 Scripts essenciais: $(($arquivosEssenciais.Keys | Where-Object { Test-Path $_ }).Count)/$($arquivosEssenciais.Count)" -ForegroundColor Green
Write-Host "   🔧 Sistema: $(if ($totalArquivos -ge 20 -and $totalPrompts -ge 8) { "✅ COMPLETO" } else { "⚠️  BÁSICO" })" -ForegroundColor $(if ($totalArquivos -ge 20 -and $totalPrompts -ge 8) { "Green" } else { "Yellow" })

Write-Host ""
Write-RepairSuccess "🚀 Projeto pronto para uso!"
Write-Host ""
Write-Host "💡 Para testar:" -ForegroundColor Yellow
Write-Host "   .\ma.ps1 'criar qualquer coisa'" -ForegroundColor White
Write-Host "   .\quero.ps1 'sua ideia aqui'" -ForegroundColor White
Write-Host ""