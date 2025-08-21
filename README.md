[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&color=2AF767&width=435&lines=NeoVini+-+Uma+Configura%C3%A7%C3%A3o+Neovim%3A;C%23+.NET!)](https://git.io/typing-svg)

![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg?style=for-the-badge&logo=lua)
[![Neovim](https://img.shields.io/badge/Neovim%200.9+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

**NeoVini** é uma configuração completa para o Neovim (v0.9+), transformando-o em uma IDE moderna, rápida e poderosa, otimizada para o desenvolvimento de aplicações C# .NET.

![Tela inicial do NeoVini](lua\img\4cbd721f-f883-4791-9c67-a7901e915a03.jpg)
![Código em C# no NeoVini](lua\img\5a2d5c3b-5667-4a41-9948-650c125ad9ab.jpg)

## ✨ Filosofia e Funcionalidades

A filosofia é ser **leve na inicialização** e **poderoso na execução**. Usando `lazy.nvim`, os plugins são carregados sob demanda, garantindo um arranque quase instantâneo, sem sacrificar as funcionalidades de uma IDE completa.

### Gerenciamento de Código e LSP

* **IntelliSense Completo:** Configuração automática de `csharp-ls` via `mason.nvim` para análise de código em tempo real.
* **Autocompletar Inteligente:** `nvim-cmp` com fontes para LSP, snippets, buffers e caminhos.
* **Biblioteca de Snippets:** `friendly-snippets` pré-carregada com dezenas de atalhos para C# (ex: `prop`, `ctor`, `for`).
* **Adição Automática de `using`:** As diretivas `using` são adicionadas, removidas e ordenadas automaticamente ao salvar.
* **Template de Classe:** Atalho para gerar uma nova classe com o namespace e nome corretos, baseados na estrutura da sua solução.
* **Renomeação Interativa:** `inc-rename.nvim` para renomear variáveis e métodos com feedback visual em tempo real.

### Depuração e Testes

* **Debugger Integrado:** `nvim-dap` com `nvim-dap-ui` para uma experiência de depuração visual completa.
* **Fluxo de Debug Inteligente:** Um atalho (`<F5>`) que permite selecionar o projeto, compilá-lo e iniciar a depuração, abrindo o navegador para Web APIs.
* **Executor de Testes:** Atalho para selecionar e rodar projetos de teste (`<IsTestProject>`) com a saída exibida em uma janela flutuante.

### Interface e Experiência do Usuário (UI/UX)

* **Paleta de Comandos:** Um menu central (`<Espaço><Espaço>`) inspirado no VS Code, construído com `telescope.nvim`, para acesso rápido a todas as funcionalidades.
* **Tela de Início Personalizada:** `alpha-nvim` com o logo "NeoVini", menu de atalhos e frases em "mineirês".
* **Barra de Abas:** `bufferline.nvim` para gerenciar ficheiros abertos, com indicadores de erros e suporte a temas.
* **Terminal Integrado:** `toggleterm.nvim` para terminais flutuantes e divididos que fecham automaticamente e usam `<Esc>` para sair do modo de inserção.
* **Feedback Visual:** `fidget.nvim` para notificações de progresso do LSP e `which-key.nvim` para exibir atalhos disponíveis.
* **Estética Aprimorada:** Múltiplos temas escuros pré-configurados (Dracula, Tokyo Night, GitHub, etc.), guias de indentação, rolagem suave e transparência total (efeito acrílico).

### Ferramentas de Produtividade

* **Interface para Git:** `Neogit` para uma gestão completa do Git (stage, commit, push, etc.) sem sair do editor.
* **Busca "Fuzzy":** `telescope.nvim` para procurar ficheiros, texto, buffers e muito mais.
* **Gestão de Projetos .NET:** Atalhos para adicionar pacotes NuGet (com busca ou diretamente) e referências entre projetos.

---
## 🚀 Pré-requisitos

Antes de instalar, é **essencial** garantir que os seguintes programas estejam instalados e acessíveis no seu sistema:

1.  **Neovim (v0.9.0 ou superior)**.
2.  **Git**.
3.  **.NET SDK** (Recomendado .NET 8 ou superior).
4.  **Debugger `netcoredbg` (Instalação Manual para Windows):**
    * **Passo 1:** Vá para a [página de Releases do netcoredbg no GitHub](https://github.com/Samsung/netcoredbg/releases).
    * **Passo 2:** Encontre a versão mais recente e, na seção "Assets", baixe o ficheiro `netcoredbg-win-x64.zip`.
    * **Passo 3:** Crie uma pasta chamada `netcoredbg` diretamente no seu disco `C:\`.
    * **Passo 4:** Extraia **todo o conteúdo** do ficheiro `.zip` para dentro da pasta `C:\netcoredbg`.
    * **Pronto!** A configuração do NeoVini já está a apontar para `C:/netcoredbg/netcoredbg.exe`.
5.  **Nerd Font:** Essencial para os ícones. Recomenda-se a [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads). Após instalar, **configure o seu terminal** para a usar.
6.  **Ferramentas de Build (Compilador C):** `gcc` e `make` (ou equivalentes no Windows).
7.  **Utilitários de Busca (Para o Telescope):** `ripgrep` e `fd`.
8.  **PowerShell (para Windows):** Necessário para os scripts de busca de pacotes NuGet e projetos de teste.

---
## 📦 Instalação

1.  **Faça um backup** da sua configuração atual:
    ```powershell
    mv ~/.config/nvim ~/.config/nvim.bak
    ```

2.  **Clone este repositório** para a pasta de configuração do Neovim:
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO> ~/.config/nvim
    ```

3.  **Inicie o Neovim:**
    ```bash
    nvim
    ```
Na primeira inicialização, `lazy.nvim` irá baixar, instalar e configurar todos os plugins automaticamente. Aguarde o processo terminar e reinicie o Neovim.

---
## 🕹️ Guia de Uso e Atalhos Principais

**Tecla Líder:** A tecla `<leader>` está mapeada para a tecla **`<Espaço>`**.

| Categoria                   | Atalho                      | Ação                                                                    |
| :-------------------------- | :-------------------------- | :---------------------------------------------------------------------- |
| **🚀 Ações Principais**      |                             |                                                                         |
|                             | `<Espaço><Espaço>`          | **Paleta de Comandos:** Abre o menu principal com todas as ações.       |
|                             | `<F5>`                      | **Debugar Projeto:** Abre seletor de .csproj, compila e inicia o debug. |
|                             | `<Espaço> + r`              | Rodar projeto .NET (abre seletor de .csproj).                           |
| **💡 Código e LSP**          |                             |                                                                         |
|                             | `<Espaço> + f`              | Formatar o ficheiro inteiro.                                            |
|                             | `<Espaço> + ca`             | Ver Ações de Código disponíveis (ex: adicionar `using`).                |
|                             | `gd`                        | Ir para a Definição.                                                    |
|                             | `gr`                        | Ver Referências (usa o Telescope).                                      |
|                             | `K`                         | Mostrar Documentação (Hover).                                           |
|                             | `<Espaço> + rn`             | Renomear Símbolo (interativo).                                          |
|                             | `<Espaço> + ct`             | Inserir Template de Classe C# (em ficheiro vazio).                      |
| **🐞 Depurador (DAP)**       |                             |                                                                         |
|                             | `<F10>` / `<F11>` / `<F12>` | Step Over / Step Into / Step Out.                                       |
|                             | `<Espaço> + b`              | Adicionar ou remover um Breakpoint.                                     |
|                             | `<Espaço> + du`             | Mostrar / Esconder a interface do debugger.                             |
| **🌿 Git (Neogit)**          |                             |                                                                         |
|                             | `<Espaço> + gg`             | Abrir a interface do Neogit.                                            |
| **💻 Terminal (ToggleTerm)** |                             |                                                                         |
|                             | `<Espaço> + ft`             | Abrir/Fechar Terminal Flutuante.                                        |
|                             | `<Esc>`                     | **No Modo Terminal:** Sair para o Modo Normal.                          |
| **🗂️ Projetos .NET**         |                             |                                                                         |
|                             | `<Espaço> + tt`             | Rodar Testes (abre seletor de projetos de teste).                       |
|                             | `<Espaço> + np`             | Adicionar Pacote NuGet (com busca).                                     |
|                             | `<Espaço> + na`             | Adicionar Pacote NuGet (diretamente).                                   |
|                             | `<Espaço> + pr`             | Adicionar Referência de Projeto.                                        |
|                             | `<Espaço> + fp`             | Procurar e alternar entre Projetos.                                     |

---
## 🎨 Personalização

* **Mudar o Tema:** Edite `lua/plugins/themes.lua`. Lembre-se de alterar o nome do tema também na configuração da `lualine`.
* **Adicionar Plugins:** Crie um novo ficheiro `.lua` em `lua/plugins/` com a especificação do `lazy.nvim`.
* **Mudar Atalhos Gerais:** Edite `lua/core/keymaps.lua`.

---
## ⚠️ Solução de Problemas (FAQ)

* **Problema: Ícones aparecem como quadrados.**
  * **Solução:** Garanta que você instalou uma **Nerd Font** e a configurou como a fonte principal do seu emulador de terminal.

* **Problema: O debugger (`<F5>`) falha ou o processo fecha imediatamente.**
  * **Causa:** Incompatibilidade entre a versão do .NET do seu projeto e os Runtimes .NET instalados.
  * **Solução:** Verifique o `<TargetFramework>` no `.csproj` e garanta que a versão correspondente está na lista de `dotnet --list-runtimes`. Se não estiver, instale o **.NET Runtime** ausente.

* **Problema: Erro de `module not found` ao iniciar o Neovim.**
  * **Causa:** Um ficheiro de configuração está a tentar usar um plugin (`require(...)`) antes de o `lazy.nvim` o ter carregado.
  * **Solução:** Defina os atalhos de plugins "preguiçosos" usando a propriedade `keys` na sua especificação em `lua/plugins/`, em vez de os definir globalmente em `keymaps.lua`.

* **Comando Universal de Diagnóstico:**
  * Dentro do Neovim, execute `:checkhealth`. Ele fornecerá um relatório detalhado sobre possíveis problemas.
