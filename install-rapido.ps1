# 🚀 INSTALAÇÃO RÁPIDA DO AGENTE PRINCIPAL
# ======================================
# Este script instala o Agente Principal em qualquer projeto VS Code

param(
    [switch]$Force = $false,
    [switch]$Quiet = $false
)

function Write-InstallMessage {
    param([string]$Message, [string]$Icon = "🚀")
    if (-not $Quiet) {
        Write-Host "$Icon $Message" -ForegroundColor Cyan
    }
}

function Test-ProjectSetup {
    # Verifica se já está configurado
    return (Test-Path "ma.ps1") -or (Test-Path "quero.ps1") -or (Test-Path ".vscode\tasks.json")
}

Write-InstallMessage "INSTALAÇÃO RÁPIDA - Agente Principal para VS Code" "🤖"
Write-InstallMessage "====================================================" "🤖"

# Verificar se já está instalado
if ((Test-ProjectSetup) -and (-not $Force)) {
    Write-Host ""
    Write-Host "✅ Agente Principal já está configurado neste projeto!" -ForegroundColor Green
    Write-Host ""
    Write-Host "💡 Para usar:" -ForegroundColor Cyan
    Write-Host "   quero 'sua tarefa aqui'" -ForegroundColor White
    Write-Host "   ma 'seu comando aqui'" -ForegroundColor White
    Write-Host ""
    Write-Host "🔧 Para reinstalar: .\install-rapido.ps1 -Force" -ForegroundColor Gray
    exit 0
}

Write-InstallMessage "Baixando arquivos do Agente Principal..." "📦"

# URLs dos arquivos essenciais (GitHub raw)
$baseUrl = "https://raw.githubusercontent.com/jessefreitas/vscode-multiagent/master"
$arquivosEssenciais = @{
    "ma.ps1" = "$baseUrl/scripts/ma.ps1"
    "quero.ps1" = "$baseUrl/quero.ps1"
    "super-agent.ps1" = "$baseUrl/scripts/super-agent.ps1"
    "generate-code-scpo.ps1" = "$baseUrl/scripts/generate-code-scpo.ps1"
}

# Baixar arquivos principais
foreach ($arquivo in $arquivosEssenciais.Keys) {
    try {
        Write-InstallMessage "Baixando $arquivo..." "⬇️"
        Invoke-WebRequest -Uri $arquivosEssenciais[$arquivo] -OutFile $arquivo -UseBasicParsing
        Write-InstallMessage "$arquivo baixado com sucesso!" "✅"
    } catch {
        Write-InstallMessage "Erro ao baixar $arquivo: $($_.Exception.Message)" "❌"
    }
}

# Criar pasta .vscode se não existir
if (-not (Test-Path ".vscode")) {
    New-Item -ItemType Directory -Path ".vscode" | Out-Null
    Write-InstallMessage "Pasta .vscode criada" "📁"
}

# Configurar tasks.json
$tasksJson = @"
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "😊 SUPER FÁCIL: Só me diga o que quer!",
            "type": "shell",
            "command": "pwsh", 
            "args": [
                "-Command",
                "& { Write-Host '😊 Me diga o que você quer (em linguagem normal):' -ForegroundColor Green; Write-Host 'Exemplos: quero um site, preciso de uma API, fazer um app' -ForegroundColor Gray; `$want = Read-Host 'O que você quer'; .\\quero.ps1 \"`$want\" }"
            ],
            "group": "build",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            }
        },
        {
            "label": "🤖 Agente Principal: Gerar Código",
            "type": "shell", 
            "command": "pwsh",
            "args": [
                "-Command",
                "& { `$task = Read-Host '🤖 Descreva sua tarefa (Agente interpretará automaticamente)'; .\\ma.ps1 \"`$task\" }"
            ],
            "group": "build"
        },
        {
            "label": "📊 Status do Sistema",
            "type": "shell",
            "command": "pwsh",
            "args": ["-Command", ".\\ma.ps1 status"],
            "group": "build"
        }
    ]
}
"@

$tasksJson | Set-Content ".vscode\tasks.json"
Write-InstallMessage "Tasks do VS Code configuradas" "⚙️"

# Configurar settings.json
$settingsJson = @"
{
    "// Agente Principal - Configuração Automática": "Sistema configurado para máxima produtividade",
    
    "multiagent.enabled": true,
    "multiagent.autoMode": true,
    "multiagent.learnFromUser": true,
    
    "scpo.enabled": true,
    "scpo.autoOptimize": true,
    "scpo.intelligentMode": true,
    
    "files.autoSave": "onWindowChange",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.fixAll": true
    },
    
    "terminal.integrated.defaultProfile.windows": "PowerShell",
    "terminal.integrated.profiles.windows": {
        "PowerShell": {
            "source": "PowerShell",
            "icon": "terminal-powershell"
        }
    }
}
"@

$settingsJson | Set-Content ".vscode\settings.json"
Write-InstallMessage "Configurações do VS Code aplicadas" "⚙️"

# Configurar keybindings.json (atalhos)
$keybindingsJson = @"
[
    {
        "key": "ctrl+shift+m q",
        "command": "workbench.action.terminal.sendSequence",
        "args": {
            "text": "quero \"\\u0008\" "
        },
        "when": "terminalFocus"
    },
    {
        "key": "ctrl+shift+m g",
        "command": "workbench.action.terminal.sendSequence",
        "args": {
            "text": "ma \"\\u0008\" "
        },
        "when": "terminalFocus"
    }
]
"@

$keybindingsJson | Set-Content ".vscode\keybindings.json"
Write-InstallMessage "Atalhos de teclado configurados" "⌨️"

# Criar arquivo de projeto
$projectConfig = @"
{
  "agentePrincipal": {
    "versao": "2.0",
    "instaladoEm": "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    "projeto": "$(Split-Path -Leaf (Get-Location))",
    "modoAutomatico": true,
    "paraLeigos": true
  },
  "configuracoes": {
    "autoExecutar": true,
    "autoCorrigir": true,
    "semRevisao": true,
    "linguagemNatural": true
  }
}
"@

$projectConfig | Set-Content "agente-config.json"
Write-InstallMessage "Configuração do projeto salva" "💾"

# Criar README de uso rápido
$readmeRapido = @"
# 🤖 Agente Principal Instalado!

## ✅ Instalação Concluída com Sucesso!

### 🚀 Como usar (SUPER FÁCIL):

#### No Terminal:
\`\`\`powershell
quero "um site de vendas"
quero "uma API para mobile"
ma "otimizar meu código"
\`\`\`

#### No VS Code:
- **Ctrl+Shift+P** → "SUPER FÁCIL"
- **Ctrl+Shift+M Q** → Comando rápido
- **Ctrl+Shift+P** → "Tasks: Run Task"

### 💡 Exemplos:
\`\`\`powershell
quero "adicionar sistema de login"
quero "criar banco de dados"
quero "fazer testes automatizados"
ma "documentar este código"
\`\`\`

### 🎯 Você só precisa PEDIR!
O Agente Principal faz tudo automaticamente:
- ✅ Escreve código
- ✅ Testa automaticamente  
- ✅ Corrige erros
- ✅ Otimiza performance
- ✅ Instala dependências

**É só usar! 🎉**
"@

$readmeRapido | Set-Content "COMO-USAR-AGENTE.md"

Write-Host ""
Write-Host "🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "✅ Agente Principal configurado neste projeto!" -ForegroundColor Green
Write-Host "✅ VS Code configurado com tasks e atalhos!" -ForegroundColor Green
Write-Host "✅ Pronto para usar IMEDIATAMENTE!" -ForegroundColor Green
Write-Host ""
Write-Host "🚀 TESTE AGORA:" -ForegroundColor Cyan
Write-Host "===============" -ForegroundColor Cyan
Write-Host ""
Write-Host "No terminal, digite:" -ForegroundColor White
Write-Host "   quero \"um site simples\"" -ForegroundColor Yellow
Write-Host "   ma \"otimizar este projeto\"" -ForegroundColor Yellow
Write-Host ""
Write-Host "Ou no VS Code:" -ForegroundColor White
Write-Host "   Ctrl+Shift+P → \"SUPER FÁCIL\"" -ForegroundColor Yellow
Write-Host ""
Write-Host "📖 Leia: COMO-USAR-AGENTE.md para mais detalhes" -ForegroundColor Gray
Write-Host ""
Write-Host "🤖 Agente Principal pronto para trabalhar! 🎉" -ForegroundColor Green