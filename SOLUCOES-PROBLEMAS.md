# 🔧 SOLUCIONANDO PROBLEMAS COMUNS

## ❌ Problema: "Prompts não foram criados no projeto"

### 🎯 Solução Rápida:
```powershell
# Execute isto na pasta do seu projeto:
.\reparar-projeto.ps1
```

### 🔧 Soluções Alternativas:

#### 1. Corrigir apenas os prompts:
```powershell
.\corrigir-prompts.ps1
```

#### 2. Criar projeto novo (garantido):
```powershell
.\criar-projeto.ps1 MeuProjeto "descrição do projeto"
```

#### 3. Verificar manualmente:
```powershell
# Ver quantos prompts você tem:
Get-ChildItem prompts -Filter "*.md" | Measure-Object | Select-Object Count

# Deve mostrar Count = 10
```

---

## ✅ Verificação Completa

Depois de executar qualquer solução, verifique se tem tudo:

```powershell
.\ma.ps1 check
```

Deve mostrar:
- ✅ 10 prompts SCPO
- ✅ Scripts essenciais  
- ✅ Configurações OK
- ✅ Sistema funcionando

---

## 🚀 Comandos de Emergência

### Se NADA funcionar:
```powershell
# Baixar sistema completo novamente
.\install.ps1

# Criar projeto do zero
.\criar-projeto.ps1 MeuProjetoNovo "minha descrição"
```

### Para projetos existentes quebrados:
```powershell
# Reparar projeto atual
.\reparar-projeto.ps1

# Ou especificar caminho
.\reparar-projeto.ps1 C:\MeuProjeto
```

---

## 📞 Ainda com problemas?

1. **Verifique se está na pasta certa** - deve ter o arquivo `ma.ps1`
2. **Execute como administrador** se der erro de permissão
3. **Use caminhos absolutos** se estiver em dúvida

### Status esperado depois da correção:
```
📊 RELATÓRIO DE REPARAÇÃO
=========================
  📄 Prompts SCPO: 10/10  ✅
  🔧 Scripts: 5/5         ✅  
  ⚙️ Configurações: ✅
  📋 Projeto: ✅

🎉 PROJETO TOTALMENTE REPARADO!
```

**Pronto!** Agora pode usar normalmente:
```powershell
.\ma.ps1 safe-code MeuArquivo -Type js
```