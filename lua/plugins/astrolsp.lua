-- For an example see https://github.com/AstroNvim/template/blob/b777fe96c301ac472642dadb9721a7e799700420/lua/plugins/astrolsp.lua

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  -- enable servers that you already have installed without mason
  opts = function(plugin, opts)
    -- safely extend the servers list
    opts.servers = opts.servers or {}
    vim.list_extend(opts.servers, {
      "mojo",
    })
  end,
}
