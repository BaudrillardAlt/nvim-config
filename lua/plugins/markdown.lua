return {

  -- JSON + Schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- Markdown Rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      require("snacks")
        .toggle({
          name = "Render Markdown",
          get = function()
            return require("render-markdown.state").enabled
          end,
          set = function(enabled)
            local m = require("render-markdown")
            if enabled then
              m.enable()
            else
              m.disable()
            end
          end,
        })
        :map("<leader>um")
    end,
  },

  -- Notes
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~/notes") .. "/**.md",
      "BufNewFile " .. vim.fn.expand("~/notes") .. "/**.md",
    },

    ui = { enable = false },
    ft = "markdown",
    opts = {
      legacy_commands = false,
      workspaces = {
        { name = "notes", path = "~/notes" },
      },
      picker = { name = "fzf-lua" },
      completion = { blink = true, nvim_cmp = false, min_chars = 2, create_new = true },
      notes_subdir = "notes",
      new_notes_location = "notes_subdir",
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        alias_format = "%Y-%m-%d",
        template = "daily.md",
        workdays_only = false,
      },
      attachments = {
        img_folder = "assets/img",
        confirm_img_paste = true,
      },
      preferred_link_style = "wiki",
    },
    keys = {
      { "<leader>nn", "<cmd>Obsidian new_from_template Core<cr>", desc = "New Obsidian note" },
      { "<leader>no", "<cmd>Obsidian search<cr>", desc = "Search Obsidian notes" },
      { "<leader>ns", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
      { "<leader>nb", "<cmd>Obsidian backlinks<cr>", desc = "Show location list of backlinks" },
      { "<leader>nf", "<cmd>Obsidian follow_link<cr>", desc = "Follow link under cursor" },
      { "<leader>nt", "<cmd>Obsidian template Core<cr>", desc = "Apply Core Template" },
    },
  },
}
