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
                border = "none"
              },
            },
          },
        },
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "SnacksPickerList", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksPickerBorder", { bg = "NONE" })
      end,
    })
  end,
}
