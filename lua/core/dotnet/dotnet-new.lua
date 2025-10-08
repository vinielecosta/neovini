local M = {}

local float_runner = require('core.functions.run_command_in_float')

-- List of valid .NET project templates
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

-- Function to get available templates
function M.list_templates()
    return vim.tbl_keys(project_templates)
end

-- Function to validate project name
local function validate_project_name(name)
    -- Check if name is empty or nil
    if not name or name == "" then
        return false, "Project name cannot be empty"
    end

    -- Check if name follows C# naming conventions
    if not name:match("^[%a_][%w_]*$") then
        return false, "Invalid project name. Must start with letter or underscore and contain only letters, numbers, and underscores"
    end

    return true, nil
end

-- Function to create a new .NET project
function M.create_project()
    -- First, prompt for project type
    vim.ui.select(M.list_templates(), {
        prompt = "Select project type:",
        format_item = function(item)
            return project_templates[item] .. " - " .. item
        end,
    }, function(project_type)
        if not project_type then return end

        -- Then, prompt for project name
        vim.ui.input({
            prompt = "Enter project name: ",
        }, function(project_name)
            if not project_name then return end

            -- Validate project name
            local valid, err = validate_project_name(project_name)
            if not valid then
                vim.notify(err, vim.log.levels.ERROR)
                return
            end

            -- Create the project
            local command = string.format('dotnet new %s -n "%s" --framework net8.0', project_type, project_name)
            float_runner.run_command_in_float(
                command,
                'Creating project ' .. project_name,
                'Project ' .. project_name .. ' created successfully!',
                'Failed to create project ' .. project_name
            )

            -- After project creation, check if user wants to open it
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
