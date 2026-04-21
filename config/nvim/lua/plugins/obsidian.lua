return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "vault",
        path = "~/Documents/Obsidian/Lessons/", -- change this
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    opts = {},
  },

  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && npm install",
  --   keys = {},
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- },
}
