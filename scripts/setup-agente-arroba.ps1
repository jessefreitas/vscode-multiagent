# 🤖 Configuração do Agente @ Principal
# Adicione ao seu perfil PowerShell ($PROFILE)

# Função para interceptar comando @
function Invoke-AgentArroba {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    
    $command = $Arguments -join " "
    
    if ([string]::IsNullOrWhiteSpace($command)) {
        Write-Host "🤖 AGENTE @ PRINCIPAL - Sistema MultiAgent + SCPO + OmniForge" -ForegroundColor Cyan
        Write-Host "💡 Use: @ 'sua tarefa aqui'" -ForegroundColor Yellow
        Write-Host "📖 Exemplos:" -ForegroundColor Green
        Write-Host "   @ 'criar API REST Python'" -ForegroundColor White
        Write-Host "   @ 'otimizar este código'" -ForegroundColor White
        Write-Host "   @ 'revisar segurança'" -ForegroundColor White
        Write-Host "   @ help  # Para mais comandos" -ForegroundColor White
        return
    }
    
    # Verificar se estamos no diretório correto
    $scriptPath = "scripts\agent-principal.ps1"
    if (!(Test-Path $scriptPath)) {
        # Tentar localizar o diretório do projeto
        $possiblePaths = @(
            "C:\vscode-multiagent-setup\scripts\agent-principal.ps1",
            ".\vscode-multiagent-setup\scripts\agent-principal.ps1",
            "..\vscode-multiagent-setup\scripts\agent-principal.ps1"
        )
        
        $foundPath = $possiblePaths | Where-Object { Test-Path $_ } | Select-Object -First 1
        
        if ($foundPath) {
            $scriptPath = $foundPath
        } else {
            Write-Host "❌ Agente @ não encontrado. Navegue até o diretório vscode-multiagent-setup" -ForegroundColor Red
            Write-Host "💡 Ou execute: cd C:\vscode-multiagent-setup" -ForegroundColor Yellow
            return
        }
    }
    
    # Executar agente principal com otimizações automáticas habilitadas
    & $scriptPath -Command $command -AutoOptimize -AutoSecurity -AutoEconomy
}

# Criar alias @ para o agente
Set-Alias -Name "@" -Value Invoke-AgentArroba -Force

# Função para setup automático
function Initialize-AgenteArroba {
    Write-Host "🔧 Configurando Agente @ Principal..." -ForegroundColor Cyan
    
    # Verificar se o alias já existe no perfil
    if (Test-Path $PROFILE) {
        $profileContent = Get-Content $PROFILE -Raw
        if ($profileContent -notmatch "Set-Alias.*@.*Invoke-AgentArroba") {
            Write-Host "📝 Adicionando ao perfil PowerShell..." -ForegroundColor Yellow
            $configContent = Get-Content $PSCommandPath -Raw
            Add-Content -Path $PROFILE -Value "`n# Agente @ Principal`n$configContent"
        }
    } else {
        Write-Host "📝 Criando perfil PowerShell..." -ForegroundColor Yellow
        New-Item -Path $PROFILE -ItemType File -Force
        $configContent = Get-Content $PSCommandPath -Raw  
        Set-Content -Path $PROFILE -Value "# Agente @ Principal`n$configContent"
    }
    
    Write-Host "✅ Agente @ configurado! Reinicie o PowerShell." -ForegroundColor Green
    Write-Host "💡 Teste com: @ 'criar API REST'" -ForegroundColor Yellow
}

# Verificar instalação automática
if ($MyInvocation.InvocationName -eq "Initialize-AgenteArroba" -or $args[0] -eq "setup") {
    Initialize-AgenteArroba
}

Write-Host "🤖 Agente @ Principal carregado! Use: @ 'sua tarefa'" -ForegroundColor Green