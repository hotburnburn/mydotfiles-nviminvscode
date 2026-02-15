-- basic: keymap and vscodemap
local keymap = vim.keymap.set
local vscode = require('vscode-neovim')

local function vscm(command)
    return function()
        vscode.action(command)
    end
end

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
    keymap('n', '<leader>e', vscm('workbench.view.explorer'))
    keymap('n', '<leader>g', vscm('workbench.view.scm'))
    keymap('n', '<leader>s', vscm('workbench.action.toggleStatusbarVisibility'))
    keymap('n', '<leader>m', vscm('editor.action.toggleMinimap'))
    keymap('n', '<leader>l', vscm('outline.focus'))
    keymap('n', '<leader>k', vscm('workbench.action.tasks.runTask'))
    keymap('n', '<leader>r', vscm('code-runner.run'))

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

    keymap('n', 'tp', vscm('workbench.action.previousEditor'))
    keymap('n', 'tn', vscm('workbench.action.nextEditor'))
    keymap('n', 'to', vscm('workbench.action.closeOtherEditors'))
    keymap('n', 'tw', vscm('workbench.action.closeAllEditors'))

    keymap('n', 'tt', vscm('testing.runAtCursor'))
    keymap('n', 'tf', vscm('testing.runAll'))

    keymap('n', '<leader>p', vscm('workbench.action.showCommands'))

    keymap({'i', 'v'}, '<C-s>', '<Esc>:w<CR>', {
        noremap = true,
        silent = true
    })
end

