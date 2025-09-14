---@diagnostic disable: missing-fields
return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.default",
    },
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    opts = {
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = LazyVim.config.icons.kinds,
      },

      completion = {
        trigger = {
          prefetch_on_insert = true,
          show_in_snippet = true,
          show_on_backspace = true,
          show_on_backspace_in_keyword = false,
          show_on_backspace_after_accept = true,
          show_on_backspace_after_insert_enter = true,
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_insert = false,
          show_on_accept_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = { "'", '"', "(" },
        },
        list = {
          max_items = 200,
          selection = {
            preselect = false,
            auto_insert = true,
          },
          cycle = { from_bottom = true, from_top = true },
        },
        menu = {
          auto_show = true,
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = { enabled = true },
        accept = {
          auto_brackets = {
            enabled = true,
            kind_resolution = { enabled = true },
            semantic_token_resolution = { enabled = true, timeout_ms = 400 },
          },
        },
      },

      signature = { enabled = true },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      cmdline = { enabled = false },

      keymap = {
        preset = "enter",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-c>"] = { "cancel", "hide", "fallback" },
      },
    },
  },
}
