local M = {}

local float_runner = require('core.functions.run_command_in_float')

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

function M.add_package_directly()

    vim.ui.input({
        prompt = 'Comando: ',
        default = 'dotnet add package '
    }, function(user_input)
        if not user_input or user_input == '' or user_input == 'dotnet add package ' then
            vim.notify('Instalação cancelada.', vim.log.levels.WARN)
            return
        end

        local package_part = user_input:gsub('dotnet add package ', '')

        select_project_and_run(function(project_path)

            local final_command = 'dotnet add "' .. project_path .. '" package ' .. package_part
            local package_name = package_part:match("^%S+")
            float_runner.run_command_in_float(final_command, 'Instalando ' .. package_name,
                'Pacote ' .. package_name .. ' instalado com sucesso!', 'Falha ao instalar o pacote ' .. package_name)
        end)
    end)
end

return M
