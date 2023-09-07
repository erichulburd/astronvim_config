return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "tamago324/nlsp-settings.nvim",
    module = "nlspsettings",
    -- lazy = false,
    config = function()
      require("nlspsettings").setup {
        config_home = vim.fn.stdpath "config" .. "/lua/user/nlsp-settings",
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers_fallback = { ".git" },
        append_default_schemas = true,
        loader = "json",
      }
    end
  },
  -- Reference setup: https://github.com/AstroNvim/AstroNvim/issues/1129
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      vim.schedule(function()
        require("copilot").setup({
          -- per https://github.com/zbirenbaum/copilot-cmp/tree/b732a58ac8b7287b981cd9f0d9c0f61e5e9d5760#install
          suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
              accept = "<C-l>",
              next = "<C-j>",
              prev = "<C-k>",
              dismiss = "<C-e>",
            }
          },
          filetypes = {
            -- for some reason copilot does not play well with ccls. When both are enabled, the editor emits
            -- the error "warning: multiple different client offset_encodings detected for buffer, this is not supported yet"
            -- see https://github.com/neovim/nvim-lspconfig/issues/2709
            cpp = false,
            c = false,
            cuda = false,
            opencl = false,
          }
        })
      end) -- 100
      -- require("copilot").setup({ suggestion = { auto_trigger = true } })
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   after = { "nvim-cmp", "copilot.lua" },
  --   config = function()
  --     astronvim.add_cmp_source({
  --       name = "copilot",
  --       priority = 999,
  --       max_item_count = 3,
  --       keyword_length = 2
  --     })
  --     require("copilot_cmp").setup()
  --   end
  -- },
  {
    "mfussenegger/nvim-dap-python",
    pin = true,
    config = function()
      require("dap-python").setup("~/.local/virtualenvs/debugpy/bin/python")
      require("dap-python").test_runner = "pytest"
      require('dap').set_exception_breakpoints({ "raised", "uncaught" })

      require('dap').configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'My custom launch configuration',
          justMyCode = false,
          program = '${file}',
        },
      }
    end,
  }
}
