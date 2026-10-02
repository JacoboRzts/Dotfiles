return {
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
    init = function()
      local jqx = require("nvim-jqx.config")
      jqx.geometry.border = "single"
      jqx.geometry.width = 0.7
      jqx.query_key = "X"
      jqx.sort = false
      jqx.show_legend = true
    end,
  },

  {
    dir = vim.fn.stdpath("config"),
    name = "data-formats-config",
    lazy = false,
    config = function()

      -- Helpers de conversión
      local function json_to_yaml()
        vim.cmd("%!yq e -P '.' -")          -- -P = pretty YAML output
        vim.bo.filetype = "yaml"
      end

      local function yaml_to_json()
        vim.cmd("%!yq e -o=json '.' -")
        vim.bo.filetype = "json"
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "json", "yaml" },
        callback = function(ev)
          local buf = ev.buf
          local ft  = vim.bo[buf].filetype

          -- Formatear en su lugar
          local function format()
            if ft == "json" then
              vim.cmd("%!jq .")
            elseif ft == "yaml" then
              vim.cmd("%!yq e '.' -")
            end
          end

          -- Minificar (solo JSON)
          local function minify()
            if ft == "json" then
              vim.cmd("%!jq -c .")
            end
          end

          -- <leader>fp  → formatear / parsear
          vim.keymap.set("n", "<leader>fp", format, {
            buffer = buf,
            desc = "Format/parse " .. ft,
          })

          -- <leader>fm  → minificar (solo JSON)
          if ft == "json" then
            vim.keymap.set("n", "<leader>fm", minify, {
              buffer = buf,
              desc = "Minify JSON",
            })
          end

          -- <leader>fj  → convertir a JSON
          -- <leader>fy  → convertir a YAML
          vim.keymap.set("n", "<leader>fj", yaml_to_json, {
            buffer = buf,
            desc = "Convert to JSON",
          })
          vim.keymap.set("n", "<leader>fy", json_to_yaml, {
            buffer = buf,
            desc = "Convert to YAML",
          })
        end,
      })

    end,
  },
}
