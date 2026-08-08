-- treesitter: plugin and configs
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
  local install_dir = vim.fn.stdpath("data") .. "/site"
  vim.opt.runtimepath:append(install_dir)

  -- the main branch nests runtime files (queries, etc.) under runtime/
  local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
  vim.opt.runtimepath:append(ts_path .. "/runtime")

  require("nvim-treesitter").setup({
    install_dir = install_dir,
  })

  require("nvim-treesitter").install({
    "python", "lua", "latex", "vim", "vimdoc", "html",
    "css", "javascript", "markdown", "c", "cpp", "regex", "bash"
  }):wait(300000)

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local ft = args.match
      local lang = vim.treesitter.language.get_lang(ft) or ft
      pcall(vim.treesitter.start, args.buf, lang)
    end,
  })
end,
}
