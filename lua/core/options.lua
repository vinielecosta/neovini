local opt = vim.opt -- atalho para vim.opt

-- Numeração de linhas
opt.relativenumber = true
opt.number = true

-- Tabulação e identação
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Quebra de linha inteligente
opt.wrap = false

-- Pesquisa
opt.ignorecase = true
opt.smartcase = true

-- Aparência
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.cursorline = true

-- Comportamento
opt.clipboard = 'unnamedplus' -- Sincroniza com a área de transferência do sistema
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.backup = false

-- Tempo de espera para comandos
opt.timeoutlen = 300
opt.updatetime = 300