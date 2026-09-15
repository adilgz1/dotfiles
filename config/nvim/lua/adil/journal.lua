local M = {}

M.config = {
  marker = "<!%-%- journal %-%->",
  date_format = "%Y-%m-%d",                 -- used both to check + to write the heading
  entry_lines = function(date_str)
    -- Customize this: whatever lines you want a new entry to look like
    return {
      "",
      "## " .. date_str,
      "- ",
    }
  end,
}

local function is_journal_buffer(bufnr)
  local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
  return first_line ~= nil and first_line:match(M.config.marker) ~= nil
end

local function has_today_entry(bufnr, date_str)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local pattern = "^##%s+" .. vim.pesc(date_str)
  for _, line in ipairs(lines) do
    if line:match(pattern) then return true end
  end
  return false
end

function M.ensure_today_entry()
  local bufnr = vim.api.nvim_get_current_buf()
  if not is_journal_buffer(bufnr) then return end

  local date_str = os.date(M.config.date_format)
  if has_today_entry(bufnr, date_str) then return end

  local lines = M.config.entry_lines(date_str)
  local last_line = vim.api.nvim_buf_line_count(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, last_line, last_line, false, lines)
  vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(bufnr), 0 })
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.md",
    callback = function()
      vim.schedule(M.ensure_today_entry)
    end,
  })
end

return M
