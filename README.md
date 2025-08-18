# NeoVini - Uma Configuração Neovim Completa para C# .NET

![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg?style=for-the-badge&logo=lua)

Configuração completa para o Neovim (v0.9+), transformando-o em uma IDE moderna e rápida para o desenvolvimento de aplicações C# .NET.

## ✨ Funcionalidades

### 🛠️ Desenvolvimento C#
* **LSP (IntelliSense):** 
    * Autocompletar inteligente com `csharp_ls`
    * Go-to-definition, referências, documentação inline
    * Code actions e refactoring
    * Diagnósticos em tempo real

* **Depurador Avançado:**
    * Build e Debug integrados (`<F5>`)
    * Interface visual com `nvim-dap-ui`
    * Breakpoints condicionais
    * Depuração de Web APIs com auto-abertura do navegador
    * Build automático antes do debug
    * Seleção interativa de projetos em soluções multi-projeto

* **Gerenciamento de Projetos:**
    * Adição de referências de projeto
    * Gerenciamento de pacotes NuGet
    * Execução de testes unitários (`<leader>tt`)

### 🎯 Editor
* **Autocompletar:** 
    * Suporte a LSP, snippets, paths e buffer
    * Navegação com Tab/Shift-Tab
    * Preview de documentação

* **Treesitter:**
    * Syntax highlighting avançado
    * Indentação inteligente
    * Suporte a C#, Lua, JSON, Markdown

* **Git:**
    * Visualização de mudanças inline
    * Stage/unstage de hunks
    * Navegação entre mudanças

### 🖥️ Interface
* **Tema:** Dracula com fundo transparente
* **Barra de Status:** Informativa e customizada
* **Explorador de Arquivos:** Tree-style com ícones
* **Terminal Integrado:** 
    * Modos flutuante e vertical
    * Integração com LazyGit
    * Auto-fechamento após comandos

### 🔍 Busca e Navegação
* **Telescope:**
    * Busca fuzzy em arquivos
    * Busca por texto em todo projeto
    * Seletor de projetos .NET
    * Live grep

## ⌨️ Atalhos Principais

### Desenvolvimento
* `<F5>` - Build e Debug do projeto selecionado
* `<F10>/<F11>/<F12>` - Step Over/Into/Out
* `<leader>b` - Toggle breakpoint
* `<leader>du` - Toggle interface do debugger
* `<leader>tt` - Rodar testes do projeto
* `<leader>r` - Rodar projeto sem debug

### Navegação
* `gd` - Ir para definição
* `gr` - Ver referências
* `K` - Mostrar documentação
* `<leader>ca` - Code actions
* `<C-j/k/h/l>` - Navegar entre splits

### Terminal & Git
* `<leader>ft` - Terminal flutuante
* `<leader>vt` - Terminal vertical
* `]h/[h` - Próxima/anterior mudança git
* `<leader>hs` - Stage hunk

## 🚀 Instalação

### Pré-requisitos
1. Neovim 0.9+
2. Git
3. .NET SDK 8+
4. netcoredbg (debugger)
5. Node.js
6. gcc/make
7. ripgrep & fd
8. Nerd Font

### Passos
1. Backup: `mv ~/.config/nvim ~/.config/nvim.bak`
2. Clone: `git clone <URL_DO_REPO> ~/.config/nvim`
3. Iniciar: `nvim` (instalação automática dos plugins)

## ⚙️ Configuração

### Estrutura
```
~/.config/nvim/
├── lua/
│   ├── core/           # Configurações base
│   ├── plugins/        # Configurações de plugins
│   └── utils/         # Funções utilitárias
└── init.lua          # Arquivo principal
```

### Personalização
* Temas: `lua/plugins/themes.lua`
* Atalhos: `lua/core/keymaps.lua`
* LSP/DAP: `lua/plugins/lsp/` e `lua/plugins/dap.lua`

## 🔧 Solução de Problemas

### Debug
* **Erro 404 no Swagger**: Verifique `ASPNETCORE_ENVIRONMENT='Development'`
* **Processo fecha imediatamente**: Confirme versão do .NET Runtime

### Visual
* **Ícones quebrados**: Instale e configure uma Nerd Font
* **Transparência não funciona**: Verifique configuração do terminal

### Diagnóstico
* `:checkhealth` - Verificação completa do sistema
