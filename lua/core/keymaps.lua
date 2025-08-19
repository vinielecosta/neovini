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

-- FLUXO CORRIGIDO: Encontrar e Substituir com UI customizada
keymap('n', '<leader>s', function()
    local Input = require('nui.input')
    local Popup = require('nui.popup')

    local function create_input_popup(prompt, opts, on_submit)
        local options = {
            position = {
                row = 2,
                col = '100%'
            },
            size = {
                width = 40
            },
            enter = true,
            border = {
                style = 'rounded',
                text = {
                    top = prompt,
                    top_align = 'left'
                }
            },
            win_options = {
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder'
            }
        }

        local input = Input(options, {
            on_close = function()
                vim.cmd('nohlsearch')
            end,
            on_submit = on_submit
        })

        -- Lógica para destaque em tempo real
        if opts.live_highlight then
            input:on({event.BufTextChanged, event.BufEnter}, function()
                local current_text = input:get_value()
                if current_text and #current_text > 0 then
                    vim.fn.setreg('/', vim.pesc(current_text))
                    vim.cmd('set hlsearch')
                else
                    vim.cmd('set nohlsearch')
                end
            end)
        end

        input:mount()
        input:map('i', '<esc>', function()
            input:unmount()
        end, {
            noremap = true
        })
    end

    create_input_popup('Encontrar: ', {
        live_highlight = true
    }, function(search_term)
        if not search_term or search_term == '' then
            return
        end

        create_input_popup('Substituir por: ', {}, function(replace_term)
            if not replace_term then
                vim.cmd('nohlsearch');
                return
            end

            local matches = {}
            local line_count = vim.api.nvim_buf_line_count(0)
            for i = 1, line_count do
                local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
                local last_end = 1
                while true do
                    local start_idx, end_idx = string.find(line, vim.pesc(search_term), last_end, true)
                    if not start_idx then
                        break
                    end
                    table.insert(matches, {
                        line = i,
                        start_col = start_idx - 1,
                        end_col = end_idx
                    })
                    last_end = end_idx + 1
                end
            end

            if #matches == 0 then
                vim.notify("Palavra '" .. search_term .. "' não encontrada.", vim.log.levels.WARN)
                vim.cmd('nohlsearch')
                return
            end

            local current_match_index = 1
            local confirmation_popup

            local function process_next_match()
                if confirmation_popup and confirmation_popup.winid and
                    vim.api.nvim_win_is_valid(confirmation_popup.winid) then
                    confirmation_popup:unmount()
                end
                if current_match_index > #matches then
                    vim.notify("Substituição concluída.", vim.log.levels.INFO)
                    vim.cmd('nohlsearch')
                    return
                end

                local match = matches[current_match_index]
                vim.api.nvim_win_set_cursor(0, {match.line, match.start_col})
                vim.cmd('normal! zz')

                confirmation_popup = Popup({
                    position = {
                        row = 2,
                        col = '100%'
                    },
                    size = {
                        width = 40,
                        height = 3
                    },
                    enter = true,
                    border = {
                        style = 'rounded',
                        text = {
                            top = 'Substituir?',
                            top_align = 'center'
                        }
                    },
                    win_options = {
                        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder'
                    }
                })
                confirmation_popup:mount()
                vim.api.nvim_buf_set_lines(confirmation_popup.bufnr, 0, -1, false, {" (y)es / (n)o / (a)ll / (q)uit"})
                vim.bo[confirmation_popup.bufnr].modifiable = false

                local function cleanup_and_run(action)
                    if confirmation_popup and confirmation_popup.winid and
                        vim.api.nvim_win_is_valid(confirmation_popup.winid) then
                        confirmation_popup:unmount()
                    end
                    action()
                end

                local keymaps = {
                    y = function()
                        cleanup_and_run(function()
                            local current_match = matches[current_match_index]
                            local line_num = current_match.line - 1
                            local old_line = vim.api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]

                            vim.api.nvim_buf_set_text(0, line_num, current_match.start_col, line_num,
                                current_match.end_col, {replace_term})

                            local new_line = vim.api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]
                            local length_diff = #new_line - #old_line

                            for i = current_match_index + 1, #matches do
                                if matches[i].line == current_match.line then
                                    matches[i].start_col = matches[i].start_col + length_diff
                                    matches[i].end_col = matches[i].end_col + length_diff
                                end
                            end

                            current_match_index = current_match_index + 1
                            process_next_match()
                        end)
                    end,
                    n = function()
                        cleanup_and_run(function()
                            current_match_index = current_match_index + 1;
                            process_next_match()
                        end)
                    end,
                    a = function()
                        cleanup_and_run(function()
                            for i = #matches, current_match_index, -1 do
                                local m = matches[i]
                                vim.api.nvim_buf_set_text(0, m.line - 1, m.start_col, m.line - 1, m.end_col,
                                    {replace_term})
                            end
                            current_match_index = #matches + 1
                            process_next_match()
                        end)
                    end,
                    q = function()
                        cleanup_and_run(function()
                            current_match_index = #matches + 1;
                            process_next_match()
                        end)
                    end
                }

                for key, func in pairs(keymaps) do
                    vim.api.nvim_buf_set_keymap(confirmation_popup.bufnr, 'n', key, '', {
                        noremap = true,
                        callback = func
                    })
                end
            end

            process_next_match()
        end)
    end)
end, {
    desc = 'Encontrar e Substituir no arquivo'
})

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
