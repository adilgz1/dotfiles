return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    todo_comments.setup()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })
    keymap.set("n", "<leader>ft", function()
      require("fzf-lua").fzf_exec(
        "rg --column --line-number --no-heading --color=always 'TODO:|FIXME:|HACK:|NOTE:|WARNING:'",
        {
          actions = require("fzf-lua").defaults.actions.files,
          previewer = "builtin",
        }
      )
    end, { desc = "Find todos" })
    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })
    -- TODO: please
  end,
}
