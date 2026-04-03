-- basic: keymap and vscodemap
local keymap = vim.keymap.set

-- native
keymap('n', '<leader>c', '"_c', {
    remap = true,
    desc = "let c discard the content to hole register"
})

keymap('n', '<CR><CR>', ':noh<CR>', {
    silent = true,
    desc = "enter*2 -> silent noh"
})

-- in vscode
if vim.g.vscode then
    local vscode = require('vscode-neovim')

    local function vscm(command)
        return function()
            vscode.action(command)
        end
    end

    keymap("n", "j", function()
        return vim.v.count == 0 and "gj" or "j"
    end, {
        expr = true,
        remap = true
    })

    keymap("n", "k", function()
        return vim.v.count == 0 and "gk" or "k"
    end, {
        expr = true,
        remap = true
    })

    -- = 扩大选中范围 (向外扩展：单词 -> 语句 -> 块 -> 函数 -> 类)
    keymap({'n', 'v'}, '-', vscm('editor.action.smartSelect.expand'), {
        desc = "VSCode: 扩大选中范围"
    })

    -- - 缩小选中范围
    keymap({'n', 'v'}, '_', vscm('editor.action.smartSelect.shrink'), {
        desc = "VSCode: 缩小选中范围"
    })

    keymap('n', '<leader>e', vscm('workbench.view.explorer'))
    keymap('n', '<leader>g', vscm('workbench.view.scm'))
    keymap('n', 'ts', vscm('workbench.action.toggleStatusbarVisibility'))
    keymap('n', 'tm', vscm('editor.action.toggleMinimap'))
    keymap('n', 'tb', vscm('breadcrumbs.toggle'))
    keymap('n', '<leader>l', vscm('outline.focus'))
    keymap('n', '<leader>k', vscm('workbench.action.tasks.runTask'))
    keymap('n', '<leader>r', function()
        vscm('code-runner.run')()
        vim.defer_fn(function()
            vscm('workbench.action.terminal.focus')()
        end, 100) -- 延迟 100ms
    end)

    keymap('n', '<leader>ce', vscm('errorLens.copyProblemMessage'))
    keymap('n', '<leader>cl', vscm('notifications.clearAll'))
    keymap('n', '<leader>ch', vscm('workbench.action.showOutputChannels'))

    keymap('n', '<leader> ', vscm('workbench.action.quickOpen'))
    keymap('n', '<leader>o', vscm('workbench.action.openRecent'))

    keymap('n', '<leader>[', vscm('editor.fold'))
    keymap('n', '<leader>]', vscm('editor.unfold'))

    keymap('n', ']d', vscm('editor.action.marker.next'))
    keymap('n', '[d', vscm('editor.action.marker.prev'))

    keymap('n', 'gd', vscm('editor.action.revealDefinition'))
    keymap('n', 'gb', vscm('workbench.action.navigateBack'))

    keymap('n', 'gs', vscm('workbench.action.gotoSymbol'))
    keymap('n', 'gS', vscm('workbench.action.showAllSymbols'))

    keymap('n', 'J', vscm('workbench.action.previousEditor'))
    keymap('n', 'L', vscm('workbench.action.nextEditor'))
    keymap('n', 'to', vscm('workbench.action.closeOtherEditors'))
    keymap('n', 'tw', vscm('workbench.action.closeAllEditors'))

    keymap('n', 'tt', vscm('testing.runAtCursor'))
    keymap('n', 'tf', vscm('testing.runAll'))

    keymap('n', '<leader>p', vscm('workbench.action.showCommands'))

    keymap('n', 'zh', vscm('workbench.action.navigateLeft'))
    keymap('n', 'zl', vscm('workbench.action.navigateRight'))
    keymap('n', 'zj', vscm('workbench.action.navigateDown'))
    keymap('n', 'zk', vscm('workbench.action.navigateUp'))
    keymap('n', 'zp', 'zt', {
        remap = true
    })

    keymap({'i', 'v'}, '<C-s>', '<Esc>:w<CR>', {
        noremap = true,
        silent = true
    })
end

-- 全局单字符跳转（类似 f/F 但跨行）
local function go_to_char(forward)
    return function()
        local char = vim.fn.getcharstr()
        if char == '\27' or char == '' then
            return
        end -- ESC 取消

        -- 转义特殊字符 / \ . * $ ^ ~ [ 等
        local escaped = vim.fn.escape(char, '/\\.*$^~[]')

        -- 搜索：W = 不循环 wrap, z = 开始位置不计算在内（避免原地不动）
        local flag = forward and 'Wz' or 'bWz'
        vim.fn.search(escaped, flag)
    end
end

keymap({'n', 'x', 'o'}, 'gn', go_to_char(true), {
    desc = 'Go to next char (global)'
})
keymap({'n', 'x', 'o'}, 'gp', go_to_char(false), {
    desc = 'Go to prev char (global)'
})
