return {
  "dmtrKovalenko/fff.nvim",
  build = "nix run .#release",
  lazy = false,

  opts = {
    hl = {
      normal = "Normal",
      border = "FloatBorder",
      title = "Title",
    },

    debug = {
      enabled = false,
    },
    layout = {

      prompt_position = "top",
      flex = { size = 130, wrap = "bottom" },
    },
  },

  keys = {
    {
      "<leader>ff",
      function()
        require("fff").find_files()
      end,
      desc = "FFF files",
    },
    {
      "<leader>/",
      function()
        require("fff").live_grep()
      end,
      desc = "FFF grep",
    },
    {
      "<leader>fz",
      function()
        require("fff").live_grep({
          grep = { modes = { "fuzzy", "plain" } },
        })
      end,
      desc = "FFF fuzzy/plain grep",
    },
    {
      "<leader>fc",
      function()
        require("fff").live_grep({
          query = vim.fn.expand("<cword>"),
        })
      end,
      desc = "Search current word",
    },
  },
}
