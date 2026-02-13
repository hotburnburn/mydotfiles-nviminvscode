vim.g.mapleader = " " -- 设置 Leader 键为空格
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

if vim.g.vscode then
    vim.opt.cmdheight = 5
    vim.opt.shortmess:append("satIc")
end
