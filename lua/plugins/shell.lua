return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash" },
        },
        fish_lsp = {},
        just_lsp = {
          cmd = { "just-lsp" },
          filetypes = { "just" },
        },
      },
    },
  },
}
