-- lazy.nvim
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      vsplit = {
        view = "split",
        position = "right",
        size = "40%",
        enter = true,
      },
    },
    routes = {
      {
        filter = {
          event = "lsp",
          kind = "progress",
        },
        opts = { skip = true },
      },
    },
    -- your existing config...
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  }
}
