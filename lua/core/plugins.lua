return { ----------------------------------------------------------------------
-- UI & Themes
----------------------------------------------------------------------
{'sainnhe/sonokai' -- lazy = false,
-- priority = 1000,
-- config = function()
--     vim.g.sonokai_style = 'shusia'
--     vim.g.sonokai_enable_italic = 1
--     vim.cmd.colorscheme('sonokai')
-- end
}, {'nvim-tree/nvim-web-devicons'}, {
    'nvim-tree/nvim-tree.lua',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('configs.nvim-tree')
    end
}, {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme('moonfly')
    end
}, {
    'thebigcicca/neokinds',
    config = function()
        require('configs.neokinds')
    end
}, {
    'folke/zen-mode.nvim',
    lazy = false,
    config = function()
        require('configs.zen-mode')
    end
}, {
    "folke/twilight.nvim",
    lazy = true,
    config = function()
        require('configs.twilight')
    end
}, {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('configs.lualine')
    end
}, {
    "willothy/nvim-cokeline",
    lazy = true,
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons"},
    config = function()
        require("configs.cokeline")
    end
}, {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*"
}, -------------------------------------------------------------
-- Development Tools
----------------------------------------------------------------------
{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('configs.treesitter')
    end
}, {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        require('configs.ts-context')
    end
}, {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        require('configs.autopairs')
    end
}, {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('configs.indent-lines')
    end
}, {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        -- Ativa o plugin
        require("configs.which-key")
    end
}, {
    "nvim-neotest/neotest",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "MunifTanjim/nui.nvim",
                    "Issafalcon/neotest-dotnet" -- Adaptador específico para .NET
    },
    config = function()
        require("configs.neotest")
    end
}, {
    'MeF0504/vim-pets',
    config = function()
        vim.g.pets_garden_width = 30
        vim.g.pets_garden_height = 10
    end
}, {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim'},
    opts = {}
}, ----------------------------------------------------------------------
-- LSP & Completion
----------------------------------------------------------------------
{
    'hrsh7th/nvim-cmp',
    dependencies = {'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'rafamadriz/friendly-snippets'},
    config = function()
        require('configs.completion')
    end
}, {
    'williamboman/mason-lspconfig.nvim',
    opts = {},
    dependencies = {{
        'mason-org/mason.nvim',
        opts = {}
    }, 'neovim/nvim-lspconfig'},
    config = function()
        require('configs.mason')
    end
}, {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
        filewatching = "roslyn",
        silent = true
    }
}, {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup()
        vim.diagnostic.config({
            virtual_text = false
        })
    end
}, ----------------------------------------------------------------------
-- Git Integration
----------------------------------------------------------------------
{
    'lewis6991/gitsigns.nvim',
    config = function()
        require('configs.gitsigns')
    end
}, {
    'NeogitOrg/neogit',
    dependencies = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
    config = function()
        require('configs.neogit')
    end
}, ----------------------------------------------------------------------
-- Debugging
----------------------------------------------------------------------
{
    'mfussenegger/nvim-dap',
    dependencies = {'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text', 'nvim-neotest/nvim-nio'},
    config = function()
        require('configs.dap')
    end
}, ----------------------------------------------------------------------
-- Terminal & File Navigation
----------------------------------------------------------------------
{
    'akinsho/toggleterm.nvim',
    config = function()
        require('configs.toggleterm')
    end
}, {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        require('configs.telescope')
    end
}, {
    'karb94/neoscroll.nvim',
    config = function()
        require('configs.smooth-scroll')
    end
}, ----------------------------------------------------------------------
-- Language Specific
----------------------------------------------------------------------
{
    'DestopLine/boilersharp.nvim',
    config = function()
        require('configs.boilersharp')
    end
}, {"VPavliashvili/json-nvim"}, ----------------------------------------------------------------------
-- Startup Screen
----------------------------------------------------------------------
{
    'goolord/alpha-nvim',
    config = function()
        require('configs.alpha')
    end
}}
