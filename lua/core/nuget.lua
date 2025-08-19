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

-- HELPER: Abre o seletor de projetos do Telescope e executa uma ação
local function select_project_and_run(callback)
    require('telescope.builtin').find_files({
        prompt_title = 'Selecione o Projeto (.csproj)',
        find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local function on_project_select()
                local selection = action_state.get_selected_entry()
                local project_path = selection.value
                actions.close(prompt_bufnr)
                callback(project_path)
            end
            map('i', '<CR>', on_project_select)
            map('n', '<CR>', on_project_select)
            return true
        end
    })
end

---
-- NOVO FLUXO: Adicionar Pacote Diretamente
---
function M.add_package_directly()
    vim.ui.input({
        prompt = 'Comando: ',
        default = 'dotnet add package '
    }, function(user_input)
        if not user_input or user_input == '' or user_input == 'dotnet add package ' then
            vim.notify('Instalação cancelada.', vim.log.levels.WARN)
            return
        end

        -- Extrai a parte do pacote do comando do usuário
        local package_part = user_input:gsub('dotnet add package ', '')

        -- Abre o seletor de projetos e, quando um for escolhido, executa o comando
        select_project_and_run(function(project_path)
            local final_command = 'dotnet add "' .. project_path .. '" package ' .. package_part
            local package_name = package_part:match("^%S+")
            run_command_in_float(final_command, 'Instalando ' .. package_name,
                'Pacote ' .. package_name .. ' instalado com sucesso!', 'Falha ao instalar o pacote ' .. package_name)
        end)
    end)
end

---
-- FLUXO ANTIGO: Buscar e Instalar Pacote (ainda útil!)
---
function M.install_package()
    vim.ui.input({
        prompt = 'Buscar Pacote NuGet (ex: EntityFrameworkCore): '
    }, function(search_term)
        if not search_term or search_term == '' then
            return
        end
        vim.notify('Buscando pacotes para: ' .. search_term)
        local ps_command = string.format(
            "try { Find-Package -Name '*%s*' -ProviderName NuGet | ConvertTo-Json -Compress } catch { @{error=$_.Exception.Message} | ConvertTo-Json -Compress }",
            search_term)
        local command = {"pwsh", "-Command", ps_command}
        vim.fn.jobstart(command, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if not data or #data == 0 then
                    return
                end
                local json_string = table.concat(data, "")
                if json_string == '' then
                    vim.notify("Nenhum pacote encontrado para '" .. search_term .. "'", vim.log.levels.WARN)
                    return
                end
                local ok, results = pcall(vim.json.decode, json_string)
                if not ok or not results then
                    vim.notify("Erro ao processar a resposta da busca.", vim.log.levels.ERROR)
                    return
                end
                if results.error then
                    vim.notify("Erro na busca do PowerShell: " .. results.error, vim.log.levels.ERROR)
                    return
                end
                if type(results) == 'table' and results.Name then
                    results = {results}
                end
                if #results == 0 then
                    vim.notify("Nenhum pacote encontrado para '" .. search_term .. "'", vim.log.levels.WARN)
                    return
                end
                local entries = {}
                for _, item in ipairs(results) do
                    table.insert(entries, {
                        display = string.format("📦 %s (%s)", item.Name, item.Version),
                        value = item.Name
                    })
                end
                require('telescope.pickers').new({}, {
                    prompt_title = "Selecione o Pacote NuGet",
                    finder = require('telescope.finders').new_table({
                        results = entries
                    }),
                    sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
                    attach_mappings = function(prompt_bufnr, map)
                        local actions = require('telescope.actions')
                        local action_state = require('telescope.actions.state')
                        local function on_package_select()
                            local selection = action_state.get_selected_entry()
                            local package_id = selection.value
                            actions.close(prompt_bufnr)
                            select_project_and_run(function(project_path)
                                local final_command = 'dotnet add "' .. project_path .. '" package ' .. package_id
                                run_command_in_float(final_command, 'Instalando ' .. package_id,
                                    'Pacote ' .. package_id .. ' instalado com sucesso!',
                                    'Falha ao instalar o pacote ' .. package_id)
                            end)
                        end
                        map('i', '<CR>', on_package_select)
                        map('n', '<CR>', on_package_select)
                        return true
                    end
                }):find()
            end,
            on_stderr = function(_, data)
                vim.notify("Erro inesperado no terminal: " .. table.concat(data, ""), vim.log.levels.ERROR)
            end
        })
    end)
end

return M
