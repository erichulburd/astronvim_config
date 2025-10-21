-- For an example see https://github.com/AstroNvim/template/blob/b777fe96c301ac472642dadb9721a7e799700420/lua/plugins/astrolsp.lua

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  tag = "v3.2.1",
  -- enable servers that you already have installed without mason
  ---@type AstroLSPOpts
  opts = function(plugin, opts)

    -- safely extend the servers list
    opts.servers = opts.servers or {
      -- rust_analyzer = function(server_opts)
      --   -- See https://github.com/hrsh7th/cmp-nvim-lsp/issues/44#issuecomment-2096368152
      --   -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
      --   -- local rust_analyzer_capabilities = cmp_nvim_lsp.default_capabilities()
      --   -- rust_analyzer_capabilities.workspace = { didChangeWatchedFiles = { dynamicRegistration = true } }
      --   -- opts.config.rust_analyzer = { capabilities = rust_analyzer_capabilities }
      --
      --   local capabilities = server_opts.capabilities
      --   capabilities.workspace = capabilities.workspace or {}
      --   capabilities.workspace.didChangeWatchedFiles = {
      --     dynamicRegistration = true,
      --   }
      --
      --   -- Use vim.tbl_deep_extend to safely merge your custom settings
      --   -- with the default server_opts provided by AstroNvim.
      --   -- 'force' ensures your new settings overwrite any existing ones.
      --   server_opts.settings = vim.tbl_deep_extend("force",
      --     server_opts.settings or {},
      --     rust_analyzer_settings
      --   )
      --
      --   return server_opts
      -- end,
      ruff = {
        settings = {
          format = { backend = "internal" }
        }
      }
    }

    vim.filetype.add({
      extension = {
        mojo = 'mojo',
        cxx = 'cpp',
        cppm = 'cpp',

      },
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "mojo",
        callback = function()
            vim.opt_local.commentstring = "# %s"
        end
    })

    vim.list_extend(opts.servers, {
      "mojo",
      "neocmake",
      "clangd"
    })

    opts.config = opts.config or {}


    -- https://github.com/neovim/nvim-lspconfig/blob/056f569f71e4b726323b799b9cfacc53653bceb3/doc/server_configurations.md#neocmake
    local neocmake_capabilities = vim.lsp.protocol.make_client_capabilities()
    neocmake_capabilities.textDocument.completion.completionItem.snippetSupport = true
    opts.config.neocmake = { capabilities = neocmake_capabilities }

    local clangd_capabilities = vim.lsp.protocol.make_client_capabilities()
    clangd_capabilities.offsetEncoding = "utf-16"
    local llvm_tag = os.getenv("LLVM_TAG")
    if llvm_tag == nil then llvm_tag = os.getenv("DEFAULT_LLVM_TAG") end
    opts.config.clangd = {
      capabilities = clangd_capabilities,
      cmd = { os.getenv("HOME") .. "/.build/" .. llvm_tag .. "/bin/clangd" },
      filetypes = { "c", "cpp", "cppm", "cxx", "objc", "objcpp", "cuda" }
    }

    -- add mappings
    -- if opts.mappings.n.gd then
    --   opts.mappings.n.gd[1] = function()
    --     require("snacks.picker").lsp_definitions()
    --   end
    -- end
    -- if opts.mappings.n.gI then
    --   opts.mappings.n.gI[1] = function()
    --     require("snacks.picker").lsp_implementations()
    --   end
    -- end
    -- if opts.mappings.n.gy then
    --   opts.mappings.n.gy[1] = function()
    --     require("snacks.picker").lsp_type_definitions()
    --   end
    -- end
    -- if opts.mappings.n["<Leader>lG"] then
    --   opts.mappings.n["<Leader>lG"][1] = function()
    --     require("snacks.picker").lsp_workspace_symbols()
    --   end
    -- end
    -- if opts.mappings.n["<Leader>lR"] then
    --   opts.mappings.n["<Leader>lR"][1] = function()
    --     require("snacks.picker").lsp_references()
    --   end
    -- end
  end,
  dependencies = {
    -- {
    --   "mason-org/mason-lspconfig.nvim",
    --   tag = "v2.1.0"
    -- },
    -- {
    --   "tamago324/nlsp-settings.nvim", -- add the nlsp setting plugin
    --   opts = {
    --     -- set the config table for the `setup()` call
    --     config_home = vim.fn.stdpath "config" .. "/nlsp-settings",
    --     local_settings_dir = ".nlsp-settings",
    --     local_settings_root_markers_fallback = { ".git" },
    --     append_default_schemas = true,
    --     loader = "json",
    --   },
    -- },
  }
}
