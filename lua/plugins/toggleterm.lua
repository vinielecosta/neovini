-- ~/.config/nvim/lua/plugins/toggleterm.lua
-- Este ficheiro configura o toggleterm.nvim, um plugin avançado para gerir
-- terminais integrados no Neovim. Ele permite abrir terminais flutuantes,
-- verticais ou horizontais com atalhos de teclado.

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  ---
  -- Título: Atalhos de Teclado (Lazy Loaded)
  ---
  -- Define os atalhos para abrir/fechar os terminais.
  -- Usar a propriedade 'keys' do lazy.nvim garante que o plugin só seja
  -- carregado na primeira vez que um destes atalhos for pressionado.
  keys = {
    { '<leader>ft', "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal Flutuante" },
    { '<leader>vt', "<cmd>ToggleTerm direction=vertical<CR>", desc = "Terminal Vertical" },
    { '<leader>st', "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal Horizontal" },
    { '<leader>gg', "<cmd>ToggleTerm direction=float cmd=lazygit<CR>", desc = "LazyGit" },
    -- Atalho para sair do modo terminal de forma mais intuitiva com a tecla Esc.
    { '<esc>', '<C-\\><C-n>', mode = 't', desc = 'Sair do modo terminal' },
  },
  ---
  -- Título: Configuração Principal
  ---
  -- A função de configuração principal do plugin.
  config = function()
    require('toggleterm').setup({
      -- Fecha o terminal automaticamente quando o processo dentro dele finaliza.
      close_on_exit = true,
      -- Inicia novos terminais já no modo de inserção, pronto para digitar.
      start_in_insert = true,
      -- Define o PowerShell como o shell padrão para todos os terminais.
      shell = "pwsh",
      -- A direção padrão se nenhum for especificado no comando.
      direction = 'float',
      -- Opções específicas para as janelas de terminal flutuantes.
      float_opts = {
        border = 'rounded',
      },
    })
  end,
}
