return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash" },
        },
        fish_lsp = {},
        nushell = {
          cmd = { "nu", "--lsp" },
          filetypes = { "nu" },
        },
        just_lsp = {
          cmd = { "just-lsp" },
          filetypes = { "just" },
        },
      },
    },
  },
}
