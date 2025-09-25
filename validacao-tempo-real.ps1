# 🔄 VALIDAÇÃO EM TEMPO REAL - SISTEMA SEXTA-FEIRA
# ================================================
# Monitora e valida código enquanto você programa

param(
    [string]$ProjectPath = ".",
    [switch]$StartMonitoring = $false,
    [int]$IntervalSeconds = 30
)

function Write-ValidatorMessage {
    param([string]$Message, [string]$Icon = "🔄")
    Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Write-ValidatorSuccess {
    param([string]$Message, [string]$Icon = "✅")
    Write-Host "$Icon $Message" -ForegroundColor Green
}

function Write-ValidatorWarning {
    param([string]$Message, [string]$Icon = "⚠️")
    Write-Host "$Icon $Message" -ForegroundColor Yellow
}

function Write-ValidatorError {
    param([string]$Message, [string]$Icon = "❌")
    Write-Host "$Icon $Message" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔄 VALIDAÇÃO EM TEMPO REAL SEXTA-FEIRA" -ForegroundColor Magenta
Write-Host "=======================================" -ForegroundColor Magenta
Write-Host ""

# Navegar para pasta do projeto
if ($ProjectPath -ne ".") {
    if (Test-Path $ProjectPath) {
        Set-Location $ProjectPath
        Write-ValidatorMessage "Monitorando projeto: $ProjectPath"
    } else {
        Write-ValidatorError "Pasta não encontrada: $ProjectPath"
        exit 1
    }
}

# Função para validar arquivo individual
function Test-CodeFile {
    param([string]$FilePath)
    
    $issues = @()
    $content = Get-Content $FilePath -Raw -ErrorAction SilentlyContinue
    if (-not $content) { return $issues }
    
    $fileName = Split-Path -Leaf $FilePath
    $extension = [System.IO.Path]::GetExtension($FilePath)
    
    # Validações por tipo de arquivo
    switch ($extension) {
        ".js" {
            # JavaScript validations
            if ($content -notmatch "use strict") {
                $issues += "⚠️ ${fileName}: Considere usar 'use strict'"
            }
            
            if ($content -match "var\s+" -and $content -notmatch "let\s+|const\s+") {
                $issues += "💡 ${fileName}: Prefira 'let' ou 'const' ao invés de 'var'"
            }
            
            if ($content -match "==\s*[^=]" -and $content -notmatch "===") {
                $issues += "⚠️ ${fileName}: Use '===' ao invés de '=='"
            }
        }
        
        ".py" {
            # Python validations
            if ($content -notmatch "#!/usr/bin/env python|# -*- coding:") {
                $issues += "💡 ${fileName}: Adicione shebang e encoding"
            }
            
            if ($content -match "print\(" -and $content -notmatch "logging|logger") {
                $issues += "⚠️ ${fileName}: Use logging ao invés de print"
            }
            
            # Verificar imports organizados
            $lines = $content -split "`n"
            $importLines = $lines | Where-Object { $_ -match "^import\s|^from\s" }
            if ($importLines.Count -gt 5 -and $content -notmatch "# Imports organizados") {
                $issues += "💡 ${fileName}: Organize imports por grupo"
            }
        }
        
        ".cs" {
            # C# validations
            if ($content -notmatch "namespace\s+") {
                $issues += "❌ ${fileName}: Namespace obrigatório em C#"
            }
            
            if ($content -match "public\s+class" -and $content -notmatch "/// <summary>") {
                $issues += "💡 ${fileName}: Adicione documentação XML"
            }
        }
        
        ".ts" {
            # TypeScript validations
            if ($content -match "any\s+" -and ($content | Select-String "any").Matches.Count -gt 2) {
                $issues += "⚠️ ${fileName}: Muitos tipos 'any' - seja mais específico"
            }
            
            if ($content -notmatch "interface\s+|type\s+" -and $content -match "function.*\{") {
                $issues += "💡 ${fileName}: Defina interfaces para parâmetros complexos"
            }
        }
    }
    
    # Validações gerais para todos os arquivos
    
    # Linhas muito longas
    $longLines = ($content -split "`n") | Where-Object { $_.Length -gt 120 }
    if ($longLines.Count -gt 0) {
        $issues += "💡 ${fileName}: $($longLines.Count) linhas muito longas (>120 chars)"
    }
    
    # Funções muito grandes
    $functionMatches = [regex]::Matches($content, "function\s+\w+|def\s+\w+|public\s+\w+\s+\w+\s*\(")
    foreach ($match in $functionMatches) {
        $functionStart = $match.Index
        $functionContent = $content.Substring($functionStart, [Math]::Min(2000, $content.Length - $functionStart))
        $functionLines = ($functionContent -split "`n").Count
        
        if ($functionLines -gt 30) {
            $issues += "⚠️ ${fileName}: Função muito longa ($functionLines linhas)"
        }
    }
    
    # Comentários TODO/FIXME/HACK
    if ($content -match "TODO|FIXME|HACK|XXX") {
        $todoCount = ($content | Select-String "TODO|FIXME|HACK|XXX").Matches.Count
        $issues += "💡 ${fileName}: $todoCount comentários pendentes (TODO/FIXME)"
    }
    
    return $issues
}

# Função para validar todo o projeto
function Test-Project {
    $allIssues = @()
    $fileCount = 0
    
    # Buscar arquivos de código
    $codeFiles = Get-ChildItem -Recurse -Include "*.js", "*.py", "*.cs", "*.java", "*.php", "*.ts", "*.go", "*.cpp" -ErrorAction SilentlyContinue
    
    foreach ($file in $codeFiles) {
        if ($file.FullName -like "*node_modules*" -or $file.FullName -like "*__pycache__*") {
            continue
        }
        
        $fileIssues = Test-CodeFile $file.FullName
        $allIssues += $fileIssues
        $fileCount++
        
        if ($fileIssues.Count -eq 0) {
            Write-ValidatorSuccess "$($file.Name) ✓"
        } else {
            Write-ValidatorWarning "$($file.Name) ($($fileIssues.Count) issues)"
        }
    }
    
    return @{
        Issues = $allIssues
        FileCount = $fileCount
    }
}

# Configurar monitoramento em tempo real
if ($StartMonitoring) {
    Write-ValidatorMessage "Iniciando monitoramento em tempo real (intervalo: ${IntervalSeconds}s)..." "👁️"
    
    # Criar arquivo de configuração do monitor
    $monitorConfig = @{
        enabled = $true
        interval = $IntervalSeconds
        lastCheck = Get-Date
        totalChecks = 0
        issuesFound = 0
    }
    
    $monitorConfig | ConvertTo-Json | Set-Content ".validator-config.json"
    
    Write-ValidatorSuccess "Monitor configurado! Pressione Ctrl+C para parar."
    
    try {
        while ($true) {
            Clear-Host
            Write-Host "🔄 MONITOR ATIVO - $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Green
            Write-Host "=================================" -ForegroundColor Green
            Write-Host ""
            
            $result = Test-Project
            
            Write-Host ""
            Write-Host "📊 RESUMO:" -ForegroundColor Cyan
            Write-Host "   📁 Arquivos: $($result.FileCount)" -ForegroundColor Gray
            Write-Host "   ⚠️  Issues: $($result.Issues.Count)" -ForegroundColor $(if ($result.Issues.Count -eq 0) { "Green" } else { "Yellow" })
            
            if ($result.Issues.Count -gt 0) {
                Write-Host ""
                Write-Host "🔍 ISSUES ENCONTRADOS:" -ForegroundColor Yellow
                foreach ($issue in $result.Issues | Select-Object -First 10) {
                    Write-Host "   $issue" -ForegroundColor Yellow
                }
                
                if ($result.Issues.Count -gt 10) {
                    Write-Host "   ... e mais $($result.Issues.Count - 10) issues" -ForegroundColor Gray
                }
            }
            
            Write-Host ""
            Write-Host "⏱️  Próxima verificação em ${IntervalSeconds}s..." -ForegroundColor Gray
            
            # Atualizar estatísticas
            $monitorConfig.totalChecks++
            $monitorConfig.issuesFound = $result.Issues.Count
            $monitorConfig.lastCheck = Get-Date
            $monitorConfig | ConvertTo-Json | Set-Content ".validator-config.json"
            
            Start-Sleep -Seconds $IntervalSeconds
        }
    } catch {
        Write-ValidatorMessage "Monitor interrompido pelo usuário"
    }
} else {
    # Execução única
    Write-ValidatorMessage "Executando validação única..." "🔍"
    
    $result = Test-Project
    
    Write-Host ""
    Write-ValidatorSuccess "🔍 VALIDAÇÃO CONCLUÍDA!"
    Write-Host "========================" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "📊 RESUMO:" -ForegroundColor Cyan
    Write-Host "   📁 Arquivos analisados: $($result.FileCount)" -ForegroundColor Gray
    Write-Host "   ⚠️  Issues encontrados: $($result.Issues.Count)" -ForegroundColor $(if ($result.Issues.Count -eq 0) { "Green" } else { "Yellow" })
    
    if ($result.Issues.Count -gt 0) {
        Write-Host ""
        Write-Host "🔍 DETALHES:" -ForegroundColor Yellow
        foreach ($issue in $result.Issues) {
            Write-Host "   $issue" -ForegroundColor Yellow
        }
    }
    
    # Calcular score de qualidade
    $qualityScore = [Math]::Max(0, 100 - ($result.Issues.Count * 2))
    $qualityLevel = switch ($qualityScore) {
        { $_ -ge 95 } { "🏆 PERFEITO"; "Green" }
        { $_ -ge 85 } { "✅ EXCELENTE"; "Green" }
        { $_ -ge 70 } { "👍 BOM"; "Green" }
        { $_ -ge 50 } { "⚠️ REGULAR"; "Yellow" }
        default { "❌ PRECISA MELHORAR"; "Red" }
    }
    
    Write-Host ""
    Write-Host "🎯 QUALIDADE: $($qualityLevel[0]) ($qualityScore/100)" -ForegroundColor $qualityLevel[1]
    
    Write-Host ""
    Write-Host "💡 COMANDOS:" -ForegroundColor Yellow
    Write-Host "   .\validacao-tempo-real.ps1 -StartMonitoring    # Monitor contínuo" -ForegroundColor White
    Write-Host "   .\anti-erros.ps1 -AutoFix                     # Corrigir issues" -ForegroundColor White
}

Write-Host ""