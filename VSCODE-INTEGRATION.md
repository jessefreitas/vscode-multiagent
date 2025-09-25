# 🚀 VS Code Integration Guide - MultiAgent + SCPO

## ✅ Integração Completada!

O sistema MultiAgent + SCPO agora está **totalmente integrado** ao VS Code. Aqui está tudo que foi configurado:

## 🎯 Recursos Instalados

### 1. **Extensão SCPO** ✅

- ✅ 40+ snippets especializados por domínio
- ✅ Comandos integrados no Command Palette
- ✅ IntelliSense para padrões SCPO
- ✅ Syntax highlighting para arquivos .scpo

### 2. **Configurações VS Code** ✅

- ✅ Settings otimizados para desenvolvimento SCPO
- ✅ Associações de arquivo (.scpo, multiagent.json)
- ✅ Terminal integrado com mensagens MultiAgent
- ✅ Formatação automática e code actions

### 3. **Atalhos de Teclado** ✅

Todos começam com `Ctrl+Shift+M`:

| Atalho           | Comando  | Descrição                  |
| ---------------- | -------- | -------------------------- |
| `Ctrl+Shift+M G` | Generate | Gerar código com SCPO      |
| `Ctrl+Shift+M R` | Review   | Analisar arquivo atual     |
| `Ctrl+Shift+M E` | Execute  | Executar arquivo (dry-run) |
| `Ctrl+Shift+M S` | Status   | Status do projeto          |
| `Ctrl+Shift+M L` | List     | Listar prompts SCPO        |
| `Ctrl+Shift+M P` | Search   | Buscar prompts             |
| `Ctrl+Shift+M I` | Init     | Inicializar projeto        |
| `Ctrl+Shift+M H` | Help     | Ajuda                      |
| `Ctrl+Shift+M B` | Backup   | Backup do projeto          |
| `Ctrl+Shift+M C` | Clean    | Limpar cache               |

### 4. **Tasks Integradas** ✅

Acesse via `Ctrl+Shift+P > Tasks: Run Task`:

- ✅ MultiAgent: Generate Code
- ✅ MultiAgent: Review Current File
- ✅ MultiAgent: Execute Current File (Dry Run)
- ✅ MultiAgent: Project Status
- ✅ SCPO: List Available Prompts
- ✅ SCPO: Search Prompts
- ✅ MultiAgent: Initialize Project with SCPO
- ✅ MultiAgent: Backup Project
- ✅ MultiAgent: Clean Cache

### 5. **Debugging Configurado** ✅

Pressione `F5` para debugar:

- ✅ Debug Generate Script
- ✅ Debug Review Script
- ✅ Debug MA Command

## 🎮 Como Usar

### Método 1: Atalhos de Teclado (Mais Rápido)

```
Ctrl+Shift+M G → Digite sua tarefa → Enter
Ctrl+Shift+M R → Review do arquivo atual
Ctrl+Shift+M S → Status do projeto
```

### Método 2: Command Palette

```
Ctrl+Shift+P → "Tasks: Run Task" → Selecionar task
Ctrl+Shift+P → "SCPO" → Comandos da extensão
```

### Método 3: Terminal Integrado

```bash
# Terminal já configurado com MultiAgent
ma generate "sua tarefa" backend
ma scpo list
ma review arquivo.py --scpo
```

### Método 4: Snippets SCPO

```
Digite "scpo" + Tab → Vários snippets aparecem
Digite "ma" + Tab → Templates MultiAgent
Digite domínio (backend, frontend, etc.) + Tab → Templates específicos
```

## 🧠 Snippets SCPO Disponíveis

### Gerais

- `scpo-task` → Template de task SCPO completo
- `scpo-validation` → Padrão de validação
- `scpo-processing` → Estrutura de processamento
- `scpo-error` → Tratamento de erros SCPO

### Por Linguagem

**Python:**

- `scpo-py-class` → Classe Python com padrões SCPO
- `scpo-py-async` → Função assíncrona SCPO
- `scpo-py-api` → API Flask/FastAPI com SCPO

**JavaScript:**

- `scpo-js-class` → Classe ES6 com SCPO
- `scpo-js-async` → Função async/await SCPO
- `scpo-js-express` → API Express com SCPO

**TypeScript:**

- `scpo-ts-interface` → Interface TypeScript SCPO
- `scpo-ts-service` → Service class com SCPO

### Por Domínio

**Backend:**

- `scpo-backend-api` → REST API completa
- `scpo-backend-auth` → Autenticação JWT
- `scpo-backend-db` → Operações de banco

**Frontend:**

- `scpo-frontend-component` → Componente React/Vue
- `scpo-frontend-hook` → Custom Hook React
- `scpo-frontend-store` → State management

**Testing:**

- `scpo-test-unit` → Teste unitário
- `scpo-test-integration` → Teste de integração
- `scpo-test-e2e` → Teste end-to-end

## 🎨 Interface Visual

### Status Bar

O VS Code agora mostra:

- 🤖 Status do MultiAgent
- 📊 Compliance SCPO
- ⚡ Última operação

### Explorer

- 📁 Pasta `prompts/` com ícone especial
- 📁 Pasta `scripts/` destacada
- 📁 `.multiagent-cache/` com ícone de cache

### Command Palette

Busque por:

- "SCPO" → Comandos da extensão
- "MultiAgent" → Tasks do sistema
- "MA:" → Ações rápidas

## 🚀 Workflow Otimizado

### 1. Desenvolvimento Diário

```
1. Ctrl+Shift+M S (verificar status)
2. Ctrl+Shift+M G (gerar código quando necessário)
3. Ctrl+Shift+M R (review contínuo)
4. Ctrl+Shift+M E (testar antes de commit)
```

### 2. Início de Projeto

```
1. Ctrl+Shift+M I (inicializar com SCPO)
2. Ctrl+Shift+M L (explorar prompts disponíveis)
3. Configurar domínio principal no settings.json
```

### 3. Debugging e Análise

```
1. F5 → Debug scripts MultiAgent
2. Ctrl+Shift+M R → Review detalhado
3. Logs em .multiagent-cache/logs/
```

## 🔧 Personalização

### Modificar Settings

Edite `.vscode/settings.json`:

```json
{
  "scpo.domainContext": "seu-dominio-preferido",
  "multiagent.autoReview": true,
  "scpo.tokenOptimization": true
}
```

### Adicionar Atalhos

Edite `.vscode/keybindings.json` para adicionar seus próprios atalhos.

### Criar Tasks Customizadas

Adicione em `.vscode/tasks.json` suas próprias automações.

## 📊 Monitoramento

### Logs e Cache

- ✅ Logs em `.multiagent-cache/logs/`
- ✅ Sessions em `.multiagent-cache/scpo-session-*.log`
- ✅ Reviews em `.multiagent-cache/scpo-review-*.md`

### Métricas

- ✅ Tempo de geração
- ✅ Compliance SCPO score
- ✅ Token usage optimization
- ✅ Quality metrics

## 🎯 Próximos Passos

1. **Explore os snippets** digitando `scpo` + Tab
2. **Teste os atalhos** Ctrl+Shift+M + letra
3. **Use o Command Palette** com "SCPO" e "MultiAgent"
4. **Configure seu domínio preferido** em settings.json
5. **Crie workflows personalizados** em tasks.json

## 🆘 Problemas Comuns

### Extensão não carregou

```bash
# Reinstalar extensão
code --uninstall-extension scpo-toolkit
cd vscode-extension-scpo
code --install-extension scpo-toolkit-1.0.0.vsix
```

### Atalhos não funcionam

- Verifique se `.vscode/keybindings.json` existe
- Reinicie o VS Code
- Verifique conflitos em File > Preferences > Keyboard Shortcuts

### Tasks não aparecem

- Abra Command Palette: Ctrl+Shift+P
- Digite "Tasks: Run Task"
- Se não aparecer, verifique `.vscode/tasks.json`

### Terminal não reconhece `ma`

```bash
# Verificar se está no diretório correto
pwd
# Deve mostrar: C:\vscode-multiagent-setup

# Testar manualmente
.\scripts\ma.ps1 help
```

---

## 🎉 Pronto!

Seu **VS Code está totalmente integrado** com MultiAgent + SCPO!

**Teste agora:**

1. Pressione `Ctrl+Shift+M G`
2. Digite: "Create a simple REST API"
3. Escolha domínio: "backend"
4. Veja a mágica acontecer! ✨

**Comando completo de teste:**

```bash
Ctrl+Shift+M G → "Create user authentication API" → backend
```
