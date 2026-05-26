return {
  "dmtrKovalenko/fff.nvim",
  build = "nix run .#release",
  lazy = false,

  opts = {
    hl = {
      normal = "Normal",
    },
  },

  keys = {
    {
      "<leader>ff",
      function()
        require("fff").find_files({
          cwd = LazyVim.root(),
        })
      end,
      desc = "FFF files",
    },
    {
      "<leader>/",
      function()
        require("fff").live_grep({
          cwd = LazyVim.root(),
        })
      end,
      desc = "FFF grep",
    },
    {
      "<leader>fz",
      function()
        require("fff").live_grep({
          cwd = LazyVim.root(),
          grep = { modes = { "fuzzy", "plain" } },
        })
      end,
      desc = "FFF fuzzy/plain grep",
    },
    {
      "<leader>fc",
      function()
        require("fff").live_grep({
          cwd = LazyVim.root(),
          query = vim.fn.expand("<cword>"),
        })
      end,
      desc = "Search current word",
    },
  },
}
