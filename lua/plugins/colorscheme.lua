return {

  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    dim_inactive = true,
    opts = {
      style = "auto",
      dim_inactive = true,
      variants = {
        modus_operandi = "default", -- Set variant for `modus_operandi` style
        modus_vivendi = "tinted", -- Set variant for `modus_vivendi` style
      },
      on_highlights = function(hl, c)
        hl["@character.printf"] = { fg = c.cyan_warmer }
        hl["@lsp.typemod.function.defaultlibrary"] = { fg = c.indigo }
        hl["@lsp.type.parameter.c"] = { fg = c.fg_alt }
        hl["@keyword.directive.c"] = { fg = "#ffbd5e" }
        hl["@keyword.directive.define.c"] = { fg = "#ffbd5e" }
        hl["@keyword.import.c"] = { fg = "#ffbd5e" }
        hl.Comment = { fg = "#808080", italic = true }
        hl["@comment"] = { link = "Comment" }
        hl.YankyPut = { link = "Search" }
        hl.YankyYanked = { bg = c.yellow_intense, fg = c.bg_main }
      end,
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = false,
      transparent = false,
    },
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon",
      dimInactive = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {

      colorscheme = "modus",
    },
  },
}
