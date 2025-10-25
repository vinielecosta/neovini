local M = {}

local float_runner = require('core.functions.run_command_in_float')

function M.add_project_reference()
    require('telescope.builtin').find_files({
        prompt_title = '1/2: Select the project TO ADD the reference',
        find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            local function on_target_project_select()
                local selection = action_state.get_selected_entry()
                local target_project_path = selection.value
                actions.close(prompt_bufnr)

                require('telescope.builtin').find_files({
                    prompt_title = '2/2: Select the project TO BE REFERENCED',
                    find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
                    attach_mappings = function(prompt_bufnr2, map2)
                        local function on_source_project_select()
                            local selection2 = action_state.get_selected_entry()
                            local source_project_path = selection2.value
                            actions.close(prompt_bufnr2)

                            local command = string.format('dotnet add "%s" reference "%s"', target_project_path,
                                source_project_path)
                            float_runner.run_command_in_float(command, 'Adding Project Reference',
                                'Project reference added successfully!', 'Failed to add project reference.')
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
