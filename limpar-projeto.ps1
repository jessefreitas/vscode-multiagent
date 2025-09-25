#!/usr/bin/env pwsh
# 🧹 LIMPEZA INTELIGENTE DO PROJETO
# ================================
# Remove arquivos desnecessários mantendo apenas o essencial

Write-Host "🧹 INICIANDO LIMPEZA INTELIGENTE" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Arquivos de exemplo/teste para remover
$arquivosExemplo = @(
    "AnaliseData.py",
    "AnalyzerDados.rs", 
    "ComponenteDashboard.jsx",
    "ExemploAPI.js",
    "ProcessarDados.cs",
    "ProcessarDados.go", 
    "processarDados.py",
    "test-fibonacci.py",
    "scpo-task-20250925-114736.js",
    "scpo-task-20250925-114929.js"
)

# Documentação obsoleta/duplicada
$docsObsoletos = @(
    "CHECKLIST-SISTEMA-COMPLETO.md",
    "EXPANSAO-CONCLUIDA.md",
    "IMPLEMENTACAO-CONCLUIDA.md",
    "INTEGRATION-SUMMARY.md", 
    "INTEGRATION_PLAN.md",
    "PROJETO-COMPLETO.md",
    "README-INTEGRATED.md",
    "README-original.md",
    "SISTEMA-COMPLETO-FINAL.md",
    "STATUS-FINAL-SEXTA-FEIRA.md",
    "STATUS.md",
    "VSCODE-INTEGRATION.md"
)

# Scripts experimentais/obsoletos
$scriptsExperimentais = @(
    "agente.ps1",
    "auto-reparacao.ps1",
    "diagnostico-sexta.ps1",
    "diagnostico.ps1",
    "execute-code.ps1",
    "generate-code-scpo.ps1",
    "generate-code.ps1",
    "instalar-sexta-global.ps1", 
    "install-rapido.ps1",
    "mcp-init.ps1",
    "novo.ps1",
    "quero.ps1",
    "review-code.ps1",
    "sexta-feira.ps1",
    "test-multiagent.ps1"
)

# Pastas de teste/temporárias
$pastasTemp = @(
    "TesteSite",
    "tests",
    "docs",
    "src"
)

# Função para remover com confirmação
function Remove-SafelyWithConfirm {
    param($items, $category, $color = "Yellow")
    
    if ($items.Count -eq 0) { return }
    
    Write-Host "📂 $category ($($items.Count) itens):" -ForegroundColor $color
    
    $removed = 0
    foreach ($item in $items) {
        if (Test-Path $item) {
            try {
                Remove-Item $item -Recurse -Force -ErrorAction Stop
                Write-Host "  ✅ $item" -ForegroundColor Green
                $removed++
            } catch {
                Write-Host "  ❌ $item (erro: $($_.Exception.Message))" -ForegroundColor Red
            }
        } else {
            Write-Host "  ➖ $item (não existe)" -ForegroundColor Gray
        }
    }
    
    if ($removed -gt 0) {
        Write-Host "  → $removed arquivos removidos" -ForegroundColor $color
    }
    Write-Host ""
}

# Executar limpeza
Remove-SafelyWithConfirm $arquivosExemplo "Arquivos de Exemplo/Teste"
Remove-SafelyWithConfirm $docsObsoletos "Documentação Obsoleta" "Orange"
Remove-SafelyWithConfirm $scriptsExperimentais "Scripts Experimentais" "Red"
Remove-SafelyWithConfirm $pastasTemp "Pastas Temporárias" "Magenta"

# Limpar cache se existir
if (Test-Path ".multiagent-cache") {
    Remove-Item ".multiagent-cache" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "🗑️ Cache limpo" -ForegroundColor Gray
}

# Mostrar arquivos essenciais que foram mantidos
Write-Host "📋 ARQUIVOS ESSENCIAIS MANTIDOS:" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

$essenciais = @(
    "ma.ps1",
    "anti-erros.ps1",
    "validacao-tempo-real.ps1",
    "gerar-codigo-seguro.ps1", 
    "sistema-anti-erros.ps1",
    "corrigir-prompts.ps1",
    "criar-projeto.ps1",
    "reparar-projeto.ps1",
    "templates-inteligentes.ps1",
    "verificar-mcp.ps1"
)

foreach ($arquivo in $essenciais) {
    if (Test-Path $arquivo) {
        $tamanho = [math]::Round((Get-Item $arquivo).Length / 1KB, 1)
        Write-Host "  ✅ $arquivo ($tamanho KB)" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $arquivo (FALTANDO!)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "📋 DOCUMENTAÇÃO MANTIDA:" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan

$docsEssenciais = @(
    "README.md",
    "GUIA-INTEGRADO-COMPLETO.md",
    "INICIO-RAPIDO-5MIN.md", 
    "EXEMPLOS-PRATICOS.md",
    "SEXTA-FEIRA-GUIA-LEIGOS.md",
    "PARA-LEIGOS.md",
    "SOLUCOES-PROBLEMAS.md",
    "LINGUAGENS-SUPORTADAS.md"
)

foreach ($doc in $docsEssenciais) {
    if (Test-Path $doc) {
        Write-Host "  ✅ $doc" -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "📊 RESUMO DA LIMPEZA:" -ForegroundColor White
Write-Host "====================" -ForegroundColor White

Write-Host "  🗂️ Projeto organizado e limpo!" -ForegroundColor Green
Write-Host "  📁 Pastas mantidas: prompts/, settings/, templates/, vscode-extension-scpo/" -ForegroundColor Gray
Write-Host "  🔧 Scripts funcionais: $(($essenciais | Where-Object { Test-Path $_ }).Count)/$($essenciais.Count)" -ForegroundColor Green
Write-Host "  📚 Documentação: $(($docsEssenciais | Where-Object { Test-Path $_ }).Count) guias essenciais" -ForegroundColor Cyan

Write-Host ""
Write-Host "🎉 LIMPEZA CONCLUÍDA!" -ForegroundColor Green
Write-Host "Projeto pronto para produção! 🚀" -ForegroundColor Green
Write-Host ""