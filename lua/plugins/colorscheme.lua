return {

  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    dim_inactive = true,
    opts = {
      style = "auto",
      dim_inactive = true,
      variant = "default",
      on_highlights = function(hl, c)
        hl["@character.printf"] = { fg = c.cyan_warmer }
        hl["@lsp.typemod.function.defaultlibrary"] = { fg = c.indigo }
        hl["@lsp.type.parameter.c"] = { fg = c.fg_alt }
        hl["@keyword.directive.c"] = { fg = "#ffbd5e" }
        hl["@keyword.directive.define.c"] = { fg = "#ffbd5e" }
        hl["@keyword.import.c"] = { fg = "#ffbd5e" }
        hl.YankyPut = { link = "Search" }
        hl.YankyYanked = { bg = c.yellow_intense, fg = c.bg_main }
      end,
    },
    config = function(_, opts)
      require("modus-themes").setup(opts)
      vim.cmd.colorscheme("modus")
    end,
  },
}
