# 🎉 SEXTA-FEIRA ATIVAR PROJETO

[![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white)](https://docs.microsoft.com/en-us/powershell/)
[![VS Code](https://img.shields.io/badge/VS%20Code-007ACC?style=flat&logo=visual-studio-code&logoColor=white)](https://code.visualstudio.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> **🚀 Crie projetos completos com 1 comando! GitHub + Pasta + Agente Inteligente + VS Code = TUDO AUTOMÁTICO!**

## 🎯 **1 COMANDO = PROJETO COMPLETO**

```powershell
Sexta-Feira "meu-app" "aplicativo incrível que vai mudar o mundo"
```

**EM 30 SEGUNDOS:**
- ✅ Pasta criada em `C:\vscode\meu-app`
- ✅ Repositório GitHub criado e sincronizado
- ✅ VS Code configurado com agente inteligente
- ✅ Ambiente completo pronto para codar
- ✅ Agente que escreve código automaticamente

**ZERO configuração manual! ZERO conhecimento técnico!**

## 🌟 **Revolucionário para Leigos**

### ❌ **ANTES:** 2-3 horas configurando ambiente
### ✅ **AGORA:** 30 segundos = tudo pronto!

- 🤖 **Agente Ultra-Inteligente**: Escreve código sozinho
- 🎯 **Para Leigos**: Zero conhecimento técnico necessário  
- 🚀 **Automação Total**: GitHub + Local + VS Code + Deploy
- ⚡ **1 Comando**: Cria projeto profissional completo
- 🔥 **Qualidade Profissional**: Código otimizado automaticamente
- 📱 **Multi-Plataforma**: Web, Mobile, Desktop, APIs

## 🚀 Início Rápido

### **🎯 Para LEIGOS (Zero conhecimento técnico):**
```powershell
# Criar projeto novo automaticamente
novo MinhaLoja "uma loja online completa"
novo MeuApp "um app de lista de tarefas"

# Usar em pasta existente
quero "um site de vendas"
quero "uma API para mobile"
```

### **🛠️ Para Desenvolvedores:**
```powershell
# Clone e instale
git clone https://github.com/jessefreitas/vscode-multiagent.git
cd vscode-multiagent
.\install.ps1

# Use em qualquer projeto
ma init                              # Configurar projeto
ma "criar API REST Python"          # Gerar código inteligente
ma review arquivo.py                 # Revisar qualidade
ma execute script.py                 # Executar com segurança
```

## 🎯 Casos de Uso

### 🔧 Desenvolvedor Individual

```powershell
# Novo projeto Python
mkdir meu-projeto && cd meu-projeto
ma init -Type python -Interactive
ma generate "criar função fibonacci recursiva"
ma review fibonacci.py
```

### 👥 Equipe de Desenvolvimento

```powershell
# Padronizar configurações
ma init                              # Em cada projeto
# Todos terão as mesmas configurações de qualidade e segurança
```

### 🎓 Estudante/Aprendizado

```powershell
# Template completo para Data Science
ma template datascience
# Estrutura profissional pronta para usar
```

## 📊 Workflows de Agentes

### Geração de Código

```
1. 🧠 Coder Agent    → Analisa requisitos e gera código
2. 🔍 Reviewer Agent → Verifica qualidade e segurança
3. ⚡ Executor Agent → Testa em ambiente sandbox
4. 📊 Report Agent  → Gera relatório com métricas
```

### Revisão de Código

```
1. 🔒 Security Agent     → Detecta vulnerabilidades
2. 📈 Performance Agent  → Analisa complexidade
3. 🎨 Style Agent       → Verifica padrões
4. 🏗️ Architecture Agent → Valida design patterns
```

## 🛠️ Instalação Detalhada

### Pré-requisitos

- Windows 10/11
- PowerShell 5.1+
- VS Code instalado
- Git (opcional)

### Instalação

1. **Clone o repositório**:

   ```powershell
   git clone https://github.com/jessefreitas/vscode-multiagent.git
   ```

2. **Execute a instalação**:

   ```powershell
   cd vscode-multiagent
   .\install.ps1
   ```

3. **Reinicie o PowerShell** para ativar comando `ma`

## 📋 Comandos Disponíveis

| Comando       | Descrição                         | Exemplo                           |
| ------------- | --------------------------------- | --------------------------------- |
| `ma init`     | Inicializar projeto MultiAgent    | `ma init -Type python`            |
| `ma generate` | Gerar código baseado em descrição | `ma generate "criar classe User"` |
| `ma review`   | Analisar qualidade e segurança    | `ma review app.py`                |
| `ma execute`  | Executar código em sandbox        | `ma execute script.py`            |
| `ma template` | Criar projeto com template        | `ma template datascience`         |

## 🎨 Templates Disponíveis

### 📊 Data Science

```powershell
ma template datascience
```

- Estrutura completa de projeto
- Jupyter notebooks configurados
- Bibliotecas essenciais (pandas, numpy, matplotlib)
- Scripts de utilidades
- Virtual environment setup

### 🌐 Web API (Em desenvolvimento)

- Flask/FastAPI estruture
- Middleware configuration
- Authentication setup
- Database integration

### 🖥️ CLI Tool (Em desenvolvimento)

- Argparse configuration
- Logging setup
- Error handling
- Package structure

## 🔒 Recursos de Segurança

### Análise Automática

- ✅ Detecção de `eval()` e `exec()`
- ✅ Verificação de comandos OS
- ✅ Validação de imports perigosos
- ✅ Análise de strings hardcoded

### Execução Sandbox

- ✅ Timeout configurável (30s default)
- ✅ Backup automático antes da execução
- ✅ Logs detalhados de todas as operações
- ✅ Isolamento de ambiente

## 📊 Métricas e Relatórios

### Pontuação de Qualidade (0-10)

- **8-10**: Excelente qualidade
- **6-7**: Boa qualidade
- **4-5**: Qualidade moderada
- **0-3**: Necessita revisão

### Relatórios Gerados

- 📁 `.multiagent-cache/` - Logs de sessão
- 📊 Métricas de complexidade
- 🔒 Relatórios de segurança
- ⏱️ Tempos de execução

## 🔧 Configuração Avançada

### Personalizar Agentes

Edite `multiagent.json` no seu projeto:

```json
{
  "agents": {
    "enabled": ["coder", "reviewer", "executor"],
    "workflows": ["code-generation", "bug-fixing"]
  },
  "safety": {
    "maxExecutionTime": 30000,
    "sandboxEnabled": true
  }
}
```

### Configurações VS Code

O sistema aplica automaticamente:

- Settings otimizados por linguagem
- Tasks personalizadas
- Debug configurations
- Extensões recomendadas

## 🤝 Contribuindo

### Adicionar Novos Templates

1. Crie script em `/templates/create-[nome]-project.ps1`
2. Adicione ao comando `ma template`
3. Teste completamente
4. Envie Pull Request

### Melhorar Agentes

1. Modifique scripts em `/scripts/`
2. Adicione novos padrões de detecção
3. Teste com diferentes cenários
4. Documente mudanças

## 📝 Changelog

### v1.0.0 (2025-09-25)

- ✅ Sistema base completo
- ✅ Agentes Coder, Reviewer, Executor
- ✅ Template Data Science
- ✅ Comando unificado `ma`
- ✅ Análise de segurança automática
- ✅ Documentação completa

## 🆘 Suporte

### Problemas Comuns

**Comando `ma` não encontrado:**

```powershell
# Recarregar perfil
. $PROFILE
```

**Erro de execução de scripts:**

```powershell
# Como administrador
Set-ExecutionPolicy RemoteSigned
```

**VS Code não carrega configurações:**

1. Feche completamente o VS Code
2. Execute `ma init` novamente
3. Reabra o projeto

### Obter Ajuda e Documentação

- ⚡ **[Início Rápido - 5 Minutos](INICIO-RAPIDO-5MIN.md)** - Comece a usar agora!
- � **[Guia Integrado Completo](GUIA-INTEGRADO-COMPLETO.md)** - Documentação completa
- 💡 **[Exemplos Práticos](EXEMPLOS-PRATICOS.md)** - Casos de uso reais
- 🔧 **[Integração VS Code](VSCODE-INTEGRATION.md)** - Recursos avançados
- 🧠 **[Prompt OmniForge](prompts/omniforge-orchestrator-agent.md)** - GitHub Copilot
- 📊 **[Resumo da Integração](INTEGRATION-SUMMARY.md)** - Status do sistema
- 🐛 [Reportar Bug](https://github.com/jessefreitas/vscode-multiagent/issues)
- 💡 [Sugerir Funcionalidade](https://github.com/jessefreitas/vscode-multiagent/issues)

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🙏 Agradecimentos

- Inspirado nas melhores práticas de [AutoGen](https://github.com/microsoft/autogen)
- Baseado em padrões do [Semantic Kernel](https://github.com/microsoft/semantic-kernel)
- Workflows adaptados do [LangGraph](https://github.com/langchain-ai/langgraph)
- Arquitetura influenciada pelo [OpenAI Swarm](https://github.com/openai/swarm)

---

**🎉 Transforme seu desenvolvimento com Multiagentes! Comece agora: `git clone https://github.com/jessefreitas/vscode-multiagent.git`**
