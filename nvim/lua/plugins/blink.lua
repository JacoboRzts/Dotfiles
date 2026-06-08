return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "accept", "fallback" },
      ["<CR>"] = { "fallback" },
    },
    sources = {
      per_filetype = {
        tex = { "lsp", "path", "buffer" },
      },
    },
  },
}
