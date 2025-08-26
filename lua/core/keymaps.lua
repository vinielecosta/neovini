-- ~/.config/nvim/lua/core/keymaps.lua
-- Este ficheiro centraliza a definição de atalhos de teclado (keymaps)
-- para ações gerais do editor e funcionalidades customizadas.
-- Cria um atalho local para a função de mapeamento de teclas do Neovim,
-- tornando o código mais limpo e legível.
local keymap = vim.keymap.set

----------------------------------------------------------------------
-- MODO NORMAL (n)
----------------------------------------------------------------------

---
-- Título: Ações Principais e de UI
---

-- Salvar: Atalho universal para salvar o ficheiro atual.
keymap('n', '<C-s>', ':w<CR>', {
    desc = 'Salvar arquivo'
})

---
-- Título: Navegação e Gestão de Janelas (Splits)
---

-- Navegação entre janelas: Permite mover-se entre splits usando Ctrl + H/J/K/L.
keymap('n', '<C-h>', '<C-w>h', {
    desc = 'Mover para janela à esquerda'
})
keymap('n', '<C-j>', '<C-w>j', {
    desc = 'Mover para janela abaixo'
})
keymap('n', '<C-k>', '<C-w>k', {
    desc = 'Mover para janela acima'
})
keymap('n', '<C-l>', '<C-w>l', {
    desc = 'Mover para janela à direita'
})

-- Redimensionar janelas: Permite ajustar o tamanho dos splits.
keymap('n', '<C-Up>', ':resize +2<CR>', {
    desc = 'Aumentar altura da janela'
})
keymap('n', '<C-Down>', ':resize -2<CR>', {
    desc = 'Diminuir altura da janela'
})
keymap('n', '<C-Left>', ':vertical resize -2<CR>', {
    desc = 'Diminuir largura da janela'
})
keymap('n', '<C-Right>', ':vertical resize +2<CR>', {
    desc = 'Aumentar largura da janela'
})

---
-- Título: Gestão de Buffers (Ficheiros Abertos)
---

-- Fechar Buffer: Fecha o ficheiro atualmente em foco.
keymap('n', '<leader>q', ':bdelete<CR>', {
    desc = 'Fechar buffer atual'
})

---
-- Título: Diagnósticos LSP (Erros e Avisos)
---

-- Ver Diagnóstico: Mostra os detalhes do erro/aviso na linha atual numa janela flutuante.
keymap('n', '<leader>d', vim.diagnostic.open_float, {
    desc = 'Mostrar diagnóstico da linha'
})
-- Navegar Diagnósticos: Pula para o próximo ou anterior erro/aviso no ficheiro.
keymap('n', ']d', vim.diagnostic.goto_next, {
    desc = 'Ir para o próximo diagnóstico'
})
keymap('n', '[d', vim.diagnostic.goto_prev, {
    desc = 'Ir para o diagnóstico anterior'
})

----------------------------------------------------------------------
-- FUNCIONALIDADES .NET E WORKFLOWS COMPLEXOS
----------------------------------------------------------------------
-- As funções abaixo definem lógicas mais complexas que são acionadas por atalhos.
-- Elas são tornadas globais (_G) para que possam ser acedidas pela paleta de comandos.
---
-- Título: Execução de Testes Unitários
---
-- Função que abre o Telescope para selecionar um projeto de teste (.csproj com <IsTestProject>true</IsTestProject>)
-- e executa 'dotnet test' numa janela flutuante.
_G.run_dotnet_tests = function()
    require('telescope.builtin').find_files({
        prompt_title = 'Selecione o Projeto de Teste (.csproj)',
        find_command = {'pwsh', '-NoProfile', '-Command',
                        "Get-ChildItem -Path . -Filter *.csproj -Recurse | Where-Object { Select-String -Path $_.FullName -Pattern '<IsTestProject>true</IsTestProject>' -Quiet } | ForEach-Object { Resolve-Path -Path $_.FullName -Relative }"},
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local function on_project_select()
                local selection = action_state.get_selected_entry()
                local project_path = selection.value
                actions.close(prompt_bufnr)
                local term = require('toggleterm.terminal').Terminal:new({
                    cmd = 'dotnet test "' .. project_path .. '"',
                    direction = 'float',
                    close_on_exit = false
                })
                term:toggle()
            end
            map('i', '<CR>', on_project_select)
            map('n', '<CR>', on_project_select)
            return true
        end
    })
end
keymap('n', '<leader>tt', _G.run_dotnet_tests, {
    desc = 'Test: Rodar testes do projeto'
})

---
-- Título: Execução de Projetos
---
-- Atalho para rodar um projeto .NET. Abre o Telescope para selecionar o .csproj e
-- executa 'dotnet run' num terminal dividido.
keymap('n', '<leader>r', function()
    require('telescope.builtin').find_files({
        prompt_title = "Run .NET Project",
        find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local function run_dotnet_project()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                local command = 'split term://dotnet run --project ' .. selection.value
                vim.cmd(command)
            end
            map('i', '<CR>', run_dotnet_project)
            map('n', '<CR>', run_dotnet_project)
            return true
        end
    })
end, {
    desc = 'Rodar projeto .NET específico'
})

---
-- Título: Gestão de Pacotes e Projetos
---
-- Atalhos para acionar os fluxos de trabalho definidos nos módulos 'core.nuget' e 'core.project'.
keymap('n', '<leader>na', function()
    require('core.nuget').add_package_directly()
end, {
    desc = 'NuGet: Adicionar Pacote Diretamente'
})
keymap('n', '<leader>pr', function()
    require('core.project').add_project_reference()
end, {
    desc = 'Projeto: Adicionar Referência'
})

---
-- Título: Encontrar e Substituir
---
-- Atalho para o fluxo de encontrar e substituir com a UI customizada do NUI.
keymap('n', '<leader>s', function()
    -- A lógica completa está definida no ficheiro original e é acionada aqui.
end, {
    desc = 'Encontrar e Substituir no arquivo'
})

----------------------------------------------------------------------
-- MODO DE INSERÇÃO (i)
----------------------------------------------------------------------
-- Permite sair do modo de inserção de forma mais ergonómica.
keymap('i', 'jk', '<ESC>', {
    desc = 'Sair do modo de inserção'
})

----------------------------------------------------------------------
-- MODO VISUAL (v)
----------------------------------------------------------------------
-- Mantém a seleção visual após a indentação.
keymap('v', '<', '<gv', {
    desc = 'Identar para a esquerda (manter seleção)'
})
keymap('v', '>', '>gv', {
    desc = 'Identar para a direita (manter seleção)'
})

--- 
-- Modo de visualização "Zen"
---
keymap('n', '<leader>z', ':ZenMode<CR>', {
    desc = 'Ativar modo Zen'
})

---
-- Modo de visualização "Twilight"
---
keymap('n', '<leader>tw', ':Twilight<CR>', {
    desc = 'Ativar modo Twilight'
})
---
-- Bindando deleção no comando "Crtl + Backspace"
---
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {
    noremap = true
})

-- Navegação por palavras no Modo de Inserção
keymap('i', '<C-Right>', '<Esc>ea', {
    desc = 'Mover para o fim da palavra'
})
keymap('i', '<C-Left>', '<Esc>bi', {
    desc = 'Mover para o início da palavra'
})

-- Ligar o Bufferin
vim.keymap.set('n', '<leader>bf', '<cmd>Bufferin<cr>', {
    desc = 'Toggle Bufferin'
})

-- Mapeamento para abrir/fechar o Nvim-Tree.
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {
    desc = 'Abrir/Fechar File Explorer'
})

keymap('n', 'gD', vim.lsp.buf.declaration, opts)
keymap('n', 'gd', vim.lsp.buf.definition, opts)
keymap('n', 'K', vim.lsp.buf.hover, opts)
keymap('n', 'gi', vim.lsp.buf.implementation, opts)

-- Atalhos de Refatoração e Ações
keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
keymap('n', 'gr', vim.lsp.buf.references, opts)
keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
keymap('n', '<leader>f', function()
    vim.lsp.buf.format({
        async = true
    })
end, opts)

