return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = function()
      local ret = {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          -- virtual_text = {
          --   spacing = 4,
          --   source = "if_many",
          --   prefix = "●",
          -- },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
        inlay_hints = {
          enabled = true,
          exclude = { "vue" },
        },
        codelens = {
          enabled = false,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        servers = {
          harper_ls = {
            filetypes = { "markdown", "text" },
            settings = {
              ["harper-ls"] = {},
            },
          },
          lua_ls = {
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                codeLens = { enable = true },
                completion = { callSnippet = "Replace" },
                doc = { privateName = { "^_" } },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
          fish_lsp = {},

          taplo = {},
          jsonls = {
            -- lazy-load schemastore when needed
            on_new_config = function(new_config)
              new_config.settings.json.schemas = new_config.settings.json.schemas or {}
              vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
              json = {
                format = { enable = true },
                validate = { enable = true },
              },
            },
          },
          marksman = {}, -- Markdown LSP
          -- C/C++ (clangd)
          clangd = {
            mason = false,
            keys = {
              { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            },
            root_dir = function(fname)
              local markers = {
                "pico_sdk_import.cmake",
                "Makefile",
                "configure.ac",
                "configure.in",
                "config.h.in",
                "meson.build",
                "meson_options.txt",
                "build.ninja",
                "compile_commands.json",
                "compile_flags.txt",
              }
              local found = vim.fs.find(markers, { path = fname, upward = true })[1]
              return found and vim.fs.dirname(found)
            end,
            capabilities = {
              offsetEncoding = { "utf-16" },
            },
            cmd = (function()
              local is_cross_compiling = vim.fn.glob("**/pico_sdk_import.cmake") ~= ""
              local base_cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
              }
              if is_cross_compiling then
                table.insert(base_cmd, "--query-driver=/usr/bin/arm-none-eabi-*")
              end
              return base_cmd
            end)(),
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
          },
          -- Python
          basedpyright = {
            enabled = true,
            cmd = { "uv", "run", "basedpyright-langserver", "--stdio" },
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "recommended",
                  diagnosticMode = "workspace",
                  autoImportCompletions = true,
                  autoSearchPaths = true,
                },
              },
            },
          },
          ruff = {
            enabled = true,
            cmd = { "uv", "run", "ruff", "server" },
            init_options = { settings = { logLevel = "error" } },
            keys = {
              { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
            },
          },
          -- Assembly
          asm_lsp = {
            cmd = { "asm-lsp" },
            filetypes = { "asm", "s", "S" },
          },
          -- Disable conflicting servers
          pyright = { enabled = false },
          ruff_lsp = { enabled = false },
        },
        setup = {
          clangd = function(_, server_opts)
            local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
            require("clangd_extensions").setup(
              vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = server_opts })
            )
            return false
          end,
          ruff = function()
            LazyVim.lsp.on_attach(function(client)
              client.server_capabilities.hoverProvider = false
            end, "ruff")
          end,
          hls = function()
            return true
          end,
        },
      }
      return ret
    end,
    config = function(_, opts)
      LazyVim.format.register(LazyVim.lsp.formatter())
      LazyVim.lsp.on_attach(function(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)
      LazyVim.lsp.setup()
      LazyVim.lsp.on_dynamic_capability(require("plugins.lsp.keymaps").on_attach)
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts =
          vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities) }, opts.servers[server] or {})
        if server_opts.enabled == false then
          return
        end
        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      for server, server_opts in pairs(opts.servers) do
        if server_opts ~= false then
          setup(server)
        end
      end

      if opts.inlay_hints.enabled then
        LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(_, buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      if opts.codelens.enabled and vim.lsp.codelens then
        LazyVim.lsp.on_supports_method("textDocument/codeLens", function(_, buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end
    end,
  },

  {
    "terror/just-lsp",
    ft = { "just" },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      lspconfig.just.setup({
        cmd = { "just-lsp" },
        filetypes = { "just" },
        root_dir = util.root_pattern(".git", ".jj"),
      })
    end,
  },
}
