return {
  "lervag/vimtex",
  lazy = false,
  config = function()
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "xdg-open"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_clipboard_toggle = 0
    vim.opt.breakindent = true
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_quickfix_mode = 0
    -- vim.g.vimtex_quickfix_ignore_filters = {
    --   "Underfull",
    --   "Overfull",
    --   "Package caption Warning",
    -- }
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = '-xelatex'
    } 
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-halt-on-error",
      },
    }
  end,
}
