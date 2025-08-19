-- ~/.config/nvim/init.lua
-- Este é o ponto de entrada principal da sua configuração do Neovim.
-- A sua única responsabilidade é carregar os outros módulos de configuração na ordem correta.

----------------------------------------------------------------------
-- Título: Definição da Tecla Líder (Leader Key)
----------------------------------------------------------------------
-- A tecla líder é um atalho mestre que precede muitos comandos customizados.
-- Usar a barra de espaço é uma prática comum e ergonómica.
-- É crucial definir isto ANTES de carregar qualquer plugin ou atalho.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

----------------------------------------------------------------------
-- Título: Carregamento da Configuração Principal
----------------------------------------------------------------------
-- Carrega os ficheiros de configuração de base do editor.
require('core.options') -- Opções gerais do Neovim (ex: numeração de linhas, indentação).
require('core.keymaps') -- Atalhos de teclado globais e essenciais.

----------------------------------------------------------------------
-- Título: Bootstrap do Gerenciador de Plugins (lazy.nvim)
----------------------------------------------------------------------
-- Esta secção verifica se o lazy.nvim está instalado. Se não estiver,
-- ele clona o repositório do GitHub e instala-o automaticamente.
-- Isto garante que a sua configuração seja portátil e funcione em qualquer máquina.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- Usa a versão estável mais recente.
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

----------------------------------------------------------------------
-- Título: Inicialização do Lazy.nvim
----------------------------------------------------------------------
-- Esta é a chamada principal para o lazy.nvim.
-- O comando 'lazy'.setup('plugins') instrui o lazy a procurar e carregar
-- todos os ficheiros .lua dentro da pasta 'lua/plugins/'.
require('lazy').setup('plugins', {
  -- Configurações opcionais do Lazy.
  change_detection = {
    notify = false, -- Desativa as notificações automáticas sobre alterações nos plugins.
  },
})
