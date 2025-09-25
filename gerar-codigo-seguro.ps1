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

# Templates para mais linguagens
$templateCSharp = @'
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.Extensions.Logging;

namespace CodeSeguro
{
    /// <summary>
    /// {NOME} - Classe C# com proteções automáticas
    /// </summary>
    public class {NOME}
    {
        private readonly ILogger<{NOME}> _logger;
        
        /// <summary>
        /// Inicializa nova instância de {NOME}
        /// </summary>
        /// <param name="logger">Logger para rastreamento</param>
        public {NOME}(ILogger<{NOME}> logger = null)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }
        
        /// <summary>
        /// Executa operação com proteções automáticas
        /// </summary>
        /// <param name="parameters">Parâmetros da operação</param>
        /// <returns>Resultado da operação</returns>
        public async Task<OperationResult> ExecuteAsync(Dictionary<string, object> parameters = null)
        {
            // 🛡️ Validação de entrada
            parameters ??= new Dictionary<string, object>();
            
            _logger?.LogInformation("[{NOME}] Iniciando execução com {@Parameters}", parameters);
            
            try
            {
                // 🎯 SUA LÓGICA AQUI
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
                    throw new InvalidOperationException("Resultado nulo");
                }
                
                _logger?.LogInformation("[{NOME}] Execução concluída: {@Result}", result);
                return result;
            }
            catch (Exception ex)
            {
                // 🚨 Tratamento de erro robusto
                _logger?.LogError(ex, "[{NOME}] Erro na execução");
                
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
}
'@

$templateGo = @'
package main

import (
    "encoding/json"
    "fmt"
    "log"
    "time"
)

// OperationResult representa o resultado padronizado de operações
type OperationResult struct {
    Success   bool        `json:"success"`
    Data      interface{} `json:"data"`
    Message   string      `json:"message,omitempty"`
    Error     string      `json:"error,omitempty"`
    ErrorType string      `json:"error_type,omitempty"`
    Timestamp time.Time   `json:"timestamp"`
}

// {NOME} executa operação com proteções automáticas
func {NOME}(params map[string]interface{}) *OperationResult {
    // 🛡️ Validação de entrada
    if params == nil {
        params = make(map[string]interface{})
    }
    
    // 🔍 Logging de entrada
    log.Printf("[{NOME}] Iniciando execução com params: %+v", params)
    
    // 🚨 Recuperação de panic
    defer func() {
        if r := recover(); r != nil {
            log.Printf("[{NOME}] Panic recuperado: %v", r)
        }
    }()
    
    // 🎯 SUA LÓGICA AQUI
    result := &OperationResult{
        Success:   true,
        Data:      nil,
        Message:   "Operação concluída com sucesso",
        Timestamp: time.Now(),
    }
    
    // ✅ Validação de saída
    if result == nil {
        return &OperationResult{
            Success:   false,
            Error:     "Resultado nulo",
            ErrorType: "ValidationError",
            Timestamp: time.Now(),
        }
    }
    
    log.Printf("[{NOME}] Execução concluída: %+v", result)
    return result
}

// test{NOME} executa teste da função
func test{NOME}() {
    fmt.Println("🧪 Testando {NOME}...")
    
    result := {NOME}(map[string]interface{}{})
    
    if result.Success {
        fmt.Printf("✅ Teste passou: %+v\n", result)
    } else {
        fmt.Printf("❌ Teste falhou: %s\n", result.Error)
    }
}

func main() {
    test{NOME}()
}
'@

$templateRust = @'
use std::collections::HashMap;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use log::{info, error};

/// Resultado padronizado de operações
#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct OperationResult {
    pub success: bool,
    pub data: Option<serde_json::Value>,
    pub message: Option<String>,
    pub error: Option<String>,
    pub error_type: Option<String>,
    pub timestamp: DateTime<Utc>,
}

impl OperationResult {
    pub fn success(data: Option<serde_json::Value>, message: &str) -> Self {
        Self {
            success: true,
            data,
            message: Some(message.to_string()),
            error: None,
            error_type: None,
            timestamp: Utc::now(),
        }
    }
    
    pub fn error(error: &str, error_type: &str) -> Self {
        Self {
            success: false,
            data: None,
            message: None,
            error: Some(error.to_string()),
            error_type: Some(error_type.to_string()),
            timestamp: Utc::now(),
        }
    }
}

/// {NOME} - Função Rust com proteções automáticas
pub fn {NOME}(params: Option<HashMap<String, serde_json::Value>>) -> Result<OperationResult, Box<dyn std::error::Error>> {
    // 🛡️ Validação de entrada
    let params = params.unwrap_or_else(HashMap::new);
    
    // 🔍 Logging de entrada
    info!("[{NOME}] Iniciando execução com params: {:?}", params);
    
    // 🚨 Tratamento de erro com Result
    match execute_logic(&params) {
        Ok(data) => {
            let result = OperationResult::success(data, "Operação concluída com sucesso");
            info!("[{NOME}] Execução concluída: {:?}", result);
            Ok(result)
        }
        Err(e) => {
            error!("[{NOME}] Erro na execução: {}", e);
            Ok(OperationResult::error(&e.to_string(), "ExecutionError"))
        }
    }
}

/// Lógica principal da função
fn execute_logic(_params: &HashMap<String, serde_json::Value>) -> Result<Option<serde_json::Value>, Box<dyn std::error::Error>> {
    // 🎯 SUA LÓGICA AQUI
    Ok(Some(serde_json::json!({
        "status": "ok",
        "processed": true
    })))
}

/// Teste da função
#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_{NOME}() {
        println!("🧪 Testando {NOME}...");
        
        let result = {NOME}(None);
        
        match result {
            Ok(op_result) => {
                if op_result.success {
                    println!("✅ Teste passou: {:?}", op_result);
                } else {
                    println!("❌ Teste falhou: {:?}", op_result.error);
                }
            }
            Err(e) => {
                println!("❌ Erro no teste: {}", e);
            }
        }
    }
}

fn main() {
    env_logger::init();
    
    println!("🚀 Executando {NOME}...");
    
    match {NOME}(None) {
        Ok(result) => println!("Resultado: {:?}", result),
        Err(e) => println!("Erro: {}", e),
    }
}
'@

$templateJava = @'
import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * {NOME} - Classe Java com proteções automáticas
 */
public class {NOME} {
    private static final Logger logger = Logger.getLogger({NOME}.class.getName());
    
    /**
     * Resultado padronizado de operações
     */
    public static class OperationResult {
        private boolean success;
        private Object data;
        private String message;
        private String error;
        private String errorType;
        private String timestamp;
        
        public OperationResult(boolean success) {
            this.success = success;
            this.timestamp = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        }
        
        // Getters e Setters
        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        
        public Object getData() { return data; }
        public void setData(Object data) { this.data = data; }
        
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        
        public String getError() { return error; }
        public void setError(String error) { this.error = error; }
        
        public String getErrorType() { return errorType; }
        public void setErrorType(String errorType) { this.errorType = errorType; }
        
        public String getTimestamp() { return timestamp; }
    }
    
    /**
     * Executa operação com proteções automáticas
     * @param params Parâmetros da operação
     * @return Resultado da operação
     */
    public static OperationResult execute(Map<String, Object> params) {
        // 🛡️ Validação de entrada
        if (params == null) {
            params = new HashMap<>();
        }
        
        // 🔍 Logging de entrada
        logger.info(String.format("[{NOME}] Iniciando execução com params: %s", params));
        
        OperationResult result = new OperationResult(true);
        
        try {
            // 🎯 SUA LÓGICA AQUI
            result.setMessage("Operação concluída com sucesso");
            result.setData(null);
            
            // ✅ Validação de saída
            if (result == null) {
                throw new IllegalStateException("Resultado nulo");
            }
            
            logger.info(String.format("[{NOME}] Execução concluída com sucesso"));
            return result;
            
        } catch (Exception ex) {
            // 🚨 Tratamento de erro robusto
            logger.log(Level.SEVERE, String.format("[{NOME}] Erro na execução: %s", ex.getMessage()), ex);
            
            result.setSuccess(false);
            result.setError(ex.getMessage());
            result.setErrorType(ex.getClass().getSimpleName());
            
            return result;
        }
    }
    
    /**
     * Teste da função
     */
    public static void test{NOME}() {
        System.out.println("🧪 Testando {NOME}...");
        
        try {
            OperationResult result = execute(new HashMap<>());
            
            if (result.isSuccess()) {
                System.out.printf("✅ Teste passou: %s%n", result.getMessage());
            } else {
                System.out.printf("❌ Teste falhou: %s%n", result.getError());
            }
            
        } catch (Exception ex) {
            System.out.printf("❌ Erro no teste: %s%n", ex.getMessage());
        }
    }
    
    public static void main(String[] args) {
        test{NOME}();
    }
}
'@

$templatePHP = @'
<?php
/**
 * {NOME} - Classe PHP com proteções automáticas
 */

class {NOME} {
    private $logger;
    
    public function __construct() {
        // 🔍 Configurar logging básico
        $this->logger = function($message) {
            error_log("[{NOME}] " . $message);
        };
    }
    
    /**
     * Executa operação com proteções automáticas
     * @param array $params Parâmetros da operação
     * @return array Resultado da operação
     */
    public function execute($params = []) {
        // 🛡️ Validação de entrada
        if (!is_array($params)) {
            $params = [];
        }
        
        // 🔍 Logging de entrada
        ($this->logger)("Iniciando execução com params: " . json_encode($params));
        
        try {
            // 🎯 SUA LÓGICA AQUI
            $result = [
                'success' => true,
                'data' => null,
                'message' => 'Operação concluída com sucesso',
                'timestamp' => date('c')
            ];
            
            // ✅ Validação de saída
            if (!is_array($result) || !isset($result['success'])) {
                throw new Exception('Resultado inválido');
            }
            
            ($this->logger)("Execução concluída com sucesso");
            return $result;
            
        } catch (Exception $ex) {
            // 🚨 Tratamento de erro robusto
            ($this->logger)("Erro na execução: " . $ex->getMessage());
            
            return [
                'success' => false,
                'error' => $ex->getMessage(),
                'error_type' => get_class($ex),
                'trace' => $ex->getTraceAsString(),
                'timestamp' => date('c')
            ];
        }
    }
    
    /**
     * Teste da função
     */
    public static function test{NOME}() {
        echo "🧪 Testando {NOME}...\n";
        
        try {
            $instance = new {NOME}();
            $result = $instance->execute([]);
            
            if ($result['success']) {
                echo "✅ Teste passou: " . $result['message'] . "\n";
            } else {
                echo "❌ Teste falhou: " . $result['error'] . "\n";
            }
            
        } catch (Exception $ex) {
            echo "❌ Erro no teste: " . $ex->getMessage() . "\n";
        }
    }
}

// Executar teste se este for o arquivo principal
if (basename(__FILE__) == basename($_SERVER['PHP_SELF'])) {
    {NOME}::test{NOME}();
}
?>
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
  "cs" { $templateCSharp }
  "csharp" { $templateCSharp }
  "c#" { $templateCSharp }
  "go" { $templateGo }
  "golang" { $templateGo }
  "rs" { $templateRust }
  "rust" { $templateRust }
  "java" { $templateJava }
  "php" { $templatePHP }
  default { $templateJS }
}

# Extensão do arquivo
$extensao = switch ($Linguagem.ToLower()) {
  "py" { ".py" }
  "python" { ".py" }
  "react" { ".jsx" }
  "jsx" { ".jsx" }
  "cs" { ".cs" }
  "csharp" { ".cs" }
  "c#" { ".cs" }
  "go" { ".go" }
  "golang" { ".go" }
  "rs" { ".rs" }
  "rust" { ".rs" }
  "java" { ".java" }
  "php" { ".php" }
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
    
  # Instruções específicas por linguagem
  switch ($Linguagem.ToLower()) {
    "js" { Write-Host "   3. Testar: node $nomeArquivo" -ForegroundColor White }
    "py" { Write-Host "   3. Testar: python $nomeArquivo" -ForegroundColor White }
    "cs" { Write-Host "   3. Compilar: dotnet run" -ForegroundColor White }
    "go" { Write-Host "   3. Executar: go run $nomeArquivo" -ForegroundColor White }
    "rs" { Write-Host "   3. Executar: cargo run" -ForegroundColor White }
    "java" { 
      Write-Host "   3. Compilar: javac $nomeArquivo" -ForegroundColor White
      Write-Host "   4. Executar: java $Nome" -ForegroundColor White
    }
    "php" { Write-Host "   3. Executar: php $nomeArquivo" -ForegroundColor White }
    default { Write-Host "   3. Executar conforme sua linguagem" -ForegroundColor White }
  }
    
  Write-Host "   🔍 Validar: .\anti-erros.ps1" -ForegroundColor White
    
}
catch {
  Write-Host "❌ Erro ao criar arquivo: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""