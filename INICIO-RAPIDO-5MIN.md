# ⚡ Início Rápido - 5 Minutos para Começar

## 🚀 Setup Inicial (1 minuto)

### **Verificar Sistema**
```powershell
# 1. Verificar se tudo está funcionando
.\scripts\ma.ps1 status

# 2. Abrir VS Code
code .
```

## 🎯 Seu Primeiro Código (2 minutos)

### **Via VS Code (Recomendado)**
1. **Pressione**: `Ctrl+Shift+M` depois `G`
2. **Digite**: "criar função Python para calcular média de lista"
3. **Escolha domínio**: backend
4. **Pronto!** Código gerado automaticamente

### **Via Terminal**
```powershell
# Gerar código SCPO
.\scripts\generate-code-scpo.ps1 -CodeTask "criar função Python para calcular média" -Domain backend -OutputFile "media.py"

# Review automático
.\scripts\ma.ps1 review media.py

# Executar seguro
.\scripts\ma.ps1 execute media.py -DryRun
```

## 🧠 GitHub Copilot + OmniForge (1 minuto)

### **Ativar Prompt Especializado**
1. **Copie** o conteúdo de `prompts/omniforge-orchestrator-agent.md`
2. **Configure** como prompt personalizado no GitHub Copilot
3. **Use comandos**:
   - `@omniforge: criar API completa`
   - `@backend: implementar autenticação`
   - `@frontend: criar interface moderna`

## 🎨 VS Code Produtivo (1 minuto)

### **Atalhos Essenciais**
- `Ctrl+Shift+M G` → **Gerar código**
- `Ctrl+Shift+M R` → **Revisar código**
- `Ctrl+Shift+M S` → **Status sistema**

### **Tasks Rápidas**
- `Ctrl+Shift+P` → `Tasks: Run Task` → **MultiAgent: Generate Code**

### **Snippets SCPO**
- Digite `scpo-` → **Templates automáticos**

## 🎯 Casos de Uso Imediatos

### **1. Resolver Problema Real (30 segundos)**
```powershell
# Exemplo: Preciso de uma API REST
.\scripts\ma.ps1 generate "criar API REST FastAPI com CRUD de usuários" -domain backend
```

### **2. Melhorar Código Existente (30 segundos)**
```powershell
# Review de arquivo existente
.\scripts\ma.ps1 review meu-codigo.py

# Sugestões automáticas de melhoria
```

### **3. Aprender/Estudar (30 segundos)**
```powershell
# Template educacional completo
.\scripts\ma.ps1 template datascience

# Estrutura profissional pronta!
```

## 🏆 Próximo Nível

### **Explore Mais:**
- 📖 **GUIA-INTEGRADO-COMPLETO.md** - Guia completo detalhado
- 📖 **VSCODE-INTEGRATION.md** - Recursos avançados VS Code
- 🔧 Personalize keybindings em `.vscode/keybindings.json`
- 🎨 Crie seus prompts em `prompts/`

### **Dicas Profissionais:**
1. **Use sempre** `Ctrl+Shift+M S` para verificar status
2. **Combine** comandos: generate → review → execute
3. **Explore** snippets SCPO para velocidade máxima
4. **Integre** com GitHub Copilot para poder total

---

## 🎉 Pronto! Você já está usando o sistema mais avançado de desenvolvimento com IA!

**🚀 Comece agora**: `Ctrl+Shift+M G` e digite sua primeira tarefa!