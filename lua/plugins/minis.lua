return {{
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
        silent = true
    } -- 核心：空表即开启默认配置 (sa, sd, sr)，无需额外映射
}, {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
        local ai = require("mini.ai")

        return {
            n_lines = 500, -- 搜索范围

            -- 这里的 custom_textobjects 可以定义更复杂的规则，
            custome_textobjects = {
                -- 核心：覆盖默认的 f，将其绑定到完整的函数定义 (基于 Treesitter)
                f = ai.gen_spec.treesitter({
                    a = "@function.outer", -- 包含函数声明（如 def 或 fn）及整个函数体
                    i = "@function.inner" -- 仅函数内部的代码块
                }),

                -- 💡 既然改了，强烈建议顺手把 c 绑定到类 (Class) 上，写 Python 时极其好用
                c = ai.gen_spec.treesitter({
                    a = "@class.outer",
                    i = "@class.inner"
                }),

                -- F: 函数调用 (Function Call)，例如 requests.get(url)
                F = ai.gen_spec.treesitter({
                    a = "@call.outer",
                    i = "@call.inner"
                }, {})
            }
        }
    end
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
