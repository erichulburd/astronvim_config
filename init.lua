---@diagnostic disable-next-line: different-requires
local nilfunc = function(...) return nil end


return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- config = {
    --   ccls = {
    --     filetypes = { "c", "cpp", "cuda", "objc", "objcpp", "opencl" },
    --     -- offset_encoding = "utf-8",
    --     handlers = {
    --       ["textDocument/publishDiagnostics"] = nilfunc,
    --       ["textDocument/signatureHelp"] = nilfunc,
    --     },
    --     --         -- offset_encoding = "utf-8",
    --     -- cmd = { "ccls" },
    --     -- filetypes = { "c", "cpp", "objc", "objcpp" },
    --     -- root_dir = root_pattern("compile_commands.json", ".ccls", ".git"),
    --   }
    -- },
    -- -- customize lsp formatting options
    -- formatting = {
    --
    -- },
    -- enable servers that you already have installed without mason
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    -- Set up Copilot keybindings
    -- reference: https://github.com/AstroNvim/AstroNvim/issues/1129#issuecomment-1283706965
    local copilot_options = { silent = true, expr = true, script = true }
    vim.api.nvim_set_keymap("i", "<C-cr>", "copilot#Accept(<Tab>)", copilot_options)
  end,
}
