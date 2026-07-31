return {
  "tpope/vim-dadbod",
  lazy = true,
  cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",
  },
  init = function()
    -- Save connections/queries under your nvim data dir
    vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_winwidth = 40

    -- Optional: predefine connections instead of adding via :DBUIAddConnection
    -- vim.g.dbs = {
    --   { name = "local_pg", url = "postgres://user:pass@localhost:5432/mydb" },
    -- }
  end,
  keys = {
    { "<leader>Du", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    { "<leader>Df", "<cmd>DBUIFindBuffer<CR>", desc = "Find DB buffer" },
    { "<leader>Da", "<cmd>DBUIAddConnection<CR>", desc = "Add DB connection" },
  },
}
