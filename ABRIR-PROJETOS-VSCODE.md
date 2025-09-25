# 🚀 GUIA: Abrindo Projetos no VS Code com Agente Principal

## 🎯 **Cenário: Você abriu um projeto no VS Code e quer usar o Agente Principal**

### 📋 **Situações Comuns:**

#### **1️⃣ Projeto Completamente Novo (Pasta Vazia)**
#### **2️⃣ Projeto Existente (Sem Agente Principal)**  
#### **3️⃣ Projeto com Código (Quer melhorar/otimizar)**

---

## 🚀 **MÉTODO 1: Setup Automático (Mais Fácil)**

### **Passo 1: Abrir Terminal no VS Code**
- Pressione `Ctrl + Shift + ~` (til) 
- Ou: `Terminal → New Terminal`

### **Passo 2: Instalar o Agente Principal**
```powershell
# Método Rápido: Baixar e instalar automaticamente
iwr https://raw.githubusercontent.com/jessefreitas/vscode-multiagent/master/install-rapido.ps1 | iex

# Ou se já tiver o sistema em alguma pasta:
# Copiar de onde está instalado
xcopy "C:\caminho\do\vscode-multiagent-setup\*" "." /E /H /Y
```

### **Passo 3: Usar Imediatamente**
```powershell
# Para projeto novo
quero "um site de vendas online"

# Para melhorar projeto existente  
ma "otimizar este código"
ma "adicionar autenticação"
ma "criar API REST"
```

---

## 🛠️ **MÉTODO 2: Setup Manual (Mais Controle)**

### **Passo 1: Inicializar Projeto**
```powershell
# Baixar arquivos essenciais
ma init --download

# Ou copiar manualmente de uma instalação existente
```

### **Passo 2: Configurar VS Code**
```powershell
# Criar configurações VS Code
ma setup-vscode

# Isso cria:
# - .vscode/tasks.json (tarefas)
# - .vscode/settings.json (configurações)  
# - .vscode/keybindings.json (atalhos)
```

### **Passo 3: Testar Sistema**
```powershell
# Verificar se funciona
ma status

# Teste rápido
ma "criar função hello world"
```

---

## ⚡ **MÉTODO 3: Super Rápido (1 Comando)**

### **Se você quer ZERO complicação:**

```powershell
# Cole este comando no terminal e pressione Enter
& { iwr -useb https://raw.githubusercontent.com/jessefreitas/vscode-multiagent/master/setup-instant.ps1 } | iex; quero "melhorar meu projeto"
```

**Isso fará TUDO automaticamente:**
- ✅ Baixa o sistema
- ✅ Configura VS Code  
- ✅ Instala dependências
- ✅ Ativa o Agente Principal
- ✅ Pronto para usar!

---

## 🎯 **Exemplos Práticos por Situação:**

### **📁 Projeto Vazio (Nova pasta):**
```powershell
# Método 1: Comando único
quero "um site de portfólio pessoal"

# Método 2: Passo a passo
ma init
ma "criar estrutura básica de site"
```

### **💻 Projeto com Código Existente:**
```powershell
# Analisar e melhorar
ma "revisar todo o código deste projeto"
ma "otimizar performance"
ma "adicionar testes automatizados"
```

### **🔧 Projeto Específico (Ex: Python):**
```powershell
# Para projetos Python
ma "criar API FastAPI com banco de dados"
ma "adicionar testes pytest"
ma "dockerizar aplicação"
```

### **🌐 Projeto Web:**
```powershell
# Para projetos web
ma "criar frontend React moderno"
ma "adicionar sistema de login"
ma "integrar com API backend"
```

---

## 🎮 **Atalhos do VS Code (Depois de Configurado):**

### **Atalhos de Teclado:**
- `Ctrl+Shift+M Q` - Comando `quero` rápido
- `Ctrl+Shift+M G` - Comando `ma` rápido
- `Ctrl+Shift+M R` - Review código atual
- `Ctrl+Shift+M E` - Executar código

### **Command Palette (Ctrl+Shift+P):**
- "**SUPER FÁCIL**" - Interface visual para leigos
- "**MultiAgent Generate**" - Gerar código
- "**MultiAgent Review**" - Revisar código
- "**MultiAgent Status**" - Ver status do sistema

### **Tasks (Ctrl+Shift+P → Tasks):**
- "**🤖 Agente Principal: Gerar Código**"
- "**😊 SUPER FÁCIL: Só me diga o que quer!**"
- "**MultiAgent: Review Current File**"
- "**MultiAgent: Project Status**"

---

## 🔍 **Como Saber Se Está Funcionando:**

### **Teste Rápido:**
```powershell
# Digite no terminal
ma status
```

**Se aparecer:**
```
✅ MultiAgent Project: [Nome]
✅ SCPO Prompts: X available  
✅ SCPO VS Code Extension: Available
```

**= Está funcionando! 🎉**

### **Se Não Funcionar:**
```powershell
# Diagnóstico
ma help

# Reinstalar
ma clean
ma init --force
```

---

## 💡 **Fluxo Recomendado (Passo a Passo):**

### **1. Abrir VS Code no seu projeto**
- `File → Open Folder` 
- Ou arrastar pasta para VS Code

### **2. Abrir Terminal** 
- `Ctrl+Shift+~`

### **3. Um comando mágico:**
```powershell
quero "transformar este projeto em algo incrível"
```

### **4. Relaxar! 😊**
O Agente Principal fará tudo automaticamente!

---

## 🆘 **Problemas Comuns:**

### **"Comando não encontrado":**
```powershell
# Instalar sistema primeiro
iwr https://raw.githubusercontent.com/jessefreitas/vscode-multiagent/master/install.ps1 | iex
```

### **"Projeto não reconhecido":**
```powershell
# Inicializar
ma init --force
```

### **"Permissão negada":**
```powershell
# Executar como administrador
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 🎉 **Resultado Final:**

Depois de configurado, você pode:

- ✅ **Abrir qualquer projeto no VS Code**
- ✅ **Digite `quero "alguma coisa"` no terminal**  
- ✅ **O Agente Principal faz TUDO automaticamente**
- ✅ **Zero conhecimento técnico necessário!**

### **Exemplos Finais:**
```powershell
quero "adicionar sistema de login"
quero "criar banco de dados"  
quero "fazer deploy na nuvem"
quero "otimizar para mobile"
```

**É só pedir e o agente faz! 🤖✨**