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
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- C/C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function(ev)
    local opts = { buffer = ev.buf }
    local wk = require("which-key")
    wk.add({ "<localleader>c", group = "C/C++", buffer = ev.buf })

    -- Compilar en una ventana de Ghostty
    vim.keymap.set("n", "<localleader>cb", function()
      local output = vim.fn.systemlist("cmake --build build")
      local ok = vim.v.shell_error == 0

      vim.notify(
        ok and "✓ Build exitoso" or "✗ Build fallido\n" .. table.concat(output, "\n"),
        ok and vim.log.levels.INFO or vim.log.levels.ERROR,
        { title = "CMake" }
      )
    end, vim.tbl_extend("force", opts, { desc = "Build (notify)" }))

    -- Helper: compilar async y ejecutar callback solo si fue exitoso
    local function build_then(on_success)
      local output = {}
      vim.notify("Compilando...", vim.log.levels.INFO, { title = "CMake" })

      vim.fn.jobstart("cmake --build build", {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data) vim.list_extend(output, data) end,
        on_stderr = function(_, data) vim.list_extend(output, data) end,
        on_exit = function(_, code)
          if code ~= 0 then
            vim.notify(
              "✗ Build fallido\n" .. table.concat(output, "\n"),
              vim.log.levels.ERROR,
              { title = "CMake" }
            )
            return
          end
          vim.notify("✓ Build exitoso", vim.log.levels.INFO, { title = "CMake" })
          on_success()
        end,
      })
    end

    -- Ejecutar en nueva ventana de Ghostty
    vim.keymap.set("n", "<localleader>cR", function()
      build_then(function()
        local bin = vim.fn.getcwd() .. "/build/run.out"
        local cmd = string.format("ghostty -e bash -c '%s; echo; read -p \"Press Enter to close...\"'", bin)
        vim.fn.jobstart(cmd, { detach = true })
      end)
    end, vim.tbl_extend("force", opts, { desc = "Build and Run C/C++ (Ghostty)" }))

    -- Ejecutar silenciosamente y mostrar output en quickfix
    vim.keymap.set("n", "<localleader>cr", function()
      build_then(function()
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
            while #output > 0 and output[#output] == "" do
              table.remove(output)
            end
            if #output == 0 then
              vim.notify("run.out ends whitout output (exit code: " .. code .. ")", vim.log.levels.INFO)
              return
            end
            vim.fn.setqflist({}, "r", {
              title = "run.out (exit: " .. code .. ")",
              lines = output,
            })
            vim.cmd("copen")
          end,
          })
        end)
      end, vim.tbl_extend("force", opts, { desc = "Build and Run C/C++ (quiet)" }))

    -- Solo ejecutar en Ghostty 
    vim.keymap.set("n", "<localleader>cX", function()
      local bin = vim.fn.getcwd() .. "/build/run.out"
      local cmd = string.format("ghostty -e bash -c '%s; echo; read -p \"Press Enter to close...\"'", bin)
      vim.fn.jobstart(cmd, { detach = true })
    end, vim.tbl_extend("force", opts, { desc = "Only Run C/C++ (Ghostty)" }))

    -- Ejecutar silenciosamente y mostrar output en quickfix
    vim.keymap.set("n", "<localleader>cx", function()
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
    end, vim.tbl_extend("force", opts, { desc = "Only Run C/C++ (quiet)" }))

  end,
})
