return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sql = { "sleek" },    -- keep this if you want Sleek for SQL
        kotlin = { "ktfmt" }, -- Add ktfmt for Kotlin files
      },
      formatters = {
        sleek = {
          command = "sleek",
          args = {
            "--indent-spaces", "2",
            "--uppercase", "false",
            "--lines-between-queries", "1",
          },
          stdin = true,
        },
        ktfmt = { -- Define the ktfmt formatter
          command = "ktfmt",
          -- ktfmt typically reads from stdin and writes to stdout,
          -- which are conform.nvim's defaults.
          -- You may need to adjust the command or args if you're using a
          -- wrapper script or a specific ktfmt flavor (like ktfmt-google-style).
        },
      },
    },
  },
}
