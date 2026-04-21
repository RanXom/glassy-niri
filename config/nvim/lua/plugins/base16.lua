return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 2000,
  config = function()
    require("matugen").setup()
  end,
}
