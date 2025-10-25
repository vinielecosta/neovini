local M = {}

function M.find_cs_files()
    if vim.fn.has('win32') == 1 then
        return {'pwsh', '-NoProfile', '-Command',
                "Get-ChildItem -Path . -Filter *.cs -Recurse | " ..
            "ForEach-Object { Resolve-Path -Path $_.FullName -Relative }"}
    else
        return {'find', '.', '-type', 'f', '-name', '*.cs'}
    end
end

return M