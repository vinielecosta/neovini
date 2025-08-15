-- ~/.config/nvim/lua/plugins/dap.lua
return {
    'mfussenegger/nvim-dap',
    dependencies = {{
        'rcarriga/nvim-dap-ui',
        config = function()
            local dapui = require('dapui')
            dapui.setup()
            vim.keymap.set('n', '<leader>du', function()
                dapui.toggle()
            end, {
                desc = 'Toggle DAP UI'
            })
        end
    }, {'nvim-neotest/nvim-nio'}},
    config = function()
        local dap = require('dap')

        dap.adapters.coreclr = {
            type = 'executable',
            command = 'C:/netcoredbg/netcoredbg.exe',
            args = {'--interpreter=vscode'}
        }

        dap.configurations.cs = {{
            type = 'coreclr',
            name = 'launch - Web API (dynamic)',
            request = 'launch',
            cwd = '${workspaceFolder}',
            env = {
                ASPNETCORE_ENVIRONMENT = 'Development'
            },
            launchBrowser = {
                enabled = true,
                args = '${auto-detect-url}',
                windows = {
                    command = 'cmd.exe',
                    args = '/C start ${auto-detect-url}'
                }
            }
        }}

        ---
        -- FUNÇÃO PRINCIPAL QUE ORQUESTRA O BUILD E O DEBUG
        ---
        local function start_net_debug_session()
            local telescope_builtin = require('telescope.builtin')
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            telescope_builtin.find_files({
                prompt_title = 'Select .NET Project to Build and Debug',
                find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
                attach_mappings = function(prompt_bufnr, map)
                    local function select_project_and_build()
                        local selection = action_state.get_selected_entry()
                        local csproj_path = selection.value
                        actions.close(prompt_bufnr)

                        -- **NOVA LÓGICA DE BUILD ASSÍNCRONO**

                        -- 1. Cria um terminal flutuante para mostrar a saída do build
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
                            title = 'Building ' .. vim.fn.fnamemodify(csproj_path, ':t')
                        })
                        vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

                        -- 2. Define o que fazer quando o build terminar
                        local on_build_exit = function(_, exit_code)
                            if exit_code == 0 then
                                -- SUCESSO: fecha o terminal e inicia o debug
                                vim.api.nvim_win_close(win, true)
                                vim.notify('Build bem-sucedido! Iniciando debugger...', vim.log.levels.INFO)

                                -- Lógica para iniciar o DAP (a que tínhamos antes)
                                local project_name = vim.fn.fnamemodify(csproj_path, ':t:r')
                                local project_dir = vim.fn.fnamemodify(csproj_path, ':h')
                                local dll_path = project_dir .. '/bin/Debug/net8.0/' .. project_name .. '.dll'
                                local dap_config = dap.configurations.cs[1]
                                dap_config.program = dll_path
                                dap.run(dap_config)
                            else
                                -- FALHA: mantém o terminal aberto com os erros
                                vim.notify('Build falhou! Corrija os erros e tente novamente.', vim.log.levels.ERROR)
                                vim.api.nvim_win_set_config(win, {
                                    title = 'Build FALHOU!',
                                    title_pos = 'center'
                                })
                            end
                        end

                        -- 3. Inicia o job de build
                        vim.fn.jobstart('dotnet build "' .. csproj_path .. '"', {
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
                            on_exit = on_build_exit
                        })
                    end

                    map('i', '<CR>', select_project_and_build)
                    map('n', '<CR>', select_project_and_build)
                    return true
                end
            })
        end

        -- Mapeamentos de Teclas do Debugger
        vim.keymap.set('n', '<F5>', start_net_debug_session, {
            desc = 'Debug: Build & Run Project'
        })
        vim.keymap.set('n', '<S-F5>', function()
            dap.terminate()
        end, {
            desc = 'Debug: Terminate'
        })
        vim.keymap.set('n', '<F10>', function()
            dap.step_over()
        end, {
            desc = 'Debug: Step Over'
        })
        vim.keymap.set('n', '<F11>', function()
            dap.step_into()
        end, {
            desc = 'Debug: Step Into'
        })
        vim.keymap.set('n', '<F12>', function()
            dap.step_out()
        end, {
            desc = 'Debug: Step Out'
        })
        vim.keymap.set('n', '<leader>b', function()
            dap.toggle_breakpoint()
        end, {
            desc = 'Debug: Toggle Breakpoint'
        })
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end, {
            desc = 'Debug: Set Conditional Breakpoint'
        })
    end
}
