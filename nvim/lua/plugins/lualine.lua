return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      globalstatus = true,
      theme = {
        normal   = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
        insert   = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
        visual   = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
        replace  = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
        command  = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
        inactive = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
      }
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str) return str end,
          icon = '',
          color = { bg = 'none', fg = '#445CCF' },
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
          symbols = {
            readonly = '',
            unnamed = '',
          },
          color = { bg = 'none' };
        }
      },
      lualine_x = {
        {
          'location',
          color = { bg = 'none', fg = "#27272a" };
        }
      },
      lualine_y = {
        {
          'diagnostics',
          symbols = {error = ' ', warn = ' ', info = ' ', hint = '󱐋 '},
          color = { bg = 'none' },
            -- Displays diagnostics status in color if set to true.
          colored = true,
          -- Show diagnostics even if there are bg.
          always_visible = false,
        },
      },
      lualine_z = {
        {
          'diff',
          color = { bg = 'none' },
          separator = { left = '', right = ''},
          symbols = { added = ' ', modified = ' ', removed = '× ' },
        },
      },
    },
  },
}
