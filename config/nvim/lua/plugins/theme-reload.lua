return {
  name = "theme-reload",
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

        -- unload matugen module
        package.loaded["matugen"] = nil

        -- reload theme
        require("matugen").setup()

        -- redraw UI
        vim.cmd("redraw!")
      end)
    )
  end,
}
