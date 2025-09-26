# MultiAgent Quick Command - Comando rápido para tarefas comuns
param(
    [Parameter(Position = 0, Mandatory = $true)]
    [ValidateSet("init", "generate", "review", "execute", "template", "safe-code", "check", "fix")]
    [string]$Command,
    
    [Parameter(Position = 1)]
    [string]$Target = "",
    
    [Parameter()]
    [string]$Type = "python",
    
    [Parameter()]
    [switch]$Interactive,
    
    [Parameter()]
    [switch]$DryRun,
    
    [Parameter()]
    [switch]$DetailedOutput
)

# Cores para output
$colors = @{
    Success   = "Green"
    Warning   = "Yellow" 
    Error     = "Red"
    Info      = "Cyan"
    Highlight = "Magenta"
}

function Write-ColorOutput {
    param($Message, $Color = "White")
    Write-Host $Message -ForegroundColor $colors[$Color]
}

# Cabeçalho
Write-Host ""
Write-ColorOutput "🤖 MultiAgent Quick Command" "Info"
Write-ColorOutput "===========================" "Info"

# Verificar e corrigir prompts se necessário
if (-not (Test-Path "prompts") -or (Get-ChildItem "prompts" -Filter "*.md" -ErrorAction SilentlyContinue).Count -lt 5) {
    Write-ColorOutput "🔧 Verificando prompts SCPO..." "Warning"
    $corretorPath = Join-Path $PSScriptRoot "corrigir-prompts.ps1"
    if (Test-Path $corretorPath) {
        & $corretorPath "." 2>$null | Out-Null
        Write-ColorOutput "✅ Prompts verificados!" "Success"
    }
}

# Verificar se sistema está instalado
$installPath = "$env:USERPROFILE\.vscode-multiagent"
if (-not (Test-Path $installPath)) {
    Write-ColorOutput "❌ Sistema MultiAgent não instalado!" "Error"
    Write-ColorOutput "Execute: .\install.ps1" "Warning"
    exit 1
}

# Executar comando
switch ($Command) {
    "init" {
        Write-ColorOutput "🚀 Inicializando projeto MultiAgent..." "Info"
        
        $params = @{
            ProjectPath = if ([string]::IsNullOrEmpty($Target)) { (Get-Location).Path } else { $Target }
            ProjectType = $Type
        }
        
        if ($Interactive) { $params.Interactive = $true }
        
        & "$installPath\scripts\init-project.ps1" @params
    }
    
    "generate" {
        if ([string]::IsNullOrEmpty($Target)) {
            Write-ColorOutput "❌ Especifique a tarefa de código: ma generate 'criar função de ordenação'" "Error"
            exit 1
        }
        
        Write-ColorOutput "🧠 Gerando código para: $Target" "Info"
        
        $params = @{ CodeTask = $Target }
        if ($DryRun) { $params.Review = $true }
        
        & "$installPath\scripts\generate-code.ps1" @params
    }
    
    "review" {
        if ([string]::IsNullOrEmpty($Target)) {
            Write-ColorOutput "❌ Especifique o arquivo: ma review arquivo.py" "Error"
            exit 1
        }
        
        if (-not (Test-Path $Target)) {
            Write-ColorOutput "❌ Arquivo não encontrado: $Target" "Error"
            exit 1
        }
        
        Write-ColorOutput "🔍 Revisando código em: $Target" "Info"
        
        $params = @{ FilePath = $Target }
        if ($DetailedOutput) { $params.Detailed = $true }
        
        & "$installPath\scripts\review-code.ps1" @params
    }
    
    "execute" {
        if ([string]::IsNullOrEmpty($Target)) {
            Write-ColorOutput "❌ Especifique o arquivo: ma execute arquivo.py" "Error"
            exit 1
        }
        
        if (-not (Test-Path $Target)) {
            Write-ColorOutput "❌ Arquivo não encontrado: $Target" "Error"
            exit 1
        }
        
        Write-ColorOutput "🚀 Executando código: $Target" "Info"
        
        $params = @{ FilePath = $Target }
        if ($DryRun) { $params.DryRun = $true }
        if ($DetailedOutput) { $params.Verbose = $true }
        
        & "$installPath\scripts\execute-code.ps1" @params
    }
    
    "template" {
        Write-ColorOutput "📋 Templates disponíveis:" "Info"
        Write-ColorOutput "• datascience - Projeto completo de Data Science" "Highlight"
        Write-ColorOutput "• webapp - Aplicação web (Flask/FastAPI)" "Highlight" 
        Write-ColorOutput "• cli - Ferramenta de linha de comando" "Highlight"
        Write-ColorOutput "• api - API REST com testes" "Highlight"
        
        if (-not [string]::IsNullOrEmpty($Target)) {
            switch ($Target.ToLower()) {
                "datascience" {
                    Write-ColorOutput "🔬 Criando template Data Science..." "Info"
                    
                    $projectName = if ($Interactive) { 
                        Read-Host "Nome do projeto"
                    }
                    else { 
                        "DataScienceProject" 
                    }
                    
                    & "$installPath\templates\create-datascience-project.ps1" -ProjectName $projectName
                }
                default {
                    Write-ColorOutput "❌ Template '$Target' não implementado ainda" "Warning"
                    Write-ColorOutput "💡 Contribua implementando novos templates!" "Info"
                }
            }
        }
    }
    
    "safe-code" {
        Write-ColorOutput "🛡️ Gerando código seguro..." "Info"
        
        if (Test-Path "gerar-codigo-seguro.ps1") {
            $linguagem = if ([string]::IsNullOrEmpty($Type)) { "js" } else { $Type }
            $nome = if ([string]::IsNullOrEmpty($Target)) { 
                Read-Host "Nome da função/componente" 
            }
            else { 
                $Target 
            }
            
            & .\gerar-codigo-seguro.ps1 -Tipo "funcao" -Nome $nome -Linguagem $linguagem
        }
        else {
            Write-ColorOutput "❌ Script gerar-codigo-seguro.ps1 não encontrado!" "Error"
            Write-ColorOutput "Execute: ma fix" "Warning"
        }
    }
    
    "check" {
        Write-ColorOutput "🔍 Executando verificação completa..." "Info"
        
        # Verificar scripts anti-erros
        if (Test-Path "sistema-anti-erros.ps1") {
            & .\sistema-anti-erros.ps1 verificar
        }
        else {
            Write-ColorOutput "⚠️ Sistema anti-erros não encontrado" "Warning"
            Write-ColorOutput "Execute: ma fix" "Warning"
        }
    }
    
    "fix" {
        Write-ColorOutput "🔧 Reparando sistema..." "Info"
        
        # Auto-reparação
        if (Test-Path "auto-reparacao.ps1") {
            & .\auto-reparacao.ps1
        }
        
        # Instalar sistema anti-erros
        if (Test-Path "sistema-anti-erros.ps1") {
            & .\sistema-anti-erros.ps1 instalar
        }
        
        Write-ColorOutput "✅ Sistema reparado!" "Success"
    }
}

Write-Host ""
Write-ColorOutput "✅ Comando executado!" "Success"

# Dicas de uso
if ($Command -eq "init" -and -not $Interactive) {
    Write-Host ""
    Write-ColorOutput "💡 Próximos passos:" "Info"
    Write-ColorOutput "• ma safe-code MinhaFuncao -Type js" "Highlight"
    Write-ColorOutput "• ma check (verificar sistema)" "Highlight"
    Write-ColorOutput "• ma fix (reparar problemas)" "Highlight"
    Write-ColorOutput "• Reinicie o VS Code para carregar as configurações" "Highlight"
}