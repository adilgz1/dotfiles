-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap


-- exit insert mode with `jk` 
keymap.set("i", "jk", "<ESC>", {desc = "Exit insert mode with jk"})

-- rebind pgup, pgdn, half pgup, half pgdn so that cursor is centered after
keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true }, {desc = "page down"})
keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true }, {desc = "page up"})
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true }, {desc = "half page up"})
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true }, {desc = "half page down"})

-- Keep search results centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set("n", "H", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { silent = true })


vim.keymap.set("i", "<C-l>", function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local char = line:sub(col + 1, col + 1)
  if char:match("[%)%]%}%$>\"']") then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
  end
end, { silent = true })


-- set H and L to move to start(of non whitespace) and end of line in normal mode
vim.keymap.set({ "n", "v", "o" }, "H", "^", { noremap = true })
vim.keymap.set({ "n", "v", "o" }, "L", "$", { noremap = true })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab



-- testing for minty color picker
keymap.set("n", "<C-t>", function()
  require("plenary.reload").reload_module "minty.huefy"
  require("minty.huefy").open()

end, {})



