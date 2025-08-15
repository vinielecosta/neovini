-- ~/.config/nvim/lua/core/keymaps.lua
-- Cria um atalho local para a função de mapeamento de teclas do Neovim
local keymap = vim.keymap.set

-- MODO NORMAL (n)
--------------------

-- Salvar
keymap('n', '<C-s>', ':w<CR>', {
    desc = 'Salvar arquivo'
})

-- Navegação entre janelas (splits)
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

-- Redimensionar janelas
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

-- Gerenciamento de Buffers
keymap('n', '<leader>q', ':bdelete<CR>', {
    desc = 'Fechar buffer atual'
})

-- Rodar Projetos .NET
keymap('n', '<leader>r', function()
    -- Usa o Telescope para encontrar apenas arquivos .csproj
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

-- Diagnósticos (Erros e Avisos)
keymap('n', '<leader>d', vim.diagnostic.open_float, {
    desc = 'Mostrar diagnóstico da linha'
})
keymap('n', ']d', vim.diagnostic.goto_next, {
    desc = 'Ir para o próximo diagnóstico'
})
keymap('n', '[d', vim.diagnostic.goto_prev, {
    desc = 'Ir para o diagnóstico anterior'
})
-- Instalador de Pacotes NuGet
keymap('n', '<leader>np', function()
    require('core.nuget').install_package()
end, {
    desc = 'NuGet: Buscar e Adicionar Pacote'
})
keymap('n', '<leader>na', function()
    require('core.nuget').add_package_directly()
end, {
    desc = 'NuGet: Adicionar Pacote Diretamente'
})

---
-- NOVO FLUXO DE TESTES UNITÁRIOS
---
local function run_dotnet_tests()
    require('telescope.builtin').find_files({
        prompt_title = 'Selecione o Projeto de Teste (.csproj)',
        find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local function on_project_select()
                local selection = action_state.get_selected_entry()
                local project_path = selection.value
                actions.close(prompt_bufnr)

                -- Abre um terminal flutuante e executa 'dotnet test'
                local term = require('toggleterm.terminal').Terminal:new({
                    cmd = 'dotnet test "' .. project_path .. '"',
                    direction = 'float',
                    close_on_exit = false -- Mantém o terminal aberto para ver os resultados
                })
                term:toggle()
            end
            map('i', '<CR>', on_project_select)
            map('n', '<CR>', on_project_select)
            return true
        end
    })
end

keymap('n', '<leader>tt', run_dotnet_tests, {
    desc = 'Test: Rodar testes do projeto'
})
