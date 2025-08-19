-- ~/.config/nvim/lua/core/options.lua
-- Este ficheiro contém as configurações de base do editor Neovim.

local opt = vim.opt -- Cria um atalho para facilitar a escrita das opções

----------------------------------------------------------------------
-- NAVEGAÇÃO E VISUALIZAÇÃO
----------------------------------------------------------------------

-- Numeração de linhas
opt.relativenumber = true -- Mostra a numeração relativa à linha atual
opt.number = true         -- Mostra o número da linha atual

-- Aparência
opt.termguicolors = true  -- Habilita o suporte completo a cores (essencial para temas)
opt.signcolumn = 'yes'    -- Mantém a coluna de sinais sempre visível (para Git e erros)
opt.cursorline = true     -- Destaca a linha onde o cursor está

-- Quebra de linha
opt.wrap = false          -- Impede que linhas longas quebrem visualmente

----------------------------------------------------------------------
-- EDIÇÃO E INDENTAÇÃO
----------------------------------------------------------------------

-- Tabulação e indentação
opt.tabstop = 4           -- Define o tamanho de um Tab para 4 espaços
opt.shiftwidth = 4        -- Define o tamanho da indentação automática para 4 espaços
opt.expandtab = true      -- Converte a tecla Tab em espaços
opt.autoindent = true     -- Indenta novas linhas automaticamente

----------------------------------------------------------------------
-- PESQUISA
----------------------------------------------------------------------

-- Comportamento da pesquisa
opt.ignorecase = true     -- Ignora a diferença entre maiúsculas e minúsculas na pesquisa
opt.smartcase = true      -- A menos que a sua pesquisa contenha uma letra maiúscula

----------------------------------------------------------------------
-- COMPORTAMENTO GERAL
----------------------------------------------------------------------

-- Sincroniza com a área de transferência do sistema
opt.clipboard = 'unnamedplus'

-- Comportamento da divisão de janelas (splits)
opt.splitright = true     -- Abre novos splits verticais à direita
opt.splitbelow = true     -- Abre novos splits horizontais abaixo

-- Desativa ficheiros de backup e swap para uma experiência mais limpa
opt.swapfile = false
opt.backup = false

-- Tempos de resposta da UI
opt.timeoutlen = 300      -- Tempo de espera para atalhos compostos (em ms)
opt.updatetime = 300      -- Frequência de atualização para plugins (em ms)
