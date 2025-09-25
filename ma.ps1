# MultiAgent Quick Command - Comando rápido para tarefas comuns
param(
    [Parameter(Position=0, Mandatory=$true)]
    [ValidateSet("init", "generate", "review", "execute", "template")]
    [string]$Command,
    
    [Parameter(Position=1)]
    [string]$Target = "",
    
    [Parameter()]
    [string]$Type = "python",
    
    [Parameter()]
    [switch]$Interactive,
    
    [Parameter()]
    [switch]$DryRun,
    
    [Parameter()]
    [switch]$Verbose
)

# Cores para output
$colors = @{
    Success = "Green"
    Warning = "Yellow" 
    Error = "Red"
    Info = "Cyan"
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
            ProjectPath = if([string]::IsNullOrEmpty($Target)) { (Get-Location).Path } else { $Target }
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
        if ($Verbose) { $params.Detailed = $true }
        
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
        if ($Verbose) { $params.Verbose = $true }
        
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
                    } else { 
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
}

Write-Host ""
Write-ColorOutput "✅ Comando executado!" "Success"

# Dicas de uso
if ($Command -eq "init" -and -not $Interactive) {
    Write-Host ""
    Write-ColorOutput "💡 Dicas de uso:" "Info"
    Write-ColorOutput "• Use -Interactive para configuração guiada" "Highlight"
    Write-ColorOutput "• Reinicie o VS Code para carregar as configurações" "Highlight"
    Write-ColorOutput "• Pressione Ctrl+Shift+P e digite 'MultiAgent'" "Highlight"
}