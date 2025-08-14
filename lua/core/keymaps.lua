local keymap = vim.keymap.set

-- Modo Normal
-- Navegação entre janelas
keymap('n', '<C-h>', '<C-w>h', {
    desc = 'Mover para janela à esquerda'
})
keymap('n', '<C-l>', '<C-w>l', {
    desc = 'Mover para janela à direita'
})
keymap('n', '<C-j>', '<C-w>j', {
    desc = 'Mover para janela abaixo'
})
keymap('n', '<C-k>', '<C-w>k', {
    desc = 'Mover para janela acima'
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

-- Fechar buffer
keymap('n', '<leader>q', ':bdelete<CR>', {
    desc = 'Fechar buffer atual'
})

-- Salvar
keymap('n', '<C-s>', ':w<CR>', {
    desc = 'Salvar arquivo'
})

-- Modo de Inserção
-- Sair do modo de inserção rapidamente
keymap('i', 'jk', '<ESC>', {
    desc = 'Sair do modo de inserção'
})

-- Modo Visual
-- Manter o texto selecionado após identar
keymap('v', '<', '<gv', {
    desc = 'Identar para a esquerda (manter seleção)'
})
keymap('v', '>', '>gv', {
    desc = 'Identar para a direita (manter seleção)'
})

-- NOVO ATALHO INTELIGENTE PARA RODAR PROJETOS .NET
keymap('n', '<leader>r', function()
    -- Usa o Telescope para encontrar apenas arquivos .csproj
    require('telescope.builtin').find_files({
        prompt_title = "Run .NET Project",
        -- Comando para encontrar arquivos que terminam com .csproj na pasta atual
        find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
        -- Mapeamento customizado para a seleção
        attach_mappings = function(prompt_bufnr, map)
            -- Importa as funções de ação do Telescope
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            -- Define uma nova ação a ser executada ao pressionar Enter
            local function run_dotnet_project()
                -- Pega a entrada selecionada
                local selection = action_state.get_selected_entry()
                -- Fecha a janela do Telescope
                actions.close(prompt_bufnr)
                -- Monta e executa o comando no terminal
                local command = 'split term://dotnet run --project ' .. selection.value
                vim.cmd(command)
            end

            -- Mapeia a tecla Enter para a nossa nova ação
            map('i', '<CR>', run_dotnet_project)
            map('n', '<CR>', run_dotnet_project)
            return true
        end
    })
end, {
    desc = 'Rodar projeto .NET específico'
})
