# 🧠 MCP Memory Server - Auto Inicialização
# ========================================
# Este arquivo garante que o MCP Memory Server inicie com o projeto

Write-Host "🧠 Iniciando MCP Memory Server..." -ForegroundColor Cyan

try {
    # Verificar se NPX está disponível
    $npxVersion = npx --version 2>$null
    if (-not $npxVersion) {
        Write-Host "❌ NPX não encontrado. Instale Node.js para usar MCP Memory Server" -ForegroundColor Red
        exit 1
    }
    
    # Iniciar MCP Memory Server em background
    Write-Host "🚀 Iniciando MCP Memory Server..." -ForegroundColor Green
    
    # Definir caminho do banco de dados
    $memoryDbPath = "./mcp-memory.db"
    $env:MEMORY_STORAGE_PATH = $memoryDbPath
    
    # Iniciar o servidor (será gerenciado pelo VS Code)
    Write-Host "✅ MCP Memory Server configurado!" -ForegroundColor Green
    Write-Host "📁 Database: $memoryDbPath" -ForegroundColor Gray
    Write-Host "💡 O servidor será iniciado automaticamente pelo VS Code" -ForegroundColor Yellow
    
} catch {
    Write-Host "❌ Erro ao configurar MCP Memory Server: $($_.Exception.Message)" -ForegroundColor Red
}
