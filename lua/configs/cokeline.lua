-- ~/.config/nvim/lua/configs/cokeline.lua
require('cokeline').setup({
  show_if_buffers_are_at_least = 1,
  
  default_hl = {
    bg = "#1F1F28",
    -- Altere a cor do texto para um valor válido.
    -- O #c0c0c0 é um cinza claro que combina com o tema.
    fg = "#c0c0c0",
    fill_hl = '#1F1F28'
  }
})