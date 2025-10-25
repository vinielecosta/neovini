local M = {}

local float_runner = require('core.functions.run_command_in_float')

local project_templates = {
    webapi = "webapi",
    console = "console",
    classlib = "classlib",
    webapp = "webapp",
    mvc = "mvc",
    blazor = "blazor",
    xunit = "xunit",
    nunit = "nunit",
    mstest = "mstest",
}

function M.list_templates()
    return vim.tbl_keys(project_templates)
end

local function validate_project_name(name)
    if not name or name == "" then
        return false, "Project name cannot be empty"
    end

    if not name:match("^[%a_][%w_]*$") then
        return false, "Invalid project name. Must start with letter or underscore and contain only letters, numbers, and underscores"
    end

    return true, nil
end

function M.create_project()
    vim.ui.select(M.list_templates(), {
        prompt = "Select project type:",
        format_item = function(item)
            return project_templates[item] .. " - " .. item
        end,
    }, function(project_type)
        if not project_type then return end

        vim.ui.input({
            prompt = "Enter project name: ",
        }, function(project_name)
            if not project_name then return end

            local valid, err = validate_project_name(project_name)
            if not valid then
                vim.notify(err, vim.log.levels.ERROR)
                return
            end

            local command = string.format('dotnet new %s -n "%s" --framework net8.0', project_type, project_name)
            float_runner.run_command_in_float(
                command,
                'Creating project ' .. project_name,
                'Project ' .. project_name .. ' created successfully!',
                'Failed to create project ' .. project_name
            )

            vim.defer_fn(function()
                vim.ui.select({'Yes', 'No'}, {
                    prompt = "Open project in new window?"
                }, function(choice)
                    if choice == 'Yes' then
                        vim.cmd('!code ./' .. project_name)
                    end
                end)
            end, 1000)
        end)
    end)
end

return M
