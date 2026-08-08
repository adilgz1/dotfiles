-- table-mode: markdown table creation & auto-alignment
return {
  "dhruvasagar/vim-table-mode",
  ft = "markdown",
  cmd = { "TableModeToggle", "TableModeRealign", "Tableize" },
  keys = {
    { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle table mode" },
    { "<leader>tr", "<cmd>TableModeRealign<cr>", desc = "Realign table" },
  },
  init = function()
    -- use standard markdown pipe-table syntax instead of the plugin's
    -- default non-markdown-compatible corner char
    vim.g.table_mode_corner = "|"
  end,
}
