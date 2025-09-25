# 🔧 INTEGRAÇÃO SISTEMA ANTI-ERROS
# =================================
# Integra todos os scripts de prevenção de erros

param(
  [string]$Acao = "status"
)

function Write-IntegrationMessage {
  param([string]$Message, [string]$Icon = "🔧")
  Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Write-IntegrationSuccess {
  param([string]$Message, [string]$Icon = "✅")
  Write-Host "$Icon $Message" -ForegroundColor Green
}

function Write-IntegrationError {
  param([string]$Message, [string]$Icon = "❌")
  Write-Host "$Icon $Message" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 SISTEMA INTEGRADO ANTI-ERROS" -ForegroundColor Magenta
Write-Host "===============================" -ForegroundColor Magenta
Write-Host ""

$scriptsAntiErros = @(
  "anti-erros.ps1",
  "validacao-tempo-real.ps1",
  "gerar-codigo-seguro.ps1",
  "verificar-mcp.ps1",
  "auto-reparacao.ps1"
)

switch ($Acao.ToLower()) {
  "status" {
    Write-IntegrationMessage "Verificando status do sistema..." "🔍"
        
    foreach ($script in $scriptsAntiErros) {
      if (Test-Path $script) {
        Write-IntegrationSuccess "$script - Disponível"
      }
      else {
        Write-IntegrationError "$script - Ausente"
      }
    }
        
    # Verificar VS Code settings
    if (Test-Path ".vscode\settings.json") {
      Write-IntegrationSuccess "Configurações VS Code - OK"
    }
    else {
      Write-IntegrationError "Configurações VS Code - Ausentes"
    }
        
    # Verificar MCP Memory
    if (Test-Path "verificar-mcp.ps1") {
      Write-IntegrationMessage "Verificando MCP Memory Server..." "🧠"
      & .\verificar-mcp.ps1 -Silencioso
    }
  }
    
  "instalar" {
    Write-IntegrationMessage "Instalando sistema anti-erros..." "📦"
        
    # Criar diretório de templates se não existir
    if (-not (Test-Path "templates")) {
      New-Item -ItemType Directory -Path "templates" -Force | Out-Null
      Write-IntegrationSuccess "Diretório templates criado"
    }
        
    # Instalar extensões VS Code recomendadas
    $extensoes = @(
      "ms-python.python",
      "ms-vscode.vscode-json",
      "ms-vscode.powershell",
      "esbenp.prettier-vscode"
    )
        
    Write-IntegrationMessage "Instalando extensões VS Code..." "🧩"
    foreach ($ext in $extensoes) {
      try {
        code --install-extension $ext --force 2>$null
        Write-IntegrationSuccess "Extensão $ext instalada"
      }
      catch {
        Write-IntegrationError "Falha ao instalar $ext"
      }
    }
        
    Write-IntegrationSuccess "Sistema anti-erros instalado!"
  }
    
  "gerar" {
    Write-IntegrationMessage "Iniciando gerador de código..." "🎯"
        
    $linguagem = Read-Host "Linguagem (js/py/react)"
    if (-not $linguagem) { $linguagem = "js" }
        
    $nome = Read-Host "Nome da função/componente"
    if (-not $nome) { $nome = "MinhaFuncao" }
        
    & .\gerar-codigo-seguro.ps1 -Tipo "funcao" -Nome $nome -Linguagem $linguagem
  }
    
  "verificar" {
    Write-IntegrationMessage "Executando verificação completa..." "🔍"
        
    # Anti-erros
    if (Test-Path "anti-erros.ps1") {
      Write-IntegrationMessage "Executando anti-erros..." "🛡️"
      & .\anti-erros.ps1
    }
        
    # Validação tempo real
    if (Test-Path "validacao-tempo-real.ps1") {
      Write-IntegrationMessage "Iniciando validação tempo real..." "⏱️"
      & .\validacao-tempo-real.ps1 -Modo "once"
    }
        
    # MCP Memory
    if (Test-Path "verificar-mcp.ps1") {
      Write-IntegrationMessage "Verificando MCP Memory..." "🧠"
      & .\verificar-mcp.ps1
    }
  }
    
  "ajuda" {
    Write-Host "🔧 COMANDOS DISPONÍVEIS:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  status      - Verificar status do sistema" -ForegroundColor White
    Write-Host "  instalar    - Instalar sistema completo" -ForegroundColor White
    Write-Host "  gerar       - Gerar código seguro" -ForegroundColor White
    Write-Host "  verificar   - Executar verificação completa" -ForegroundColor White
    Write-Host "  ajuda       - Mostrar esta ajuda" -ForegroundColor White
    Write-Host ""
    Write-Host "💡 EXEMPLOS:" -ForegroundColor Cyan
    Write-Host "  .\sistema-anti-erros.ps1 status" -ForegroundColor Gray
    Write-Host "  .\sistema-anti-erros.ps1 gerar" -ForegroundColor Gray
    Write-Host "  .\sistema-anti-erros.ps1 verificar" -ForegroundColor Gray
  }
    
  default {
    Write-IntegrationError "Ação '$Acao' não reconhecida"
    Write-Host "Use: .\sistema-anti-erros.ps1 ajuda" -ForegroundColor Yellow
  }
}

Write-Host ""