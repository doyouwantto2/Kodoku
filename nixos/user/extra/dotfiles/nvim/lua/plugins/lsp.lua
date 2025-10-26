local lsp_util = require("lspconfig.util")

local function find_root_pattern(patterns)
  return function(fname)
    return lsp_util.root_pattern(unpack(patterns))(fname)
  end
end

local function ts_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end

local common_root_dir = find_root_pattern { ".git", "package.json" }

return {
  {
    "dgagn/diagflow.nvim",
    event = 'LspAttach',
    opts = {},
  },

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      opts.sorting = opts.sorting or {}
      opts.sorting.comparators = opts.sorting.comparators or {}
      table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
    end,
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mason-org/mason.nvim",
      optional = true,
      opts = { ensure_installed = { "codelldb" } },
    },
    opts = function()
      local dap = require("dap")
      local adapter_name = "codelldb"

      if not dap.adapters[adapter_name] then
        dap.adapters[adapter_name] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
          },
        }
      end

      local cc_config = {
        {
          type = adapter_name,
          request = "launch",
          name = "Launch file",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = adapter_name,
          request = "attach",
          name = "Attach to process",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.c = cc_config
      dap.configurations.cpp = cc_config
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },

  { "mason-org/mason.nvim",                      enabled = false },
  { "mason-org/mason-lspconfig.nvim",            enabled = false },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = false },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        htmlhint_ls = {
          cmd = { "htmlhint-ls", "--stdio" },
          filetypes = { "html" },
          root_dir = common_root_dir,
          settings = {},
        },
        csslint_ls = {
          cmd = { "csslint", "--stdio" },
          filetypes = { "css" },
          root_dir = common_root_dir,
          settings = {},
        },

        nixd = {
          cmd = { "nixd" },
          settings = {
            nixd = {
              formatting = { command = { "nixpkgs-fmt" } },
            },
          },
        },

        tsserver = {
          cmd = { "typescript-language-server", "--stdio" },
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
          root_dir = find_root_pattern {
            "tsconfig.json",
            "package.json",
            "jsconfig.json",
            ".git",
          },
          init_options = {
            hostInfo = "neovim",
          },
          on_attach = ts_on_attach,
        },

        html = {
          cmd = { "vscode-html-language-server", "--stdio" },
        },
        cssls = {
          cmd = { "vscode-css-language-server", "--stdio" },
        },
        jsonls = {
          cmd = { "vscode-json-language-server", "--stdio" },
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
              },
            },
          },
        },

        ccls = {
          cmd = { "ccls" },
          init_options = {
            cache = {
              directory = ".ccls-cache",
            },
            compilationDatabaseDirectory = "build",
          },
        },

        astro = {
          cmd = { "astro-ls", "--stdio" },
          filetypes = { "astro" },
          root_dir = find_root_pattern {
            "astro.config.mjs",
            "astro.config.ts",
            "package.json",
            "tsconfig.json",
            ".git",
          },
        },

        tailwindcss = {
          filetypes = {
            "templ",
            "vue",
            "html",
            "astro",
            "javascript",
            "typescript",
            "react",
            "htmlangular",
          },
        },
      },
    },
  },
}
