return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          auto_close = true,
          layout = {
            layout = {
              position = "right",
              width = 30,
              min_width = 30,
              border = "none",
              box = "vertical",
              {
                win = "list",
                border = "none",
              },
            },
          },
        },
      },
    },
  },
}
