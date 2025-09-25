# 🎉 COMANDO GLOBAL: Sexta-Feira Ativar Projeto
# =============================================
# Instala globalmente o comando "Sexta-Feira Ativar Projeto"

Write-Host ""
Write-Host "🎉 INSTALANDO COMANDO GLOBAL: Sexta-Feira Ativar Projeto" -ForegroundColor Magenta
Write-Host "=========================================" -ForegroundColor Magenta
Write-Host ""

# Criar pasta para scripts globais
$globalPath = "$env:USERPROFILE\.vscode-sexta"
if (-not (Test-Path $globalPath)) {
  New-Item -ItemType Directory -Path $globalPath -Force | Out-Null
  Write-Host "✅ Pasta global criada: $globalPath" -ForegroundColor Green
}

# Copiar script principal
Copy-Item "sexta-feira.ps1" "$globalPath\sexta-feira.ps1" -Force
Write-Host "✅ Script copiado para pasta global" -ForegroundColor Green

# Criar alias global
$aliasScript = @"
# Sexta-Feira Ativar Projeto - Alias Global
function Sexta-Feira-Ativar-Projeto {
    param(
        [Parameter(Position = 0)]
        [string]`$NomeProjeto = "",
        
        [Parameter(Position = 1, ValueFromRemainingArguments = `$true)]
        [string[]]`$DescricaoProjeto = @(),
        
        [switch]`$Private = `$false,
        [switch]`$Force = `$false
    )
    
    # Formar a descrição completa
    `$descricaoCompleta = `$DescricaoProjeto -join " "
    
    if (`$descricaoCompleta) {
        & "$globalPath\sexta-feira.ps1" `$NomeProjeto `$descricaoCompleta -Private:`$Private -Force:`$Force
    } else {
        & "$globalPath\sexta-feira.ps1" `$NomeProjeto -Private:`$Private -Force:`$Force
    }
}

# Alias mais curto
function sexta {
    param(
        [Parameter(Position = 0, Mandatory = `$false)]
        [string]`$NomeProjeto = "",
        
        [Parameter(Position = 1, ValueFromRemainingArguments = `$true)]
        [string[]]`$DescricaoProjeto = @(),
        
        [switch]`$Private = `$false,
        [switch]`$Force = `$false
    )
    
    # Formar a descrição completa
    `$descricaoCompleta = `$DescricaoProjeto -join " "
    
    if (`$descricaoCompleta) {
        & "$globalPath\sexta-feira.ps1" `$NomeProjeto `$descricaoCompleta -Private:`$Private -Force:`$Force
    } else {
        & "$globalPath\sexta-feira.ps1" `$NomeProjeto -Private:`$Private -Force:`$Force
    }
}

Write-Host "🎉 Comando 'Sexta-Feira Ativar Projeto' carregado!" -ForegroundColor Magenta
"@

$aliasScript | Set-Content "$globalPath\alias.ps1"

# Adicionar ao perfil do PowerShell
$profilePath = $PROFILE
if (-not (Test-Path $profilePath)) {
  New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$profileContent = Get-Content $profilePath -ErrorAction SilentlyContinue
$sourceCommand = ". `"$globalPath\alias.ps1`""

if ($profileContent -notcontains $sourceCommand) {
  Add-Content $profilePath "`n# Sexta-Feira Ativar Projeto"
  Add-Content $profilePath $sourceCommand
  Write-Host "✅ Comando adicionado ao perfil do PowerShell" -ForegroundColor Green
}
else {
  Write-Host "✅ Comando já existe no perfil do PowerShell" -ForegroundColor Green
}

# Criar comando para terminal integrado do VS Code
$vscodeCommand = @"
{
    "terminal.integrated.profiles.windows": {
        "PowerShell Sexta-Feira": {
            "source": "PowerShell",
            "args": ["-NoExit", "-Command", ". '$globalPath\\alias.ps1'"],
            "icon": "star"
        }
    }
}
"@

$vscodeCommand | Set-Content "$globalPath\vscode-terminal.json"

Write-Host ""
Write-Host "🎉 INSTALAÇÃO CONCLUÍDA!" -ForegroundColor Magenta
Write-Host "========================" -ForegroundColor Magenta
Write-Host ""
Write-Host "✅ COMANDOS DISPONÍVEIS EM QUALQUER LUGAR:" -ForegroundColor Green
Write-Host ""
Write-Host "🎯 COMANDO COMPLETO:" -ForegroundColor Cyan
Write-Host "   Sexta-Feira-Ativar-Projeto MeuProjeto 'descrição do projeto'" -ForegroundColor White
Write-Host ""
Write-Host "⚡ COMANDO RÁPIDO:" -ForegroundColor Cyan
Write-Host "   sexta MeuProjeto 'descrição do projeto'" -ForegroundColor White
Write-Host ""
Write-Host "💡 EXEMPLOS:" -ForegroundColor Yellow
Write-Host "   sexta LojaOnline 'uma loja virtual completa'" -ForegroundColor Gray
Write-Host "   sexta MeuApp 'aplicativo de tarefas'" -ForegroundColor Gray
Write-Host "   sexta SitePortfolio 'meu site pessoal'" -ForegroundColor Gray
Write-Host ""
Write-Host "🔄 REINICIE O POWERSHELL para ativar os comandos globais" -ForegroundColor Yellow
Write-Host ""
Write-Host "🎉 Agora você pode usar 'sexta' em qualquer lugar! 🚀" -ForegroundColor Magenta