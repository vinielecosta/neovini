-- ~/.config/nvim/init.lua
-- This is the main entry point of your Neovim configuration
-- Its sole responsibility is to load the other configuration modules in the correct order

----------------------------------------------------------------------
-- Leader Key Definition
----------------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

----------------------------------------------------------------------
-- Loading Core Configuration
----------------------------------------------------------------------

require('core.options') 
require('core.keymaps') 

----------------------------------------------------------------------
-- Plugin Manager Bootstrap (lazy.nvim)
----------------------------------------------------------------------
-- This section checks if lazy.nvim is installed. If it's not,
-- it clones the GitHub repository and installs it automatically

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- Use the latest stable version.
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

----------------------------------------------------------------------
-- Lazy.nvim Initialization
----------------------------------------------------------------------

require('lazy').setup('plugins', {
  change_detection = {
    notify = true, -- Enables automatic notifications about plugin changes.
  },
})
