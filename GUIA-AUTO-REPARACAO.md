# 🔧 Guia Auto-Reparação Sexta-Feira

## 🎯 O que é?

A **Auto-Reparação** é um sistema que verifica e repara projetos Sexta-Feira, garantindo que todos os arquivos essenciais estejam presentes.

## 🚨 Quando usar?

### ✅ Use a Auto-Reparação quando:
- Clonou um projeto do GitHub e alguns arquivos estão faltando
- Scripts param de funcionar inexplicavelmente  
- Prompts SCPO não estão sendo carregados
- Projeto parece "incompleto" ou "quebrado"
- Quer garantir que tem todos os arquivos mais recentes

### ❌ NÃO precisa usar quando:
- Projeto está funcionando normalmente
- Acabou de criar com `sexta NomeProjeto`
- Só quer testar algo rápido

## 🛠️ Como usar?

### 🔧 **Opção 1: Reparação Simples**
```powershell
.\auto-reparacao.ps1
```

### 🔧 **Opção 2: Reparação com Detalhes**
```powershell
.\auto-reparacao.ps1 -Verbose
```

### 🔧 **Opção 3: Reparar Outro Projeto**
```powershell
.\auto-reparacao.ps1 -ProjectPath "C:\MeuOutroProjeto"
```

## 📊 O que ela verifica e repara?

### 🤖 **Scripts Essenciais:**
- `ma.ps1` - Agente principal
- `quero.ps1` - Interface simples  
- `agente.ps1` - Sistema de agente
- `generate-code-scpo.ps1` - Geração de código
- `review-code.ps1` - Revisão de código
- `execute-code.ps1` - Execução de código

### 📚 **Prompts SCPO (10 prompts):**
- `agente-principal-arroba.md` - Agente principal
- `backend-architecture.md` - Arquitetura backend
- `ui-design.md` - Design de interface
- `web-development.md` - Desenvolvimento web
- `code-optimization.md` - Otimização de código
- `documentation.md` - Documentação
- `testing-quality.md` - Testes e qualidade
- `product-strategy.md` - Estratégia de produto
- `omniforge-orchestrator-agent.md` - Orquestrador
- `README.md` - Documentação dos prompts

### 📄 **Arquivos Auxiliares:**
- `diagnostico-sexta.ps1` - Diagnóstico
- `instalar-sexta-global.ps1` - Instalação global
- `SEXTA-FEIRA-GUIA-LEIGOS.md` - Guia para leigos
- `STATUS-FINAL-SEXTA-FEIRA.md` - Status do sistema

## 📈 Exemplo de Saída

```
🔧 AUTO-REPARAÇÃO SEXTA-FEIRA
==============================

✅ Projeto Sexta-Feira detectado!
🔧 Verificando integridade dos arquivos...
⚠️  Encontrados 3 arquivos faltando - iniciando reparação...

🔧 Reparando 1 scripts essenciais...
⬇️  Baixando ma.ps1...
✅ ma.ps1 reparado!

🔧 Reparando 2 prompts SCPO...
📄 Baixando prompts/ui-design.md...
✅ prompts/ui-design.md reparado!
📄 Baixando prompts/testing-quality.md...
✅ prompts/testing-quality.md reparado!

🎉 AUTO-REPARAÇÃO CONCLUÍDA!
=========================

📊 PROJETO REPARADO - ESTATÍSTICAS:
   📁 Total de arquivos: 45
   📚 Prompts SCPO: 10
   🤖 Scripts essenciais: 6/6
   🔧 Sistema: ✅ COMPLETO

🚀 Projeto pronto para uso!

💡 Para testar:
   .\ma.ps1 'criar qualquer coisa'
   .\quero.ps1 'sua ideia aqui'
```

## 🎯 Casos de Uso Práticos

### 🔄 **Cenário 1: Clone do GitHub**
```powershell
git clone https://github.com/usuario/meu-projeto-sexta
cd meu-projeto-sexta
.\auto-reparacao.ps1
# ✅ Projeto pronto para usar!
```

### 🔧 **Cenário 2: Projeto Quebrado**
```powershell
# Script para de funcionar
.\quero.ps1 "criar um site"
# ❌ Erro: arquivo não encontrado

# Executar reparação
.\auto-reparacao.ps1
# ✅ Arquivos reparados!

# Tentar novamente
.\quero.ps1 "criar um site"  
# ✅ Funcionando!
```

### 📊 **Cenário 3: Verificação Preventiva**
```powershell
# Antes de trabalhar em projeto importante
.\auto-reparacao.ps1
# ✅ Todos os arquivos estão presentes! Projeto está completo.
```

## 🚨 Solução de Problemas

### ❌ **"Este não parece ser um projeto Sexta-Feira"**
**Solução:** Execute o comando na pasta correta que tem `multiagent.json`

### ❌ **"Falha ao reparar arquivo"**
**Soluções:**
- Verifique sua conexão com internet
- Execute novamente (pode ser temporário)
- Execute com `-Verbose` para mais detalhes

### ❌ **"Pasta não encontrada"**
**Solução:** Verifique se o caminho está correto:
```powershell
.\auto-reparacao.ps1 -ProjectPath "C:\Caminho\Correto\Projeto"
```

## 💡 Dicas

### ✅ **Boas Práticas:**
- Execute sempre após clonar projeto
- Use antes de apresentações importantes
- Execute se scripts parecem "quebrados"
- Mantenha uma cópia do `auto-reparacao.ps1` sempre

### 🚀 **Para Automação:**
```powershell
# Adicionar no final do clone
git clone https://github.com/usuario/projeto
cd projeto
.\auto-reparacao.ps1
```

---

**🎉 Com a Auto-Reparação, seus projetos Sexta-Feira sempre funcionarão perfeitamente!**