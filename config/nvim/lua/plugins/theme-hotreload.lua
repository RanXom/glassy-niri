return {
  name = "matugen-reload",
  dir = vim.fn.stdpath("config"),
  lazy = false,
  priority = 2000,

  config = function()
    local signal = vim.uv.new_signal()

    signal:start(
      "sigusr1",
      vim.schedule_wrap(function()
        -- clear highlights
        vim.cmd("highlight clear")
        vim.cmd("syntax reset")

        -- reload generated theme module
        package.loaded["matugen"] = nil
        require("matugen").setup()

        -- trigger colorscheme autocommands
        vim.api.nvim_exec_autocmds("ColorScheme", {})

        -- redraw UI
        vim.cmd("redraw!")
      end)
    )
  end,
}
