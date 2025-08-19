-- ~/.config/nvim/lua/core/autocmds.lua
-- Este ficheiro define "autocomandos", que são ações automáticas
-- acionadas por eventos específicos no Neovim (ex: fechar um terminal, criar um ficheiro).

-- Cria um grupo de autocomandos chamado 'MyAutoCmds'.
-- Usar um grupo é uma boa prática para manter as automações organizadas
-- e evitar que se acumulem ao recarregar a configuração.
-- 'clear = true' garante que o grupo seja limpo antes de adicionar os comandos novamente.
local augroup = vim.api.nvim_create_augroup('MyAutoCmds', {
  clear = true,
})

---
-- Título: Fechamento Automático do Terminal
---
-- Define uma automação para o evento 'TermClose', que é acionado
-- sempre que o processo dentro de uma janela de terminal é finalizado.
vim.api.nvim_create_autocmd('TermClose', {
  group = augroup,
  pattern = '*', -- Aplica-se a qualquer terminal.
  -- O comando 'bdelete!' fecha o buffer do terminal à força,
  -- fazendo com que a janela do terminal desapareça automaticamente.
  command = 'bdelete!',
})
