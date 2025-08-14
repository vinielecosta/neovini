-- Defina o líder global ANTES de carregar qualquer plugin
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Carrega as opções base do editor
require('core.options')

-- Carrega os mapeamentos de teclas globais
require('core.keymaps')

-- Bootstrap do gerenciador de pacotes lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Carrega os plugins usando lazy.nvim
-- A pasta 'lua/plugins' será lida automaticamente
require('lazy').setup('plugins', {
  -- Configurações do Lazy, se necessário
  change_detection = {
    notify = false,
  },
})