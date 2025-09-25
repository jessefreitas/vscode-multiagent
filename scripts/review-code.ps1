# Script MultiAgent: Revisão de Código
param(
  [Parameter(Mandatory = $true)]
  [string]$FilePath,
    
  [Parameter(Mandatory = $false)]
  [switch]$Detailed = $false,
    
  [Parameter(Mandatory = $false)]
  [switch]$SaveReport = $true
)

Write-Host "🔍 MultiAgent Code Reviewer" -ForegroundColor Cyan
Write-Host "📁 Arquivo: $FilePath" -ForegroundColor Gray

# Verificar se o arquivo existe
if (-not (Test-Path $FilePath)) {
  Write-Host "❌ Arquivo não encontrado: $FilePath" -ForegroundColor Red
  exit 1
}

# Verificar se é um projeto MultiAgent
if (-not (Test-Path "multiagent.json")) {
  Write-Host "⚠️  Este não é um projeto MultiAgent, mas continuando a análise..." -ForegroundColor Yellow
  $config = @{ project = @{ type = "unknown" } }
}
else {
  $config = Get-Content "multiagent.json" | ConvertFrom-Json
}

# Criar diretório de cache se não existir
$cacheDir = ".multiagent-cache"
if (-not (Test-Path $cacheDir)) {
  New-Item -ItemType Directory -Path $cacheDir | Out-Null
}

# Gerar timestamp para sessão
$sessionId = Get-Date -Format "yyyyMMdd-HHmmss"
$reviewFile = "$cacheDir\review-$sessionId.md"

# Carregar conteúdo do arquivo
$fileContent = Get-Content $FilePath -Raw
$lines = $fileContent -split "`n"
$linesCount = $lines.Count

# Detectar linguagem do arquivo
$fileExtension = [System.IO.Path]::GetExtension($FilePath).ToLower()
$language = switch ($fileExtension) {
  ".py" { "python" }
  ".js" { "javascript" }
  ".ts" { "typescript" }
  ".cs" { "csharp" }
  ".java" { "java" }
  ".cpp" { "cpp" }
  ".c" { "c" }
  ".go" { "go" }
  ".rs" { "rust" }
  default { "unknown" }
}

Write-Host "📋 Linguagem detectada: $language" -ForegroundColor Green
Write-Host "📊 Total de linhas: $linesCount" -ForegroundColor Green

# Inicializar relatório
$report = @"
# 🔍 Relatório de Revisão MultiAgent

**Arquivo:** `$FilePath`  
**Linguagem:** $language  
**Linhas:** $linesCount  
**Sessão:** $sessionId  
**Timestamp:** $(Get-Date)  

---

## 📊 Análise Geral

"@

$issues = @()
$suggestions = @()
$positives = @()

Write-Host ""
Write-Host "🧠 Analisando estrutura do código..." -ForegroundColor Cyan

# 1. Análise de Estrutura
$structureIssues = @()

# Verificar se o arquivo está vazio
if ($linesCount -eq 0 -or [string]::IsNullOrWhiteSpace($fileContent)) {
  $structureIssues += "❌ Arquivo vazio"
}
else {
  $positives += "✅ Arquivo contém código"
}

# Análises específicas por linguagem
switch ($language) {
  "python" {
    # Verificar imports
    $imports = $lines | Where-Object { $_ -match "^\s*(import|from)\s+" }
    if ($imports.Count -gt 0) {
      $positives += "✅ Imports encontrados ($($imports.Count))"
    }
        
    # Verificar classes e funções
    $classes = $lines | Where-Object { $_ -match "^\s*class\s+" }
    $functions = $lines | Where-Object { $_ -match "^\s*def\s+" }
        
    if ($classes.Count -gt 0) {
      $positives += "✅ Classes definidas ($($classes.Count))"
    }
    if ($functions.Count -gt 0) {
      $positives += "✅ Funções definidas ($($functions.Count))"
    }
        
    # Verificar docstrings
    $docstrings = ($fileContent -split '"""').Count - 1
    if ($docstrings -gt 0) {
      $positives += "✅ Docstrings encontradas ($docstrings)"
    }
    else {
      $issues += "⚠️  Nenhuma docstring encontrada"
    }
        
    # Verificar if __name__ == "__main__"
    if ($fileContent -match "__name__\s*==\s*[`"']__main__[`"']") {
            $positives += "✅ Padrão __main__ implementado"
        } else {
            $suggestions += "💡 Considere adicionar if __name__ == '__main__'"
        }
    }
    
    "javascript" {
        # Verificar strict mode
        if ($fileContent -match "'use strict'| \"use strict\"") {
            $positives += "✅ Strict mode habilitado"
        } else {
            $suggestions += "💡 Considere adicionar 'use strict'"
        }
        
        # Verificar requires/imports
        $requires = $lines | Where-Object { $_ -match "require\( | import\s+" }
        if ($requires.Count -gt 0) {
            $positives += "✅ Imports/requires encontrados ($($requires.Count))"
        }
        
        # Verificar funções
        $functions = $lines | Where-Object { $_ -match "function\s+ | =>\s* | \.prototype\." }
        if ($functions.Count -gt 0) {
            $positives += "✅ Funções definidas ($($functions.Count))"
        }
        
        # Verificar try/catch
        $errorHandling = $lines | Where-Object { $_ -match "try\s*\ { | catch\s*\(" }
        if ($errorHandling.Count -gt 0) {
            $positives += "✅ Tratamento de erro implementado"
        } else {
            $suggestions += "💡 Considere adicionar tratamento de erros"
        }
    }
    
    "csharp" {
        # Verificar namespace
        if ($fileContent -match "namespace\s+") {
            $positives += "✅ Namespace definido"
        } else {
            $issues += "⚠️  Namespace não encontrado"
        }
        
        # Verificar classes
        $classes = $lines | Where-Object { $_ -match "class\s+" }
        if ($classes.Count -gt 0) {
            $positives += "✅ Classes definidas ($($classes.Count))"
        }
        
        # Verificar usando statements
        $usings = $lines | Where-Object { $_ -match "^\s*using\s+" }
        if ($usings.Count -gt 0) {
            $positives += "✅ Using statements ($($usings.Count))"
        }
        
        # Verificar documentação XML
        $xmlDocs = $lines | Where-Object { $_ -match "^\s*///\s*" }
        if ($xmlDocs.Count -gt 0) {
            $positives += "✅ Documentação XML encontrada"
        } else {
            $suggestions += "💡 Considere adicionar documentação XML"
        }
    }
}

Write-Host "🔍 Analisando qualidade do código..." -ForegroundColor Cyan

# 2. Análise de Qualidade
$qualityIssues = @()

# Verificar linhas muito longas (>120 caracteres)
$longLines = $lines | Where-Object { $_.Length -gt 120 }
if ($longLines.Count -gt 0) {
    $issues += "⚠️  Linhas muito longas: $($longLines.Count)"
}

# Verificar linhas vazias consecutivas
$emptyLineGroups = 0
$consecutiveEmpty = 0
foreach ($line in $lines) {
    if ([string]::IsNullOrWhiteSpace($line)) {
        $consecutiveEmpty++
    } else {
        if ($consecutiveEmpty -gt 3) {
            $emptyLineGroups++
        }
        $consecutiveEmpty = 0
    }
}
if ($emptyLineGroups -gt 0) {
    $issues += "⚠️  Muitas linhas vazias consecutivas em $emptyLineGroups locais"
}

# Verificar comentários
$commentLines = switch ($language) {
    "python" { $lines | Where-Object { $_ -match "^\s*#" } }
    "javascript" { $lines | Where-Object { $_ -match "^\s*(// | /\*)" } }
    "csharp" { $lines | Where-Object { $_ -match "^\s*(// | /\* | ///)" } }
    default { $lines | Where-Object { $_ -match "^\s*(#|//|/\*)" } }
            }

            $commentRatio = if ($linesCount -gt 0) { [math]::Round(($commentLines.Count / $linesCount) * 100, 1) } else { 0 }

            if ($commentRatio -gt 15) {
              $positives += "✅ Boa documentação ($commentRatio% comentários)"
            }
            elseif ($commentRatio -gt 5) {
              $suggestions += "💡 Documentação adequada ($commentRatio% comentários)"
            }
            else {
              $issues += "⚠️  Pouca documentação ($commentRatio% comentários)"
            }

            Write-Host "🔒 Verificando segurança..." -ForegroundColor Cyan

            # 3. Análise de Segurança
            $securityIssues = @()

            # Padrões de segurança comuns
            $securityPatterns = @{
              "Hardcoded Password" = "password\s*=\s*['\"][^'\"]+['\"]"
              "SQL Injection Risk" = "SELECT.*\+.*FROM|INSERT.*\+.*INTO"
              "Hardcoded API Key" = "(api_key|apikey|secret)\s*=\s*['\"][^'\"]{20,}['\"]"
              "Eval Usage" = "\beval\s*\("
              "Unsafe Deserialization" = "pickle\.loads|yaml\.load(?!_safe)"
            }

            foreach ($pattern in $securityPatterns.GetEnumerator()) {
              if ($fileContent -match $pattern.Value) {
                $securityIssues += "🚨 Possível $($pattern.Key) detectado"
              }
            }

            if ($securityIssues.Count -eq 0) {
              $positives += "🔒 Nenhum problema de segurança óbvio detectado"
            }

            Write-Host "🧪 Verificando padrões de teste..." -ForegroundColor Cyan

            # 4. Análise de Testes
            $testPatterns = @()

            switch ($language) {
              "python" {
                if ($fileContent -match "import\s+unittest|import\s+pytest|def\s+test_") {
                  $testPatterns += "✅ Estrutura de testes detectada"
                }
              }
              "javascript" {
                if ($fileContent -match "describe\s*\(|it\s*\(|test\s*\(|expect\s*\(") {
                  $testPatterns += "✅ Estrutura de testes detectada"
                }
              }
              "csharp" {
                if ($fileContent -match "\[Test\]|\[TestMethod\]|Assert\.") {
                  $testPatterns += "✅ Estrutura de testes detectada"
                }
              }
            }

            if ($testPatterns.Count -eq 0 -and -not ($FilePath -match "test|spec")) {
              $suggestions += "💡 Considere adicionar testes unitários"
            }

            # Análise detalhada se solicitada
            if ($Detailed) {
              Write-Host "🔬 Executando análise detalhada..." -ForegroundColor Cyan
    
              # Complexidade ciclomática básica
              $complexityKeywords = @("if", "else", "elif", "while", "for", "foreach", "switch", "case", "catch", "&&", "||")
              $complexityCount = 0
    
              foreach ($keyword in $complexityKeywords) {
                $matches = [regex]::Matches($fileContent, "\b$keyword\b", [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
                $complexityCount += $matches.Count
              }
    
              if ($complexityCount -gt 20) {
                $issues += "⚠️  Alta complexidade ($complexityCount pontos de decisão)"
              }
              elseif ($complexityCount -gt 10) {
                $suggestions += "💡 Complexidade moderada ($complexityCount pontos de decisão)"
              }
              else {
                $positives += "✅ Baixa complexidade ($complexityCount pontos de decisão)"
              }
            }

            # Compilar relatório
            $report += "`n### ✅ Pontos Positivos`n"
            if ($positives.Count -gt 0) {
              $positives | ForEach-Object { $report += "- $_`n" }
            }
            else {
              $report += "- Nenhum ponto positivo identificado`n"
            }

            $report += "`n### ⚠️ Issues Encontrados`n"
            if ($issues.Count -gt 0) {
              $issues | ForEach-Object { $report += "- $_`n" }
            }
            else {
              $report += "- Nenhum issue crítico encontrado`n"
            }

            if ($securityIssues.Count -gt 0) {
              $report += "`n### 🚨 Problemas de Segurança`n"
              $securityIssues | ForEach-Object { $report += "- $_`n" }
            }

            $report += "`n### 💡 Sugestões de Melhoria`n"
            if ($suggestions.Count -gt 0) {
              $suggestions | ForEach-Object { $report += "- $_`n" }
            }
            else {
              $report += "- Código está em boa forma, sem sugestões específicas`n"
            }

            # Pontuação geral
            $totalPoints = $positives.Count * 2 - $issues.Count - $securityIssues.Count * 2
            $maxPoints = 20
            $score = [math]::Max(0, [math]::Min(10, [math]::Round((($totalPoints + $maxPoints / 2) / $maxPoints) * 10, 1)))

            $report += "`n### 📊 Pontuação Geral: $score/10`n"

            if ($score -ge 8) {
              $report += "🎉 **Excelente qualidade de código!**`n"
            }
            elseif ($score -ge 6) {
              $report += "👍 **Boa qualidade de código**`n"
            }
            elseif ($score -ge 4) {
              $report += "⚠️ **Qualidade moderada - melhorias necessárias**`n"
            }
            else {
              $report += "🚨 **Qualidade baixa - revisão extensiva recomendada**`n"
            }

            $report += @"

---

## 🎯 Recomendações Prioritárias

1. **Imediatas**: Resolver problemas de segurança
2. **Curto prazo**: Melhorar documentação e comentários  
3. **Médio prazo**: Adicionar testes unitários
4. **Longo prazo**: Refatorar código complexo

---

*Relatório gerado pelo MultiAgent System em $(Get-Date)*
"@

            # Exibir resultado no console
            Write-Host ""
            Write-Host "📊 Resultado da Revisão" -ForegroundColor Cyan
            Write-Host "======================" -ForegroundColor Cyan
            Write-Host "Pontuação: $score/10" -ForegroundColor $(if ($score -ge 6) { 'Green' }else { 'Yellow' })
            Write-Host "Pontos Positivos: $($positives.Count)" -ForegroundColor Green
            Write-Host "Issues: $($issues.Count)" -ForegroundColor Yellow
            Write-Host "Problemas de Segurança: $($securityIssues.Count)" -ForegroundColor Red
            Write-Host "Sugestões: $($suggestions.Count)" -ForegroundColor Cyan

            # Salvar relatório se solicitado
            if ($SaveReport) {
              $report | Set-Content $reviewFile
              Write-Host ""
              Write-Host "📝 Relatório detalhado salvo em: $reviewFile" -ForegroundColor Green
              Write-Host "💡 Abra o arquivo para ver a análise completa" -ForegroundColor Cyan
            }

            Write-Host ""
            Write-Host "✅ Revisão concluída!" -ForegroundColor Green