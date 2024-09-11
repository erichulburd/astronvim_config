-- For an example see https://github.com/AstroNvim/template/blob/b777fe96c301ac472642dadb9721a7e799700420/lua/plugins/astrolsp.lua

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  -- enable servers that you already have installed without mason
  ---@type AstroLSPOpts
  opts = function(plugin, opts)
    -- safely extend the servers list
    opts.servers = opts.servers or {}

    vim.filetype.add({
      extension = {
        mojo = 'mojo'

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
    opts.config.clangd = { capabilities = clangd_capabilities, cmd = { os.getenv("HOME") .. "/.build/" .. os.getenv("LLVM_TAG") .. "/bin/clangd" } }
  
    -- See https://github.com/hrsh7th/cmp-nvim-lsp/issues/44#issuecomment-2096368152
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local rust_analyzer_capabilities = cmp_nvim_lsp.default_capabilities()
    rust_analyzer_capabilities.workspace = { didChangeWatchedFiles = { dynamicRegistration = true } }
    opts.config.rust_analyzer = { capabilities = rust_analyzer_capabilities }
  end,
}
