local lsp_zero = require "lsp-zero"

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  require("core.utils").load_mappings("lspconfig", { buffer = bufnr })
  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end
  lsp_zero.default_keymaps { buffer = bufnr }
  -- make sure you use clients with formatting capabilities
  -- otherwise you'll get a warning message
  if client.supports_method "textDocument/formatting" then
    require("lsp-format").on_attach(client)
  end
end)

require("mason").setup {
  ensure_installed = { "prettierd" }
}
require("mason-lspconfig").setup {
  ensure_installed = { "tsserver", "lua_ls", "clangd", "marksman" },
  handlers = {
    lsp_zero.default_setup,
    arduino_language_server = function()
      require("lspconfig").clangd.setup({})
    end
  },
}

lsp_zero.format_on_save {
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ["tsserver"] = { "javascript", "typescript" },
    ["rust_analyzer"] = { "rust" },
  },
}

require("flutter-tools").setup {
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "rounded",
  },
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = false,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = false,
      -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
      -- this will show the currently selected project configuration
      project_config = false,
    },
  },
  debugger = {          -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
    -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
    -- see |:help dap.set_exception_breakpoints()| for more info
    exception_breakpoints = {},
    register_configurations = function(_)
      require("dap").configurations.dart = {}
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
  widget_guides = {
    enabled = false,
  },
  closing_tags = {
    highlight = "ErrorMsg", -- highlight for the closing tag
    prefix = ">",           -- character to use for close tag e.g. > Widget
    enabled = false,        -- set to false to disable
  },
  dev_log = {
    enabled = true,
    notify_errors = false, -- if there is an error whilst running then notify the user
    open_cmd = "tabedit",  -- command to use to open the log buffer
  },
  dev_tools = {
    autostart = false,         -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
    auto_open = false,   -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    capabilities = lsp_zero.get_capabilities(),
  },
}
