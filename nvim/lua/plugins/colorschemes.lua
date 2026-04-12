return {
  -- Vague
  {
    "vague-theme/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup({
        transparent = true,
      })
    end,
  },

  -- Oxocarbon
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Zenbones
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
  },

  -- onedark
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
  },


  -- Auto dark/light mode
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 500,
      set_dark_mode = function()
        vim.opt.background = "dark"
        vim.cmd("colorscheme vague")
      end,
      set_light_mode = function()
        vim.opt.background = "light"
        vim.cmd("colorscheme onedark")
      end,
    },
  },
}
