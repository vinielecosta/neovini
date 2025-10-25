local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 'f', "", opts('Up'))
    vim.keymap.set('n', '<C-x>', api.node.open.vertical, opts('Open: Vertical Split'))
end

require('nvim-tree').setup({
    on_attach = my_on_attach,
    -- Sort files in a case-sensitive way
    sort_by = 'case_sensitive',
    -- File explorer window settings
    view = {
        width = {
            min = 20, -- Min width
            max = 60, -- Max width
        }
    },
    -- Rendering settings
    renderer = {
        icons = {
            show = {
                modified = true,
            },
            glyphs = {
                git = {
                    deleted = "",
                }
            }
        },
        group_empty = true,         -- Show empty folders
        full_name = true,           -- Show full file names
        highlight_modified = "all", -- Highlight files based on git status
    },
    -- File filters
    filters = {
        dotfiles = false  -- Show hidden files (e.g., .gitignore)
    },
    hijack_cursor = true, -- Keep the cursor on the first letter of the filename
    -- Configure delete action to move files to trash
    modified = {
        enable = true
    },
    update_focused_file = {
        enable = true
    },
    trash = {
        cmd = "trash" -- Requires a command-line trash utility, use "D" to send files to the trash bin
    }
})
