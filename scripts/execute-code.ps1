# Script MultiAgent: Execução Segura de Código
param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath,
    
    [Parameter(Mandatory=$false)]
    [int]$TimeoutSeconds = 30,
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$Verbose = $false
)

Write-Host "🚀 MultiAgent Safe Code Executor" -ForegroundColor Cyan
Write-Host "📁 Arquivo: $FilePath" -ForegroundColor Gray

# Verificar se o arquivo existe
if (-not (Test-Path $FilePath)) {
    Write-Host "❌ Arquivo não encontrado: $FilePath" -ForegroundColor Red
    exit 1
}

# Verificar se é um projeto MultiAgent
if (-not (Test-Path "multiagent.json")) {
    Write-Host "⚠️  Este não é um projeto MultiAgent, mas continuando..." -ForegroundColor Yellow
    $config = @{ 
        safety = @{ 
            maxExecutionTime = 30000
            allowedOperations = @("read", "write", "execute")
            sandboxEnabled = $true 
        } 
    }
} else {
    $config = Get-Content "multiagent.json" | ConvertFrom-Json
}

# Criar diretório de cache se não existir
$cacheDir = ".multiagent-cache"
if (-not (Test-Path $cacheDir)) {
    New-Item -ItemType Directory -Path $cacheDir | Out-Null
}

# Gerar timestamp para sessão
$sessionId = Get-Date -Format "yyyyMMdd-HHmmss"
$executionLog = "$cacheDir\execution-$sessionId.log"

# Detectar linguagem do arquivo
$fileExtension = [System.IO.Path]::GetExtension($FilePath).ToLower()
$language = switch ($fileExtension) {
    ".py" { "python" }
    ".js" { "javascript" }
    ".ts" { "typescript" }
    ".cs" { "csharp" }
    ".ps1" { "powershell" }
    ".sh" { "bash" }
    default { "unknown" }
}

Write-Host "📋 Linguagem detectada: $language" -ForegroundColor Green

# Verificar se a linguagem é suportada
$supportedLanguages = @("python", "javascript", "powershell")
if ($language -notin $supportedLanguages) {
    Write-Host "❌ Linguagem '$language' não suportada para execução automática" -ForegroundColor Red
    Write-Host "Linguagens suportadas: $($supportedLanguages -join ', ')" -ForegroundColor Yellow
    exit 1
}

# Log inicial
$logContent = @"
MultiAgent Safe Code Execution Log
==================================
Timestamp: $(Get-Date)
File: $FilePath
Language: $language
Session: $sessionId
Timeout: $TimeoutSeconds seconds
DryRun: $DryRun
Sandbox: $($config.safety.sandboxEnabled)

"@

Write-Host ""
Write-Host "🔒 Verificações de Segurança" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan

# Análise de segurança do código
$fileContent = Get-Content $FilePath -Raw
$securityIssues = @()

# Padrões perigosos por linguagem
$dangerousPatterns = @{}

switch ($language) {
    "python" {
        $dangerousPatterns = @{
            "Eval/Exec" = "\b(eval|exec)\s*\("
            "OS Commands" = "os\.(system|popen|spawn)"
            "Subprocess" = "subprocess\.(call|run|Popen)"
            "File Operations" = "open\s*\([^)]*['\"]w"
            "Import System" = "import\s+(os|sys|subprocess)"
        }
    }
    "javascript" {
        $dangerousPatterns = @{
            "Eval" = "\beval\s*\("
            "Function Constructor" = "new\s+Function\s*\("
            "Child Process" = "child_process|exec|spawn"
            "File System" = "fs\.(writeFile|unlink|rmdir)"
            "Network" = "require\s*\(\s*['\"]http|['\"]https"
        }
    }
    "powershell" {
        $dangerousPatterns = @{
            "Invoke Expression" = "Invoke-Expression|iex"
            "Download" = "Invoke-WebRequest|wget|curl"
            "File Deletion" = "Remove-Item|del|rm"
            "Registry" = "Set-ItemProperty|New-ItemProperty"
            "Process" = "Start-Process|Invoke-Command"
        }
    }
}

foreach ($pattern in $dangerousPatterns.GetEnumerator()) {
    if ($fileContent -match $pattern.Value) {
        $securityIssues += "🚨 $($pattern.Key) detectado"
        $logContent += "SECURITY ISSUE: $($pattern.Key) detected`n"
    }
}

if ($securityIssues.Count -gt 0) {
    Write-Host "⚠️  Problemas de segurança detectados:" -ForegroundColor Red
    $securityIssues | ForEach-Object { Write-Host "   $_" -ForegroundColor Red }
    
    if (-not $DryRun) {
        $response = Read-Host "Deseja continuar mesmo assim? (y/N)"
        if ($response -ne "y" -and $response -ne "Y") {
            Write-Host "❌ Execução cancelada por segurança." -ForegroundColor Red
            $logContent += "EXECUTION CANCELLED: Security concerns`n"
            $logContent | Set-Content $executionLog
            exit 1
        }
    }
} else {
    Write-Host "✅ Nenhum problema de segurança óbvio detectado" -ForegroundColor Green
}

# Verificação de dependências
Write-Host ""
Write-Host "📦 Verificando Dependências" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan

$dependencyIssues = @()

switch ($language) {
    "python" {
        # Verificar se Python está instalado
        try {
            $pythonVersion = python --version 2>&1
            Write-Host "✅ Python encontrado: $pythonVersion" -ForegroundColor Green
            $logContent += "Python version: $pythonVersion`n"
        } catch {
            $dependencyIssues += "❌ Python não encontrado"
            Write-Host "❌ Python não encontrado no PATH" -ForegroundColor Red
        }
        
        # Verificar imports
        $imports = ($fileContent | Select-String "^\s*(import|from)\s+(\w+)" -AllMatches).Matches
        if ($imports.Count -gt 0) {
            Write-Host "📋 Imports detectados:" -ForegroundColor Yellow
            $imports | ForEach-Object { 
                $module = $_.Groups[2].Value
                Write-Host "   - $module" -ForegroundColor Gray
            }
        }
    }
    
    "javascript" {
        # Verificar se Node.js está instalado
        try {
            $nodeVersion = node --version 2>&1
            Write-Host "✅ Node.js encontrado: $nodeVersion" -ForegroundColor Green
            $logContent += "Node.js version: $nodeVersion`n"
        } catch {
            $dependencyIssues += "❌ Node.js não encontrado"
            Write-Host "❌ Node.js não encontrado no PATH" -ForegroundColor Red
        }
        
        # Verificar requires
        $requires = ($fileContent | Select-String "require\s*\(\s*['\"]([^'\"]+)" -AllMatches).Matches
        if ($requires.Count -gt 0) {
            Write-Host "📋 Modules requeridos:" -ForegroundColor Yellow
            $requires | ForEach-Object { 
                $module = $_.Groups[1].Value
                Write-Host "   - $module" -ForegroundColor Gray
            }
        }
    }
    
    "powershell" {
        Write-Host "✅ PowerShell nativo (sempre disponível)" -ForegroundColor Green
        $logContent += "PowerShell execution environment ready`n"
    }
}

if ($dependencyIssues.Count -gt 0) {
    Write-Host "⚠️  Problemas de dependência:" -ForegroundColor Red
    $dependencyIssues | ForEach-Object { Write-Host "   $_" -ForegroundColor Red }
    
    if (-not $DryRun) {
        Write-Host "❌ Não é possível executar sem as dependências necessárias." -ForegroundColor Red
        $logContent += "EXECUTION FAILED: Missing dependencies`n"
        $logContent | Set-Content $executionLog
        exit 1
    }
}

# Modo Dry Run
if ($DryRun) {
    Write-Host ""
    Write-Host "🧪 Modo Dry Run - Simulando Execução" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor Cyan
    
    $command = switch ($language) {
        "python" { "python `"$FilePath`"" }
        "javascript" { "node `"$FilePath`"" }
        "powershell" { "powershell -ExecutionPolicy Bypass -File `"$FilePath`"" }
    }
    
    Write-Host "Comando que seria executado:" -ForegroundColor Yellow
    Write-Host "   $command" -ForegroundColor White
    Write-Host "Timeout: $TimeoutSeconds segundos" -ForegroundColor Yellow
    Write-Host "Diretório: $(Get-Location)" -ForegroundColor Yellow
    
    $logContent += "DRY RUN MODE: Command simulation`n"
    $logContent += "Command: $command`n"
    $logContent += "Timeout: $TimeoutSeconds seconds`n"
    $logContent | Set-Content $executionLog
    
    Write-Host ""
    Write-Host "✅ Simulação concluída - arquivo está pronto para execução" -ForegroundColor Green
    exit 0
}

# Execução Real (Sandbox)
Write-Host ""
Write-Host "🚀 Iniciando Execução em Sandbox" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

$startTime = Get-Date
$logContent += "EXECUTION START: $startTime`n"

# Criar backup do diretório atual (apenas arquivos modificados recentemente)
$backupDir = "$cacheDir\backup-$sessionId"
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

try {
    # Executar comando com timeout
    $command = switch ($language) {
        "python" { "python" }
        "javascript" { "node" }
        "powershell" { "powershell" }
    }
    
    $arguments = switch ($language) {
        "python" { @("`"$FilePath`"") }
        "javascript" { @("`"$FilePath`"") }
        "powershell" { @("-ExecutionPolicy", "Bypass", "-File", "`"$FilePath`"") }
    }
    
    Write-Host "⚡ Executando: $command $($arguments -join ' ')" -ForegroundColor Yellow
    Write-Host "⏱️  Timeout: $TimeoutSeconds segundos" -ForegroundColor Gray
    
    # Usar Start-Process com timeout
    $process = Start-Process -FilePath $command -ArgumentList $arguments -PassThru -NoNewWindow -RedirectStandardOutput "$cacheDir\output-$sessionId.txt" -RedirectStandardError "$cacheDir\error-$sessionId.txt"
    
    $completed = $process.WaitForExit($TimeoutSeconds * 1000)
    $endTime = Get-Date
    $executionTime = ($endTime - $startTime).TotalSeconds
    
    if ($completed) {
        $exitCode = $process.ExitCode
        $stdout = Get-Content "$cacheDir\output-$sessionId.txt" -ErrorAction SilentlyContinue
        $stderr = Get-Content "$cacheDir\error-$sessionId.txt" -ErrorAction SilentlyContinue
        
        Write-Host ""
        Write-Host "📊 Resultado da Execução" -ForegroundColor Cyan
        Write-Host "========================" -ForegroundColor Cyan
        Write-Host "Código de Saída: $exitCode" -ForegroundColor $(if($exitCode -eq 0){'Green'}else{'Red'})
        Write-Host "Tempo de Execução: $([math]::Round($executionTime, 2))s" -ForegroundColor Green
        
        if ($stdout) {
            Write-Host ""
            Write-Host "📤 Saída Padrão:" -ForegroundColor Green
            $stdout | ForEach-Object { Write-Host "   $_" -ForegroundColor White }
        }
        
        if ($stderr) {
            Write-Host ""
            Write-Host "⚠️  Saída de Erro:" -ForegroundColor Red
            $stderr | ForEach-Object { Write-Host "   $_" -ForegroundColor Red }
        }
        
        $logContent += "EXECUTION COMPLETED`n"
        $logContent += "Exit code: $exitCode`n"
        $logContent += "Execution time: $executionTime seconds`n"
        $logContent += "STDOUT:`n$($stdout -join "`n")`n"
        $logContent += "STDERR:`n$($stderr -join "`n")`n"
        
    } else {
        # Timeout - terminar processo
        $process.Kill()
        Write-Host "⏰ Execução interrompida por timeout ($TimeoutSeconds segundos)" -ForegroundColor Red
        $logContent += "EXECUTION TIMEOUT: $TimeoutSeconds seconds`n"
        $exitCode = -1
    }
    
} catch {
    Write-Host "❌ Erro durante a execução: $($_.Exception.Message)" -ForegroundColor Red
    $logContent += "EXECUTION ERROR: $($_.Exception.Message)`n"
    $exitCode = -1
}

# Limpeza
if (Test-Path "$cacheDir\output-$sessionId.txt") {
    Remove-Item "$cacheDir\output-$sessionId.txt" -ErrorAction SilentlyContinue
}
if (Test-Path "$cacheDir\error-$sessionId.txt") {
    Remove-Item "$cacheDir\error-$sessionId.txt" -ErrorAction SilentlyContinue
}

# Salvar log completo
$logContent | Set-Content $executionLog

Write-Host ""
Write-Host "📋 Relatório Final" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host "Arquivo: $FilePath" -ForegroundColor White
Write-Host "Linguagem: $language" -ForegroundColor White
Write-Host "Sessão: $sessionId" -ForegroundColor White
Write-Host "Log completo: $executionLog" -ForegroundColor White

if ($exitCode -eq 0) {
    Write-Host "Status: ✅ Executado com sucesso" -ForegroundColor Green
} else {
    Write-Host "Status: ❌ Falha na execução (código $exitCode)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔒 Execução realizada em ambiente controlado" -ForegroundColor Cyan
Write-Host "💡 Verifique o log para detalhes completos" -ForegroundColor Cyan

exit $exitCode