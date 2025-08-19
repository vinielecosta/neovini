-- ~/.config/nvim/lua/core/project_ref.lua
-- Este módulo contém a lógica para gerir referências entre projetos .NET,
-- replicando a funcionalidade "Add Project Reference" do Visual Studio.

-- Cria a tabela do módulo que será retornada no final do ficheiro.
local M = {}

----------------------------------------------------------------------
-- FUNÇÕES AUXILIARES (HELPERS)
----------------------------------------------------------------------

---
-- Título: Terminal Flutuante para Comandos
---
-- Função genérica que executa qualquer comando de terminal numa janela flutuante,
-- mostrando o progresso e o resultado (sucesso ou falha).
-- @param command string: O comando a ser executado.
-- @param title string: O título a ser exibido na janela flutuante.
-- @param success_msg string: A mensagem de notificação em caso de sucesso.
-- @param failure_msg string: A mensagem de notificação em caso de falha.
local function run_command_in_float(command, title, success_msg, failure_msg)
  -- Cria um novo buffer (área de texto) para a janela flutuante.
  local buf = vim.api.nvim_create_buf(false, true)
  -- Calcula as dimensões da janela para ocupar 80% da tela.
  local width = math.floor(vim.api.nvim_get_option('columns') * 0.8)
  local height = math.floor(vim.api.nvim_get_option('lines') * 0.8)
  -- Abre a janela flutuante no centro da tela.
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.api.nvim_get_option('lines') - height) / 2),
    col = math.floor((vim.api.nvim_get_option('columns') - width) / 2),
    border = 'rounded',
    title = title,
  })
  -- Garante que o buffer seja descartado ao fechar a janela.
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- Inicia o comando de forma assíncrona (job).
  vim.fn.jobstart(command, {
    stdout_buffered = true, -- Captura a saída padrão.
    stderr_buffered = true, -- Captura a saída de erro.
    -- Funções de callback para exibir a saída do comando na janela.
    on_stdout = function(_, data)
      if data then vim.api.nvim_buf_set_lines(buf, -1, -1, false, data) end
    end,
    on_stderr = function(_, data)
      if data then vim.api.nvim_buf_set_lines(buf, -1, -1, false, data) end
    end,
    -- Função chamada quando o comando termina.
    on_exit = function(_, exit_code)
      if exit_code == 0 then -- Código 0 indica sucesso.
        vim.api.nvim_win_set_config(win, { title = 'Sucesso!', title_pos = 'center' })
        vim.notify(success_msg, vim.log.levels.INFO)
        -- Fecha a janela automaticamente após 3 segundos.
        vim.defer_fn(function() vim.api.nvim_win_close(win, true) end, 3000)
      else -- Qualquer outro código indica falha.
        vim.api.nvim_win_set_config(win, { title = 'FALHA!', title_pos = 'center' })
        vim.notify(failure_msg, vim.log.levels.ERROR)
      end
    end,
  })
end

----------------------------------------------------------------------
-- FLUXO DE TRABALHO PRINCIPAL
----------------------------------------------------------------------

---
-- Título: Adicionar Referência de Projeto
---
-- Orquestra o fluxo de adicionar uma referência de um projeto a outro,
-- utilizando o Telescope para a seleção interativa.
function M.add_project_reference()
  -- Passo 1: Abre o Telescope para selecionar o projeto que VAI RECEBER a referência.
  require('telescope.builtin').find_files({
    prompt_title = '1/2: Selecione o projeto PARA ADICIONAR a referência',
    find_command = { 'fd', '--type', 'f', '--glob', '*.csproj' },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local function on_target_project_select()
        local selection = action_state.get_selected_entry()
        local target_project_path = selection.value
        actions.close(prompt_bufnr)

        -- Passo 2: Abre o Telescope novamente para selecionar o projeto A SER REFERENCIADO.
        require('telescope.builtin').find_files({
          prompt_title = '2/2: Selecione o projeto A SER REFERENCIADO',
          find_command = { 'fd', '--type', 'f', '--glob', '*.csproj' },
          attach_mappings = function(prompt_bufnr2, map2)
            local function on_source_project_select()
              local selection2 = action_state.get_selected_entry()
              local source_project_path = selection2.value
              actions.close(prompt_bufnr2)

              -- Passo 3: Monta o comando 'dotnet add reference' e o executa.
              local command = string.format('dotnet add "%s" reference "%s"', target_project_path, source_project_path)
              run_command_in_float(
                command,
                'Adicionando Referência de Projeto',
                'Referência adicionada com sucesso!',
                'Falha ao adicionar a referência.'
              )
            end
            -- Mapeia a tecla Enter para confirmar a seleção.
            map2('i', '<CR>', on_source_project_select)
            map2('n', '<CR>', on_source_project_select)
            return true
          end,
        })
      end
      -- Mapeia a tecla Enter para confirmar a seleção.
      map('i', '<CR>', on_target_project_select)
      map('n', '<CR>', on_target_project_select)
      return true
    end,
  })
end

-- Retorna o módulo para que ele possa ser usado por outros ficheiros (ex: keymaps.lua).
return M
