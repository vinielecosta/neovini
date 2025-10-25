require("neogit").setup({
    -- Use the default settings as they work well for most users
    -- Customize only if needed
    kind = "split",
    signs = {
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
    },
    integrations = {
        diffview = true
    },
})
