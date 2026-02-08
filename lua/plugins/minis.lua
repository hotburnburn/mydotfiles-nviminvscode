return {{
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
        local ai = require("mini.ai")

        return {
            n_lines = 500 -- 搜索范围

            -- 这里的 custom_textobjects 可以定义更复杂的规则，
        }
    end
}, {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
        silent = true
    } -- 核心：空表即开启默认配置 (sa, sd, sr)，无需额外映射
}, {
    "echasnovski/mini.indentscope",
    version = false, -- 建议用最新版
    event = "VeryLazy",
    opts = {
        -- 这里的 mappings 就是你要找的
        mappings = {
            object_scope = 'ii', -- 选中缩进层级内部 (比如 if 内部)
            object_scope_with_border = 'ai', -- 选中缩进层级及上方一行 (比如 if 行 + 内部)

            -- 其他跳转功能
            goto_top = '[i',
            goto_bottom = ']i'
        },
        draw = {
            delay = 0,
            predicate = function()
                return false
            end
        }
    }
}}
