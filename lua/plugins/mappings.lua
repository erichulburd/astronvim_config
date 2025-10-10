-- See https://docs.astronvim.com/recipes/mappings/#add-custom-mappings
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          gd = {
            function()
              vim.lsp.buf.type_definition()
            end,
            desc = "Go to type definition",
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- gy = {
          --   function()
          --     vim.lsp.buf.type_definition()
          --   end,
          --   desc = "Go to type definition",
          -- },
        }
      },
    },
  },
}
