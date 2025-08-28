return {
    ----------------------------------------------------------------------
    -- UI & Themes
    ----------------------------------------------------------------------
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("configs.kanagawa")
            vim.cmd("colorscheme kanagawa-dragon")
        end
    },
    { 'nvim-tree/nvim-web-devicons' },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('configs.nvim-tree')
        end
    },
    {
        'thebigcicca/neokinds',
        config = function()
            require('configs.neokinds')
        end
    },
    {
        'folke/zen-mode.nvim',
        config = function()
            require('configs.zen-mode')
        end
    },
    {
        "folke/twilight.nvim",
        config = function()
            require('configs.twilight')
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('configs.lualine')
        end
    },
    {
        "willothy/nvim-cokeline",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        -- Use 'config' para carregar a configuração de um arquivo externo
        config = function()
            require("configs.cokeline")
        end,
    },

    ----------------------------------------------------------------------
    -- Development Tools
    ----------------------------------------------------------------------
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('configs.treesitter')
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require('configs.ts-context')
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('configs.autopairs')
        end
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('configs.indent-lines')
        end
    },
    -- lua/plugins.lua
    {
        "folke/which-key.nvim",
        event = "VeryLazy", -- Carrega o plugin de forma preguiçosa para não atrasar o início
        config = function()
            -- Ativa o plugin
            require("configs.which-key")
        end
    },
    {
        "andythigpen/nvim-coverage",
        version = "*",
        config = function()
            require("configs.nvim-coverage")
        end,
    },
    -- {
    -- "nvim-neotest/neotest",
    --     dependencies = {
    --         "nvim-neotest/nvim-nio",
    --         "nvim-lua/plenary.nvim",
    --         "antoinemadec/FixCursorHold.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --         "Issafalcon/neotest-dotnet",
    --     },
    --     config = function()
    --         -- Ativa o plugin
    --         require("configs.neotest")
    --     end
    -- },
    ----------------------------------------------------------------------
    -- LSP & Completion
    ----------------------------------------------------------------------
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'rafamadriz/friendly-snippets',
        },
        config = function()
            require('configs.completion')
        end
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('configs.mason')
        end
    },
    {
        "seblyng/roslyn.nvim",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {
                filewatching = "roslyn",
                silent = true
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup()
            vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
        end
    },

    ----------------------------------------------------------------------
    -- Git Integration
    ----------------------------------------------------------------------
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('configs.gitsigns')
        end
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
        },
        config = function()
            require('configs.neogit')
        end
    },

    ----------------------------------------------------------------------
    -- Debugging
    ----------------------------------------------------------------------
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require('configs.dap')
        end
    },

    ----------------------------------------------------------------------
    -- Terminal & File Navigation
    ----------------------------------------------------------------------
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('configs.toggleterm')
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('configs.telescope')
        end
    },
    {
        'karb94/neoscroll.nvim',
        config = function()
            require('configs.smooth-scroll')
        end
    },

    ----------------------------------------------------------------------
    -- Language Specific
    ----------------------------------------------------------------------
    {
        'DestopLine/boilersharp.nvim',
        config = function()
            require('configs.boilersharp')
        end
    },

    ----------------------------------------------------------------------
    -- Startup Screen
    ----------------------------------------------------------------------
    {
        'goolord/alpha-nvim',
        config = function()
            require('configs.alpha')
        end
    },
}
