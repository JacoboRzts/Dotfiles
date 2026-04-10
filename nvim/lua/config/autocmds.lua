-- MarkDown 
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "es,en"
  end,
})

-- LaTeX 
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "es,en"
  end,
})

-- C/C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function(ev)
    local opts = { buffer = ev.buf }
    local wk = require("which-key")
    wk.add({ "<localleader>c", group = "C/C++", buffer = ev.buf })

    vim.keymap.set("n", "<localleader>cb", "<cmd>!cmake build<CR>",
      vim.tbl_extend("force", opts, { desc = "Build C/C++" }))

    -- Ejecutar en nueva ventana de Ghostty
    vim.keymap.set("n", "<localleader>cr", function()
      local bin = vim.fn.getcwd() .. "/build/run.out"
      local cmd = string.format("ghostty -e bash -c '%s; echo; read -p \"Press Enter to close...\"'", bin)
      vim.fn.jobstart(cmd, { detach = true })
    end, vim.tbl_extend("force", opts, { desc = "Run C/C++ (Ghostty)" }))

    -- Ejecutar silenciosamente y mostrar output en quickfix
    vim.keymap.set("n", "<localleader>cR", function()
      local bin = vim.fn.getcwd() .. "/build/run.out"
      local output = {}
      vim.fn.jobstart(bin, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
          if data then vim.list_extend(output, data) end
        end,
        on_stderr = function(_, data)
          if data then vim.list_extend(output, data) end
        end,
        on_exit = function(_, code)
          -- Filtrar líneas vacías al final
          while #output > 0 and output[#output] == "" do
            table.remove(output)
          end
          if #output == 0 then
            vim.notify("run.out terminó sin output (exit code: " .. code .. ")", vim.log.levels.INFO)
            return
          end
          -- Abrir output en quickfix
          vim.fn.setqflist({}, "r", {
            title = "run.out (exit: " .. code .. ")",
            lines = output,
          })
          vim.cmd("copen")
        end,
      })
    end, vim.tbl_extend("force", opts, { desc = "Run C/C++ (silencioso)" }))
  end,
})
