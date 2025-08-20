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

        -- Ação para inserir o template de classe C#.
        function actions.insert_csharp_template()
          if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
            local filename = vim.api.nvim_buf_get_name(0)
            if not filename:match('%.cs$') then
              vim.notify("Arquivo não é .cs. Template não inserido.", vim.log.levels.WARN)
              return
            end
            local class_name = vim.fn.fnamemodify(filename, ':t:r')
            local sln_file = vim.fn.findfile('.sln', vim.fn.getcwd() .. ';')
            local namespace
            if sln_file ~= '' and sln_file ~= nil then
              local sln_dir = vim.fn.fnamemodify(sln_file, ':p:h')
              local solution_name = vim.fn.fnamemodify(sln_file, ':t:r')
              local current_dir = vim.fn.fnamemodify(filename, ':p:h')
              local relative_path = current_dir:gsub(vim.pesc(sln_dir), ''):gsub('^[\\/]', '')
              local sub_namespace = relative_path:gsub('[\\/]', '.')
              if sub_namespace ~= '' then
                namespace = solution_name .. '.' .. sub_namespace
              else
                namespace = solution_name
              end
            else
              namespace = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
            end
            local template = {
              'namespace ' .. namespace .. ';', '', 'public class ' .. class_name, '{', '    ', '}',
            }
            vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
            vim.api.nvim_win_set_cursor(0, { 5, 5 })
            vim.notify("Template de classe C# inserido!", vim.log.levels.INFO)
          else
            vim.notify("O arquivo não está vazio. Template não inserido.", vim.log.levels.INFO)
          end
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
          { "Procurar Ficheiros", function() require('telescope.builtin').find_files() end, category = "Ficheiros" },
          { "Procurar Texto (Grep)", function() require('telescope.builtin').live_grep() end, category = "Ficheiros" },
          { "Ver Buffers Abertos", function() require('telescope.builtin').buffers() end, category = "Ficheiros" },
          
          { "Formatar Ficheiro", function()
              vim.lsp.buf.format({ async = true })
              vim.notify("Código formatado!", vim.log.levels.INFO, { title = "NeoVini" })
            end, category = "Codigo" }, -- CORRIGIDO
          { "C#: Inserir Template de Classe", actions.insert_csharp_template, category = "Codigo" }, -- CORRIGIDO
          { "Rodar Projeto", actions.run_dotnet_project, category = ".NET" },
          { "Rodar Testes", actions.run_dotnet_tests, category = ".NET" },
          { "NuGet: Adicionar Pacote", function() require('core.nuget').add_package_directly() end, category = ".NET" },
          { "Projeto: Adicionar Referência", function() require('core.project_ref').add_project_reference() end, category = ".NET" },

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
