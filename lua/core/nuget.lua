-- ~/.config/nvim/lua/core/nuget.lua
-- Este módulo contém toda a lógica para procurar e instalar pacotes NuGet
-- de forma interativa dentro do Neovim, usando o Telescope e o PowerShell.

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
-- @param command string: O comando a ser executado (ex: "dotnet add ...").
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
    -- Função chamada quando há uma nova saída padrão.
    on_stdout = function(_, data)
      if data then vim.api.nvim_buf_set_lines(buf, -1, -1, false, data) end
    end,
    -- Função chamada quando há uma nova saída de erro.
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

---
-- Título: Seletor de Projetos com Telescope
---
-- Função que abre uma janela do Telescope para o utilizador selecionar um ficheiro .csproj
-- e depois executa uma função de "callback" com o caminho do projeto selecionado.
-- @param callback function: A função a ser executada após a seleção do projeto.
local function select_project_and_run(callback)
  require('telescope.builtin').find_files({
    prompt_title = 'Selecione o Projeto (.csproj)',
    find_command = { 'fd', '--type', 'f', '--glob', '*.csproj' },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local function on_project_select()
        local selection = action_state.get_selected_entry()
        local project_path = selection.value
        actions.close(prompt_bufnr)
        -- Chama a função de callback passada como argumento.
        callback(project_path)
      end
      -- Mapeia a tecla Enter para confirmar a seleção.
      map('i', '<CR>', on_project_select)
      map('n', '<CR>', on_project_select)
      return true
    end,
  })
end

----------------------------------------------------------------------
-- FLUXOS DE TRABALHO PRINCIPAIS
----------------------------------------------------------------------

---
-- Título: Adicionar Pacote Diretamente
---
-- Orquestra o fluxo de adicionar um pacote NuGet quando o utilizador já sabe o nome.
function M.add_package_directly()
  -- Passo 1: Pede ao utilizador para digitar o comando.
  vim.ui.input({
    prompt = 'Comando: ',
    default = 'dotnet add package ',
  }, function(user_input)
    if not user_input or user_input == '' or user_input == 'dotnet add package ' then
      vim.notify('Instalação cancelada.', vim.log.levels.WARN)
      return
    end

    -- Extrai apenas o nome do pacote e a versão (se houver) do input.
    local package_part = user_input:gsub('dotnet add package ', '')

    -- Passo 2: Abre o seletor de projetos.
    select_project_and_run(function(project_path)
      -- Passo 3: Monta o comando final e o executa no terminal flutuante.
      local final_command = 'dotnet add "' .. project_path .. '" package ' .. package_part
      local package_name = package_part:match("^%S+")
      run_command_in_float(
        final_command,
        'Instalando ' .. package_name,
        'Pacote ' .. package_name .. ' instalado com sucesso!',
        'Falha ao instalar o pacote ' .. package_name
      )
    end)
  end)
end

-- Retorna o módulo para que ele possa ser usado por outros ficheiros.
return M
