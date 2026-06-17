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
          function()
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon, icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
            return icon or ''
          end,
          color = function()
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local _, icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
            return { fg = icon_color, bg = 'none' }
          end,
          padding = { left = 1, right = 0 },
        },
        {
          'filename',
          file_status = true,
          color = { bg = 'none', fg = 246 },
          path = 0,
          symbols = {
            unnamed = '',
            newfile = '',
            modified = '',
            readonly = '',
          }
        },
      },
      lualine_x = {
        {
          color = { bg = 'none' };
        }
      },
      lualine_y = {
        {
          'diagnostics',
          symbols = {error = ' ', warn = ' ', info = ' ', hint = '󱐋 '},
          color = { bg = 'none' },
            -- Displays diagnostics status in color if set to true.
          colored = true,
          -- Show diagnostics even if there are none.
          always_visible = false,
        },
      },
      lualine_z = {
        {
          'diff',
          color = { bg = 'none' },
          separator = { left = '', right = ''},
          symbols = { added = ' ', modified = ' ', removed = ' ' },
        },
      },
    },
  },
}
