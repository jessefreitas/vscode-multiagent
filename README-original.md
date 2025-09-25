# 🤖 Sistema Multiagente para VS Code - Configuração Global

Este repositório contém a configuração centralizada para implementar melhores práticas de multiagentes que escrevem código em todos os seus projetos no VS Code.

## 🚀 Instalação Rápida

```powershell
# 1. Clone este repositório
git clone https://github.com/jessefreitas/vscode-multiagent.git
cd vscode-multiagent

# 2. Execute o script de instalação
.\install.ps1

# 3. Reinicie o PowerShell para usar comando 'ma'
```

## 📁 Estrutura

```
vscode-multiagent-setup/
├── templates/                 # Templates para diferentes tipos de projeto
│   ├── python/
│   ├── javascript/
│   ├── csharp/
│   └── generic/
├── agents/                    # Definições de agentes especializados
│   ├── base/
│   ├── coder/
│   ├── reviewer/
│   └── executor/
├── workflows/                 # Fluxos de trabalho predefinidos
├── extensions/                # Configurações de extensões recomendadas
├── settings/                  # Configurações globais do VS Code
└── scripts/                   # Scripts de automação

## 🎯 Funcionalidades

- ✅ Configuração automática de agentes para qualquer projeto
- ✅ Templates prontos para diferentes linguagens
- ✅ Workflows de desenvolvimento com IA
- ✅ Integração com GitHub Copilot e outras extensões
- ✅ Sandboxing seguro para execução de código
- ✅ Sistema de review automático
- ✅ Métricas e monitoramento

## � Como Usar

### 1. Instalação Global
Execute o script de instalação para configurar o sistema em todo o VS Code:
```powershell
.\install.ps1
```

### 2. Inicializar Projeto
Para cada projeto novo, execute:
```powershell
# No diretório do projeto
pwsh -File "$env:USERPROFILE\.vscode-multiagent\scripts\init-project.ps1" -ProjectType python -Interactive
```

### 3. Usar Tasks do MultiAgent
No VS Code, pressione `Ctrl+Shift+P` e digite "Tasks: Run Task", depois selecione:
- **MultiAgent: Generate Code** - Gerar código com IA
- **MultiAgent: Review Code** - Revisar código atual  
- **MultiAgent: Execute Safely** - Executar código em sandbox

### 4. Comando Rápido 'ma'
Após a instalação, use o comando `ma` para acesso rápido:
```powershell
# Inicializar projeto
ma init

# Gerar código
ma generate "criar uma função que ordena lista de números"

# Revisar código
ma review meuarquivo.py

# Executar código com segurança
ma execute meuarquivo.py

# Criar template de projeto
ma template datascience
```

### 5. Scripts Disponíveis
- `init-project.ps1` - Inicializar projeto com configurações MultiAgent
- `generate-code.ps1` - Gerar código baseado em descrição de tarefa  
- `review-code.ps1` - Analisar qualidade e segurança do código
- `execute-code.ps1` - Executar código em ambiente controlado
- `ma.ps1` - Comando unificado para todas as operações

## 📋 Workflows Disponíveis

- **Code Generation**: Coder → Reviewer → Executor → Tester
- **Bug Fixing**: Analyzer → Fixer → Validator → Deployer  
- **Refactoring**: Analyzer → Architect → Refactor → Validator
- **Documentation**: Analyzer → Writer → Reviewer → Publisher

## ⚙️ Configuração

Veja os arquivos de configuração em `/settings/` para personalizar comportamentos.