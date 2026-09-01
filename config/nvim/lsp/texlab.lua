return {
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = { ".latexmkrc", ".git" },
  settings = {
    texlab = {
      build = {
        onSave = false, -- vimtex already handles compilation
      },
      chktex = {
        onOpenAndSave = true,
      },
    },
  },
}
