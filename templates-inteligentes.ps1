# 🎯 TEMPLATES INTELIGENTES ANTI-ERROS
# ====================================
# Gera código com proteções automáticas contra erros

param(
    [Parameter(Mandatory)]
    [string]$TemplateType,
    
    [string]$FileName = "",
    [string]$FunctionName = "",
    [string]$ClassName = "",
    [hashtable]$Parameters = @{}
)

function Write-TemplateMessage {
    param([string]$Message, [string]$Icon = "🎯")
    Write-Host "$Icon $Message" -ForegroundColor Cyan
}

function Write-TemplateSuccess {
    param([string]$Message, [string]$Icon = "✅")
    Write-Host "$Icon $Message" -ForegroundColor Green
}

# Templates anti-erros por linguagem
$templates = @{
    "js-function" = @"
/**
 * $FunctionName - Função com proteções anti-erros
 * @param {Object} params - Parâmetros da função
 * @returns {Promise<Object>} Resultado da operação
 */
async function $FunctionName(params = {}) {
    // 🛡️ Validação de entrada
    if (!params || typeof params !== 'object') {
        throw new Error('Parâmetros inválidos para $FunctionName');
    }
    
    // 🔍 Logging de entrada
    console.log('[$FunctionName] Iniciando execução', { params });
    
    try {
        // 🎯 IMPLEMENTAR LÓGICA AQUI
        const result = {
            success: true,
            data: null,
            message: 'Operação concluída com sucesso'
        };
        
        // ✅ Validação de saída
        if (!result || typeof result !== 'object') {
            throw new Error('Resultado inválido em $FunctionName');
        }
        
        console.log('[$FunctionName] Execução concluída', { result });
        return result;
        
    } catch (error) {
        // 🚨 Tratamento de erro robusto
        console.error('[$FunctionName] Erro na execução:', error);
        
        return {
            success: false,
            error: error.message,
            stack: error.stack,
            timestamp: new Date().toISOString()
        };
    }
}

// 🧪 Função de teste
async function test$FunctionName() {
    console.log('🧪 Testando $FunctionName...');
    
    try {
        const result = await $FunctionName({});
        console.log('✅ Teste passou:', result);
    } catch (error) {
        console.error('❌ Teste falhou:', error);
    }
}

// Executar teste se este for o arquivo principal
if (typeof require !== 'undefined' && require.main === module) {
    test$FunctionName();
}
"@

    "py-function" = @"
"""
$FunctionName - Função Python com proteções anti-erros
"""
import logging
import traceback
from typing import Dict, Any, Optional
from datetime import datetime

# 🔧 Configuração de logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def $FunctionName(params: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
    """
    $FunctionName com proteções automáticas contra erros
    
    Args:
        params (Dict[str, Any], optional): Parâmetros da função
        
    Returns:
        Dict[str, Any]: Resultado da operação
        
    Raises:
        ValueError: Se parâmetros inválidos
        Exception: Para outros erros
    """
    # 🛡️ Validação de entrada
    if params is None:
        params = {}
    
    if not isinstance(params, dict):
        raise ValueError("Parâmetros inválidos - esperado dict")
    
    # 🔍 Logging de entrada  
    logger.info("[$FunctionName] Iniciando execução", extra={'params': params})
    
    try:
        # 🎯 IMPLEMENTAR LÓGICA AQUI
        result = {
            'success': True,
            'data': None,
            'message': 'Operação concluída com sucesso',
            'timestamp': datetime.now().isoformat()
        }
        
        # ✅ Validação de saída
        if not isinstance(result, dict) or 'success' not in result:
            raise ValueError("Resultado inválido na função")
        
        logger.info("[$FunctionName] Execução concluída", extra={'result': result})
        return result
        
    except Exception as error:
        # 🚨 Tratamento de erro robusto
        logger.error("[$FunctionName] Erro na execução: " + str(error))
        logger.error(traceback.format_exc())
        
        return {
            'success': False,
            'error': str(error),
            'error_type': type(error).__name__,
            'traceback': traceback.format_exc(),
            'timestamp': datetime.now().isoformat()
        }

def test_$FunctionName():
    """🧪 Função de teste para $FunctionName"""
    print("🧪 Testando $FunctionName...")
    
    try:
        result = $FunctionName({})
        print("✅ Teste passou:", result)
    except Exception as error:
        print("❌ Teste falhou:", error)

if __name__ == "__main__":
    test_$FunctionName()
"@

    "cs-class" = @"
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.Extensions.Logging;

namespace AntiErros
{
    /// <summary>
    /// $ClassName - Classe C# com proteções anti-erros
    /// </summary>
    public class $ClassName
    {
        private readonly ILogger<$ClassName> _logger;
        
        /// <summary>
        /// Inicializa nova instância de $ClassName
        /// </summary>
        /// <param name="logger">Logger para rastreamento</param>
        public $ClassName(ILogger<$ClassName> logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }
        
        /// <summary>
        /// Método principal com proteções anti-erros
        /// </summary>
        /// <param name="parameters">Parâmetros da operação</param>
        /// <returns>Resultado da operação</returns>
        public async Task<OperationResult> ExecuteAsync(Dictionary<string, object> parameters = null)
        {
            // 🛡️ Validação de entrada
            parameters ??= new Dictionary<string, object>();
            
            _logger.LogInformation("[$ClassName.ExecuteAsync] Iniciando execução com parâmetros: {@Parameters}", parameters);
            
            try
            {
                // 🎯 IMPLEMENTAR LÓGICA AQUI
                var result = new OperationResult
                {
                    Success = true,
                    Data = null,
                    Message = "Operação concluída com sucesso",
                    Timestamp = DateTime.UtcNow
                };
                
                // ✅ Validação de saída
                if (result == null)
                {
                    throw new InvalidOperationException("Resultado nulo em $ClassName.ExecuteAsync");
                }
                
                _logger.LogInformation("[$ClassName.ExecuteAsync] Execução concluída: {@Result}", result);
                return result;
            }
            catch (Exception ex)
            {
                // 🚨 Tratamento de erro robusto
                _logger.LogError(ex, "[$ClassName.ExecuteAsync] Erro na execução");
                
                return new OperationResult
                {
                    Success = false,
                    Error = ex.Message,
                    ErrorType = ex.GetType().Name,
                    StackTrace = ex.StackTrace,
                    Timestamp = DateTime.UtcNow
                };
            }
        }
    }
    
    /// <summary>
    /// Resultado padronizado de operações
    /// </summary>
    public class OperationResult
    {
        public bool Success { get; set; }
        public object Data { get; set; }
        public string Message { get; set; }
        public string Error { get; set; }
        public string ErrorType { get; set; }
        public string StackTrace { get; set; }
        public DateTime Timestamp { get; set; }
    }
    
    /// <summary>
    /// 🧪 Classe de teste para $ClassName
    /// </summary>
    public static class ${ClassName}Tests
    {
        public static async Task RunTestsAsync()
        {
            Console.WriteLine("🧪 Testando $ClassName...");
            
            using var loggerFactory = LoggerFactory.Create(builder => builder.AddConsole());
            var logger = loggerFactory.CreateLogger<$ClassName>();
            var instance = new $ClassName(logger);
            
            try
            {
                var result = await instance.ExecuteAsync();
                Console.WriteLine(`$"✅ Teste passou: {result.Success}");
            }
            catch (Exception ex)
            {
                Console.WriteLine(`$"❌ Teste falhou: {ex.Message}");
            }
        }
    }
}
"@

    "api-endpoint" = @"
/**
 * 🛡️ API Endpoint com proteções anti-erros
 * Rota: /$FunctionName
 */

const express = require('express');
const rateLimit = require('express-rate-limit');
const helmet = require('helmet');
const validator = require('validator');

const router = express.Router();

// 🛡️ Middlewares de segurança
router.use(helmet());
router.use(rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100 // limite por IP
}));

// 🔍 Middleware de logging
router.use((req, res, next) => {
    console.log(`[API] ${req.method} ${req.path}`, {
        ip: req.ip,
        userAgent: req.get('User-Agent'),
        timestamp: new Date().toISOString()
    });
    next();
});

// 🛡️ Validação de entrada
const validate$FunctionName = (req, res, next) => {
    const errors = [];
    
    // Adicionar validações específicas aqui
    // Exemplo:
    // if (!req.body.email || !validator.isEmail(req.body.email)) {
    //     errors.push('Email inválido');
    // }
    
    if (errors.length > 0) {
        return res.status(400).json({
            success: false,
            errors: errors,
            message: 'Dados de entrada inválidos'
        });
    }
    
    next();
};

// 📝 GET /$FunctionName
router.get('/$FunctionName', async (req, res) => {
    try {
        const result = {
            success: true,
            data: {
                message: 'Endpoint $FunctionName funcionando',
                timestamp: new Date().toISOString()
            }
        };
        
        res.json(result);
        
    } catch (error) {
        console.error('[$FunctionName GET] Erro:', error);
        
        res.status(500).json({
            success: false,
            error: 'Erro interno do servidor',
            timestamp: new Date().toISOString()
        });
    }
});

// 📝 POST /$FunctionName
router.post('/$FunctionName', validate$FunctionName, async (req, res) => {
    try {
        // 🎯 IMPLEMENTAR LÓGICA AQUI
        const result = {
            success: true,
            data: req.body,
            message: 'Dados processados com sucesso'
        };
        
        res.status(201).json(result);
        
    } catch (error) {
        console.error('[$FunctionName POST] Erro:', error);
        
        res.status(500).json({
            success: false,
            error: 'Erro interno do servidor',
            timestamp: new Date().toISOString()
        });
    }
});

// 🚨 Middleware de tratamento de erros
router.use((error, req, res, next) => {
    console.error('[API Error]', error);
    
    res.status(500).json({
        success: false,
        error: 'Erro interno do servidor',
        timestamp: new Date().toISOString()
    });
});

module.exports = router;
"@

    "react-component" = @"
import React, { useState, useEffect, useCallback } from 'react';
import PropTypes from 'prop-types';

/**
 * 🛡️ $ClassName - Componente React com proteções anti-erros
 */
const $ClassName = ({ 
    initialData = {},
    onError = () => {},
    onSuccess = () => {},
    ...props 
}) => {
    // 🔄 Estados com valores padrão seguros
    const [data, setData] = useState(initialData);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    
    // 🛡️ Função para lidar com erros
    const handleError = useCallback((err, context = '') => {
        console.error(`[$ClassName${context}] Erro:`, err);
        
        const errorInfo = {
            message: err.message || 'Erro desconhecido',
            context: context,
            timestamp: new Date().toISOString()
        };
        
        setError(errorInfo);
        
        // Callback para componente pai
        if (typeof onError === 'function') {
            onError(errorInfo);
        }
    }, [onError]);
    
    // 🛡️ Função para operações assíncronas
    const safeAsyncOperation = useCallback(async (operation, operationName = 'operation') => {
        try {
            setLoading(true);
            setError(null);
            
            const result = await operation();
            
            // ✅ Validação de resultado
            if (result === undefined || result === null) {
                throw new Error(`Resultado inválido em ${operationName}`);
            }
            
            console.log(`[$ClassName.${operationName}] Sucesso:`, result);
            
            if (typeof onSuccess === 'function') {
                onSuccess(result);
            }
            
            return result;
            
        } catch (err) {
            handleError(err, `.${operationName}`);
            return null;
            
        } finally {
            setLoading(false);
        }
    }, [handleError, onSuccess]);
    
    // 🔄 Effect com cleanup
    useEffect(() => {
        let isMounted = true;
        
        const initializeComponent = async () => {
            if (!isMounted) return;
            
            try {
                // 🎯 IMPLEMENTAR INICIALIZAÇÃO AQUI
                console.log(`[$ClassName] Componente inicializado`);
                
            } catch (err) {
                if (isMounted) {
                    handleError(err, '.useEffect');
                }
            }
        };
        
        initializeComponent();
        
        // 🧹 Cleanup
        return () => {
            isMounted = false;
        };
    }, [handleError]);
    
    // 🚨 Renderização de erro
    if (error) {
        return (
            <div className="error-container" role="alert">
                <h3>⚠️ Algo deu errado</h3>
                <p>{error.message}</p>
                <button 
                    onClick={() => {
                        setError(null);
                        // Tentar reinicializar
                    }}
                    className="retry-button"
                >
                    🔄 Tentar novamente
                </button>
            </div>
        );
    }
    
    // 🔄 Renderização de loading
    if (loading) {
        return (
            <div className="loading-container">
                <div className="spinner">🔄</div>
                <p>Carregando...</p>
            </div>
        );
    }
    
    // 🎯 Renderização principal
    return (
        <div className="$($ClassName.ToLower())-container" {...props}>
            <h2>$ClassName</h2>
            
            {/* 🎯 IMPLEMENTAR CONTEÚDO AQUI */}
            <div className="content">
                <p>Componente $ClassName funcionando!</p>
                <pre>{JSON.stringify(data, null, 2)}</pre>
            </div>
            
            {/* 🛠️ Controles de desenvolvimento */}
            {process.env.NODE_ENV === 'development' && (
                <div className="dev-controls">
                    <button onClick={() => handleError(new Error('Erro de teste'), '.test')}>
                        🧪 Testar Erro
                    </button>
                </div>
            )}
        </div>
    );
};

// 🔍 PropTypes para validação
$ClassName.propTypes = {
    initialData: PropTypes.object,
    onError: PropTypes.func,
    onSuccess: PropTypes.func
};

// 📋 Default props
$ClassName.defaultProps = {
    initialData: {},
    onError: () => {},
    onSuccess: () => {}
};

export default $ClassName;

// 🧪 Para testes
export { $ClassName };
"@
}

Write-Host ""
Write-Host "🎯 TEMPLATES INTELIGENTES ANTI-ERROS" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Magenta
Write-Host ""

# Verificar se template existe
if (-not $templates.ContainsKey($TemplateType)) {
    Write-Host "❌ Template '$TemplateType' não encontrado!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Templates disponíveis:" -ForegroundColor Yellow
    foreach ($template in $templates.Keys) {
        Write-Host "   • $template" -ForegroundColor White
    }
    exit 1
}

# Definir nome do arquivo se não especificado
if (-not $FileName) {
    $extension = switch ($TemplateType) {
        "js-function" { ".js" }
        "py-function" { ".py" }
        "cs-class" { ".cs" }
        "api-endpoint" { ".js" }
        "react-component" { ".jsx" }
        default { ".txt" }
    }
    
    $baseName = if ($FunctionName) { $FunctionName } elseif ($ClassName) { $ClassName } else { "template" }
    $FileName = "$baseName$extension"
}

# Solicitar parâmetros se não fornecidos
if (-not $FunctionName -and $TemplateType -match "function|endpoint") {
    $FunctionName = Read-Host "Nome da função"
    if (-not $FunctionName) {
        $FunctionName = "minhaFuncao"
    }
}

if (-not $ClassName -and $TemplateType -match "class|component") {
    $ClassName = Read-Host "Nome da classe/componente"
    if (-not $ClassName) {
        $ClassName = "MinhaClasse"
    }
}

Write-TemplateMessage "Gerando template '$TemplateType'..." "🎯"
Write-TemplateMessage "Arquivo: $FileName" "📄"

# Expandir template
$templateContent = $templates[$TemplateType]

# Substituir variáveis no template
$templateContent = $templateContent -replace '\$FunctionName', $FunctionName
$templateContent = $templateContent -replace '\$ClassName', $ClassName
$templateContent = $templateContent -replace '\$FileName', ([System.IO.Path]::GetFileNameWithoutExtension($FileName))

# Salvar arquivo
try {
    $templateContent | Set-Content $FileName -Encoding UTF8
    Write-TemplateSuccess "Template criado: $FileName"
    
    # Mostrar estatísticas
    $lines = ($templateContent -split "`n").Count
    $protections = ($templateContent | Select-String "🛡️|try|catch|validate|error").Matches.Count
    
    Write-Host ""
    Write-Host "📊 ESTATÍSTICAS:" -ForegroundColor Cyan
    Write-Host "   📄 Linhas: $lines" -ForegroundColor Gray
    Write-Host "   🛡️ Proteções: $protections" -ForegroundColor Green
    Write-Host "   ✅ Testes incluídos: Sim" -ForegroundColor Green
    Write-Host "   🔍 Logging incluído: Sim" -ForegroundColor Green  
    Write-Host "   🚨 Error handling: Sim" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "💡 PRÓXIMOS PASSOS:" -ForegroundColor Yellow
    Write-Host "   1. Edite o arquivo gerado: code $FileName" -ForegroundColor White
    Write-Host "   2. Implemente sua lógica na seção marcada" -ForegroundColor White
    Write-Host "   3. Execute testes: node $FileName (JS) ou python $FileName (PY)" -ForegroundColor White
    Write-Host "   4. Valide com: .\anti-erros.ps1" -ForegroundColor White
    
} catch {
    Write-Host "❌ Erro ao criar arquivo: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""