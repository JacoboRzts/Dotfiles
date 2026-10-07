return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle right<cr>", desc = "Explorer (neo-tree)" },
    },
    opts = {
      window = {
        position = "right",
        width = 40,
        mappings = {
          ["h"] = "close_node",
          ["l"] = "open",
          ["z"] = "close_all_nodes",
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
      },
    },
  },
}
