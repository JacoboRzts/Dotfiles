return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          -- auto_close = true,
          layout = {
            {
              preview = true
            },
            layout = {
              box = "vertical",
              width = 32,
              position = 'right',
              border = "none",
              {
                win = "list",
                title = "{source} {live} {flags}",
                title_pos = "left",
                border = "solid"
              },
            },
          },
        },
      },
    },
  },
}
