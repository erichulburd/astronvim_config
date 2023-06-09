-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "lua_ls",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "prettier",
        -- "stylua",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "python",
      });
      -- references:
      -- https://github.com/simrat39/rust-tools.nvim/wiki/Debugging
      -- https://github.com/simrat39/rust-tools.nvim/blob/71d2cf67b5ed120a0e31b2c8adb210dd2834242f/lua/rust-tools/dap.lua
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode

      local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
      local dap = require('dap')

      dap.adapters.lldb = {
        type = "server",
        name = "lldb",
        host = "127.0.0.1",
        port = "9998",
        executable = {
          command = codelldb_path,
          args = { "--liblldb", liblldb_path, "--port", "9998" },
        }
      }
      -- More confiuration available here:
      -- https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-vscode#configurations
      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          -- program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
          program = function()
            path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/${workspaceFolderBasename}',
              'file')
            return path
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          -- args = { "${fileDirname}/../target/debug/${workspaceFolderBasename}" },
          initCommands = function()
            -- Find out where to look for the pretty printer Python module
            local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

            local commands = {}
            local file = io.open(commands_file, 'r')
            if file then
              for line in file:lines() do
                table.insert(commands, line)
              end
              file:close()
            end
            table.insert(commands, 1, script_import)

            return commands
          end,
        }
      }
    end,
  },
}
