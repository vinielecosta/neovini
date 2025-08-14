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

        -- Configuração base do adaptador .NET
        dap.adapters.coreclr = {
            type = 'executable',
            command = 'C:/netcoredbg/netcoredbg.exe', -- Confirme se seu caminho está correto
            args = {'--interpreter=vscode'}
        }

        -- Tabela de configuração que servirá como TEMPLATE para o debug.
        -- A propriedade 'program' será preenchida dinamicamente.
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
            -- A propriedade 'program' será adicionada aqui pela nossa função customizada
        }}

        ---
        -- FUNÇÃO OTIMIZADA QUE ORQUESTRA O PROCESSO DE DEBUG
        ---
        local function start_net_debug_session()
            -- Carrega as ferramentas do Telescope
            local telescope_builtin = require('telescope.builtin')
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            -- Inicia o processo selecionando o projeto
            telescope_builtin.find_files({
                prompt_title = 'Select .NET Project to Debug',
                -- Procura por todos os arquivos .csproj na pasta da solução
                find_command = {'fd', '--type', 'f', '--glob', '*.csproj'},
                attach_mappings = function(prompt_bufnr, map)
                    -- Ação final: Pegar o projeto, deduzir a DLL e iniciar o debug
                    local function select_project_and_launch()
                        -- Pega o caminho completo do .csproj selecionado
                        local selection = action_state.get_selected_entry()
                        local csproj_path = selection.value
                        actions.close(prompt_bufnr)

                        -- **LÓGICA AUTOMÁTICA PARA ENCONTRAR A DLL**
                        -- 1. Pega o nome do arquivo de projeto sem a extensão (ex: "WebApplication4")
                        local project_name = vim.fn.fnamemodify(csproj_path, ':t:r')
                        -- 2. Pega o diretório do arquivo de projeto
                        local project_dir = vim.fn.fnamemodify(csproj_path, ':h')
                        -- 3. Monta o caminho completo para a DLL correspondente
                        local dll_path = project_dir .. '/bin/Debug/net8.0/' .. project_name .. '.dll'

                        -- Pega nosso template de configuração
                        local dap_config = dap.configurations.cs[1]
                        -- Define dinamicamente o programa a ser executado
                        dap_config.program = dll_path

                        -- Inicia a sessão de debug com a configuração finalizada
                        dap.run(dap_config)
                    end

                    map('i', '<CR>', select_project_and_launch)
                    map('n', '<CR>', select_project_and_launch)
                    return true
                end
            })
        end

        -- Mapeamentos de Teclas do Debugger
        vim.keymap.set('n', '<F5>', start_net_debug_session, {
            desc = 'Debug: Select Project & Run'
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
