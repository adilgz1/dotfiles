--nightfly colorscheme
return { 
  "bluz71/vim-nightfly-colors",
  name = "nightfly", 
  lazy = false, 
  priority = 1000,
  config = function()
    require("nightfly")
    vim.cmd("colorscheme nightfly")
  end,
}
