-- ~/.config/nvim/lua/configs/cokeline.lua
require('cokeline').setup({
  show_if_buffers_are_at_least = 1,

  default_hl = {
    bg = function(buffer)
      local hlgroups = require("cokeline.hlgroups")
      return buffer.is_focused and hlgroups.get_hl_attr("ColorColumn", "bg") -- Cor quando a aba está focada
        or "#1F2329" -- Cor da aba não focada
    end,
    fg = "#dad5d5",
    bold = true,
  },
})

