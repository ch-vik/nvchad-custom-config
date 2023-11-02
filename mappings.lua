local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
    ["<leader>dt"] = {
      function()
        require("dapui").toggle()
      end,
      "Toggle debugging ui",
    },
  },
}
M.undotree = {
  plugin = true,
  n = {
    ["<leader>ut"] = {
      vim.cmd.UndotreeToggle,
      "Toggle UndoTree",
    },
  },
}
M.lspconfig = {
  plugin = true,
  n = {
    ["<leader>fd"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
}
M.cmp = {
  plugin = true,
  i = {
    ["<C-Space>"] = {
      function()
        require("plugins.configs.cmp").mapping.complete()
      end,
      "Open completition",
    },
  },
}
M.trouble = {
  plugin = true,
  n = {
    ["<leader>tt"] = {
      function()
        require("trouble").open()
      end,
      "Open Trouble",
    },
  },
}
M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function()
        require("crates").upgrade_all_crates()
      end,
      "update crates",
    },
  },
}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>gg"] = { "<cmd> LazyGit <CR>" },
  },
}

return M
