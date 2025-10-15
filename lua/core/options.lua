local opt = vim.opt -- Creates a shortcut for easier option settings

----------------------------------------------------------------------
-- NAVIGATION AND VISUALIZATION
----------------------------------------------------------------------

-- Line numbering
opt.relativenumber = true -- Shows line numbers relative to current line
opt.number = true -- Shows the current line number

-- Appearance
opt.termguicolors = true -- Enables full color support (essential for themes)
opt.signcolumn = 'yes' -- Keeps sign column always visible (for Git and errors)
opt.cursorline = true -- Highlights the line where the cursor is

-- Line wrapping
opt.wrap = false -- Prevents long lines from wrapping visually

----------------------------------------------------------------------
-- EDITING AND INDENTATION
----------------------------------------------------------------------

-- Tab and indentation
opt.tabstop = 4 -- Sets Tab size to 4 spaces
opt.shiftwidth = 4 -- Sets automatic indentation size to 4 spaces
opt.expandtab = true -- Converts Tab key to spaces
opt.autoindent = true -- Automatically indents new lines

----------------------------------------------------------------------
-- SEARCH
----------------------------------------------------------------------

-- Search behavior
opt.ignorecase = true -- Ignores case when searching
opt.smartcase = true -- Unless your search contains an uppercase letter

----------------------------------------------------------------------
-- GENERAL BEHAVIOR
----------------------------------------------------------------------

-- System clipboard sync
opt.clipboard = 'unnamedplus'

-- Window split behavior
opt.splitright = true -- Opens new vertical splits to the right
opt.splitbelow = true -- Opens new horizontal splits below

-- Disables backup and swap files for a cleaner experience
opt.swapfile = false
opt.backup = false

-- UI response times
opt.timeoutlen = 300 -- Wait time for key combinations (in ms)
opt.updatetime = 300 -- Update frequency for plugins (in ms)

----------------------------------------------------------------------
-- DIAGNOSTIC CONFIGURATION
----------------------------------------------------------------------

-- Diagnostic icons configuration using the new method
vim.diagnostic.config({
    virtual_text = false, -- Disables default virtual text
    signs = {
        priority = 10,
        text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.HINT] = "●"
        }
    },
    float = {
        border = "rounded",
        source = "always"
    },
    severity_sort = true
})
