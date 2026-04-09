-- MarkDown 
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "es,en"
  end,
})

-- LaTeX 
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "es,en"
  end,
})

-- C/C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function(ev)
    local opts = { buffer = ev.buf }
    local wk = require("which-key")
    wk.add({ "<localleader>c", group = "C/C++", buffer = ev.buf })
    vim.keymap.set("n", "<localleader>cb", "<cmd>!cmake --build build<CR>",
      vim.tbl_extend("force", opts, { desc = "Build C/C++" }))
    vim.keymap.set("n", "<localleader>cr", "<cmd>!./build/ObjectDetector<CR>",
      vim.tbl_extend("force", opts, { desc = "Run C/C++" }))
  end,
})
