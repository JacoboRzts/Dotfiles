return {
  "folke/snacks.nvim",
  opts = {
    styles = {
      terminal = {
        wo = {
          winhighlight = "Normal:Normal,NormalFloat:Normal,NormalNC:Normal",
        },
      },
    },
    terminal = {
      shell = vim.o.shell,
      win = {
        position = "bottom",
        border = false,
        height = 12,
        style = "terminal",
        wo = {
          winbar = "",
        },
      },
    },
  },
}
