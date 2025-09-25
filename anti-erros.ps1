# 🛡️ SISTEMA ANTI-ERROS - MELHORIAS SEXTA-FEIRA
# ===============================================
# Detecta, previne e corrige erros automaticamente

param(
  [string]$ProjectPath = ".",
  [switch]$AutoFix = $false,
  [switch]$PreventiveMode = $false,
  [switch]$DeepAnalysis = $false
)

function Write-AntiErrorMessage {
  param([string]$Message, [string]$Icon = "🛡️")
  Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Write-AntiErrorSuccess {
  param([string]$Message, [string]$Icon = "✅")
  Write-Host "$Icon $Message" -ForegroundColor Green
}

function Write-AntiErrorWarning {
  param([string]$Message, [string]$Icon = "⚠️")
  Write-Host "$Icon $Message" -ForegroundColor Yellow
}

function Write-AntiErrorError {
  param([string]$Message, [string]$Icon = "❌")
  Write-Host "$Icon $Message" -ForegroundColor Red
}

function Write-AntiErrorFix {
  param([string]$Message, [string]$Icon = "🔧")
  Write-Host "$Icon $Message" -ForegroundColor Magenta
}

Write-Host ""
Write-Host "🛡️ SISTEMA ANTI-ERROS SEXTA-FEIRA" -ForegroundColor Magenta
Write-Host "===================================" -ForegroundColor Magenta
Write-Host ""

# Navegar para pasta do projeto
if ($ProjectPath -ne ".") {
  if (Test-Path $ProjectPath) {
    Set-Location $ProjectPath
    Write-AntiErrorMessage "Analisando projeto: $ProjectPath"
  }
  else {
    Write-AntiErrorError "Pasta não encontrada: $ProjectPath"
    exit 1
  }
}

# Verificar se é um projeto Sexta-Feira
if (-not (Test-Path "multiagent.json")) {
  Write-AntiErrorError "Este não parece ser um projeto Sexta-Feira"
  exit 1
}

Write-AntiErrorSuccess "Projeto Sexta-Feira detectado!"

# 1. ANÁLISE DE CÓDIGO ANTI-ERROS
Write-AntiErrorMessage "Executando análise anti-erros..." "🔍"

$errorsFound = @()
$warningsFound = @()
$suggestionsFound = @()
$fixesApplied = @()

# Verificar arquivos de código
$codeFiles = Get-ChildItem -Recurse -Include "*.js", "*.py", "*.cs", "*.java", "*.php", "*.ts", "*.go" -ErrorAction SilentlyContinue

foreach ($file in $codeFiles) {
  Write-AntiErrorMessage "Analisando $($file.Name)..." "📄"
    
  $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
  if (-not $content) { continue }
    
  # DETECÇÃO DE ERROS COMUNS
    
  # 1. Falta de tratamento de erros
  if ($content -notmatch "try|catch|except|Error|Exception|throw") {
    $errorsFound += "❌ $($file.Name): Falta tratamento de erros"
        
    if ($AutoFix) {
      # Adicionar template de tratamento básico
      $fixTemplate = @"

// 🛡️ TRATAMENTO DE ERROS ADICIONADO AUTOMATICAMENTE
try {
    // Código principal aqui
} catch (error) {
    console.error('Erro em $($file.Name):', error);
    // Adicionar logging ou recovery conforme necessário
}
"@
      Add-Content $file.FullName $fixTemplate
      $fixesApplied += "🔧 $($file.Name): Adicionado tratamento de erros básico"
    }
  }
    
  # 2. Variáveis não declaradas (JavaScript/Python)
  if ($file.Extension -in @(".js", ".ts")) {
    if ($content -match "^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*=\s*" -and $content -notmatch "var\s|let\s|const\s") {
      $warningsFound += "⚠️ $($file.Name): Possíveis variáveis não declaradas"
    }
  }
    
  # 3. Falta de validação de entrada
  if ($content -match "function|def " -and $content -notmatch "validate|check|verify") {
    $warningsFound += "⚠️ $($file.Name): Funções sem validação de entrada"
  }
    
  # 4. Console.log/print em produção
  if ($content -match "console\.log|print\((?!.*debug|.*test)") {
    $warningsFound += "⚠️ $($file.Name): Debug statements em código de produção"
        
    if ($AutoFix) {
      # Substituir por logging adequado
      $content = $content -replace "console\.log", "// console.log // REMOVIDO AUTOMATICAMENTE"
      Set-Content $file.FullName $content
      $fixesApplied += "🔧 $($file.Name): Debug statements comentados"
    }
  }
    
  # 5. Funções muito longas (>50 linhas)
  $lines = $content -split "`n"
  $functionLines = 0
  $inFunction = $false
  foreach ($line in $lines) {
    if ($line -match "function|def ") {
      $inFunction = $true
      $functionLines = 1
    }
    elseif ($inFunction) {
      $functionLines++
      if ($line -match "^\s*\}|\s*return" -and $functionLines -gt 50) {
        $warningsFound += "⚠️ $($file.Name): Função muito longa ($functionLines linhas)"
        $inFunction = $false
      }
    }
  }
    
  # 6. Falta de documentação
  if ($content -notmatch "/\*\*|'''|//\s*@|#\s*@") {
    $suggestionsFound += "💡 $($file.Name): Adicionar documentação de funções"
  }
    
  # 7. Códigos duplicados
  $codeBlocks = $content -split "`n" | Where-Object { $_.Trim().Length -gt 10 }
  $duplicates = $codeBlocks | Group-Object | Where-Object { $_.Count -gt 1 -and $_.Name.Trim() -ne "" }
  if ($duplicates.Count -gt 0) {
    $warningsFound += "⚠️ $($file.Name): Código duplicado detectado ($($duplicates.Count) blocos)"
  }
}

# 2. VERIFICAÇÃO DE DEPENDÊNCIAS
Write-AntiErrorMessage "Verificando dependências..." "📦"

# package.json (Node.js)
if (Test-Path "package.json") {
  try {
    $packageJson = Get-Content "package.json" | ConvertFrom-Json
        
    # Verificar dependências com vulnerabilidades conhecidas
    if ($packageJson.dependencies) {
      $oldPackages = @("jquery", "lodash", "moment", "request")
      foreach ($dep in $packageJson.dependencies.PSObject.Properties.Name) {
        if ($dep -in $oldPackages) {
          $warningsFound += "⚠️ package.json: Dependência desatualizada ou insegura: $dep"
        }
      }
    }
        
    # Verificar scripts de build/test
    if (-not $packageJson.scripts -or -not $packageJson.scripts.test) {
      $suggestionsFound += "💡 package.json: Adicionar script de testes"
    }
        
  }
  catch {
    $errorsFound += "❌ package.json: Formato JSON inválido"
  }
}

# requirements.txt (Python)
if (Test-Path "requirements.txt") {
  $requirements = Get-Content "requirements.txt"
  foreach ($req in $requirements) {
    if ($req -match "==.*") {
      # Versões fixas podem ter vulnerabilidades
      $warningsFound += "⚠️ requirements.txt: Versão fixa pode ter vulnerabilidades: $req"
    }
  }
}

# 3. VERIFICAÇÃO DE CONFIGURAÇÃO
Write-AntiErrorMessage "Verificando configurações..." "⚙️"

# .gitignore
if (-not (Test-Path ".gitignore")) {
  $errorsFound += "❌ .gitignore ausente"
    
  if ($AutoFix) {
    $gitignoreTemplate = @"
# 🛡️ GITIGNORE ANTI-ERROS GERADO AUTOMATICAMENTE

# Arquivos de sistema
.DS_Store
Thumbs.db

# IDEs
.vscode/
.idea/
*.swp
*.swo

# Dependencies
node_modules/
__pycache__/
*.pyc

# Build outputs
dist/
build/
*.log

# Environment
.env
.env.local

# Database
*.db
*.sqlite

# Temporary
temp/
tmp/
"@
    Set-Content ".gitignore" $gitignoreTemplate
    $fixesApplied += "🔧 .gitignore criado automaticamente"
  }
}

# VS Code settings
if (Test-Path ".vscode\settings.json") {
  try {
    $settings = Get-Content ".vscode\settings.json" | ConvertFrom-Json
        
    # Verificar configurações anti-erro
    if (-not $settings."files.autoSave") {
      $suggestionsFound += "💡 VS Code: Habilitar auto-save para prevenir perda de código"
    }
        
    if (-not $settings."editor.formatOnSave") {
      $suggestionsFound += "💡 VS Code: Habilitar formatação automática"
    }
        
  }
  catch {
    $errorsFound += "❌ .vscode\settings.json: JSON inválido"
  }
}

# 4. VERIFICAÇÃO DE ESTRUTURA DE PROJETO
Write-AntiErrorMessage "Verificando estrutura do projeto..." "📁"

# Estrutura básica
$essentialDirs = @("src", "tests", "docs")
foreach ($dir in $essentialDirs) {
  if (-not (Test-Path $dir) -and $AutoFix) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    $fixesApplied += "🔧 Pasta $dir criada"
  }
}

# README.md
if (-not (Test-Path "README.md")) {
  $suggestionsFound += "💡 Adicionar README.md com documentação do projeto"
    
  if ($AutoFix) {
    $readmeTemplate = @"
# $(Split-Path -Leaf (Get-Location))

## 🛡️ Projeto com Sistema Anti-Erros

Projeto criado com o Sistema Sexta-Feira incluindo proteções automáticas contra erros.

## 🚀 Como usar

1. Execute o projeto: \`npm start\` ou \`python main.py\`
2. Execute testes: \`npm test\` ou \`python -m pytest\`
3. Verifique erros: \`.\anti-erros.ps1\`

## 🔧 Manutenção

- Execute análise: \`.\anti-erros.ps1 -DeepAnalysis\`
- Correção automática: \`.\anti-erros.ps1 -AutoFix\`
- Modo preventivo: \`.\anti-erros.ps1 -PreventiveMode\`

## 📋 Status

✅ Sistema anti-erros ativo  
✅ Configurações validadas  
✅ Dependências verificadas  
"@
    Set-Content "README.md" $readmeTemplate
    $fixesApplied += "🔧 README.md criado com template anti-erros"
  }
}

# 5. MODO PREVENTIVO (Se solicitado)
if ($PreventiveMode) {
  Write-AntiErrorMessage "Ativando modo preventivo..." "🛡️"
    
  # Criar hooks de pré-commit
  if (-not (Test-Path ".git\hooks\pre-commit")) {
    $preCommitHook = @"
#!/bin/sh
# 🛡️ Hook anti-erros automático

echo "🛡️ Executando verificação anti-erros..."
powershell -Command ".\anti-erros.ps1"

if [ $? -ne 0 ]; then
    echo "❌ Erros encontrados! Commit cancelado."
    echo "💡 Execute: .\anti-erros.ps1 -AutoFix"
    exit 1
fi

echo "✅ Verificação passou! Commit permitido."
"@
        
    if (-not (Test-Path ".git\hooks")) {
      New-Item -ItemType Directory -Path ".git\hooks" -Force | Out-Null
    }
        
    Set-Content ".git\hooks\pre-commit" $preCommitHook
    $fixesApplied += "🔧 Hook de pré-commit configurado"
  }
    
  # Configurar lint-staged se package.json existe
  if (Test-Path "package.json") {
    try {
      $packageJson = Get-Content "package.json" | ConvertFrom-Json
            
      if (-not $packageJson."lint-staged") {
        $packageJson | Add-Member -Type NoteProperty -Name "lint-staged" -Value @{
          "*.js" = @("eslint --fix", "git add")
          "*.ts" = @("tslint --fix", "git add") 
          "*.py" = @("black", "git add")
        } -Force
                
        $packageJson | ConvertTo-Json -Depth 10 | Set-Content "package.json"
        $fixesApplied += "🔧 lint-staged configurado automaticamente"
      }
            
    }
    catch {
      # Ignorar erros de JSON inválido já reportados acima
    }
  }
}

# 6. ANÁLISE PROFUNDA (Se solicitado)
if ($DeepAnalysis) {
  Write-AntiErrorMessage "Executando análise profunda..." "🔬"
    
  # Análise de complexidade ciclomática
  foreach ($file in $codeFiles) {
    $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $content) { continue }
        
    # Contar estruturas condicionais
    $conditionalCount = ($content | Select-String -Pattern "if\s*\(|for\s*\(|while\s*\(|switch\s*\(" -AllMatches).Matches.Count
        
    if ($conditionalCount -gt 10) {
      $warningsFound += "⚠️ $($file.Name): Alta complexidade ciclomática ($conditionalCount condicionais)"
    }
        
    # Análise de acoplamento
    $importCount = ($content | Select-String -Pattern "import\s|require\s*\(|#include|using\s" -AllMatches).Matches.Count
        
    if ($importCount -gt 15) {
      $warningsFound += "⚠️ $($file.Name): Alto acoplamento ($importCount imports)"
    }
  }
    
  # Análise de performance
  foreach ($file in $codeFiles) {
    $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $content) { continue }
        
    # Loops aninhados
    if ($content -match "for.*for|while.*while") {
      $warningsFound += "⚠️ $($file.Name): Loops aninhados podem impactar performance"
    }
        
    # Operações síncronas que deveriam ser assíncronas
    if ($content -match "readFileSync|writeFileSync" -and $content -notmatch "async|await") {
      $suggestionsFound += "💡 $($file.Name): Considerar operações assíncronas"
    }
  }
}

# 7. RELATÓRIO FINAL
Write-Host ""
Write-AntiErrorSuccess "🛡️ ANÁLISE ANTI-ERROS CONCLUÍDA!"
Write-Host "=================================" -ForegroundColor Green
Write-Host ""

# Estatísticas
$totalIssues = $errorsFound.Count + $warningsFound.Count
$totalFiles = $codeFiles.Count

Write-Host "📊 ESTATÍSTICAS:" -ForegroundColor Cyan
Write-Host "   📁 Arquivos analisados: $totalFiles" -ForegroundColor Gray
Write-Host "   ❌ Erros encontrados: $($errorsFound.Count)" -ForegroundColor $(if ($errorsFound.Count -eq 0) { "Green" } else { "Red" })
Write-Host "   ⚠️  Avisos encontrados: $($warningsFound.Count)" -ForegroundColor $(if ($warningsFound.Count -eq 0) { "Green" } else { "Yellow" })
Write-Host "   💡 Sugestões: $($suggestionsFound.Count)" -ForegroundColor $(if ($suggestionsFound.Count -eq 0) { "Green" } else { "Cyan" })
Write-Host "   🔧 Correções aplicadas: $($fixesApplied.Count)" -ForegroundColor $(if ($fixesApplied.Count -eq 0) { "Gray" } else { "Magenta" })

# Mostrar detalhes
if ($errorsFound.Count -gt 0) {
  Write-Host ""
  Write-Host "❌ ERROS CRÍTICOS:" -ForegroundColor Red
  foreach ($errorMsg in $errorsFound) {
    Write-Host "   $errorMsg" -ForegroundColor Red
  }
}

if ($warningsFound.Count -gt 0) {
  Write-Host ""
  Write-Host "⚠️ AVISOS:" -ForegroundColor Yellow
  foreach ($warning in $warningsFound) {
    Write-Host "   $warning" -ForegroundColor Yellow
  }
}

if ($suggestionsFound.Count -gt 0) {
  Write-Host ""
  Write-Host "💡 SUGESTÕES DE MELHORIA:" -ForegroundColor Cyan
  foreach ($suggestion in $suggestionsFound) {
    Write-Host "   $suggestion" -ForegroundColor Cyan
  }
}

if ($fixesApplied.Count -gt 0) {
  Write-Host ""
  Write-Host "🔧 CORREÇÕES APLICADAS:" -ForegroundColor Magenta
  foreach ($fix in $fixesApplied) {
    Write-Host "   $fix" -ForegroundColor Magenta
  }
}

# Classificação de qualidade
Write-Host ""
$qualityScore = 100 - ($errorsFound.Count * 10) - ($warningsFound.Count * 3)
$qualityLevel = switch ($qualityScore) {
  { $_ -ge 90 } { "🏆 EXCELENTE"; "Green" }
  { $_ -ge 75 } { "✅ BOM"; "Green" }  
  { $_ -ge 60 } { "⚠️ REGULAR"; "Yellow" }
  { $_ -ge 40 } { "❌ RUIM"; "Red" }
  default { "💀 CRÍTICO"; "Red" }
}

Write-Host "🎯 QUALIDADE DO CÓDIGO: $($qualityLevel[0]) ($qualityScore/100)" -ForegroundColor $qualityLevel[1]

# Comandos úteis
Write-Host ""
Write-Host "💡 COMANDOS ÚTEIS:" -ForegroundColor Yellow
Write-Host "   .\anti-erros.ps1 -AutoFix          # Corrigir erros automaticamente" -ForegroundColor White
Write-Host "   .\anti-erros.ps1 -PreventiveMode   # Ativar proteção contínua" -ForegroundColor White
Write-Host "   .\anti-erros.ps1 -DeepAnalysis     # Análise profunda de qualidade" -ForegroundColor White

Write-Host ""

# Código de saída baseado na gravidade
if ($errorsFound.Count -gt 0) {
  exit 1  # Erros críticos
}
elseif ($warningsFound.Count -gt 5) {
  exit 2  # Muitos avisos
}
else {
  exit 0  # Tudo OK
}