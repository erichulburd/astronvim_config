---@diagnostic disable-next-line: different-requires

-- https://github.com/neovim/nvim-lspconfig/blob/67f151e84daddc86cc65f5d935e592f76b9f4496/doc/server_configurations.md#ccls

local nilfunc = function(...) return nil end

return {
  filetypes = { "c", "cpp", "cuda", "objc", "objcpp", "opencl" },
  offset_encoding = "utf-32",
  handlers = {
    ["textDocument/publishDiagnostics"] = nilfunc,
    ["textDocument/signatureHelp"] = nilfunc,
  },
}
