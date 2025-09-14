return {
  -- Rust
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = { crates = { enabled = true } },
      lsp = { enabled = true, actions = true, completion = true, hover = true },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "*",
    lazy = false,
  },

  -- C/C++
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = true,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },

  -- Haskell
  -- {
  --   "mrcjkb/haskell-tools.nvim",
  --   version = "^6",
  --   lazy = false,
  --   init = function()
  --     vim.g.haskell_tools = {
  --       hls = {
  --         default_settings = {
  --           haskell = {
  --             formattingProvider = "ormolu",
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   "mrcjkb/haskell-snippets.nvim",
  --   dependencies = { "L3MON4D3/LuaSnip" },
  --   ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  --   config = function()
  --     local haskell_snippets = require("haskell-snippets").all
  --     require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
  --   end,
  -- },

  -- CMP enhancements
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      -- C/C++ clangd scores
      opts.sorting = opts.sorting or {}
      opts.sorting.comparators = opts.sorting.comparators or {}
      table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))

      -- Python auto brackets
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
  },
}
