return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      globalstatus = true,
      theme = {
        normal   = { a = { bg = 'bg' }, b = { bg = 'none' }, c = { bg = 'none' } },
        insert   = { a = { bg = 'bg' }, b = { bg = 'none' }, c = { bg = 'none' } },
        visual   = { a = { bg = 'bg' }, b = { bg = 'none' }, c = { bg = 'none' } },
        replace  = { a = { bg = 'bg' }, b = { bg = 'none' }, c = { bg = 'none' } },
        command  = { a = { bg = 'bg' }, b = { bg = 'none' }, c = { bg = 'none' } },
        inactive = { a = { bg = 'bg' }, b = { bg = 'none' }, c = { bg = 'none' } },
      }
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str) return str end,
          icon = '',
          color = { bg = 'bg', fg = '#445CCF' },
        },
      },
      lualine_b = {
        {
          'branch',
          color = { bg = 'bg', fg = 36 },
          icon = '󰘬',
        },
      },
      lualine_c = {
        {
          'filename',
          symbols = {
            readonly = '',
            unnamed = '',
          },
          color = { bg = 'bg' };
        }
      },
      lualine_x = {
        {
          'location',
          color = { bg = 'bg', fg = "#27272a" };
        }
      },
      lualine_y = {
        {
          'diagnostics',
          symbols = {error = ' ', warn = ' ', info = ' ', hint = '󱐋 '},
          color = { bg = 'bg' },
            -- Displays diagnostics status in color if set to true.
          colored = true,
          -- Show diagnostics even if there are bg.
          always_visible = false,
        },
      },
      lualine_z = {
        {
          'diff',
          color = { bg = 'bg' },
          separator = { left = '', right = ''},
          symbols = { added = ' ', modified = ' ', removed = '× ' },
        },
      },
    },
  },
}
