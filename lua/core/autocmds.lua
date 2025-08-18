-- ~/.config/nvim/lua/core/autocmds.lua
local augroup = vim.api.nvim_create_augroup('MyAutoCmds', {
    clear = true
})

-- Fecha a janela do terminal automaticamente quando o processo dentro dele terminar
vim.api.nvim_create_autocmd('TermClose', {
    group = augroup,
    pattern = '*',
    command = 'bdelete!' -- 'bdelete!' fecha o buffer sem salvar
})
