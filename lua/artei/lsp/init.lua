local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require "artei.lsp.lsp-installer"
require("artei.lsp.handlers").setup()
