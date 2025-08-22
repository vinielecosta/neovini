-- ~/.config/nvim/lua/plugins/palette.lua
-- Este ficheiro define a Paleta de Comandos principal do NeoVini.
-- Ele utiliza o Telescope para criar uma interface de busca interativa
-- para todas as funcionalidades mais importantes da configuração.

return {
  "nvim-telescope/telescope.nvim",
  -- Define o atalho principal para abrir a paleta de comandos.
  -- Usar 'keys' garante que a lógica só seja carregada quando o atalho for usado.
  keys = {
    {
      "<leader>p", -- O atalho é Espaço + p
      function()
        ---
        -- Título: Definição das Ações da Paleta
        ---
        -- Tabela que conterá as funções mais complexas para manter o código organizado.
        local actions = {}

        -- Ação para rodar testes unitários.
        function actions.run_dotnet_tests()
          require('telescope.builtin').find_files({
            prompt_title = 'Selecione o Projeto de Teste (.csproj)',
            find_command = {
              'pwsh',
              '-NoProfile',
              '-Command',
              "Get-ChildItem -Path . -Filter *.csproj -Recurse | Where-Object { Select-String -Path $_.FullName -Pattern '<IsTestProject>true</IsTestProject>' -Quiet } | ForEach-Object { Resolve-Path -Path $_.FullName -Relative }",
            },
            attach_mappings = function(prompt_bufnr, map)
              local picker_actions = require('telescope.actions')
              local action_state = require('telescope.actions.state')
              local function on_project_select()
                local selection = action_state.get_selected_entry()
                local project_path = selection.value
                picker_actions.close(prompt_bufnr)
                local term = require('toggleterm.terminal').Terminal:new({
                  cmd = 'dotnet test "' .. project_path .. '"',
                  direction = 'float',
                  close_on_exit = false,
                })
                term:toggle()
              end
              map('i', '<CR>', on_project_select)
              map('n', '<CR>', on_project_select)
              return true
            end,
          })
        end

        -- Ação para rodar um projeto .NET.
        function actions.run_dotnet_project()
          require('telescope.builtin').find_files({
            prompt_title = "Run .NET Project",
            find_command = { 'fd', '--type', 'f', '--glob', '*.csproj' },
            attach_mappings = function(prompt_bufnr, map)
              local picker_actions = require('telescope.actions')
              local action_state = require('telescope.actions.state')
              local function on_project_select()
                local selection = action_state.get_selected_entry()
                local project_path = selection.value
                picker_actions.close(prompt_bufnr)
                local command = 'split term://dotnet run --project ' .. project_path
                vim.cmd(command)
              end
              map('i', '<CR>', on_project_select)
              map('n', '<CR>', on_project_select)
              return true
            end,
          })
        end

        ---
        -- Título: Lista de Comandos da Paleta
        ---
        local commands = {
          { "Find Files", function() require('telescope.builtin').find_files() end, category = "Ficheiros" },
          { "Find Text (Grep)", function() require('telescope.builtin').live_grep() end, category = "Ficheiros" },
          { "View Open Buffers", function() require('telescope.builtin').buffers() end, category = "Ficheiros" },
          { "Run Project", actions.run_dotnet_project, category = ".NET" },
          { "Run Tests", actions.run_dotnet_tests, category = ".NET" },
          { "NuGet: Add Package", function() require('core.nuget').add_package_directly() end, category = ".NET" },
          { "Projeto: Add Reference", function() require('core.project_ref').add_project_reference() end, category = ".NET" },

          { "Git (Neogit)", function() require('neogit').open() end, category = "Git" },
        }

        -- Mapeamento de categorias para ícones de texto (CORRIGIDO)
        local category_icons = {
          Ficheiros = "[ Ficheiros]",
          Codigo    = "[ Código]", -- CORRIGIDO
          [".NET"]  = "[ .NET]",
          Git       = "[ Git]",
        }

        ---
        -- Título: Lançador do Telescope
        ---
        require('telescope.pickers').new({}, {
          prompt_title = "Paleta de Comandos",
          finder = require('telescope.finders').new_table({
            results = commands,
            -- Define como cada entrada da tabela deve ser formatada para o Telescope.
            entry_maker = function(entry)
              -- Pega o ícone de texto correspondente à categoria
              local icon = category_icons[entry.category] or ""
              return {
                value = entry[2],      -- A função a ser executada.
                display = string.format("%-12s %s", icon, entry[1]), -- O texto a ser exibido (ex: "[Ficheiros] Procurar Ficheiros").
                ordinal = entry[1],    -- O texto a ser usado para a busca.
              }
            end,
          }),
          sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
          -- Mapeia a tecla Enter para executar a ação selecionada.
          attach_mappings = function(prompt_bufnr, map)
            local picker_actions = require('telescope.actions')
            local function run_action()
              local selection = require('telescope.actions.state').get_selected_entry()
              picker_actions.close(prompt_bufnr)
              selection.value()
            end
            map('i', '<CR>', run_action)
            map('n', '<CR>', run_action)
            return true
          end,
        }):find()
      end,
      desc = "Paleta de Comandos",
    },
  },
}
