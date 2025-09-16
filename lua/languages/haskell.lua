-- Haskell configuration (currently commented out)
-- Uncomment and modify as needed

return {
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

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function(_, opts)
  --     opts.setup = opts.setup or {}
  --     opts.setup.hls = function()
  --       return true
  --     end
  --   end,
  -- },
}