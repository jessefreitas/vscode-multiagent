#!/usr/bin/env pwsh
# 🤖 AGENTE PRINCIPAL - Versão Simplificada para Qualquer Projeto
# ==============================================================

param(
  [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
  [string[]]$Comando
)

$ComandoCompleto = $Comando -join " "

if (-not $ComandoCompleto) {
  Write-Host ""
  Write-Host "🤖 AGENTE PRINCIPAL - Assistente de Programação" -ForegroundColor Cyan
  Write-Host "===============================================" -ForegroundColor Cyan
  Write-Host "😊 Para quem não entende de código!" -ForegroundColor Green
  Write-Host ""
  Write-Host "💬 Como usar:" -ForegroundColor White
  Write-Host "   .\agente.ps1 \"quero um site de vendas\"" -ForegroundColor Yellow
  Write-Host "   .\agente.ps1 \"preciso de uma API\"" -ForegroundColor Yellow
  Write-Host "   .\agente.ps1 \"otimizar meu código\"" -ForegroundColor Yellow
  Write-Host ""
  Write-Host "🎯 Exemplos:" -ForegroundColor White
  Write-Host "   .\agente.ps1 \"criar um blog\"" -ForegroundColor Gray
  Write-Host "   .\agente.ps1 \"fazer um app de tarefas\"" -ForegroundColor Gray
  Write-Host "   .\agente.ps1 \"adicionar banco de dados\"" -ForegroundColor Gray
  Write-Host ""
  return
}

Write-Host ""
Write-Host "🤖 Agente Principal processando..." -ForegroundColor Cyan
Write-Host "Solicitação: $ComandoCompleto" -ForegroundColor Yellow
Write-Host ""

# Detectar tipo de projeto automaticamente
$tipo = "geral"
if ($ComandoCompleto -match "(site|website|página|html|web)") { $tipo = "website" }
elseif ($ComandoCompleto -match "(api|backend|servidor|rest)") { $tipo = "api" }
elseif ($ComandoCompleto -match "(app|aplicativo|mobile)") { $tipo = "app" }
elseif ($ComandoCompleto -match "(otimiz|melhor|performance)") { $tipo = "otimizacao" }

Write-Host "✅ Tipo detectado: $tipo" -ForegroundColor Green

# Simular geração de código (versão simplificada)
switch ($tipo) {
  "website" {
    Write-Host "🌐 Gerando website..." -ForegroundColor Cyan
        
    $html = @"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Site Gerado pelo Agente Principal</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2rem; text-align: center; }
        .content { padding: 2rem 0; }
        .feature { background: #f8f9fa; margin: 1rem 0; padding: 1.5rem; border-radius: 8px; }
        .footer { background: #333; color: white; text-align: center; padding: 1rem; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🚀 Site Criado pelo Agente Principal</h1>
        <p>Gerado automaticamente com base em: "$ComandoCompleto"</p>
    </div>
    
    <div class="container">
        <div class="content">
            <div class="feature">
                <h2>✨ Funcionalidade 1</h2>
                <p>Conteúdo gerado automaticamente baseado na sua solicitação.</p>
            </div>
            
            <div class="feature">
                <h2>🎯 Funcionalidade 2</h2>
                <p>Sistema responsivo e moderno, pronto para personalização.</p>
            </div>
            
            <div class="feature">
                <h2>🚀 Pronto para usar!</h2>
                <p>Site funcional gerado em segundos pelo Agente Principal.</p>
            </div>
        </div>
    </div>
    
    <div class="footer">
        <p>© $(Get-Date -Format 'yyyy') - Gerado pelo Agente Principal 🤖</p>
    </div>
</body>
</html>
"@
        
    $html | Set-Content "index.html"
    Write-Host "✅ index.html criado!" -ForegroundColor Green
  }
    
  "api" {
    Write-Host "🔌 Gerando API..." -ForegroundColor Cyan
        
    $api = @"
# 🤖 API Gerada pelo Agente Principal
# Baseada em: $ComandoCompleto

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

app = FastAPI(
    title="API Agente Principal",
    description="API gerada automaticamente",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {
        "message": "API funcionando!",
        "gerada_por": "Agente Principal 🤖",
        "baseada_em": "$ComandoCompleto"
    }

@app.get("/status")
def get_status():
    return {"status": "online", "agente": "principal"}

if __name__ == "__main__":
    print("🚀 Iniciando API...")
    uvicorn.run(app, host="0.0.0.0", port=8000)
"@
        
    $api | Set-Content "main.py"
        
    $requirements = @"
fastapi==0.104.1
uvicorn==0.24.0
"@
    $requirements | Set-Content "requirements.txt"
        
    Write-Host "✅ main.py criado!" -ForegroundColor Green
    Write-Host "✅ requirements.txt criado!" -ForegroundColor Green
    Write-Host "💡 Para executar: python main.py" -ForegroundColor Yellow
  }
    
  "app" {
    Write-Host "📱 Gerando estrutura de app..." -ForegroundColor Cyan
        
    $app = @"
# 🤖 App Gerado pelo Agente Principal
# Baseado em: $ComandoCompleto

import tkinter as tk
from tkinter import ttk, messagebox
import json
from datetime import datetime

class AgentePrincipalApp:
    def __init__(self, root):
        self.root = root
        self.root.title("App - Agente Principal 🤖")
        self.root.geometry("600x400")
        
        # Interface
        self.create_interface()
        
    def create_interface(self):
        # Título
        title = ttk.Label(self.root, text="🚀 App Criado pelo Agente Principal", 
                         font=("Arial", 16, "bold"))
        title.pack(pady=20)
        
        # Descrição
        desc = ttk.Label(self.root, text="Baseado em: $ComandoCompleto")
        desc.pack(pady=10)
        
        # Botões de exemplo
        ttk.Button(self.root, text="✨ Funcionalidade 1", 
                  command=self.funcao1).pack(pady=10)
        ttk.Button(self.root, text="🎯 Funcionalidade 2", 
                  command=self.funcao2).pack(pady=10)
        
    def funcao1(self):
        messagebox.showinfo("Sucesso", "Funcionalidade 1 executada!")
        
    def funcao2(self):
        messagebox.showinfo("Sucesso", "Funcionalidade 2 executada!")

if __name__ == "__main__":
    root = tk.Tk()
    app = AgentePrincipalApp(root)
    root.mainloop()
"@
        
    $app | Set-Content "app.py"
    Write-Host "✅ app.py criado!" -ForegroundColor Green
    Write-Host "💡 Para executar: python app.py" -ForegroundColor Yellow
  }
    
  default {
    Write-Host "💡 Gerando solução personalizada..." -ForegroundColor Cyan
        
    $readme = @"
# 🤖 Projeto Gerado pelo Agente Principal

## 📋 Descrição
Este projeto foi gerado automaticamente baseado em: **$ComandoCompleto**

## 🚀 Gerado em
$(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')

## ✨ Próximos Passos

1. **Personalize** o código conforme necessário
2. **Teste** as funcionalidades
3. **Deploy** quando estiver pronto

## 💡 Para melhorar

Use novamente o Agente Principal:
- ``.\agente.ps1 "adicionar funcionalidade X"``
- ``.\agente.ps1 "otimizar performance"``
- ``.\agente.ps1 "adicionar testes"``

## 🤖 Sobre o Agente Principal

Sistema de IA que gera código automaticamente baseado em linguagem natural.
Você só precisa descrever o que quer e o agente faz o resto!

---
*Gerado automaticamente pelo Agente Principal 🤖*
"@
        
    $readme | Set-Content "README.md"
    Write-Host "✅ README.md criado!" -ForegroundColor Green
  }
}

Write-Host ""
Write-Host "🎉 CONCLUÍDO COM SUCESSO!" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green
Write-Host ""
Write-Host "✅ Arquivos gerados baseados em: $ComandoCompleto" -ForegroundColor Green
Write-Host "📁 Localização: $(Get-Location)" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 Para modificar ou adicionar:" -ForegroundColor Cyan
Write-Host "   .\agente.ps1 \"adicionar nova funcionalidade\"" -ForegroundColor White
Write-Host ""