-- ~/.config/nvim/lua/core/project.lua
local M = {}

-- HELPER: Função genérica para rodar um comando em um terminal flutuante
local function run_command_in_float(command, title, success_msg, failure_msg)
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.api.nvim_get_option('columns') * 0.8)
    local height = math.floor(vim.api.nvim_get_option('lines') * 0.8)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = math.floor((vim.api.nvim_get_option('lines') - height) / 2),
        col = math.floor((vim.api.nvim_get_option('columns') - width) / 2),
        border = 'rounded',
        title = title
    })
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    vim.fn.jobstart(command, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
            end
        end,
        on_stderr = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
            end
        end,
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                vim.api.nvim_win_set_config(win, {
                    title = 'Sucesso!',
                    title_pos = 'center'
                })
                vim.notify(success_msg, vim.log.levels.INFO)
                vim.defer_fn(function()
                    vim.api.nvim_win_close(win, true)
                end, 3000)
            else
                vim.api.nvim_win_set_config(win, {
                    title = 'FALHA!',
                    title_pos = 'center'
                })
                vim.notify(failure_msg, vim.log.levels.ERROR)
            end
        end
    })
end

-- Função principal que orquestra a adição de referências
function M.add_project_reference()
    -- Passo 1: Selecionar o projeto que VAI RECEBER a referência
    require('telescope.builtin').find_files({
        prompt_title = '1/2: Selecione o projeto PARA ADICIONAR a referência',
        find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local function on_target_project_select()
                local selection = action_state.get_selected_entry()
                local target_project_path = selection.value
                actions.close(prompt_bufnr)

                -- Passo 2: Selecionar o projeto A SER REFERENCIADO
                require('telescope.builtin').find_files({
                    prompt_title = '2/2: Selecione o projeto A SER REFERENCIADO',
                    find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
                    attach_mappings = function(prompt_bufnr2, map2)
                        local function on_source_project_select()
                            local selection2 = action_state.get_selected_entry()
                            local source_project_path = selection2.value
                            actions.close(prompt_bufnr2)

                            -- Monta e executa o comando final
                            local command = string.format('dotnet add "%s" reference "%s"', target_project_path,
                                source_project_path)
                            run_command_in_float(command, 'Adicionando Referência de Projeto',
                                'Referência adicionada com sucesso!', 'Falha ao adicionar a referência.')
                        end
                        map2('i', '<CR>', on_source_project_select)
                        map2('n', '<CR>', on_source_project_select)
                        return true
                    end
                })
            end
            map('i', '<CR>', on_target_project_select)
            map('n', '<CR>', on_target_project_select)
            return true
        end
    })
end

return M
