# Exemplo de uso do Sistema MultiAgent
# Execute este script para testar a configuração

Write-Host "🤖 Testando Sistema MultiAgent..." -ForegroundColor Cyan

# Verificar se está configurado
if (-not (Test-Path "multiagent.json")) {
    Write-Host "❌ Sistema não configurado neste projeto" -ForegroundColor Red
    exit 1
}

# Carregar configuração
$config = Get-Content "multiagent.json" | ConvertFrom-Json
Write-Host "✅ Projeto: $($config.project.name)" -ForegroundColor Green
Write-Host "✅ Tipo: $($config.project.type)" -ForegroundColor Green
Write-Host "✅ Agentes habilitados: $($config.agents.enabled -join ', ')" -ForegroundColor Green

Write-Host ""
Write-Host "Para usar o sistema:" -ForegroundColor Cyan
Write-Host "1. Pressione Ctrl+Shift+P" -ForegroundColor White
Write-Host "2. Digite 'Tasks: Run Task'" -ForegroundColor White  
Write-Host "3. Selecione uma tarefa MultiAgent" -ForegroundColor White
