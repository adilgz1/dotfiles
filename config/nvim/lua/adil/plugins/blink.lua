return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'L3MON4D3/LuaSnip',  -- add LuaSnip as an actual dependency
  },
  version = '1.*',
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300
      },
      list = { selection = { preselect = false, auto_insert = false } },
    },
    signature = { enabled = true },
    snippets = { preset = 'luasnip' },  -- bridge blink → luasnip
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        sql = { 'omni', 'buffer' },
        mysql = { 'omni', 'buffer' },
        plsql = { 'omni', 'buffer' },
        tex = { 'lsp', 'path', 'snippets', 'buffer', 'omni' },  -- add vimtex's omnifunc for tex
      },
      providers = {
        omni = {
          async = true,
          score_offset = -3,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" },
  config = function(_, opts)
    require("luasnip.loaders.from_lua").load({ paths = "./luasnippets" })
    require("blink.cmp").setup(opts)
  end,
}
