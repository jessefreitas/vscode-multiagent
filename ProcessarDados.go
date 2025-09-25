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

// ProcessarDados executa operação com proteções automáticas
func ProcessarDados(params map[string]interface{}) *OperationResult {
    // 🛡️ Validação de entrada
    if params == nil {
        params = make(map[string]interface{})
    }
    
    // 🔍 Logging de entrada
    log.Printf("[ProcessarDados] Iniciando execução com params: %+v", params)
    
    // 🚨 Recuperação de panic
    defer func() {
        if r := recover(); r != nil {
            log.Printf("[ProcessarDados] Panic recuperado: %v", r)
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
    
    log.Printf("[ProcessarDados] Execução concluída: %+v", result)
    return result
}

// testProcessarDados executa teste da função
func testProcessarDados() {
    fmt.Println("🧪 Testando ProcessarDados...")
    
    result := ProcessarDados(map[string]interface{}{})
    
    if result.Success {
        fmt.Printf("✅ Teste passou: %+v\n", result)
    } else {
        fmt.Printf("❌ Teste falhou: %s\n", result.Error)
    }
}

func main() {
    testProcessarDados()
}
