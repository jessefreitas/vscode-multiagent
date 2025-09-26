param([string]$Nome, [string]$Descricao = "Projeto criado automaticamente")

Write-Host ""
Write-Host "🎉 SEXTA-FEIRA COM PROMPTS SCPO!" -ForegroundColor Magenta
Write-Host "================================" -ForegroundColor Magenta
Write-Host "📁 Projeto: $Nome" -ForegroundColor Cyan
Write-Host "💭 Descrição: $Descricao" -ForegroundColor Cyan
Write-Host ""

$diretorio = "C:\vscode"
$caminho = "$diretorio\$Nome"

Write-Host "📋 PASSO 1: Criando pasta em $caminho..." -ForegroundColor Yellow
if (-not (Test-Path $diretorio)) { New-Item -ItemType Directory -Path $diretorio -Force | Out-Null }
if (Test-Path $caminho) {
  $resp = Read-Host "⚠️ Pasta existe. Sobrescrever? (s/N)"
  if ($resp -ne "s") { exit }
  Remove-Item $caminho -Recurse -Force
}
New-Item -ItemType Directory -Path $caminho | Out-Null
Write-Host "  ✅ Pasta criada" -ForegroundColor Green

Write-Host "📋 PASSO 2: Clonando do GitHub..." -ForegroundColor Yellow
$temp = "$env:TEMP\clone-$(Get-Date -Format 'HHmmss')"
try {
  git clone https://github.com/jessefreitas/vscode-multiagent.git $temp --quiet
  Write-Host "  ✅ Clone realizado" -ForegroundColor Green
  
  Write-Host "📋 PASSO 3: Copiando arquivos..." -ForegroundColor Yellow
  $arquivos = @("ma.ps1", "anti-erros.ps1", "sistema-anti-erros.ps1", "validacao-tempo-real.ps1", "gerar-codigo-seguro.ps1", "corrigir-prompts.ps1", "reparar-projeto.ps1", "inicializar.ps1")
  
  foreach ($arq in $arquivos) {
    if (Test-Path "$temp\$arq") {
      Copy-Item "$temp\$arq" "$caminho\$arq" -Force
      Write-Host "    ✅ $arq" -ForegroundColor Green
    }
  }
  
  if (Test-Path "$temp\prompts") {
    Copy-Item "$temp\prompts" "$caminho\prompts" -Recurse -Force
    $count = (Get-ChildItem "$caminho\prompts" -Filter "*.md").Count
    Write-Host "    ✅ $count prompts SCPO" -ForegroundColor Green
  }
  
  if (Test-Path "$temp\settings") {
    Copy-Item "$temp\settings" "$caminho\settings" -Recurse -Force
    Write-Host "    ✅ Configurações" -ForegroundColor Green
  }
  
}
catch {
  Write-Host "❌ Erro: $_ - Usando arquivos locais" -ForegroundColor Red
  
  $arquivos = @("ma.ps1", "anti-erros.ps1", "sistema-anti-erros.ps1", "validacao-tempo-real.ps1", "gerar-codigo-seguro.ps1", "corrigir-prompts.ps1", "reparar-projeto.ps1")
  foreach ($arq in $arquivos) {
    if (Test-Path $arq) {
      Copy-Item $arq "$caminho\$arq" -Force
    }
  }
  if (Test-Path "prompts") { Copy-Item "prompts" "$caminho\prompts" -Recurse -Force }
  if (Test-Path "settings") { Copy-Item "settings" "$caminho\settings" -Recurse -Force }
}
finally {
  if (Test-Path $temp) { Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue }
}

Set-Location $caminho
@{projeto = @{nome = $Nome; descricao = $Descricao; criado = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') } } | ConvertTo-Json | Set-Content "projeto.json"

if (Test-Path ".\inicializar.ps1") { & ".\inicializar.ps1" }

Write-Host ""
Write-Host "🎉 PROJETO '$Nome' CRIADO!" -ForegroundColor Green
Write-Host "Local: $caminho" -ForegroundColor Cyan
Write-Host "Prompts SCPO: Instalados ✅" -ForegroundColor Green
Write-Host ""
