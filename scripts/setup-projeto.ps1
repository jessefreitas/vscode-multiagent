# 🚀 Setup Automático para Projetos Novos
# =======================================
# Este script facilita a criação de novos projetos com o Agente Principal

param(
    [Parameter(Position = 0)]
    [string]$ProjectName = "",
    
    [Parameter(Position = 1)]
    [string]$ProjectType = "",
    
    [switch]$AutoGenerate = $true
)

function Write-SetupMessage {
    param([string]$Message, [string]$Icon = "🚀")
    Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Show-ProjectTypes {
    Write-Host ""
    Write-Host "🎯 TIPOS DE PROJETO DISPONÍVEIS:" -ForegroundColor Green
    Write-Host "================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "🌐 SITES & WEB APPS:" -ForegroundColor White
    Write-Host "   site-vendas      - Loja online completa" -ForegroundColor Gray
    Write-Host "   blog             - Blog responsivo" -ForegroundColor Gray
    Write-Host "   portfolio        - Site pessoal" -ForegroundColor Gray
    Write-Host "   landing-page     - Página de conversão" -ForegroundColor Gray
    Write-Host ""
    Write-Host "🔌 APIs & BACKEND:" -ForegroundColor White
    Write-Host "   api-rest         - API REST completa" -ForegroundColor Gray
    Write-Host "   backend-app      - Backend para mobile" -ForegroundColor Gray
    Write-Host "   microservice     - Microserviço" -ForegroundColor Gray
    Write-Host ""
    Write-Host "📱 APLICATIVOS:" -ForegroundColor White
    Write-Host "   app-tarefas      - Lista de tarefas" -ForegroundColor Gray
    Write-Host "   app-financeiro   - Controle financeiro" -ForegroundColor Gray
    Write-Host "   app-notas        - Bloco de notas" -ForegroundColor Gray
    Write-Host ""
    Write-Host "🏢 SISTEMAS:" -ForegroundColor White
    Write-Host "   crm              - Sistema CRM" -ForegroundColor Gray
    Write-Host "   estoque          - Controle de estoque" -ForegroundColor Gray
    Write-Host "   escola           - Sistema escolar" -ForegroundColor Gray
    Write-Host ""
}

# Se não informou nome do projeto, perguntar
if (-not $ProjectName) {
    Write-Host ""
    Write-Host "🤖 CRIADOR AUTOMÁTICO DE PROJETOS" -ForegroundColor Cyan
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host ""
    $ProjectName = Read-Host "📝 Nome do seu projeto"
    
    if (-not $ProjectName) {
        Write-Host "❌ Nome é obrigatório!" -ForegroundColor Red
        exit 1
    }
}

# Se não informou tipo, mostrar opções
if (-not $ProjectType) {
    Show-ProjectTypes
    $ProjectType = Read-Host "🎯 Que tipo de projeto você quer"
}

# Criar diretório do projeto
$projectPath = ".\$ProjectName"
if (Test-Path $projectPath) {
    Write-Host "⚠️  Pasta '$ProjectName' já existe!" -ForegroundColor Yellow
    $overwrite = Read-Host "Sobrescrever? (y/N)"
    if ($overwrite -ne "y" -and $overwrite -ne "Y") {
        exit 1
    }
    Remove-Item $projectPath -Recurse -Force
}

Write-SetupMessage "Criando projeto '$ProjectName'..." "📁"
New-Item -ItemType Directory -Path $projectPath | Out-Null
Set-Location $projectPath

# Copiar sistema MultiAgent para o projeto
Write-SetupMessage "Configurando sistema MultiAgent..." "⚙️"

# Criar estrutura básica
@"
{
  "project": {
    "name": "$ProjectName",
    "type": "$ProjectType",
    "created": "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    "version": "1.0.0",
    "multiagent": {
      "enabled": true,
      "autoMode": true,
      "scpoEnabled": true
    }
  },
  "settings": {
    "autoGenerate": true,
    "autoTest": true,
    "autoFix": true,
    "learnFromUser": true
  }
}
"@ | Set-Content "project.json"

# Copiar scripts essenciais
$sourceScripts = "$PSScriptRoot\..\scripts"
if (Test-Path $sourceScripts) {
    Write-SetupMessage "Copiando scripts MultiAgent..." "📋"
    Copy-Item "$sourceScripts\ma.ps1" "." -Force
    Copy-Item "$sourceScripts\*agent*.ps1" "." -Force -ErrorAction SilentlyContinue
}

# Copiar comando 'quero'
$sourceQuero = "$PSScriptRoot\..\quero.ps1"
if (Test-Path $sourceQuero) {
    Copy-Item $sourceQuero "." -Force
}

# Mapear tipos para comandos
$typeCommands = @{
    "site-vendas" = "uma loja online completa com carrinho de compras e pagamento"
    "blog" = "um blog responsivo com admin e comentários"
    "portfolio" = "um site de portfólio pessoal moderno"
    "landing-page" = "uma landing page de conversão otimizada"
    "api-rest" = "uma API REST completa com autenticação e CRUD"
    "backend-app" = "um backend para aplicativo mobile com API"
    "microservice" = "um microserviço escalável com Docker"
    "app-tarefas" = "um aplicativo de lista de tarefas com banco de dados"
    "app-financeiro" = "um sistema de controle financeiro pessoal"
    "app-notas" = "um aplicativo de notas e lembretes"
    "crm" = "um sistema CRM completo para gestão de clientes"
    "estoque" = "um sistema de controle de estoque com relatórios"
    "escola" = "um sistema de gestão escolar completo"
}

$command = $typeCommands[$ProjectType]
if (-not $command) {
    $command = $ProjectType
}

Write-SetupMessage "Projeto '$ProjectName' criado com sucesso!" "✅"
Write-Host ""
Write-Host "📁 Local: $(Get-Location)" -ForegroundColor Gray
Write-Host "🎯 Tipo: $ProjectType" -ForegroundColor Gray
Write-Host ""

if ($AutoGenerate) {
    Write-SetupMessage "Gerando código automaticamente..." "🤖"
    Write-Host "💭 Comando: '$command'" -ForegroundColor Yellow
    Write-Host ""
    
    # Executar geração automática
    if (Test-Path ".\quero.ps1") {
        & ".\quero.ps1" $command
    } elseif (Test-Path ".\ma.ps1") {
        & ".\ma.ps1" $command
    } else {
        Write-Host "⚠️  Scripts não encontrados. Execute manualmente:" -ForegroundColor Yellow
        Write-Host "   quero '$command'" -ForegroundColor White
    }
} else {
    Write-Host "🎯 PRÓXIMOS PASSOS:" -ForegroundColor Green
    Write-Host "==================" -ForegroundColor Green
    Write-Host ""
    Write-Host "1. Entre na pasta:" -ForegroundColor White
    Write-Host "   cd $ProjectName" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Gere seu código:" -ForegroundColor White
    Write-Host "   quero '$command'" -ForegroundColor Gray
    Write-Host ""
    Write-Host "3. Ou use comando customizado:" -ForegroundColor White
    Write-Host "   quero 'sua descrição personalizada'" -ForegroundColor Gray
    Write-Host ""
}