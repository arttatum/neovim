local fileexplorer = require("nvim-tree")

vim.keymap.set("n", "<leader>s", function()
    fileexplorer.open()
end)

local view = require("nvim-tree.view")

vim.keymap.set("n", "<leader>w", function()
    view.close()
end)
