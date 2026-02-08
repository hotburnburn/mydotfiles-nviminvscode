return {{
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        highlight = {
            -- 禁用 backdrop，因为它在 VSCode 中渲染效果很差，会遮挡标签
            backdrop = true
        },
        -- 可选：针对 VSCode 的一些特定优化模式
        modes = {
            char = {
                enabled = false -- 如果你觉得 f/t/F/T 键也被 flash 接管导致不习惯，可以在这里关掉
            },
            treesitter = {
                enabled = false
            }
        }
    },
    keys = {{
        "f",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump()
        end,
        desc = "Flash"
    }}
}}
