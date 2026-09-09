-- Allows you to select a template for a fresh .tex file
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.tex",
  callback = function()
    local template_dir = vim.fn.expand("~/.config/nvim/templates/")
    local files = vim.fn.glob(template_dir .. "*.tex", false, true)

    if #files == 0 then return end

    local names = {}
    for _, f in ipairs(files) do
      table.insert(names, vim.fn.fnamemodify(f, ":t:r"))
    end

    vim.ui.select(names, { prompt = "Choose template (Esc to skip):" }, function(choice)
      if choice then
        vim.cmd("0r " .. template_dir .. choice .. ".tex")
      end
    end)
  end,
})

-- Enabling treesitter highlighting
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "lua", "vim"},
  callback = function()
    vim.treesitter.start()
  end,
})

-- sql commands for dadbod
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    vim.bo.omnifunc = "vim_dadbod_completion#omni"
  end,
})

-- using skim to open pdfs on macos and zathura on linux
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function(args)
    local cmd
    if vim.fn.has("mac") == 1 then
      cmd = { "open", "-a", "Skim", args.file }
    elseif vim.fn.has("unix") == 1 then
      cmd = { "zathura", args.file }
    else
      vim.notify("No PDF opener configured for this OS", vim.log.levels.WARN)
      return
    end

    vim.fn.jobstart(cmd, { detach = true })
    vim.schedule(function()
      vim.cmd("bwipeout! " .. args.buf)
    end)
  end,
})


-- creating new entries for days in journal files
require("adil.journal").setup({
  entry_lines = function(date_str)
    return {
      "",
      "## " .. date_str .. " (" .. os.date("%A") .. ")",
      "",
      "- ",
    }
  end,
})
