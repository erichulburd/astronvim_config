return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  tag = "1.29.0",
  opts = {
    suggestion = { enabled = true },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
      cpp = false,
      c = false,
      cuda = false,
      opencl = false,
    },
  },
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
    require("copilot").setup({ suggestion = { auto_trigger = true } })
  end,
}
