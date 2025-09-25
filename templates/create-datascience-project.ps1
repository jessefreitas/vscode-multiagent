# Template: Projeto Python - Data Science
param(
    [string]$ProjectName = "DataScienceProject",
    [string]$ProjectPath = "."
)

Write-Host "📊 Criando projeto Data Science: $ProjectName" -ForegroundColor Cyan

# Estrutura de pastas
$folders = @(
    "data/raw",
    "data/processed", 
    "data/external",
    "notebooks/exploratory",
    "notebooks/analysis", 
    "src/data",
    "src/features",
    "src/models",
    "src/visualization",
    "tests",
    "reports/figures",
    "references"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path "$ProjectPath/$folder" -Force | Out-Null
    Write-Host "✅ Criado: $folder" -ForegroundColor Green
}

# requirements.txt
$requirements = @"
# Core Data Science
numpy>=1.21.0
pandas>=1.3.0
scipy>=1.7.0
scikit-learn>=1.0.0

# Visualization  
matplotlib>=3.4.0
seaborn>=0.11.0
plotly>=5.0.0

# Jupyter
jupyter>=1.0.0
jupyterlab>=3.0.0
ipywidgets>=7.6.0

# Development
pytest>=6.0.0
black>=21.0.0
flake8>=3.9.0
mypy>=0.910

# Optional: Advanced ML
# tensorflow>=2.6.0
# torch>=1.9.0
# xgboost>=1.4.0
"@

$requirements | Set-Content "$ProjectPath/requirements.txt"
Write-Host "✅ requirements.txt criado" -ForegroundColor Green

# .gitignore para Data Science
$gitignore = @"
# Data Science specific
*.ipynb_checkpoints/
.pytest_cache/
.coverage
.mypy_cache/

# Data files (adjust as needed)
data/raw/*.csv
data/raw/*.json
data/raw/*.xlsx
data/processed/*.pkl
models/*.pkl
models/*.joblib

# Jupyter temporary files
.ipynb_checkpoints

# Environment
.env
.venv/
venv/

# IDE
.vscode/settings.json
.idea/

# OS
.DS_Store
Thumbs.db

# Python
__pycache__/
*.pyc
*.pyo
*.egg-info/
build/
dist/
"@

$gitignore | Set-Content "$ProjectPath/.gitignore"
Write-Host "✅ .gitignore criado" -ForegroundColor Green

# README.md do projeto
$readme = @"
# $ProjectName

## 🎯 Objetivo
Descrever o objetivo do projeto de Data Science aqui.

## 📊 Estrutura do Projeto
```
├── data/
│   ├── raw/          # Dados brutos, nunca editar
│   ├── processed/    # Dados limpos e processados  
│   └── external/     # Dados de fontes externas
├── notebooks/
│   ├── exploratory/  # Análise exploratória
│   └── analysis/     # Análises finais
├── src/
│   ├── data/         # Scripts para download e geração
│   ├── features/     # Scripts para feature engineering
│   ├── models/       # Scripts para treinar modelos
│   └── visualization/ # Scripts para visualização
├── tests/            # Testes unitários
├── reports/          # Relatórios gerados
│   └── figures/      # Gráficos para relatórios
└── references/       # Materiais de referência
```

## 🚀 Começando

1. **Configurar ambiente**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   # ou
   venv\Scripts\activate     # Windows
   pip install -r requirements.txt
   ```

2. **Explorar dados**:
   - Abra `notebooks/exploratory/01-initial-exploration.ipynb`
   - Comece com análise exploratória dos dados

3. **Desenvolver pipeline**:
   - Implemente processamento em `src/data/`
   - Feature engineering em `src/features/`
   - Modelos em `src/models/`

## 📈 Metodologia

1. **Entendimento do Negócio**
2. **Coleta e Exploração de Dados** 
3. **Preparação dos Dados**
4. **Modelagem**
5. **Avaliação** 
6. **Implantação**

## 🔧 Ferramentas

- **Python**: Linguagem principal
- **Pandas**: Manipulação de dados
- **Scikit-learn**: Machine Learning
- **Matplotlib/Seaborn**: Visualização
- **Jupyter**: Notebooks interativos

## 📝 Notebooks

- `01-initial-exploration.ipynb`: Primeira análise dos dados
- `02-data-cleaning.ipynb`: Limpeza e preparação
- `03-feature-engineering.ipynb`: Criação de features
- `04-model-training.ipynb`: Treinamento de modelos
- `05-model-evaluation.ipynb`: Avaliação e comparação

## 🧪 Testes

Execute os testes com:
```bash
pytest tests/
```

## 📊 Resultados

_Documentar principais findings e métricas aqui_
"@

$readme | Set-Content "$ProjectPath/README.md"
Write-Host "✅ README.md criado" -ForegroundColor Green

# Notebook inicial
$initialNotebook = @{
    cells = @(
        @{
            cell_type = "markdown"
            metadata = @{}
            source = @(
                "# $ProjectName - Análise Exploratória Inicial`n",
                "`n",
                "**Objetivo**: Primeira exploração dos dados para entender estrutura, qualidade e características principais.`n",
                "`n",
                "**Data**: $(Get-Date -Format 'yyyy-MM-dd')`n"
            )
        },
        @{
            cell_type = "code"
            execution_count = $null
            metadata = @{}
            outputs = @()
            source = @(
                "# Imports principais`n",
                "import pandas as pd`n",
                "import numpy as np`n",
                "import matplotlib.pyplot as plt`n",
                "import seaborn as sns`n",
                "from pathlib import Path`n",
                "`n",
                "# Configurações`n",
                "plt.style.use('seaborn-v0_8')`n",
                "pd.set_option('display.max_columns', None)`n",
                "pd.set_option('display.max_rows', 100)`n",
                "`n",
                "print('✅ Bibliotecas importadas com sucesso')"
            )
        },
        @{
            cell_type = "code"
            execution_count = $null
            metadata = @{}
            outputs = @()
            source = @(
                "# Definir caminhos`n",
                "DATA_RAW = Path('../data/raw')`n",
                "DATA_PROCESSED = Path('../data/processed')`n",
                "FIGURES = Path('../reports/figures')`n",
                "`n",
                "# Criar diretórios se não existirem`n",
                "FIGURES.mkdir(parents=True, exist_ok=True)`n",
                "`n",
                "print(f'📁 Dados brutos: {DATA_RAW}')`n",
                "print(f'📁 Dados processados: {DATA_PROCESSED}')`n",
                "print(f'📁 Figuras: {FIGURES}')"
            )
        },
        @{
            cell_type = "markdown"
            metadata = @{}
            source = @(
                "## 📥 Carregamento dos Dados`n",
                "`n",
                "Substituir pelo seu código de carregamento:"
            )
        },
        @{
            cell_type = "code"
            execution_count = $null
            metadata = @{}
            outputs = @()
            source = @(
                "# TODO: Carregar seus dados aqui`n",
                "# df = pd.read_csv(DATA_RAW / 'dataset.csv')`n",
                "`n",
                "# Exemplo com dados sintéticos para demonstração`n",
                "np.random.seed(42)`n",
                "df = pd.DataFrame({`n",
                "    'feature_1': np.random.normal(0, 1, 1000),`n",
                "    'feature_2': np.random.exponential(2, 1000),`n",
                "    'feature_3': np.random.choice(['A', 'B', 'C'], 1000),`n",
                "    'target': np.random.randint(0, 2, 1000)`n",
                "})`n",
                "`n",
                "print(f'📊 Dataset carregado: {df.shape[0]} linhas, {df.shape[1]} colunas')`n",
                "df.head()"
            )
        },
        @{
            cell_type = "markdown"
            metadata = @{}
            source = @(
                "## 🔍 Análise Inicial"
            )
        },
        @{
            cell_type = "code"
            execution_count = $null
            metadata = @{}
            outputs = @()
            source = @(
                "# Informações gerais`n",
                "print('📊 Informações do Dataset:')`n",
                "print(f'Shape: {df.shape}')`n",
                "print(f'Memória: {df.memory_usage(deep=True).sum() / 1024**2:.2f} MB')`n",
                "`n",
                "df.info()"
            )
        },
        @{
            cell_type = "code"
            execution_count = $null
            metadata = @{}
            outputs = @()
            source = @(
                "# Estatísticas descritivas`n",
                "df.describe(include='all')"
            )
        },
        @{
            cell_type = "markdown"
            metadata = @{}
            source = @(
                "## 📊 Visualizações Iniciais"
            )
        },
        @{
            cell_type = "code"
            execution_count = $null
            metadata = @{}
            outputs = @()
            source = @(
                "# Distribuições das variáveis numéricas`n",
                "numeric_cols = df.select_dtypes(include=[np.number]).columns`n",
                "`n",
                "fig, axes = plt.subplots(2, 2, figsize=(12, 8))`n",
                "axes = axes.ravel()`n",
                "`n",
                "for i, col in enumerate(numeric_cols[:4]):`n",
                "    if i < len(axes):`n",
                "        df[col].hist(bins=30, ax=axes[i])`n",
                "        axes[i].set_title(f'Distribuição de {col}')`n",
                "        axes[i].set_xlabel(col)`n",
                "        axes[i].set_ylabel('Frequência')`n",
                "`n",
                "plt.tight_layout()`n",
                "plt.savefig(FIGURES / 'distribuicoes_iniciais.png', dpi=300, bbox_inches='tight')`n",
                "plt.show()"
            )
        },
        @{
            cell_type = "markdown"
            metadata = @{}
            source = @(
                "## 📝 Próximos Passos`n",
                "`n",
                "1. **Limpeza de Dados**: Tratar valores faltantes, outliers`n",
                "2. **Feature Engineering**: Criar novas variáveis`n",
                "3. **Análise de Correlações**: Entender relações entre variáveis`n",
                "4. **Modelagem**: Começar com modelos simples`n",
                "5. **Avaliação**: Definir métricas apropriadas"
            )
        }
    )
    metadata = @{
        kernelspec = @{
            display_name = "Python 3"
            language = "python"
            name = "python3"
        }
        language_info = @{
            name = "python"
            version = "3.8.0"
        }
    }
    nbformat = 4
    nbformat_minor = 4
}

$initialNotebook | ConvertTo-Json -Depth 10 | Set-Content "$ProjectPath/notebooks/exploratory/01-initial-exploration.ipynb"
Write-Host "✅ Notebook inicial criado" -ForegroundColor Green

# Script de utilitários
$utilsScript = @"
"""
Utilitários comuns para projetos de Data Science
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path
from typing import List, Dict, Optional, Tuple
import warnings
warnings.filterwarnings('ignore')

class DataExplorer:
    """Classe para exploração automatizada de dados."""
    
    def __init__(self, df: pd.DataFrame):
        self.df = df.copy()
        
    def overview(self) -> None:
        """Visão geral do dataset."""
        print(f"📊 Dataset Overview")
        print("=" * 50)
        print(f"Shape: {self.df.shape}")
        print(f"Memory usage: {self.df.memory_usage(deep=True).sum() / 1024**2:.2f} MB")
        print(f"Duplicates: {self.df.duplicated().sum()}")
        
        missing = self.df.isnull().sum()
        if missing.sum() > 0:
            print(f"\n❌ Missing values:")
            print(missing[missing > 0].sort_values(ascending=False))
        else:
            print("\n✅ No missing values")
            
    def plot_distributions(self, figsize: Tuple[int, int] = (15, 10)) -> None:
        """Plotar distribuições das variáveis numéricas."""
        numeric_cols = self.df.select_dtypes(include=[np.number]).columns
        
        if len(numeric_cols) == 0:
            print("⚠️  No numeric columns found")
            return
            
        n_cols = 3
        n_rows = (len(numeric_cols) + n_cols - 1) // n_cols
        
        fig, axes = plt.subplots(n_rows, n_cols, figsize=figsize)
        axes = axes.ravel() if n_rows > 1 else [axes]
        
        for i, col in enumerate(numeric_cols):
            if i < len(axes):
                self.df[col].hist(bins=30, ax=axes[i], alpha=0.7)
                axes[i].set_title(f'{col}')
                axes[i].set_ylabel('Frequency')
                
        # Hide empty subplots
        for i in range(len(numeric_cols), len(axes)):
            axes[i].set_visible(False)
            
        plt.tight_layout()
        plt.show()
        
    def correlation_matrix(self, figsize: Tuple[int, int] = (10, 8)) -> None:
        """Matriz de correlação para variáveis numéricas."""
        numeric_df = self.df.select_dtypes(include=[np.number])
        
        if numeric_df.shape[1] < 2:
            print("⚠️  Not enough numeric columns for correlation")
            return
            
        plt.figure(figsize=figsize)
        corr = numeric_df.corr()
        
        mask = np.triu(np.ones_like(corr, dtype=bool))
        sns.heatmap(corr, mask=mask, annot=True, cmap='coolwarm', 
                   center=0, square=True, linewidths=0.5)
        plt.title('Correlation Matrix')
        plt.tight_layout()
        plt.show()

def load_data(file_path: str) -> pd.DataFrame:
    """Carregar dados com tratamento de erros."""
    try:
        if file_path.endswith('.csv'):
            return pd.read_csv(file_path)
        elif file_path.endswith(('.xlsx', '.xls')):
            return pd.read_excel(file_path)
        elif file_path.endswith('.json'):
            return pd.read_json(file_path)
        else:
            raise ValueError(f"Unsupported file format: {file_path}")
    except Exception as e:
        print(f"❌ Error loading data: {e}")
        return pd.DataFrame()

def save_processed_data(df: pd.DataFrame, filename: str, 
                       processed_dir: str = "data/processed") -> None:
    """Salvar dados processados."""
    Path(processed_dir).mkdir(parents=True, exist_ok=True)
    filepath = Path(processed_dir) / filename
    
    if filename.endswith('.csv'):
        df.to_csv(filepath, index=False)
    elif filename.endswith('.pkl'):
        df.to_pickle(filepath)
    
    print(f"✅ Data saved to {filepath}")
"@

$utilsScript | Set-Content "$ProjectPath/src/data/utils.py"
Write-Host "✅ Utilitários criados" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Template Data Science criado com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos passos:" -ForegroundColor Cyan
Write-Host "1. cd $ProjectPath" -ForegroundColor White
Write-Host "2. python -m venv venv" -ForegroundColor White
Write-Host "3. venv\Scripts\activate" -ForegroundColor White
Write-Host "4. pip install -r requirements.txt" -ForegroundColor White
Write-Host "5. jupyter lab" -ForegroundColor White