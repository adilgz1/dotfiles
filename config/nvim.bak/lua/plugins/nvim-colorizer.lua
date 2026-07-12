return {
  "norcalli/nvim-colorizer.lua",
  ft = { "css", "html", "lua", "vim" },
  config = function()
    require("colorizer").setup()
  end,
}
