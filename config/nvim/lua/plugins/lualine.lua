return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.theme = "auto"
    opts.options.globalstatus = true
    opts.options.section_separators = { "", "" }
    opts.options.component_separators = { "", "" }
  end,
}
