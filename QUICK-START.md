# 🎯 Guia de Uso Rápido - Sistema MultiAgent

## ⚡ Instalação em 2 Minutos

1. **Clone ou baixe** este repositório
2. **Execute a instalação**:
   ```powershell
   .\install.ps1
   ```
3. **Reinicie** o PowerShell para ativar o comando `ma`

## 🚀 Uso Básico

### Novo Projeto
```powershell
# Criar e configurar projeto
mkdir MeuProjeto
cd MeuProjeto
ma init

# Criar template completo de Data Science
ma template datascience
```

### Gerar Código
```powershell
# Gerar código Python
ma generate "criar função que calcula fibonacci"

# Gerar código JavaScript
ma generate "criar API REST com express" 

# Gerar código C#
ma generate "criar serviço de autenticação"
```

### Revisar Código
```powershell
# Análise completa de qualidade
ma review meuarquivo.py

# Análise detalhada com métricas
ma review meuarquivo.py -Verbose
```

### Executar com Segurança
```powershell
# Teste seguro (dry run)
ma execute meuarquivo.py -DryRun

# Execução real em sandbox
ma execute meuarquivo.py
```

## 📋 Comandos Úteis

| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `ma init` | Inicializar projeto | `ma init -Type python -Interactive` |
| `ma generate` | Gerar código | `ma generate "criar classe User"` |
| `ma review` | Revisar código | `ma review app.py` |
| `ma execute` | Executar código | `ma execute script.py` |
| `ma template` | Criar template | `ma template datascience` |

## 🎨 Templates Disponíveis

### Data Science
```powershell
ma template datascience
```
- Estrutura completa de projeto
- Jupyter notebooks configurados  
- Bibliotecas essenciais (pandas, numpy, matplotlib)
- Scripts de utilidades
- Configuração de ambiente virtual

### Em Desenvolvimento
- `webapp` - Aplicação web Flask/FastAPI
- `cli` - Ferramenta linha de comando
- `api` - API REST com testes
- `desktop` - Aplicação desktop

## 🔧 Configuração Avançada

### Projeto Interativo
```powershell
ma init -Interactive
```
- Detecta automaticamente o tipo de projeto
- Configuração guiada step-by-step
- Personalização de agentes e workflows

### Configurações por Linguagem
O sistema detecta automaticamente e aplica:

**Python**: 
- Virtual environment
- Linting com pylint
- Formatação com autopep8
- Testes com pytest

**JavaScript/Node.js**:
- NPM/Yarn support
- ESLint integration
- Prettier formatting
- Jest testing

**C#**:
- .NET Core configuration
- NuGet packages
- Debug configuration
- MSTest/xUnit support

## 🛡️ Recursos de Segurança

### Análise Automática
- Detecção de vulnerabilidades
- Padrões de código perigoso
- Validação de dependências
- Relatórios de segurança

### Execução Sandbox
- Timeout configurável
- Ambiente isolado
- Backup automático
- Logs detalhados

## 📊 Relatórios e Métricas

### Review de Código
- **Pontuação 0-10** baseada em qualidade
- **Análise de segurança** com padrões perigosos
- **Métricas de complexidade** ciclomática
- **Sugestões de melhoria** automáticas

### Logs de Execução
- Todos os logs em `.multiagent-cache/`
- Sessões numeradas por timestamp
- Output completo de stdout/stderr
- Métricas de performance

## 🎯 Workflows MultiAgent

### Geração de Código
1. **Coder Agent** → Análise e geração
2. **Reviewer Agent** → Qualidade e segurança  
3. **Optimizer Agent** → Performance e padrões

### Correção de Bugs
1. **Analyzer Agent** → Identificar causa raiz
2. **Fixer Agent** → Propor soluções
3. **Validator Agent** → Testar correções

## 📁 Estrutura de Arquivos

Após `ma init`, seu projeto terá:

```
projeto/
├── .vscode/
│   ├── settings.json    # Configurações VS Code
│   ├── tasks.json       # Tasks MultiAgent
│   └── launch.json      # Debug configuration
├── .multiagent-cache/   # Logs e cache
├── multiagent.json      # Configuração MultiAgent
├── .gitignore          # Incluindo entradas MultiAgent
└── test-multiagent.ps1 # Script de teste
```

## 🔄 Atualizações

```powershell
# Atualizar sistema MultiAgent
.\install.ps1 -Force

# Ou via comando
multiagent update
```

## 🆘 Solução de Problemas

### Comando `ma` não encontrado
```powershell
# Recarregar perfil
. $PROFILE

# Ou executar diretamente
& "$env:USERPROFILE\.vscode-multiagent\ma.ps1" init
```

### Erro de execução de scripts
```powershell
# Alterar política de execução (como admin)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

### VS Code não carrega configurações
1. Feche completamente o VS Code
2. Reabra o projeto
3. Verifique se `.vscode/` foi criado

## 💡 Dicas Pro

1. **Use `-Interactive`** para projetos novos
2. **Sempre execute `ma review`** antes de commit
3. **Use `ma execute -DryRun`** para testar segurança  
4. **Personalize `multiagent.json`** para suas necessidades
5. **Monitore logs** em `.multiagent-cache/` para debug

## 🤝 Contribuindo

Quer adicionar novos templates ou agentes?
1. Fork o repositório
2. Crie seu template em `/templates/`
3. Adicione ao `ma.ps1`
4. Teste completamente
5. Envie Pull Request

---

**🎉 Agora você tem um sistema completo de MultiAgent para desenvolvimento!**

Para mais detalhes, veja o [README.md](README.md) principal.