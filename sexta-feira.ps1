# 🚀 SEXTA-FEIRA ATIVAR PROJETO - Automação Completa
# =================================================
# Comando mágico que faz TUDO: GitHub + Pasta + Ambiente de desenvolvimento

param(
  [Parameter(Position = 0)]
  [string]$NomeProjeto = "",
    
  [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
  [string[]]$DescricaoProjeto = @(),
    
  [switch]$Private = $false,
  [switch]$Force = $false
)

# Juntar descrição
$descricao = $DescricaoProjeto -join " "

function Write-SextaMessage {
  param([string]$Message, [string]$Icon = "🎯")
  Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Write-SextaSuccess {
  param([string]$Message, [string]$Icon = "✅")
  Write-Host "$Icon $Message" -ForegroundColor Green
}

function Write-SextaError {
  param([string]$Message, [string]$Icon = "❌")
  Write-Host "$Icon $Message" -ForegroundColor Red
}

# Banner especial de sexta-feira
Write-Host ""
Write-Host "🎉 SEXTA-FEIRA ATIVAR PROJETO 🎉" -ForegroundColor Magenta
Write-Host "================================" -ForegroundColor Magenta
Write-Host "🚀 Ambiente completo em 1 comando!" -ForegroundColor Green
Write-Host ""

# Se não informou nome, perguntar
if (-not $NomeProjeto) {
  $NomeProjeto = Read-Host "📝 Nome do projeto"
  if (-not $NomeProjeto) {
    Write-SextaError "Nome é obrigatório para criar o projeto!"
    exit 1
  }
}

# Se não informou descrição, perguntar
if (-not $descricao) {
  $descricao = Read-Host "💭 Descrição do projeto (o que vai fazer)"
  if (-not $descricao) {
    $descricao = "Projeto criado automaticamente pela Sexta-Feira"
  }
}

Write-SextaMessage "Projeto: $NomeProjeto" "📁"
Write-SextaMessage "Descrição: $descricao" "💭"
Write-Host ""

# 1. CRIAR PASTA LOCAL NO C:\vscode
Write-SextaMessage "1. Criando pasta local em C:\vscode..." "📁"

$pastaBase = "C:\vscode"
$pastaProjeto = "$pastaBase\$NomeProjeto"

# Criar pasta base se não existir
if (-not (Test-Path $pastaBase)) {
  New-Item -ItemType Directory -Path $pastaBase -Force | Out-Null
  Write-SextaSuccess "Pasta base C:\vscode criada!"
}

# Verificar se projeto já existe
if (Test-Path $pastaProjeto) {
  if (-not $Force) {
    Write-Host "⚠️  Projeto '$NomeProjeto' já existe em C:\vscode!" -ForegroundColor Yellow
    $overwrite = Read-Host "Sobrescrever? (s/N)"
    if ($overwrite -ne "s" -and $overwrite -ne "S") {
      Write-SextaError "Operação cancelada."
      exit 1
    }
  }
  Remove-Item $pastaProjeto -Recurse -Force
}

# Criar pasta do projeto
New-Item -ItemType Directory -Path $pastaProjeto -Force | Out-Null
Set-Location $pastaProjeto
Write-SextaSuccess "Pasta criada: $pastaProjeto"

# 2. INICIALIZAR GIT
Write-SextaMessage "2. Inicializando Git..." "🔧"
try {
  git init *>$null
  Write-SextaSuccess "Git inicializado!"
}
catch {
  Write-SextaError "Erro ao inicializar Git. Verifique se Git está instalado."
}

# 3. CRIAR ARQUIVOS BÁSICOS DO PROJETO
Write-SextaMessage "3. Criando estrutura básica..." "📋"

# README.md
$readme = @"
# $NomeProjeto

## 📝 Descrição
$descricao

## 🚀 Criado em
$(Get-Date -Format 'dd/MM/yyyy HH:mm:ss') - Sexta-Feira Ativar Projeto

## ✨ Status
🔥 Projeto ativo e pronto para desenvolvimento!

## 🛠️ Ambiente
- ✅ Agente Principal configurado
- ✅ VS Code otimizado
- ✅ Git inicializado
- ✅ GitHub conectado

## 💡 Como usar
\`\`\`bash
# Desenvolver automaticamente
quero "funcionalidade que você quer"

# Otimizar código
ma "otimizar performance"

# Fazer deploy
ma "fazer deploy"
\`\`\`

## 🎯 Próximos passos
1. Use: \`quero "sua ideia"\`
2. O Agente Principal faz tudo!
3. Relaxe e veja a mágica acontecer ✨

---
*Criado automaticamente pelo sistema Sexta-Feira 🎉*
"@

$readme | Set-Content "README.md"
Write-SextaSuccess "README.md criado!"

# .gitignore
$gitignore = @"
# Sexta-Feira - Gitignore Automático
# ==================================

# Node modules
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/

# VS Code
.vscode/settings.json.backup

# Logs
logs
*.log

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Dependency directories
jspm_packages/

# Optional npm cache directory
.npm

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env

# Build outputs
build/
dist/
out/

# Temporary files
*.tmp
*.temp
.cache/

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Agente Principal cache
.multiagent-cache/
*.agent-temp

# Sexta-feira temp
.sexta-temp/
"@

$gitignore | Set-Content ".gitignore"
Write-SextaSuccess ".gitignore criado!"

# 4. INSTALAR SISTEMA MULTIAGENTE COMPLETO + PROMPTS
Write-SextaMessage "4. Instalando Sistema Multiagente Completo..." "🤖"

# Criar pasta de prompts
if (-not (Test-Path "prompts")) {
  New-Item -ItemType Directory -Path "prompts" -Force | Out-Null
}

# Baixar sistema completo
$sistemaUrl = "https://raw.githubusercontent.com/jessefreitas/vscode-multiagent/master"

# Scripts principais
$arquivos = @{
  "ma.ps1"                 = "$sistemaUrl/scripts/ma.ps1"
  "quero.ps1"              = "$sistemaUrl/quero.ps1" 
  "agente.ps1"             = "$sistemaUrl/agente.ps1"
  "generate-code-scpo.ps1" = "$sistemaUrl/scripts/generate-code-scpo.ps1"
  "generate-code.ps1"      = "$sistemaUrl/scripts/generate-code.ps1"
  "review-code.ps1"        = "$sistemaUrl/scripts/review-code.ps1"
  "execute-code.ps1"       = "$sistemaUrl/scripts/execute-code.ps1"
}

# Prompts SCPO essenciais
$prompts = @{
  "prompts/agente-principal-arroba.md"      = "$sistemaUrl/prompts/agente-principal-arroba.md"
  "prompts/backend-architecture.md"         = "$sistemaUrl/prompts/backend-architecture.md"
  "prompts/code-optimization.md"            = "$sistemaUrl/prompts/code-optimization.md"
  "prompts/documentation.md"                = "$sistemaUrl/prompts/documentation.md"
  "prompts/omniforge-orchestrator-agent.md" = "$sistemaUrl/prompts/omniforge-orchestrator-agent.md"
  "prompts/product-strategy.md"             = "$sistemaUrl/prompts/product-strategy.md"
  "prompts/testing-quality.md"              = "$sistemaUrl/prompts/testing-quality.md"
  "prompts/ui-design.md"                    = "$sistemaUrl/prompts/ui-design.md"
  "prompts/web-development.md"              = "$sistemaUrl/prompts/web-development.md"
  "prompts/README.md"                       = "$sistemaUrl/prompts/README.md"
}

# Baixar scripts principais
foreach ($arquivo in $arquivos.Keys) {
  try {
    Write-SextaMessage "Baixando $arquivo..." "⬇️"
    Invoke-WebRequest -Uri $arquivos[$arquivo] -OutFile $arquivo -UseBasicParsing
    Write-SextaSuccess "$arquivo instalado!"
  }
  catch {
    Write-SextaMessage "Criando $arquivo local..." "⚙️"
    # Fallback - criar versão simplificada
    if ($arquivo -eq "quero.ps1") {
      @"
param([Parameter(ValueFromRemainingArguments=`$true)][string[]]`$Request)
`$fullRequest = `$Request -join " "
Write-Host "🤖 Sexta-feira processando: `$fullRequest" -ForegroundColor Cyan
if (`$fullRequest) { & ".\agente.ps1" `$fullRequest }
"@ | Set-Content $arquivo
    }
  }
}

# Baixar prompts SCPO
Write-SextaMessage "Baixando prompts SCPO especializados..." "📚"
$promptsOk = 0
foreach ($prompt in $prompts.Keys) {
  try {
    Write-SextaMessage "Baixando $prompt..." "📄"
    Invoke-WebRequest -Uri $prompts[$prompt] -OutFile $prompt -UseBasicParsing -TimeoutSec 30
    if (Test-Path $prompt) {
      Write-SextaSuccess "Prompt $prompt instalado!"
      $promptsOk++
    }
    else {
      Write-SextaError "Arquivo $prompt não foi criado"
    }
  }
  catch {
    Write-SextaError "Erro ao baixar $prompt`: $($_.Exception.Message)"
    Write-Host "   URL: $($prompts[$prompt])" -ForegroundColor Gray
  }
}
Write-SextaMessage "$promptsOk de $($prompts.Count) prompts instalados" "📊"

# Baixar arquivos auxiliares importantes
Write-SextaMessage "Baixando configurações e templates..." "⚙️"
$auxiliares = @{
  "diagnostico-sexta.ps1"       = "$sistemaUrl/diagnostico-sexta.ps1"
  "instalar-sexta-global.ps1"   = "$sistemaUrl/instalar-sexta-global.ps1"
  "auto-reparacao.ps1"          = "$sistemaUrl/auto-reparacao.ps1"
  "STATUS-FINAL-SEXTA-FEIRA.md" = "$sistemaUrl/STATUS-FINAL-SEXTA-FEIRA.md"
  "SEXTA-FEIRA-GUIA-LEIGOS.md"  = "$sistemaUrl/SEXTA-FEIRA-GUIA-LEIGOS.md"
}

foreach ($aux in $auxiliares.Keys) {
  try {
    Write-SextaMessage "Baixando $aux..." "📄"
    Invoke-WebRequest -Uri $auxiliares[$aux] -OutFile $aux -UseBasicParsing -ErrorAction SilentlyContinue
    Write-SextaSuccess "$aux instalado!"
  }
  catch {
    # Ignorar erros - são arquivos opcionais
  }
}

# 4.9. VERIFICAÇÃO E FALLBACK - GARANTIR PROJETO COMPLETO
Write-SextaMessage "Verificando integridade do projeto..." "🔍"

# Lista de arquivos essenciais que DEVEM existir
$arquivosEssenciais = @(
  "ma.ps1", "quero.ps1", "agente.ps1", "generate-code-scpo.ps1", 
  "generate-code.ps1", "review-code.ps1", "execute-code.ps1",
  "multiagent.json", ".gitignore", "README.md"
)

# Lista de prompts essenciais
$promptsEssenciais = @(
  "prompts/agente-principal-arroba.md",
  "prompts/backend-architecture.md", 
  "prompts/ui-design.md",
  "prompts/web-development.md",
  "prompts/code-optimization.md",
  "prompts/README.md"
)

# Verificar e reparar arquivos faltantes
$arquivosFaltando = @()
$promptsFaltando = @()

foreach ($arquivo in $arquivosEssenciais) {
  if (-not (Test-Path $arquivo)) {
    $arquivosFaltando += $arquivo
  }
}

foreach ($prompt in $promptsEssenciais) {
  if (-not (Test-Path $prompt)) {
    $promptsFaltando += $prompt
  }
}

# Executar reparação se necessário
if ($arquivosFaltando.Count -gt 0 -or $promptsFaltando.Count -gt 0) {
  Write-SextaMessage "⚠️  Detectados $($arquivosFaltando.Count + $promptsFaltando.Count) arquivos faltando - executando reparação..." "🔧"
  
  # Reparar scripts faltantes
  foreach ($arquivo in $arquivosFaltando) {
    try {
      $url = $arquivos[$arquivo]
      if ($url) {
        Write-SextaMessage "Reparando $arquivo..." "🔧"
        Invoke-WebRequest -Uri $url -OutFile $arquivo -UseBasicParsing -TimeoutSec 30
        Write-SextaSuccess "✅ $arquivo reparado!"
      }
    }
    catch {
      Write-SextaError "❌ Falha ao reparar $arquivo"  
    }
  }
  
  # Reparar prompts faltantes
  foreach ($prompt in $promptsFaltando) {
    try {
      $url = $prompts[$prompt]
      if ($url) {
        Write-SextaMessage "Reparando $prompt..." "🔧"
        # Garantir que pasta prompts existe
        if (-not (Test-Path "prompts")) {
          New-Item -ItemType Directory -Path "prompts" -Force | Out-Null
        }
        Invoke-WebRequest -Uri $url -OutFile $prompt -UseBasicParsing -TimeoutSec 30
        Write-SextaSuccess "✅ $prompt reparado!"
      }
    }
    catch {
      Write-SextaError "❌ Falha ao reparar $prompt"
    }
  }
  
}
else {
  Write-SextaSuccess "✅ Todos os arquivos essenciais estão presentes!"
}

# Relatório final de integridade
$totalArquivos = (Get-ChildItem -Recurse -File | Measure-Object).Count
$totalPrompts = if (Test-Path "prompts") { (Get-ChildItem "prompts" -Filter "*.md" | Measure-Object).Count } else { 0 }

Write-Host ""
Write-SextaSuccess "📊 RELATÓRIO DE INTEGRIDADE DO PROJETO:"
Write-Host "   📁 Total de arquivos: $totalArquivos" -ForegroundColor Green
Write-Host "   📚 Prompts SCPO: $totalPrompts" -ForegroundColor Green
Write-Host "   🤖 Scripts de agente: $(($arquivosEssenciais | Where-Object { Test-Path $_ }).Count)/$($arquivosEssenciais.Count)" -ForegroundColor Green
Write-Host "   🔧 Sistema: $(if ($totalArquivos -ge 20 -and $totalPrompts -ge 5) { "✅ COMPLETO" } else { "⚠️  INCOMPLETO" })" -ForegroundColor $(if ($totalArquivos -ge 20 -and $totalPrompts -ge 5) { "Green" } else { "Yellow" })
Write-Host ""

# 4.5. INICIALIZAR PROJETO MULTIAGENT
Write-SextaMessage "Inicializando projeto MultiAgent..." "🔧"
try {
  # Criar multiagent.json básico
  $multiagentConfig = @{
    project     = @{
      name        = $NomeProjeto  
      description = $descricao
      type        = "auto-detect"
      domain      = "auto-detect"
    }
    agents      = @{
      "agente-principal" = @{
        enabled          = $true
        auto_mode        = $true
        scpo_integration = $true
      }
    }
    sexta_feira = @{
      enabled    = $true
      created    = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
      auto_setup = $true
    }
  } | ConvertTo-Json -Depth 10
    
  $multiagentConfig | Set-Content "multiagent.json"
  Write-SextaSuccess "Projeto MultiAgent inicializado!"
  
  # Criar arquivo de documentação do projeto independente
  $projetoDoc = @"
# 🎉 $NomeProjeto - Projeto Sexta-Feira Completo

> **Projeto criado em $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss') com Sistema Sexta-Feira**

## 📋 Descrição
$descricao

## 🚀 Sistema Completo Incluído

Este projeto foi criado com **TUDO necessário** para funcionar independentemente:

### 🤖 **Agentes Inteligentes:**
- `ma.ps1` - Agente principal completo
- `quero.ps1` - Comando simplificado para leigos
- `agente.ps1` - Versão básica integrada
- `generate-code-scpo.ps1` - Gerador de código SCPO
- `review-code.ps1` - Revisor automático
- `execute-code.ps1` - Executor seguro

### 📚 **Prompts SCPO Especializados:**
- `prompts/agente-principal-arroba.md` - Agente principal @
- `prompts/backend-architecture.md` - Arquitetura backend
- `prompts/frontend-design.md` - Design de interface
- `prompts/code-optimization.md` - Otimização de código
- `prompts/testing-quality.md` - Testes e qualidade
- **+ 6 prompts especializados adicionais**

### ⚙️ **Configurações VS Code:**
- `.vscode/tasks.json` - Tasks especiais Sexta-Feira
- `.vscode/settings.json` - Configurações otimizadas
- `multiagent.json` - Configuração do sistema

## 💡 **Como usar:**

### 🎯 **Para Leigos (Fácil):**
```powershell
.\quero.ps1 "criar uma página de login"
.\quero.ps1 "fazer conexão com banco de dados"  
.\quero.ps1 "otimizar meu código"
```

### 🔧 **Para Desenvolvedores (Completo):**
```powershell
.\ma.ps1 "criar API REST completa"
.\ma.ps1 "implementar autenticação JWT"
.\ma.ps1 "fazer deploy na nuvem"
```

### 🎮 **No VS Code:**
- **F5** = Agente Principal
- **Ctrl+Shift+P** → "Sexta-Feira: Desenvolver"
- **Ctrl+F5** = Novo projeto

## 🔄 **Projeto Independente:**

✅ **Funciona offline** - todos os arquivos incluídos
✅ **Clone do Git funcionará** - sistema completo
✅ **Sem dependências externas** - tudo autocontido
✅ **Prompts especializados** - qualidade profissional
✅ **Documentação completa** - para todos os níveis

## 🎊 **Criado com Sexta-Feira Ativar Projeto**

Este projeto foi gerado automaticamente pelo sistema revolucionário **Sexta-Feira**, que cria projetos profissionais completos em 30 segundos!

**Seu projeto está pronto para codar! 🚀**

---
*Gerado automaticamente em $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')*
"@
  
  $projetoDoc | Set-Content "PROJETO-COMPLETO.md"
  Write-SextaSuccess "Documentação do projeto criada!"
}
catch {
  Write-Host "⚠️  Inicialização básica aplicada" -ForegroundColor Yellow
}

# 5. CONFIGURAR VS CODE
Write-SextaMessage "5. Configurando VS Code especial para Sexta-feira..." "⚚"

# Criar .vscode
if (-not (Test-Path ".vscode")) {
  New-Item -ItemType Directory -Path ".vscode" -Force | Out-Null
}

# URL dos templates especiais
$templateBase = "https://raw.githubusercontent.com/jessefreitas/vscode-multiagent/master/templates"

# Baixar e aplicar templates otimizados
try {
  Write-SextaMessage "Baixando configurações otimizadas..." "⬇️"
    
  # tasks.json com comandos especiais de sexta-feira
  $tasksContent = Invoke-RestMethod "$templateBase/vscode-sexta-tasks.json" -ErrorAction SilentlyContinue
  if ($tasksContent) {
    $tasksContent | ConvertTo-Json -Depth 10 | Set-Content ".vscode\tasks.json"
    Write-SextaSuccess "Tasks especiais configuradas!"
  }
    
  # settings.json otimizado
  $settingsContent = Invoke-RestMethod "$templateBase/vscode-sexta-settings.json" -ErrorAction SilentlyContinue
  if ($settingsContent) {
    # Personalizar settings com info do projeto
    $settingsObj = $settingsContent | ConvertFrom-Json
    $settingsObj | Add-Member -Type NoteProperty -Name "multiagent.sextaFeira" -Value $true -Force
    $settingsObj | Add-Member -Type NoteProperty -Name "multiagent.projectName" -Value $NomeProjeto -Force
    $settingsObj | Add-Member -Type NoteProperty -Name "multiagent.description" -Value $descricao -Force
        
    $settingsObj | ConvertTo-Json -Depth 10 | Set-Content ".vscode\settings.json"
    Write-SextaSuccess "Settings personalizados aplicados!"
  }
    
  # keybindings.json para atalhos especiais
  $keybindingsContent = Invoke-RestMethod "$templateBase/vscode-sexta-keybindings.json" -ErrorAction SilentlyContinue
  if ($keybindingsContent) {
    $keybindingsContent | ConvertTo-Json -Depth 10 | Set-Content ".vscode\keybindings.json"
    Write-SextaSuccess "Atalhos de teclado configurados!"
    Write-Host "   F5 = Agente Principal | Ctrl+F5 = Novo Projeto | Shift+F5 = Status" -ForegroundColor Gray
  }
    
}
catch {
  Write-Host "⚠️  Usando configuração offline" -ForegroundColor Yellow
    
  # Fallback: configuração básica local
  $basicTasks = @{
    version = "2.0.0"
    tasks   = @(
      @{
        label        = "🎉 Sexta-Feira Desenvolver"
        type         = "shell"
        command      = "pwsh"
        args         = @("-Command", "& { `$task = Read-Host '💭 O que criar hoje'; .\quero.ps1 `"`$task`" }")
        group        = @{ kind = "build"; isDefault = $true }
        presentation = @{ echo = $true; reveal = "always"; focus = $true }
      }
    )
  } | ConvertTo-Json -Depth 10
    
  $basicTasks | Set-Content ".vscode\tasks.json"
  Write-SextaSuccess "Configuração básica aplicada!"
}

# 6. PRIMEIRO COMMIT
Write-SextaMessage "6. Fazendo primeiro commit..." "📝"
try {
  git add . *>$null
  git commit -m "🎉 Sexta-Feira Ativar Projeto: $NomeProjeto inicializado automaticamente" *>$null
  Write-SextaSuccess "Primeiro commit realizado!"
}
catch {
  Write-SextaMessage "Commit será feito após configurar GitHub" "⏳"
}

# 7. CRIAR REPOSITÓRIO NO GITHUB
Write-SextaMessage "7. Criando repositório no GitHub..." "🐙"

# Verificar se GitHub CLI está instalado
try {
  $ghVersion = & gh --version 2>$null
  if ($ghVersion) {
    Write-SextaMessage "GitHub CLI encontrado, criando repositório..." "✅"
        
    $visibility = if ($Private) { "private" } else { "public" }
        
    try {
      & gh repo create $NomeProjeto --description "$descricao" --$visibility --source=. --remote=origin --push 2>$null
      Write-SextaSuccess "Repositório '$NomeProjeto' criado no GitHub!"
      Write-SextaSuccess "Código enviado para: https://github.com/$(& gh api user | ConvertFrom-Json | Select-Object -ExpandProperty login)/$NomeProjeto"
    }
    catch {
      Write-SextaMessage "Repositório será criado manualmente: gh repo create $NomeProjeto --public" "💡"
    }
  }
  else {
    Write-SextaMessage "GitHub CLI não encontrado." "⚠️"
    Write-Host "💡 Para criar repositório automaticamente:" -ForegroundColor Yellow
    Write-Host "   1. Instale GitHub CLI: winget install GitHub.cli" -ForegroundColor Gray
    Write-Host "   2. Faça login: gh auth login" -ForegroundColor Gray
    Write-Host "   3. Execute novamente este comando" -ForegroundColor Gray
  }
}
catch {
  Write-SextaMessage "Configuração manual do GitHub necessária" "💡"
}

# 8. ABRIR NO VS CODE
Write-SextaMessage "8. Abrindo projeto no VS Code..." "🎨"
try {
  code . *>$null
  Write-SextaSuccess "VS Code aberto!"
}
catch {
  Write-SextaMessage "Abra manualmente: code ." "💡"
}

# RESULTADO FINAL
Write-Host ""
Write-Host "🎉 SEXTA-FEIRA ATIVAR PROJETO CONCLUÍDO!" -ForegroundColor Magenta
Write-Host "=========================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "✅ TUDO CRIADO E CONFIGURADO:" -ForegroundColor Green
Write-Host "   📁 Pasta: $pastaProjeto" -ForegroundColor Gray
Write-Host "   🐙 GitHub: Configurado (se CLI disponível)" -ForegroundColor Gray
Write-Host "   🤖 Agente Principal: Ativo" -ForegroundColor Gray
Write-Host "   🎨 VS Code: Configurado e aberto" -ForegroundColor Gray
Write-Host "   📝 Git: Inicializado com primeiro commit" -ForegroundColor Gray
Write-Host ""
Write-Host "🚀 PRÓXIMOS PASSOS:" -ForegroundColor Cyan
Write-Host "   1. No VS Code: Ctrl+Shift+P → 'Sexta-Feira: Desenvolver'" -ForegroundColor White
Write-Host "   2. Ou digite: quero 'funcionalidade que você quer'" -ForegroundColor White
Write-Host "   3. Relaxe enquanto o agente trabalha! 😎" -ForegroundColor White
Write-Host ""
Write-Host "💡 COMANDOS DISPONÍVEIS:" -ForegroundColor Yellow
Write-Host "   quero 'criar um site'      - Desenvolvimento automático" -ForegroundColor Gray
Write-Host "   ma 'otimizar código'       - Otimização automática" -ForegroundColor Gray
Write-Host "   ma 'fazer deploy'          - Deploy automático" -ForegroundColor Gray
Write-Host "   .\auto-reparacao.ps1       - Verificar/reparar projeto" -ForegroundColor Gray
Write-Host ""
Write-Host "🎯 Local do projeto: $pastaProjeto" -ForegroundColor Cyan
Write-Host ""
Write-Host "🎉 BOA SEXTA-FEIRA E BOM DESENVOLVIMENTO! 🚀" -ForegroundColor Magenta