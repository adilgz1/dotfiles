return {
  "lervag/vimtex",
  lazy = false,
  config = function()
    vim.g.vimtex_view_method = os.getenv("VIMTEX_VIEWER") or "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
  end,
}
