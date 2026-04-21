local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    base00 = "#131315",
    base01 = "#1f1f21",
    base02 = "#292a2c",
    base03 = "#8e9098",
    base04 = "#c4c6ce",
    base05 = "#e4e2e4",
    base06 = "#e4e2e4",
    base07 = "#e4e2e4",
    base08 = "#ffb4ab",
    base09 = "#debcdc",
    base0A = "#c1c6d4",
    base0B = "#b6c7e7",
    base0C = "#debcdc",
    base0D = "#b6c7e7",
    base0E = "#c1c6d4",
    base0F = "#93000a",
  })
end

local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    package.loaded["matugen"] = nil
    require("matugen").setup()
  end)
)

return M
