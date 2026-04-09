return {
    {
      "nvim-lualine/lualine.nvim",
        opts = {
            options = {
              icons_enabled = true,
              section_separators = { left = '', right = '' },
              component_separators = { left = '', right = '' },
              globalstatus = true,
            },
            sections = {
              lualine_a = {
                {
                  'mode',
                  fmt = function(str) return str:lower() end,
                  icon = '',
                  color = { bg = 'none', fg = 33 },
                },
              },
              lualine_b = {
                {
                  'branch',
                  color = { bg = 'none', fg = 36 },
                  icon = '󰘬',
                },
              },
              lualine_c = {
                {
                  'filename',
                  icon = '',
                  file_status = true,
                  color = { bg = 'none' ,fg = 246 },
                  path = 1,
                  symbols = {
                    unnamed = '',
                    newfile = '',
                    modified = '',
                    readonly = '',
                  }
                },
              },
              lualine_x = {},
              lualine_y = {
                {
                  'diagnostics',
                  symbols = {error = ' ', warn = ' ', info = ' ', hint = '󱐋 '},
                  color = { bg = 'none ' },
                   -- Displays diagnostics status in color if set to true.
                  colored = true,
                  -- Show diagnostics even if there are none.
                  always_visible = false,
                },
              },
              lualine_z = {
                {
                  'diff',
                  color = { bg = 'none'},
                  separator = { left = '', right = ''},
                  symbols = { added = ' ', modified = ' ', removed = ' ' },
                },
              },
            },
        },
    },
}
