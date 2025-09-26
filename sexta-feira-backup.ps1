param([string]$Nome, [string]$Descricao = "Projeto cria# } catch {
  Write-Host "❌ Usando arquivos locais..." -ForegroundColor Yellow
  $arquivos = @("ma.ps1", "anti-erros.ps1", "sistema-anti-erros.ps1", "validacao-tempo-real.ps1", "gerar-codigo-seguro.ps1", "corrigir-prompts.ps1", "reparar-projeto.ps1")
  
  foreach ($arq in $arquivos) {
    if (Test-Path $arq) {
      Copy-Item $arq "$caminhoCompleto\$arq" -Force
    }
  }
  
  Copy-Item "prompts" "$caminhoCompleto\prompts" -Recurse -Force
  Copy-Item "settings" "$caminhoCompleto\settings" -Recurse -Forceamente")

Write-Host ""
Write-Host "🎉 SEXTA-FEIRA: CRIANDO PROJETO!" -ForegroundColor Magenta
Write-Host "=================================" -ForegroundColor Magenta  
Write-Host ""
Write-Host "📁 Projeto: $Nome" -ForegroundColor Cyan
Write-Host "💭 Descrição: $Descricao" -ForegroundColor Cyan
Write-Host ""

# PASSO 1: Criar pasta
Write-Host "📋 PASSO 1: Criando pasta..." -ForegroundColor Yellow

# Definir diretório de projetos
$diretorioProjetos = "C:\vscode"
$caminhoCompleto = Join-Path $diretorioProjetos $Nome

# Criar diretório de projetos se não existir
if (-not (Test-Path $diretorioProjetos)) {
  New-Item -ItemType Directory -Path $diretorioProjetos -Force | Out-Null
}

if (Test-Path $caminhoCompleto) {
  Write-Host "⚠️ Pasta existe em $caminhoCompleto. Sobrescrever? (s/N)" -ForegroundColor Yellow
  $resp = Read-Host
  if ($resp -ne "s") { exit }
  Remove-Item $caminhoCompleto -Recurse -Force
}
New-Item -ItemType Directory -Path $caminhoCompleto | Out-Null
Write-Host "  ✅ Pasta criada em: $caminhoCompleto" -ForegroundColor Green

# PASSO 2: Clone do GitHub  
Write-Host "📋 PASSO 2: Clonando do GitHub..." -ForegroundColor Yellow
$temp = "$env:TEMP\ma-$(Get-Date -Format 'HHmmss')"

try {
  git clone https://github.com/jessefreitas/vscode-multiagent.git $temp --quiet
  Write-Host "  ✅ Clone realizado" -ForegroundColor Green
  
  # Copiar arquivos essenciais
  $arquivos = @("ma.ps1", "anti-erros.ps1", "sistema-anti-erros.ps1", "validacao-tempo-real.ps1", "gerar-codigo-seguro.ps1", "corrigir-prompts.ps1", "reparar-projeto.ps1", "inicializar.ps1")
  
  foreach ($arq in $arquivos) {
    if (Test-Path "$temp\$arq") {
      Copy-Item "$temp\$arq" "$caminhoCompleto\$arq" -Force
      Write-Host "    ✅ $arq" -ForegroundColor Green
    }
  }
  
  # Copiar prompts e settings
  Copy-Item "$temp\prompts" "$caminhoCompleto\prompts" -Recurse -Force
  Copy-Item "$temp\settings" "$caminhoCompleto\settings" -Recurse -Force  
  Write-Host "    ✅ Prompts e configurações" -ForegroundColor Green
  
}
catch {
  Write-Host "❌ Usando arquivos locais..." -ForegroundColor Yellow
  $arquivos = @("ma.ps1", "anti-erros.ps1", "sistema-anti-erros.ps1", "validacao-tempo-real.ps1", "gerar-codigo-seguro.ps1", "corrigir-prompts.ps1", "reparar-projeto.ps1")
  
  foreach ($arq in $arquivos) {
    if (Test-Path $arq) {
      Copy-Item $arq "$caminhoCompleto\$arq" -Force
    }
  }
  
  Copy-Item "prompts" "$caminhoCompleto\prompts" -Recurse -Force
  Copy-Item "settings" "$caminhoCompleto\settings" -Recurse -Force
}
finally {
  if (Test-Path $temp) { Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue }
}

# Configurar e inicializar
Set-Location $caminhoCompleto
"{`"projeto`": {`"nome`": `"$Nome`", `"descricao`": `"$Descricao`", `"criado`": `"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`"}}" | Set-Content "projeto.json"

if (Test-Path ".\inicializar.ps1") { & ".\inicializar.ps1" }

Write-Host ""
Write-Host "🎉 PROJETO '$Nome' CRIADO!" -ForegroundColor Green  
Write-Host "Local: $(Get-Location)" -ForegroundColor Cyan
Write-Host ""
