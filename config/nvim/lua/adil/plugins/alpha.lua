return {
  "goolord/alpha-nvim",
  --  enabled = false,
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    -- set ascii banner header
    dashboard.section.header.val = {

      "                  oo           " ,
      "                               " ,
      "88d888b. dP   .dP dP 88d8b.d8b." ,
      "88'  `88 88   d8' 88 88'`88'`88" ,
      "88    88 88 .88'  88 88  88  88" ,
      "dP    dP 8888P'   dP dP  dP  dP" ,

    } 

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("e", " > new file", "<cmd>ene<CR>"),
      dashboard.button("-", " > file explorer"),
      dashboard.button("<leader> -", " > file manager"),
      dashboard.button("<leader> ff", "󰱼 > file fuzzy finder" ),
      dashboard.button("<leader> fg", " > live grep"),
      dashboard.button("<leader> fh", "󰱼 > fzf history"),
      dashboard.button("<leader> fzf", " > fzf builtin"),
      dashboard.button("q", " > quit", "<cmd>qa<CR>"),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
