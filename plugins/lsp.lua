return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "tamago324/nlsp-settings.nvim", -- add the nlsp setting plugin
      opts = {
                                      -- set the config table for the `setup()` call
        config_home = vim.fn.stdpath "config" .. "/nlsp-settings",
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers_fallback = { ".git" },
        append_default_schemas = true,
        loader = "json",
      },
    },
  }
}
