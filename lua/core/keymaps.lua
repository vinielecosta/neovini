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

-- ~/.config/nvim/lua/core/keymaps.lua
-- ... (outros atalhos) ...

-- Gerenciamento de Projetos .NET
keymap('n', '<leader>pr', function()
    require('core.project').add_project_reference()
end, {
    desc = 'Projeto: Adicionar Referência'
})

-- ATALHO PARA TEMPLATE DE CLASSE C# (LÓGICA DE NAMESPACE INTERATIVA)
keymap('n', '<leader>ct', function()
    if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
        local current_filename = vim.api.nvim_buf_get_name(0)
        if not current_filename:match('%.cs$') then
            vim.notify("Arquivo não é .cs. Template não inserido.", vim.log.levels.WARN)
            return
        end

        -- Passo 1: Selecionar o arquivo .sln
        require('telescope.builtin').find_files({
            prompt_title = "Selecione o Arquivo de Solução (.sln)",
            find_command = {'fd', '--type', 'f', '--glob', '*.sln', '--full-path', vim.fn.getcwd()},
            attach_mappings = function(prompt_bufnr, map)
                local actions = require('telescope.actions')
                local action_state = require('telescope.actions.state')

                -- Passo 2: Após selecionar o .sln, gerar o template
                local function on_sln_select()
                    local selection = action_state.get_selected_entry()
                    local sln_file = selection.value
                    actions.close(prompt_bufnr)

                    local class_name = vim.fn.fnamemodify(current_filename, ':t:r')
                    local sln_dir = vim.fn.fnamemodify(sln_file, ':p:h')
                    local solution_name = vim.fn.fnamemodify(sln_file, ':t:r')
                    local current_file_dir = vim.fn.fnamemodify(current_filename, ':p:h')

                    -- Calcula o caminho relativo e o normaliza
                    local relative_path = current_file_dir:gsub(vim.pesc(sln_dir), ''):gsub('^[\\/]', '')
                    local sub_namespace = relative_path:gsub('[\\/]', '.')

                    local namespace
                    if sub_namespace ~= '' then
                        namespace = solution_name .. '.' .. sub_namespace
                    else
                        namespace = solution_name
                    end

                    local template = {'namespace ' .. namespace .. ';', '', 'public class ' .. class_name, '{', '    ',
                                      '}'}

                    vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
                    vim.api.nvim_win_set_cursor(0, {5, 5})
                    vim.notify("Template de classe C# inserido!", vim.log.levels.INFO)
                end

                map('i', '<CR>', on_sln_select)
                map('n', '<CR>', on_sln_select)
                return true
            end
        })
    else
        vim.notify("O arquivo não está vazio. Template não inserido.", vim.log.levels.INFO)
    end
end, {
    desc = 'C#: Inserir template de classe'
})
