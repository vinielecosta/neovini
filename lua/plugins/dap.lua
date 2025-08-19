-- ~/.config/nvim/lua/plugins/dap.lua
-- Este ficheiro configura o nvim-dap, o plugin que integra o Debug Adapter Protocol (DAP)
-- no Neovim, transformando-o num depurador de código completo para C# .NET.

return {
  'mfussenegger/nvim-dap',
  -- Dependências: Outros plugins que melhoram a experiência de depuração.
  dependencies = {
    -- Fornece uma interface gráfica (UI) para o depurador, mostrando pilhas de chamadas, variáveis, etc.
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        local dapui = require('dapui')
        dapui.setup()
        -- Atalho para mostrar/esconder a UI do depurador.
        vim.keymap.set('n', '<leader>du', function()
          dapui.toggle()
        end, { desc = 'Toggle DAP UI' })
      end,
    },
    -- Dependência necessária para a UI do DAP funcionar corretamente.
    { 'nvim-neotest/nvim-nio' },
  },
  config = function()
    local dap = require('dap')

    ---
    -- Título: Configuração do Adaptador de Debug
    ---
    -- Define como o nvim-dap se comunica com o depurador externo para .NET (netcoredbg).
    dap.adapters.coreclr = {
      type = 'executable',
      -- Caminho para o executável do depurador. Este foi instalado manualmente.
      command = 'C:/netcoredbg/netcoredbg.exe',
      args = { '--interpreter=vscode' },
    }

    ---
    -- Título: Configuração de Lançamento (Launch Configuration)
    ---
    -- Define um "template" de como uma sessão de depuração para C# deve ser iniciada.
    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'launch - Web API (dynamic)',
        request = 'launch',
        -- Garante que a aplicação seja executada na pasta raiz do projeto.
        cwd = '${workspaceFolder}',
        -- Define o ambiente para "Desenvolvimento", crucial para ativar o Swagger, etc.
        env = {
          ASPNETCORE_ENVIRONMENT = 'Development',
        },
        -- Configuração para abrir o navegador automaticamente ao iniciar uma API.
        launchBrowser = {
          enabled = true,
          args = '${auto-detect-url}',
          windows = {
            command = 'cmd.exe',
            args = '/C start ${auto-detect-url}',
          },
        },
      },
    }

    ---
    -- Título: Função Principal que Orquestra o Build e o Debug
    ---
    -- Esta função customizada cria o fluxo interativo para selecionar, compilar e depurar um projeto.
    local function start_net_debug_session()
      local telescope_builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      -- Passo 1: Abre o Telescope para selecionar o projeto (.csproj) a ser depurado.
      telescope_builtin.find_files({
        prompt_title = 'Select .NET Project to Build and Debug',
        find_command = { 'fd', '--type', 'f', '--glob', '*.csproj' },
        attach_mappings = function(prompt_bufnr, map)
          local function select_project_and_build()
            local selection = action_state.get_selected_entry()
            local csproj_path = selection.value
            actions.close(prompt_bufnr)

            -- Passo 2: Inicia o processo de build assíncrono numa janela flutuante.
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
              title = 'Building ' .. vim.fn.fnamemodify(csproj_path, ':t'),
            })
            vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

            -- Passo 3: Define o que fazer quando o build terminar.
            local on_build_exit = function(_, exit_code)
              if exit_code == 0 then
                -- SUCESSO: Fecha a janela de build e inicia a sessão de debug.
                vim.api.nvim_win_close(win, true)
                vim.notify('Build bem-sucedido! Iniciando debugger...', vim.log.levels.INFO)

                -- Preenche o template de configuração do DAP com o caminho da DLL.
                local project_name = vim.fn.fnamemodify(csproj_path, ':t:r')
                local project_dir = vim.fn.fnamemodify(csproj_path, ':h')
                local dll_path = project_dir .. '/bin/Debug/net8.0/' .. project_name .. '.dll'
                local dap_config = dap.configurations.cs[1]
                dap_config.program = dll_path
                dap.run(dap_config)
              else
                -- FALHA: Mantém a janela de build aberta para mostrar os erros.
                vim.notify('Build falhou! Corrija os erros e tente novamente.', vim.log.levels.ERROR)
                vim.api.nvim_win_set_config(win, {
                  title = 'Build FALHOU!',
                  title_pos = 'center',
                })
              end
            end

            -- Inicia o comando 'dotnet build'.
            vim.fn.jobstart('dotnet build "' .. csproj_path .. '"', {
              stdout_buffered = true,
              stderr_buffered = true,
              on_stdout = function(_, data) if data then vim.api.nvim_buf_set_lines(buf, -1, -1, false, data) end end,
              on_stderr = function(_, data) if data then vim.api.nvim_buf_set_lines(buf, -1, -1, false, data) end end,
              on_exit = on_build_exit,
            })
          end

          map('i', '<CR>', select_project_and_build)
          map('n', '<CR>', select_project_and_build)
          return true
        end,
      })
    end

    ---
    -- Título: Atalhos de Teclado do Debugger
    ---
    -- Define os atalhos para controlar a sessão de depuração.
    vim.keymap.set('n', '<F5>', start_net_debug_session, { desc = 'Debug: Build & Run Project' })
    vim.keymap.set('n', '<S-F5>', function() dap.terminate() end, { desc = 'Debug: Terminate' })
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Debug: Set Conditional Breakpoint' })
  end,
}
