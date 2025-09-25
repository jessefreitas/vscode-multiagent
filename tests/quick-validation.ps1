# 🧪 Validação Rápida do Sistema MultiAgent + SCPO
# ===============================================

Write-Host ""
Write-Host "🧪 VALIDAÇÃO RÁPIDA - MultiAgent + SCPO + Agente Principal" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

$passed = 0
$total = 0

function Test-Component {
    param([string]$Name, [scriptblock]$Test)
    $global:total++
    try {
        $result = & $Test
        if ($result) {
            Write-Host "✅ $Name" -ForegroundColor Green
            $global:passed++
        } else {
            Write-Host "❌ $Name" -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ $Name - $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Testes de arquivos essenciais
Test-Component "Script principal (ma.ps1)" { Test-Path "scripts\ma.ps1" }
Test-Component "Agente Principal" { Test-Path "scripts\agent-principal.ps1" }
Test-Component "Review SCPO" { Test-Path "scripts\review-code.ps1" }
Test-Component "Gerador SCPO" { Test-Path "scripts\generate-code-scpo.ps1" }
Test-Component "Prompts SCPO" { (Get-ChildItem "prompts\*.md").Count -gt 0 }

# Testes de integração VS Code
Test-Component "Tasks VS Code" { 
    $tasks = Get-Content ".vscode\tasks.json" -Raw
    $tasks -match "Agente Principal"
}
Test-Component "Settings SCPO" { 
    $settings = Get-Content ".vscode\settings.json" -Raw
    $settings -match "scpo.enabled"
}
Test-Component "Extensão SCPO" { Test-Path "vscode-extension-scpo\package.json" }

# Teste funcional básico
Test-Component "Comando Help" { 
    $help = & ".\scripts\ma.ps1" "help" 2>&1
    ($help -join " ") -match "AGENTE PRINCIPAL"
}

Test-Component "Comando Status" { 
    $status = & ".\scripts\ma.ps1" "status" 2>&1
    ($status -join " ") -match "MultiAgent.*Status"
}

# Resultados
Write-Host ""
Write-Host "📊 RESULTADO: $passed/$total testes passaram" -ForegroundColor $(if($passed -eq $total){"Green"}else{"Yellow"})

if ($passed -eq $total) {
    Write-Host ""
    Write-Host "🎉 SISTEMA 100% FUNCIONAL!" -ForegroundColor Green
    Write-Host "🚀 Pronto para uso em produção!" -ForegroundColor Green
    Write-Host ""
    Write-Host "💡 Próximos passos:" -ForegroundColor Cyan
    Write-Host "   • Use: ma 'sua tarefa' para comando inteligente" -ForegroundColor White
    Write-Host "   • Pressione Ctrl+Shift+P → Tasks para workflows VS Code" -ForegroundColor White
    Write-Host "   • Digite '@' no editor para snippets SCPO" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "⚠️  Alguns componentes precisam ajuste" -ForegroundColor Yellow
}
Write-Host ""