return {
  "willothy/nvim-cokeline",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local hlgroups = require('cokeline.hlgroups')
    local hl_attr = hlgroups.get_hl_attr
    vim.api.nvim_set_hl(0, 'MyTabLineFill', { none = hl_attr("TabLine", "bg") })
    require("cokeline").setup({
      show_if_buffers_are_at_least = 1,
      fill_hl = 'MyTabLineFill',
      components = {
        {
          text = "  ",
          fg = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "fg")
              or require("cokeline.hlgroups").get_hl_attr("Comment", "fg")
          end,
          none = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "none")
              or require("cokeline.hlgroups").get_hl_attr("TabLine", "none")
          end,
        },
        -- filename
        {
          text = function(buffer)
            return buffer.filename
          end,
          fg = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "fg")
              or require("cokeline.hlgroups").get_hl_attr("Comment", "fg")
          end,
          none = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "none")
              or require("cokeline.hlgroups").get_hl_attr("TabLine", "none")
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
          underline = function(buffer)
            return buffer.is_modified
          end,
        },
        {
          text = " ",
          fg = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "fg")
              or require("cokeline.hlgroups").get_hl_attr("Comment", "fg")
          end,
          none = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "none")
              or require("cokeline.hlgroups").get_hl_attr("TabLine", "none")
          end,
        },
        -- close
        {
          text = "✕",
          on_click = function(_, _, _, _, buffer)
            buffer:delete()
          end,
          fg = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("DiagnosticError", "fg")
              or require("cokeline.hlgroups").get_hl_attr("Comment", "fg")
          end,
          none = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "none")
              or require("cokeline.hlgroups").get_hl_attr("TabLine", "none")
          end,
        },
        {
          text = " ",
          fg = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "fg")
              or require("cokeline.hlgroups").get_hl_attr("Comment", "fg")
          end,
          none = function(buffer)
            return buffer.is_focused
              and require("cokeline.hlgroups").get_hl_attr("Normal", "none")
              or require("cokeline.hlgroups").get_hl_attr("TabLine", "none")
          end,
        },
      },
    })
  end,
}
