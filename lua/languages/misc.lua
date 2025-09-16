return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Fish shell
      opts.servers.fish_lsp = {}

      -- TOML
      opts.servers.taplo = {}

      -- JSON with schema support
      opts.servers.jsonls = {
        -- lazy-load schemastore when needed
        before_init = function(_, new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          },
        },
      }

      -- Markdown
      opts.servers.marksman = {}
    end,
  },

  {
    "terror/just-lsp",
    ft = { "just" },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      lspconfig.just.setup({
        cmd = { "just-lsp" },
        filetypes = { "just" },
        root_dir = util.root_pattern(".git", ".jj"),
      })
    end,
  },
}

