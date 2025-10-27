lsp_util = require("lspconfig.util")

function find_root_pattern(patterns)
  return function(fname)
    -- lspconfig.util.root_pattern expects patterns to be spread (unpack)
    return lsp_util.root_pattern(unpack(patterns))(fname)
  end
end

-- Function to attach Lsp server features and keymaps for TypeScript/JavaScript
function ts_on_attach(client, bufnr)
  -- Disable server-side formatting if you prefer an external formatter (like null-ls)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end

-- This line now correctly calls the globally visible function:
local common_root_dir = find_root_pattern { ".git", "package.json" }

return {
  --------------------------------------------------------------------------------
  -- CORE UTILITIES & UI
  --------------------------------------------------------------------------------

  -- Required dependency for nvim-java and many other modern plugins
  { "MunifTanjim/nui.nvim" },

  -- NEW: Required dependency for nvim-dap-ui (solves the nvim-nio error)
  { "nvim-neotest/nvim-nio" },

  -- Auto-completion engine (Required)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "neovim/nvim-lspconfig",    -- LSP source
      "hrsh7th/cmp-nvim-lsp",     -- LSP source
      "L3MON4D3/LuaSnip",         -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet source
    },
    opts = function(_, opts)
      -- Integrates clangd scores for better C/C++ completion ranking (as per user's config)
      opts.sorting = opts.sorting or {}
      opts.sorting.comparators = opts.sorting.comparators or {}
      table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
    end,
  },

  --------------------------------------------------------------------------------
  -- DEBUGGING (DAP) SETUP
  --------------------------------------------------------------------------------

  -- DAP Client (Required for debugging Java, C/C++, etc.)
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" }, -- Ensure UI is available before configuring listeners
    config = function()
      local dap = require("dap")
      -- NOTE: Removed local dapui = require("dapui") to break the dependency loop.

      -- === C/C++ Configuration (Codelldb) ===
      local adapter_name = "codelldb"

      -- Ensure the adapter is defined if not already present
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
        -- Launch configuration
        {
          type = adapter_name,
          request = "launch",
          name = "Launch file",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
        -- Attach configuration
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

      -- DAP UI Keymaps (Optional but useful)
      vim.keymap.set({ 'n', 'v' }, '<Leader>B', function() require('dap').toggle_breakpoint() end,
        { desc = "Toggle Breakpoint" })
      vim.keymap.set('n', '<Leader>C', function() require('dap').continue() end, { desc = "DAP Continue" })
      vim.keymap.set('n', '<Leader>S', function() require('dap').step_over() end, { desc = "DAP Step Over" })
      vim.keymap.set('n', '<Leader>s', function() require('dap').step_into() end, { desc = "DAP Step Into" })
    end,
  },

  -- DAP UI (Visual interface for the debugger)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- FIX: Configuration is handled here, including listeners, guaranteeing order.
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        controls = { enabled = true },
      })

      -- === DAP UI Integration Listeners (Moved here) ===
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  --------------------------------------------------------------------------------
  -- JAVA DEVELOPMENT (The core request)
  --------------------------------------------------------------------------------

  {
    "nvim-java/nvim-java",
    -- Only load the plugin when opening a Java file
    ft = { "java" },
    dependencies = {
      -- Explicitly list core dependencies for clarity
      "MunifTanjim/nui.nvim",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    opts = {
      -- Set the command to the executable you installed
      jdtls = {
        cmd = { "jdt-language-server" },
      },

      -- Your requested completion settings
      settings = {
        java = {
          completion = {
            favoriteStaticMembers = {
              "org.junit.jupiter.api.Assertions.*",
              "org.mockito.Mockito.*",
            },
          },
        },
      },
    },
  },

  --------------------------------------------------------------------------------
  -- LSP CONFIGURATIONS (LSP clients for other languages)
  --------------------------------------------------------------------------------

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- JDTLS is automatically configured by nvim-java, so we don't define it here.

        -- HTML/CSS/JSON Language Servers
        html = { cmd = { "vscode-html-language-server", "--stdio" } },
        cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
        jsonls = { cmd = { "vscode-json-language-server", "--stdio" } },

        -- TypeScript Server
        tsserver = {
          cmd = { "typescript-language-server", "--stdio" },
          filetypes = {
            "javascript", "javascriptreact", "typescript", "typescriptreact",
          },
          -- Calls the now globally visible function
          root_dir = find_root_pattern {
            "tsconfig.json", "package.json", "jsconfig.json", ".git",
          },
          init_options = { hostInfo = "neovim" },
          -- Uses the now globally visible function
          on_attach = ts_on_attach,
        },

        -- Python Pyright
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

        -- C/C++ Ccls
        ccls = {
          cmd = { "ccls" },
          init_options = {
            cache = { directory = ".ccls-cache" },
            compilationDatabaseDirectory = "build",
          },
        },

        -- Astro (As per your request)
        astro = {
          cmd = { "astro-ls", "--stdio" },
          filetypes = { "astro" },
          -- Calls the now globally visible function
          root_dir = find_root_pattern {
            "astro.config.mjs", "astro.config.ts", "package.json", "tsconfig.json", ".git",
          },
        },

        -- Tailwind CSS
        tailwindcss = {
          filetypes = {
            "templ", "vue", "html", "astro", "javascript", "typescript", "react", "htmlangular",
          },
        },

        -- Linter Servers (These usually belong in a dedicated formatter/linter setup like null-ls,
        -- but keeping them here as per your original request.)
        htmlhint_ls = {
          cmd = { "htmlhint-ls", "--stdio" }, filetypes = { "html" }, root_dir = common_root_dir, settings = {},
        },
        csslint_ls = {
          cmd = { "csslint", "--stdio" }, filetypes = { "css" }, root_dir = common_root_dir, settings = {},
        },
        nixd = {
          cmd = { "nixd" },
          settings = {
            nixd = { formatting = { command = { "nixpkgs-fmt" } } },
          },
        },
      },
    },
  },

  --------------------------------------------------------------------------------
  -- MISCELLANEOUS PLUGINS
  --------------------------------------------------------------------------------

  {
    "dgagn/diagflow.nvim",
    event = 'LspAttach',
    opts = {},
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false, -- Load immediately for Rust files
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },

  -- Plugins explicitly disabled by the user
  { "mason-org/mason.nvim",                      enabled = false },
  { "mason-org/mason-lspconfig.nvim",            enabled = false },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = false },
}
