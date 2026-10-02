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

-- Java (Maven / Gradle)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function(ev)
    local opts = { buffer = ev.buf }
    local wk = require("which-key")
    wk.add({ "<localleader>j", group = "Java", buffer = ev.buf })

    -- Detecta el proyecto y devuelve root + comandos (prefiere el wrapper)
    local function project()
      local root = vim.fs.root(ev.buf, { "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" })
      if not root then
        vim.notify("No se encontró pom.xml ni build.gradle", vim.log.levels.WARN, { title = "Java" })
        return nil
      end

      local function exists(f) return vim.uv.fs_stat(root .. "/" .. f) ~= nil end

      if exists("pom.xml") then
        local mvn = exists("mvnw") and "./mvnw" or "mvn"
        return {
          root = root,
          name = "Maven",
          build = mvn .. " -q package -DskipTests",
          test = mvn .. " test",
          test_class = function(c) return mvn .. " test -Dtest=" .. c end,
          run = mvn .. " spring-boot:run",
          clean = mvn .. " clean",
        }
      else
        local gr = exists("gradlew") and "./gradlew" or "gradle"
        return {
          root = root,
          name = "Gradle",
          build = gr .. " build -x test",
          test = gr .. " test",
          test_class = function(c) return gr .. " test --tests " .. c end,
          run = gr .. " bootRun",
          clean = gr .. " clean",
        }
      end
    end

    -- Ejecuta un comando async y notifica; opcionalmente abre quickfix si falla
    local function run_async(p, cmd, title, on_success)
      local output = {}
      vim.notify("Ejecutando: " .. cmd, vim.log.levels.INFO, { title = title })

      vim.fn.jobstart(cmd, {
        cwd = p.root,
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data) if data then vim.list_extend(output, data) end end,
        on_stderr = function(_, data) if data then vim.list_extend(output, data) end end,
        on_exit = function(_, code)
          while #output > 0 and output[#output] == "" do
            table.remove(output)
          end
          if code ~= 0 then
            vim.notify("✗ Falló (exit " .. code .. ")", vim.log.levels.ERROR, { title = title })
            vim.fn.setqflist({}, "r", { title = title .. " (exit: " .. code .. ")", lines = output })
            vim.cmd("copen")
            return
          end
          vim.notify("✓ Exitoso", vim.log.levels.INFO, { title = title })
          if on_success then on_success(output) end
        end,
      })
    end

    -- Ejecuta en una ventana nueva de Ghostty (ideal para Spring Boot, que queda corriendo)
    local function run_in_ghostty(p, cmd)
      local script = string.format("%s; echo; read -p 'Press Enter to close...'", cmd)
      vim.fn.jobstart({ "ghostty", "-e", "bash", "-c", script }, { cwd = p.root, detach = true })
    end

    -- Build (notify)
    vim.keymap.set("n", "<localleader>jb", function()
      local p = project()
      if p then run_async(p, p.build, p.name) end
    end, vim.tbl_extend("force", opts, { desc = "Build (notify)" }))

    -- Run app en Ghostty (spring-boot:run / bootRun)
    vim.keymap.set("n", "<localleader>jR", function()
      local p = project()
      if p then run_in_ghostty(p, p.run) end
    end, vim.tbl_extend("force", opts, { desc = "Run app (Ghostty)" }))

    -- Run app en un split de terminal dentro de Neovim
    vim.keymap.set("n", "<localleader>jr", function()
      local p = project()
      if not p then return end
      vim.cmd("botright 15split | terminal cd " .. vim.fn.shellescape(p.root) .. " && " .. p.run)
      vim.cmd("startinsert")
    end, vim.tbl_extend("force", opts, { desc = "Run app (terminal split)" }))

    -- Todos los tests (Ghostty, para ver el reporte completo)
    vim.keymap.set("n", "<localleader>jT", function()
      local p = project()
      if p then run_in_ghostty(p, p.test) end
    end, vim.tbl_extend("force", opts, { desc = "Test all (Ghostty)" }))

    -- Test de la clase actual (silencioso, falla -> quickfix)
    vim.keymap.set("n", "<localleader>jt", function()
      local p = project()
      if not p then return end
      local class = vim.fn.expand("%:t:r")
      run_async(p, p.test_class(class), "Test " .. class)
    end, vim.tbl_extend("force", opts, { desc = "Test current class (quiet)" }))

    -- Clean
    vim.keymap.set("n", "<localleader>jc", function()
      local p = project()
      if p then run_async(p, p.clean, p.name) end
    end, vim.tbl_extend("force", opts, { desc = "Clean" }))
  end,
})
