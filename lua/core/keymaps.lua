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

