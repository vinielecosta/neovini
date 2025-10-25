local M = {}

function M.select_project()
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

                vim.cmd('edit ' .. project_path)

                print('Arquivo de projeto aberto: ' .. project_path)

            end

            map('i', '<CR>', on_project_select)
            map('n', '<CR>', on_project_select)
            return true
        end
    })
end

return M
