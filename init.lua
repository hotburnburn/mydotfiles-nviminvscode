-- 1. load config
require("config.options")
require("config.keymaps")

-- 2. 启动 Lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
                   lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- 这里告诉 lazy 去 lua/plugins/ 目录下自动寻找插件配置
require("lazy").setup("plugins")
