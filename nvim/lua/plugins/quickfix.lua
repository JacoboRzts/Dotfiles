return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      quickfix = {
        auto_open = true,   -- abre Trouble cuando haya items en el qf
        win = { position = "bottom", size = { height = 10 } },
      },
    },
  },
  init = function()
    -- Redirige :copen a Trouble
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "quickfix",
      callback = function()
        local ok, trouble = pcall(require, "trouble")
        if ok then
          vim.schedule(function()
            vim.cmd("cclose")
            trouble.open("quickfix")
          end)
        end
      end,
    })
  end,
}
