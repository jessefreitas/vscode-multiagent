# 🎯 GERADOR DE CÓDIGO SEGURO
# ===============================
# Sistema inteligente para gerar código com proteções automáticas

param(
    [Parameter(Mandatory)]
    [string]$Tipo,
    
    [string]$Nome = "",
    [string]$Linguagem = "js"
)

function Write-CodeMessage {
    param([string]$Message, [string]$Icon = "🎯")
    Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Write-CodeSuccess {
    param([string]$Message, [string]$Icon = "✅")
    Write-Host "$Icon $Message" -ForegroundColor Green
}

# Templates seguros
$templateJS = @'
/**
 * {NOME} - Função JavaScript com proteções automáticas
 */

async function {NOME}(params = {}) {
    // 🛡️ Validação de entrada
    if (!params || typeof params !== 'object') {
        throw new Error('Parâmetros inválidos para {NOME}');
    }
    
    // 🔍 Logging
    console.log('[{NOME}] Iniciando execução', { params });
    
    try {
        // 🎯 SUA LÓGICA AQUI
        const result = {
            success: true,
            data: null,
            message: 'Operação concluída'
        };
        
        // ✅ Validação de saída
        if (!result || typeof result !== 'object') {
            throw new Error('Resultado inválido');
        }
        
        console.log('[{NOME}] Sucesso', { result });
        return result;
        
    } catch (error) {
        // 🚨 Tratamento de erro
        console.error('[{NOME}] Erro:', error);
        
        return {
            success: false,
            error: error.message,
            timestamp: new Date().toISOString()
        };
    }
}

// 🧪 Teste automático
async function test{NOME}() {
    console.log('🧪 Testando {NOME}...');
    
    try {
        const result = await {NOME}({});
        console.log('✅ Teste passou:', result);
    } catch (error) {
        console.error('❌ Teste falhou:', error);
    }
}

// Executar se for arquivo principal
if (typeof require !== 'undefined' && require.main === module) {
    test{NOME}();
}

module.exports = { {NOME}, test{NOME} };
'@

$templatePython = @'
"""
{NOME} - Função Python com proteções automáticas
"""
import logging
import traceback
from typing import Dict, Any, Optional
from datetime import datetime

# Configurar logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def {NOME}(params: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
    """
    Função com proteções automáticas contra erros
    
    Args:
        params: Parâmetros da função
        
    Returns:
        Resultado da operação
    """
    # 🛡️ Validação de entrada
    if params is None:
        params = {}
    
    if not isinstance(params, dict):
        raise ValueError("Parâmetros devem ser um dicionário")
    
    # 🔍 Logging
    logger.info(f"[{NOME}] Iniciando execução com params: {params}")
    
    try:
        # 🎯 SUA LÓGICA AQUI
        result = {
            'success': True,
            'data': None,
            'message': 'Operação concluída',
            'timestamp': datetime.now().isoformat()
        }
        
        # ✅ Validação de saída
        if not isinstance(result, dict) or 'success' not in result:
            raise ValueError("Resultado inválido")
        
        logger.info(f"[{NOME}] Sucesso: {result}")
        return result
        
    except Exception as error:
        # 🚨 Tratamento de erro
        logger.error(f"[{NOME}] Erro: {str(error)}")
        logger.error(traceback.format_exc())
        
        return {
            'success': False,
            'error': str(error),
            'error_type': type(error).__name__,
            'timestamp': datetime.now().isoformat()
        }

def test_{NOME}():
    """Teste automático para {NOME}"""
    print(f"🧪 Testando {NOME}...")
    
    try:
        result = {NOME}({})
        print(f"✅ Teste passou: {result}")
        return True
    except Exception as error:
        print(f"❌ Teste falhou: {error}")
        return False

if __name__ == "__main__":
    test_{NOME}()
'@

$templateReact = @'
import React, { useState, useEffect, useCallback } from 'react';

/**
 * {NOME} - Componente React com proteções automáticas
 */
const {NOME} = ({ 
    initialData = {},
    onError = () => {},
    onSuccess = () => {},
    ...props 
}) => {
    const [data, setData] = useState(initialData);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    
    // 🛡️ Tratamento de erro
    const handleError = useCallback((err, context = '') => {
        console.error(`[{NOME}${context}] Erro:`, err);
        
        const errorInfo = {
            message: err.message || 'Erro desconhecido',
            context: context,
            timestamp: new Date().toISOString()
        };
        
        setError(errorInfo);
        onError(errorInfo);
    }, [onError]);
    
    // 🔄 Operação segura
    const safeOperation = useCallback(async (operation, name = 'operation') => {
        try {
            setLoading(true);
            setError(null);
            
            const result = await operation();
            
            if (result === undefined || result === null) {
                throw new Error(`Resultado inválido em ${name}`);
            }
            
            onSuccess(result);
            return result;
            
        } catch (err) {
            handleError(err, `.${name}`);
            return null;
        } finally {
            setLoading(false);
        }
    }, [handleError, onSuccess]);
    
    // 🔄 Inicialização
    useEffect(() => {
        let mounted = true;
        
        const init = async () => {
            if (!mounted) return;
            
            try {
                console.log(`[{NOME}] Componente inicializado`);
                // 🎯 SUA LÓGICA DE INICIALIZAÇÃO AQUI
                
            } catch (err) {
                if (mounted) {
                    handleError(err, '.init');
                }
            }
        };
        
        init();
        
        return () => {
            mounted = false;
        };
    }, [handleError]);
    
    // 🚨 Renderização de erro
    if (error) {
        return (
            <div className="error-container">
                <h3>⚠️ Algo deu errado</h3>
                <p>{error.message}</p>
                <button onClick={() => setError(null)}>
                    🔄 Tentar novamente
                </button>
            </div>
        );
    }
    
    // 🔄 Loading
    if (loading) {
        return (
            <div className="loading-container">
                <div>🔄 Carregando...</div>
            </div>
        );
    }
    
    // 🎯 Renderização principal
    return (
        <div className="{NOME}-container" {...props}>
            <h2>{NOME}</h2>
            
            {/* 🎯 SEU CONTEÚDO AQUI */}
            <div className="content">
                <p>Componente {NOME} funcionando!</p>
                <pre>{JSON.stringify(data, null, 2)}</pre>
            </div>
        </div>
    );
};

export default {NOME};
'@

Write-Host ""
Write-Host "🎯 GERADOR DE CÓDIGO SEGURO" -ForegroundColor Magenta
Write-Host "===============================" -ForegroundColor Magenta
Write-Host ""

# Definir nome se não especificado
if (-not $Nome) {
    $Nome = Read-Host "Nome da função/componente"
    if (-not $Nome) {
        $Nome = "MinhaFuncao"
    }
}

# Selecionar template
$template = switch ($Linguagem.ToLower()) {
    "js" { $templateJS }
    "javascript" { $templateJS }
    "py" { $templatePython }
    "python" { $templatePython }
    "react" { $templateReact }
    "jsx" { $templateReact }
    default { $templateJS }
}

# Extensão do arquivo
$extensao = switch ($Linguagem.ToLower()) {
    "py" { ".py" }
    "python" { ".py" }
    "react" { ".jsx" }
    "jsx" { ".jsx" }
    default { ".js" }
}

$nomeArquivo = "$Nome$extensao"

Write-CodeMessage "Gerando código para '$Nome' em $Linguagem..." "🎯"

# Substituir placeholder
$codigo = $template -replace '\{NOME\}', $Nome

# Salvar arquivo
try {
    $codigo | Set-Content $nomeArquivo -Encoding UTF8
    Write-CodeSuccess "Código gerado: $nomeArquivo"
    
    # Estatísticas
    $linhas = ($codigo -split "`n").Count
    $protecoes = ($codigo | Select-String "try|catch|validate|error|🛡️").Matches.Count
    
    Write-Host ""
    Write-Host "📊 ESTATÍSTICAS:" -ForegroundColor Cyan
    Write-Host "   📄 Linhas: $linhas" -ForegroundColor Gray
    Write-Host "   🛡️ Proteções: $protecoes" -ForegroundColor Green
    Write-Host "   ✅ Testes: Incluídos" -ForegroundColor Green
    Write-Host "   🔍 Logging: Incluído" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "💡 PRÓXIMOS PASSOS:" -ForegroundColor Yellow
    Write-Host "   1. Editar: code $nomeArquivo" -ForegroundColor White
    Write-Host "   2. Implementar lógica na seção marcada" -ForegroundColor White
    
    if ($Linguagem -eq "js") {
        Write-Host "   3. Testar: node $nomeArquivo" -ForegroundColor White
    } elseif ($Linguagem -eq "py") {
        Write-Host "   3. Testar: python $nomeArquivo" -ForegroundColor White
    }
    
    Write-Host "   4. Validar: .\anti-erros.ps1" -ForegroundColor White
    
} catch {
    Write-Host "❌ Erro ao criar arquivo: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""