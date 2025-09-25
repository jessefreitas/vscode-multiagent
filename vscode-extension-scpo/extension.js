const vscode = require('vscode');
const axios = require('axios');
const crypto = require('crypto');

/**
 * Classe principal da extensão SCPO
 */
class SCPOExtension {
    constructor() {
        this.statusBarItem = null;
        this.cache = new Map();
        this.tokenCount = 0;
    }

    /**
     * Ativa a extensão
     */
    activate(context) {
        console.log('SCPO Toolkit ativado!');

        // Criar status bar item
        this.statusBarItem = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Right, 100);
        this.statusBarItem.command = 'scpo.analyzeTokens';
        this.updateStatusBar();
        context.subscriptions.push(this.statusBarItem);

        // Registrar comandos
        this.registerCommands(context);

        // Configurar providers
        this.registerProviders(context);

        // Monitorar mudanças no editor
        vscode.window.onDidChangeActiveTextEditor(this.onEditorChange.bind(this));
    }

    /**
     * Registra todos os comandos da extensão
     */
    registerCommands(context) {
        const commands = [
            vscode.commands.registerCommand('scpo.generateBrief', this.generateBrief.bind(this)),
            vscode.commands.registerCommand('scpo.optimizePrompt', this.optimizePrompt.bind(this)),
            vscode.commands.registerCommand('scpo.analyzeTokens', this.analyzeTokens.bind(this)),
            vscode.commands.registerCommand('scpo.insertTemplate', this.insertTemplate.bind(this)),
            vscode.commands.registerCommand('scpo.cacheManagement', this.cacheManagement.bind(this)),
            vscode.commands.registerCommand('scpo.vibecoding', this.openVibecoding.bind(this))
        ];

        commands.forEach(cmd => context.subscriptions.push(cmd));
    }

    /**
     * Registra providers para autocompletar e hover
     */
    registerProviders(context) {
        // Completion provider para templates SCPO
        const completionProvider = vscode.languages.registerCompletionItemProvider(
            ['markdown', 'plaintext'],
            {
                provideCompletionItems: this.provideCompletions.bind(this)
            },
            'scpo:', '@'
        );

        // Hover provider para documentação
        const hoverProvider = vscode.languages.registerHoverProvider(
            ['php', 'typescript', 'javascript'],
            {
                provideHover: this.provideHover.bind(this)
            }
        );

        context.subscriptions.push(completionProvider, hoverProvider);
    }

    /**
     * Gera CODE_TASK_BRIEF interativo
     */
    async generateBrief() {
        try {
            const goal = await vscode.window.showInputBox({
                prompt: 'Qual é o objetivo da tarefa?',
                placeholder: 'Ex: Implementar endpoint GET /articles com paginação'
            });

            if (!goal) return;

            const language = await vscode.window.showQuickPick(
                ['PHP', 'TypeScript', 'JavaScript', 'Python', 'Java', 'C#'],
                { placeHolder: 'Selecione a linguagem principal' }
            );

            const constraints = await vscode.window.showInputBox({
                prompt: 'Constraints técnicos (separados por vírgula)',
                placeholder: 'Ex: PHP 8.2, PSR-12, Performance < 200ms'
            });

            const acceptance = await vscode.window.showInputBox({
                prompt: 'Critérios de aceite (separados por vírgula)',
                placeholder: 'Ex: Retorna 200 OK, Lista paginada, Testes incluídos'
            });

            const brief = {
                task_id: this.generateTaskId(),
                goal: goal,
                constraints: constraints ? constraints.split(',').map(c => c.trim()) : [],
                acceptance: acceptance ? acceptance.split(',').map(a => a.trim()) : [],
                priority: 'media',
                generated_at: new Date().toISOString()
            };

            // Inserir no editor
            const editor = vscode.window.activeTextEditor;
            if (editor) {
                const briefText = this.formatBrief(brief);
                editor.edit(editBuilder => {
                    editBuilder.insert(editor.selection.active, briefText);
                });
            }

            // Calcular tokens
            const tokens = this.estimateTokens(JSON.stringify(brief));
            this.tokenCount = tokens;
            this.updateStatusBar();

            vscode.window.showInformationMessage(`Brief gerado! Tokens estimados: ${tokens}`);

        } catch (error) {
            vscode.window.showErrorMessage(`Erro ao gerar brief: ${error.message}`);
        }
    }

    /**
     * Otimiza prompt para economia de tokens
     */
    async optimizePrompt() {
        const editor = vscode.window.activeTextEditor;
        if (!editor) {
            vscode.window.showWarningMessage('Nenhum editor ativo');
            return;
        }

        const selection = editor.selection;
        const text = editor.document.getText(selection.isEmpty ? undefined : selection);

        if (!text.trim()) {
            vscode.window.showWarningMessage('Selecione ou tenha texto no editor');
            return;
        }

        try {
            const originalTokens = this.estimateTokens(text);
            const optimizedText = this.optimizeText(text);
            const optimizedTokens = this.estimateTokens(optimizedText);
            const savings = Math.round(((originalTokens - optimizedTokens) / originalTokens) * 100);

            // Mostrar preview da otimização
            const choice = await vscode.window.showInformationMessage(
                `Otimização: ${originalTokens} → ${optimizedTokens} tokens (${savings}% economia)`,
                'Aplicar', 'Cancelar'
            );

            if (choice === 'Aplicar') {
                editor.edit(editBuilder => {
                    const range = selection.isEmpty ? 
                        new vscode.Range(0, 0, editor.document.lineCount, 0) : 
                        selection;
                    editBuilder.replace(range, optimizedText);
                });

                this.tokenCount = optimizedTokens;
                this.updateStatusBar();
            }

        } catch (error) {
            vscode.window.showErrorMessage(`Erro na otimização: ${error.message}`);
        }
    }

    /**
     * Analisa uso de tokens no documento atual
     */
    async analyzeTokens() {
        const editor = vscode.window.activeTextEditor;
        if (!editor) {
            vscode.window.showWarningMessage('Nenhum editor ativo');
            return;
        }

        const text = editor.document.getText();
        const tokens = this.estimateTokens(text);
        const lines = text.split('\n').length;
        const chars = text.length;
        
        const analysis = {
            tokens: tokens,
            lines: lines,
            characters: chars,
            tokensPerLine: Math.round(tokens / lines),
            efficiency: this.calculateEfficiency(text)
        };

        const message = `📊 Análise de Tokens:
Tokens: ${analysis.tokens}
Linhas: ${analysis.lines}
Caracteres: ${analysis.characters}
Tokens/Linha: ${analysis.tokensPerLine}
Eficiência: ${analysis.efficiency}%`;

        vscode.window.showInformationMessage(message, { modal: true });
    }

    /**
     * Insere template SCPO predefinido
     */
    async insertTemplate() {
        const templates = [
            { label: 'API Endpoint (PHP)', value: 'api-php' },
            { label: 'React Component', value: 'react-component' },
            { label: 'Unit Test (PHPUnit)', value: 'phpunit-test' },
            { label: 'Database Query', value: 'database-query' },
            { label: 'Refactoring Task', value: 'refactoring' }
        ];

        const selected = await vscode.window.showQuickPick(templates, {
            placeHolder: 'Selecione um template SCPO'
        });

        if (!selected) return;

        const template = this.getTemplate(selected.value);
        const editor = vscode.window.activeTextEditor;
        
        if (editor) {
            editor.edit(editBuilder => {
                editBuilder.insert(editor.selection.active, template);
            });
        }
    }

    /**
     * Gerencia cache semântico
     */
    async cacheManagement() {
        const actions = [
            { label: '📊 Ver Estatísticas', value: 'stats' },
            { label: '🗑️ Limpar Cache', value: 'clear' },
            { label: '📋 Exportar Cache', value: 'export' },
            { label: '📥 Importar Cache', value: 'import' }
        ];

        const action = await vscode.window.showQuickPick(actions, {
            placeHolder: 'Gerenciar Cache Semântico'
        });

        if (!action) return;

        switch (action.value) {
            case 'stats':
                this.showCacheStats();
                break;
            case 'clear':
                this.clearCache();
                break;
            case 'export':
                await this.exportCache();
                break;
            case 'import':
                await this.importCache();
                break;
        }
    }

    /**
     * Abre biblioteca Vibecoding
     */
    async openVibecoding() {
        const categories = [
            { label: '🚀 Backend Development', value: 'backend' },
            { label: '🎨 Frontend Development', value: 'frontend' },
            { label: '🧪 Tests & QA', value: 'tests' },
            { label: '🚀 DevOps & Infrastructure', value: 'devops' },
            { label: '🔄 Refactoring', value: 'refactoring' },
            { label: '📱 Mobile Development', value: 'mobile' },
            { label: '🗃️ Database & Data', value: 'database' }
        ];

        const category = await vscode.window.showQuickPick(categories, {
            placeHolder: 'Escolha uma categoria do Vibecoding'
        });

        if (category) {
            // Abrir arquivo correspondente ou webview
            const uri = vscode.Uri.joinPath(
                vscode.workspace.workspaceFolders[0].uri,
                'prompts',
                `prompts-${category.value}.md`
            );
            
            try {
                const doc = await vscode.workspace.openTextDocument(uri);
                await vscode.window.showTextDocument(doc);
            } catch (error) {
                vscode.window.showWarningMessage(`Categoria ${category.label} não encontrada localmente`);
            }
        }
    }

    // Métodos auxiliares
    generateTaskId() {
        const now = new Date();
        const date = now.toISOString().split('T')[0];
        const sequence = String(Math.floor(Math.random() * 1000)).padStart(3, '0');
        return `T-${date}-${sequence}`;
    }

    estimateTokens(text) {
        // Estimativa simples: ~4 caracteres por token
        return Math.ceil(text.length / 4);
    }

    optimizeText(text) {
        return text
            .replace(/\s+/g, ' ')  // Múltiplos espaços → um espaço
            .replace(/\n\s*\n/g, '\n')  // Linhas vazias múltiplas → uma
            .replace(/,\s+/g, ',')  // Espaços após vírgulas
            .trim();
    }

    calculateEfficiency(text) {
        const words = text.split(/\s+/).length;
        const tokens = this.estimateTokens(text);
        return Math.round((words / tokens) * 100);
    }

    formatBrief(brief) {
        return `## CODE_TASK_BRIEF

**Task ID**: ${brief.task_id}
**Goal**: ${brief.goal}
**Priority**: ${brief.priority}

**Constraints**:
${brief.constraints.map(c => `- ${c}`).join('\n')}

**Acceptance Criteria**:
${brief.acceptance.map(a => `- ${a}`).join('\n')}

---
*Generated by SCPO Toolkit at ${brief.generated_at}*
`;
    }

    getTemplate(type) {
        const templates = {
            'api-php': `# Tarefa: Implementar endpoint API
# Linguagem: PHP 8.2
# Framework: Slim Framework
# Objetivo: Endpoint RESTful com validação

# Entrada
GET /resource?param=value

# Saída Esperada
{
  "data": [...],
  "meta": {...}
}

# Constraints
- PSR-12 compliant
- Prepared statements
- Error handling

# Critérios de Aceite
- Retorna JSON válido
- Valida parâmetros
- Trata erros apropriadamente`,

            'react-component': `# Tarefa: Criar componente React
# Linguagem: TypeScript
# Framework: React 18
# Objetivo: Componente reutilizável

# Props
interface Props {
  data: DataType;
  onAction: (id: string) => void;
}

# Constraints
- TypeScript strict
- TailwindCSS only
- Acessibilidade WCAG 2.1

# Critérios de Aceite
- Props tipadas corretamente
- Responsivo mobile-first
- Keyboard navigation`
        };

        return templates[type] || '# Template não encontrado';
    }

    showCacheStats() {
        const stats = {
            entries: this.cache.size,
            hitRate: '85%',  // Mock data
            memoryUsage: '2.3 MB'
        };

        vscode.window.showInformationMessage(
            `📊 Cache Stats: ${stats.entries} entradas, ${stats.hitRate} hit rate, ${stats.memoryUsage} memória`
        );
    }

    clearCache() {
        this.cache.clear();
        vscode.window.showInformationMessage('🗑️ Cache limpo com sucesso!');
    }

    updateStatusBar() {
        if (this.statusBarItem) {
            this.statusBarItem.text = `$(robot) SCPO: ${this.tokenCount} tokens`;
            this.statusBarItem.show();
        }
    }

    onEditorChange(editor) {
        if (editor) {
            const text = editor.document.getText();
            this.tokenCount = this.estimateTokens(text);
            this.updateStatusBar();
        }
    }

    // Providers
    provideCompletions(document, position) {
        const completions = [
            new vscode.CompletionItem('scpo:brief', vscode.CompletionItemKind.Snippet),
            new vscode.CompletionItem('scpo:plan', vscode.CompletionItemKind.Snippet),
            new vscode.CompletionItem('scpo:test', vscode.CompletionItemKind.Snippet)
        ];

        return completions;
    }

    provideHover(document, position) {
        const range = document.getWordRangeAtPosition(position);
        const word = document.getText(range);
        
        if (word === 'SCPO') {
            return new vscode.Hover('**SCPO**: Sistema de Cadeia de Pensamento Operacional - Economiza tokens e padroniza prompts');
        }
    }

    deactivate() {
        if (this.statusBarItem) {
            this.statusBarItem.dispose();
        }
    }
}

// Instância global da extensão
let scpoExtension;

/**
 * Função de ativação da extensão
 */
function activate(context) {
    scpoExtension = new SCPOExtension();
    scpoExtension.activate(context);
}

/**
 * Função de desativação da extensão
 */
function deactivate() {
    if (scpoExtension) {
        scpoExtension.deactivate();
    }
}

module.exports = {
    activate,
    deactivate
};