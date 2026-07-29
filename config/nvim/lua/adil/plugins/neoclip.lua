return {
  "AckslD/nvim-neoclip.lua",
  dependencies = { "ibhagwan/fzf-lua" },
  event = "VeryLazy",
  opts = {
    on_paste = { set_reg = true },
    keys = {
      fzf = {
        select = "default",   -- <CR> in insert mode -> paste
        paste = "default",
        paste_behind = "ctrl-b",
        custom = {
          ["ctrl-y"] = function(entry)
            require("neoclip.handlers").set_registers({ '"' }, entry)
          end,
        },
      },
    },
  },
  config = function(_, opts)
    require("neoclip").setup(opts)
    vim.keymap.set("n", "<leader>y", function()
      require("neoclip.fzf")()
    end, { desc = "Yank history (fuzzy search)" })
  end,
}
