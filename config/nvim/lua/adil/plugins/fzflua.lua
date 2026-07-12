return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostic disable: missing-fields
  opts = {},
  ---@diagnostic enable: missing-fields
  keys = {
    {
     "<leader>ff",
     mode = {"n"},
     function() require('fzf-lua').files() end,
     desc = "open fzf in current file's directory",
    },


    {
     "<leader>fl",
     mode = {"n"},
     function() require('fzf-lua').buffers() end,
     desc = "live grep open buffer names",
    },

    {
     "<leader>fb",
     mode = {"n"},
     function() require('fzf-lua').lgrep_curbuf() end,
     desc = "live grep in current buffer",
    },

    {
     "<leader>fw",
     mode = {"n"},
     function() require('fzf-lua').grep_cword() end,
     desc = "grep current word",
    },

    {
     "<leader>fn",
     mode = {"n"},
     function() require('fzf-lua').files({ cwd = "~/.config/nvim" }) end,
     desc = "open fzf in nvim config dir",
    },

    {
     "<leader>fr",
     mode = {"n"},
     function() require('fzf-lua').files({ cwd = "~" }) end,
     desc = "open fzf in root user directory",
    },
    {
     "<leader>fh",
     mode = {"n"},
     function() require('fzf-lua').history() end,
     desc = "opened buffers/file history",
    },
    {
     "<leader>fzf",
     mode = {"n"},
     function() require('fzf-lua').builtin({ winopts = { preview = { hidden = false } } }) end,
     desc = "look at all fzf commands",
    },
    
    {
     "<leader>fg",
     mode = {"n"},
     function() require('fzf-lua').live_grep() end,
     desc = "live grep in current file's directory",
    },

  },
}
