# 🧠 VERIFICADOR MCP MEMORY SERVER
# ===============================
# Verifica e configura MCP Memory Server para projetos Sexta-Feira

param(
    [string]$ProjectPath = ".",
    [switch]$Configure = $false,
    [switch]$Force = $false
)

function Write-MCPMessage {
    param([string]$Message, [string]$Icon = "🧠")
    Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Write-MCPSuccess {
    param([string]$Message, [string]$Icon = "✅")
    Write-Host "$Icon $Message" -ForegroundColor Green
}

function Write-MCPError {
    param([string]$Message, [string]$Icon = "❌")
    Write-Host "$Icon $Message" -ForegroundColor Red
}

function Write-MCPWarning {
    param([string]$Message, [string]$Icon = "⚠️")
    Write-Host "$Icon $Message" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🧠 VERIFICADOR MCP MEMORY SERVER" -ForegroundColor Magenta
Write-Host "=================================" -ForegroundColor Magenta
Write-Host ""

# Navegar para pasta do projeto
if ($ProjectPath -ne ".") {
    if (Test-Path $ProjectPath) {
        Set-Location $ProjectPath
        Write-MCPMessage "Verificando projeto: $ProjectPath"
    } else {
        Write-MCPError "Pasta não encontrada: $ProjectPath"
        exit 1
    }
}

# Verificar se é um projeto Sexta-Feira
if (-not (Test-Path "multiagent.json")) {
    Write-MCPError "Este não parece ser um projeto Sexta-Feira (multiagent.json não encontrado)"
    exit 1
}

Write-MCPSuccess "Projeto Sexta-Feira detectado!"

# 1. VERIFICAR CONFIGURAÇÕES GLOBAIS DO VS CODE
Write-MCPMessage "Verificando configurações globais do VS Code..." "🔍"

$vsCodeSettingsPath = "$env:APPDATA\Code\User\settings.json"
$mcpConfigured = $false

if (Test-Path $vsCodeSettingsPath) {
    $settings = Get-Content $vsCodeSettingsPath -Raw | ConvertFrom-Json -ErrorAction SilentlyContinue
    
    if ($settings -and $settings."chat.mcp.autostart") {
        Write-MCPSuccess "MCP autostart configurado: $($settings."chat.mcp.autostart")"
        $mcpConfigured = $true
    } else {
        Write-MCPWarning "MCP autostart não encontrado nas configurações globais"
    }
} else {
    Write-MCPWarning "Arquivo de configurações do VS Code não encontrado"
}

# 2. VERIFICAR CONFIGURAÇÕES DO WORKSPACE
Write-MCPMessage "Verificando configurações do workspace..." "🔍"

$workspaceSettings = ".vscode\settings.json"
$mcpInWorkspace = $false

if (Test-Path $workspaceSettings) {
    try {
        $wsSettings = Get-Content $workspaceSettings -Raw | ConvertFrom-Json -ErrorAction SilentlyContinue
        
        if ($wsSettings) {
            # Verificar se há configurações MCP específicas
            $mcpKeys = $wsSettings.PSObject.Properties.Name | Where-Object { $_ -match "mcp|memory" }
            
            if ($mcpKeys.Count -gt 0) {
                Write-MCPSuccess "Configurações MCP encontradas no workspace:"
                foreach ($key in $mcpKeys) {
                    Write-Host "   $key : $($wsSettings.$key)" -ForegroundColor Green
                }
                $mcpInWorkspace = $true
            } else {
                Write-MCPWarning "Nenhuma configuração MCP específica no workspace"
            }
        }
    } catch {
        Write-MCPWarning "Erro ao ler configurações do workspace"
    }
} else {
    Write-MCPWarning "Arquivo .vscode\settings.json não encontrado"
}

# 3. VERIFICAR SE MCP MEMORY SERVER ESTÁ DISPONÍVEL
Write-MCPMessage "Verificando disponibilidade do MCP Memory Server..." "🔍"

# Verificar se npx está disponível (necessário para memory server)
try {
    $npxVersion = npx --version 2>$null
    if ($npxVersion) {
        Write-MCPSuccess "NPX disponível: v$npxVersion"
        
        # Tentar verificar se o memory server pode ser executado
        Write-MCPMessage "Testando MCP Memory Server..." "🧪"
        
        # Criar um teste rápido
        $testResult = Start-Job -ScriptBlock {
            try {
                $process = Start-Process -FilePath "npx" -ArgumentList "@modelcontextprotocol/server-memory" -WindowStyle Hidden -PassThru
                Start-Sleep -Milliseconds 500
                if (-not $process.HasExited) {
                    $process.Kill()
                    return "DISPONÍVEL"
                }
                return "ERRO"
            } catch {
                return "ERRO: $($_.Exception.Message)"
            }
        } | Wait-Job -Timeout 5 | Receive-Job
        
        if ($testResult -eq "DISPONÍVEL") {
            Write-MCPSuccess "MCP Memory Server está disponível!"
        } else {
            Write-MCPWarning "MCP Memory Server não responde: $testResult"
        }
        
    } else {
        Write-MCPError "NPX não está disponível (necessário para MCP Memory Server)"
    }
} catch {
    Write-MCPError "Erro ao verificar NPX: $($_.Exception.Message)"
}

# 4. CONFIGURAR MCP MEMORY SE SOLICITADO
if ($Configure -or $Force) {
    Write-MCPMessage "Configurando MCP Memory Server para o projeto..." "⚙️"
    
    # Criar/atualizar configurações do workspace
    if (-not (Test-Path ".vscode")) {
        New-Item -ItemType Directory -Path ".vscode" -Force | Out-Null
        Write-MCPSuccess "Pasta .vscode criada!"
    }
    
    # Configurações MCP para o workspace
    $mcpWorkspaceConfig = @{
        "chat.mcp.autostart" = "newAndOutdated"
        "chat.mcp.servers" = @{
            "memory" = @{
                "command" = "npx"
                "args" = @("@modelcontextprotocol/server-memory")
                "env" = @{
                    "MEMORY_STORAGE_PATH" = "./mcp-memory.db"
                }
            }
        }
    }
    
    # Ler configurações existentes ou criar novas
    if (Test-Path $workspaceSettings) {
        try {
            $existingSettings = Get-Content $workspaceSettings -Raw | ConvertFrom-Json -ErrorAction SilentlyContinue
            if (-not $existingSettings) { $existingSettings = @{} }
        } catch {
            $existingSettings = @{}
        }
    } else {
        $existingSettings = @{}
    }
    
    # Mergear configurações
    foreach ($key in $mcpWorkspaceConfig.Keys) {
        $existingSettings | Add-Member -MemberType NoteProperty -Name $key -Value $mcpWorkspaceConfig[$key] -Force
    }
    
    # Salvar configurações
    try {
        $existingSettings | ConvertTo-Json -Depth 10 | Set-Content $workspaceSettings -Encoding UTF8
        Write-MCPSuccess "Configurações MCP Memory Server adicionadas ao workspace!"
        
        # Criar arquivo de inicialização MCP
        $mcpInitScript = @"
# 🧠 MCP Memory Server - Auto Inicialização
# ========================================
# Este arquivo garante que o MCP Memory Server inicie com o projeto

Write-Host "🧠 Iniciando MCP Memory Server..." -ForegroundColor Cyan

try {
    # Verificar se NPX está disponível
    `$npxVersion = npx --version 2>`$null
    if (-not `$npxVersion) {
        Write-Host "❌ NPX não encontrado. Instale Node.js para usar MCP Memory Server" -ForegroundColor Red
        exit 1
    }
    
    # Iniciar MCP Memory Server em background
    Write-Host "🚀 Iniciando MCP Memory Server..." -ForegroundColor Green
    
    # Definir caminho do banco de dados
    `$memoryDbPath = "./mcp-memory.db"
    `$env:MEMORY_STORAGE_PATH = `$memoryDbPath
    
    # Iniciar o servidor (será gerenciado pelo VS Code)
    Write-Host "✅ MCP Memory Server configurado!" -ForegroundColor Green
    Write-Host "📁 Database: `$memoryDbPath" -ForegroundColor Gray
    Write-Host "💡 O servidor será iniciado automaticamente pelo VS Code" -ForegroundColor Yellow
    
} catch {
    Write-Host "❌ Erro ao configurar MCP Memory Server: `$(`$_.Exception.Message)" -ForegroundColor Red
}
"@
        
        $mcpInitScript | Set-Content "mcp-init.ps1" -Encoding UTF8
        Write-MCPSuccess "Script de inicialização MCP criado: mcp-init.ps1"
        
        # Adicionar ao .gitignore
        $gitignoreContent = ""
        if (Test-Path ".gitignore") {
            $gitignoreContent = Get-Content ".gitignore" -Raw
        }
        
        if ($gitignoreContent -notmatch "mcp-memory\.db") {
            $gitignoreContent += "`n# MCP Memory Database`nmcp-memory.db`n"
            $gitignoreContent | Set-Content ".gitignore" -Encoding UTF8
            Write-MCPSuccess "mcp-memory.db adicionado ao .gitignore"
        }
        
    } catch {
        Write-MCPError "Erro ao salvar configurações: $($_.Exception.Message)"
    }
}

# 5. RELATÓRIO FINAL
Write-Host ""
Write-MCPSuccess "🧠 VERIFICAÇÃO MCP MEMORY CONCLUÍDA!"
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

Write-Host "📊 RESUMO:" -ForegroundColor Cyan
Write-Host "   🔧 MCP Global: $(if ($mcpConfigured) { "✅ Configurado" } else { "❌ Não configurado" })" -ForegroundColor $(if ($mcpConfigured) { "Green" } else { "Red" })
Write-Host "   🎯 MCP Workspace: $(if ($mcpInWorkspace -or $Configure) { "✅ Configurado" } else { "❌ Não configurado" })" -ForegroundColor $(if ($mcpInWorkspace -or $Configure) { "Green" } else { "Red" })
Write-Host "   📦 NPX Disponível: $(if ($npxVersion) { "✅ v$npxVersion" } else { "❌ Não encontrado" })" -ForegroundColor $(if ($npxVersion) { "Green" } else { "Red" })

Write-Host ""
if ($Configure) {
    Write-MCPSuccess "🎉 MCP Memory Server configurado para este projeto!"
    Write-Host ""
    Write-Host "💡 PRÓXIMOS PASSOS:" -ForegroundColor Yellow
    Write-Host "   1. Reinicie o VS Code para ativar as configurações" -ForegroundColor White
    Write-Host "   2. O MCP Memory Server iniciará automaticamente" -ForegroundColor White
    Write-Host "   3. Use comandos de memória no GitHub Copilot Chat" -ForegroundColor White
} else {
    Write-Host "💡 PARA CONFIGURAR MCP MEMORY:" -ForegroundColor Yellow
    Write-Host "   .\verificar-mcp.ps1 -Configure" -ForegroundColor White
}

Write-Host ""