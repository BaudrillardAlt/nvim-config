return {
  { "fei6409/log-highlight.nvim", event = "BufRead *.log", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "asm",
        "bash",
        "fish",
        "hyprlang",
        "cmake",
        "devicetree",
        "gitcommit",
        "gitignore",
        "just",
        "meson",
        "ninja",
        "nix",
      })
    end,
  },
}
