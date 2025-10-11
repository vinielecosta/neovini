local M = {}

-- Function to find test projects using PowerShell or find command
local function get_find_command()
    if vim.fn.has('win32') == 1 then
        return { 'pwsh', '-NoProfile', '-Command',
            "Get-ChildItem -Path . -Filter *.csproj -Recurse | " ..
            "Where-Object { Select-String -Path $_.FullName -Pattern '<IsTestProject>true</IsTestProject>' -Quiet } | " ..
            "ForEach-Object { Resolve-Path -Path $_.FullName -Relative }" }
    else
        return { 'find', '.', '-type', 'f', '-name', '*.csproj', '-exec', 'grep', '-l', '<IsTestProject>true</IsTestProject>', '{}', ';' }
    end
end

function M.run_tests()
    vim.notify("Finding test projects...", vim.log.levels.INFO)
    
    require('telescope.builtin').find_files({
        prompt_title = 'Select Test Project (.csproj)',
        find_command = get_find_command(),
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')
            
            local function on_project_select()
                local selection = action_state.get_selected_entry()
                local project_path = selection.value
                actions.close(prompt_bufnr)
                
                vim.notify("Running tests for " .. vim.fn.fnamemodify(project_path, ":t"), vim.log.levels.INFO)
                
                local term = require('toggleterm.terminal').Terminal:new({
                    cmd = 'dotnet test "' .. project_path .. '" --logger "console;verbosity=detailed"',
                    direction = 'float',
                    close_on_exit = false,
                    on_exit = function(t, job, exit_code, _)
                        if exit_code == 0 then
                            vim.notify("Tests completed successfully!", vim.log.levels.INFO)
                        else
                            vim.notify("Tests failed with exit code: " .. exit_code, vim.log.levels.ERROR)
                        end
                    end,
                })
                term:toggle()
            end
            
            map('i', '<CR>', on_project_select)
            map('n', '<CR>', on_project_select)
            return true
        end
    })
end

return M
