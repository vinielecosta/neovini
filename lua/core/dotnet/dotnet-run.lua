local M = {}

-- Function to get the appropriate find command based on OS
local function get_find_command()
    if vim.fn.has('win32') == 1 then
        return {'pwsh', '-NoProfile', '-Command',
                "Get-ChildItem -Path . -Filter *.csproj -Recurse | " ..
            "ForEach-Object { Resolve-Path -Path $_.FullName -Relative }"}
    else
        return {'find', '.', '-type', 'f', '-name', '*.csproj'}
    end
end

function M.run_project()
    vim.notify("Finding .NET projects...", vim.log.levels.INFO)

    require('telescope.builtin').find_files({
        prompt_title = "Select .NET Project to Run",
        find_command = get_find_command(),
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            local function run_selected_project()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                -- Notify user that project is starting
                vim.notify("Starting " .. vim.fn.fnamemodify(selection.value, ":t"), vim.log.levels.INFO)

                -- Create a new terminal in a split
                local term = require('toggleterm.terminal').Terminal:new({
                    cmd = 'dotnet run --project "' .. selection.value .. '"',
                    direction = 'horizontal',
                    close_on_exit = false,
                    on_exit = function(t, job, exit_code, _)
                        if exit_code == 0 then
                            vim.notify("Project execution completed!", vim.log.levels.INFO)
                        else
                            vim.notify("Project execution failed with exit code: " .. exit_code, vim.log.levels.ERROR)
                        end
                    end
                })
                term:toggle()
            end

            map('i', '<CR>', run_selected_project)
            map('n', '<CR>', run_selected_project)
            return true
        end
    })
end

return M
