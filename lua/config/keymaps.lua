-- basic: keymap and vscodemap
local keymap = vim.keymap.set

-- hole register c
keymap("n", "<leader>c", '"_c', {
	remap = true,
	desc = "let c discard the content to hole register",
})

keymap("n", "<CR><CR>", ":noh<CR>", {
	silent = true,
	desc = "enter*2 -> silent noh",
})

-- in vscode
if vim.g.vscode then
	local vscode = require("vscode-neovim")
	local function vscm(command)
		return function()
			vscode.action(command)
		end
	end

	keymap("n", "<Tab>", "<Nop>", {
		noremap = true,
		silent = true,
	})
	-- c: clear, o: output, n: statusbar, m:minimap, g:git, l:outline, b:breadcrumbs
	keymap("n", "<Tab>c", vscm("notifications.clearAll"))
	keymap("n", "<Tab>o", vscm("workbench.action.showOutputChannels"))
	keymap("n", "<Tab>n", vscm("workbench.action.toggleStatusbarVisibility"))
	keymap("n", "<Tab>m", vscm("editor.action.toggleMinimap"))
	keymap("n", "<Tab>b", vscm("breadcrumbs.toggle"))
	keymap("n", "<Tab>g", vscm("workbench.view.scm"))
	keymap("n", "<Tab>l", vscm("outline.focus"))

	keymap("n", "<CR>o", vscm("workbench.action.closeOtherEditors"))
	keymap("n", "<CR>t", vscm("testing.runAtCursor"))
	keymap("n", "<CR>f", vscm("testing.runAll"))
	keymap("n", "<CR>c", vscm("errorLens.copyProblemMessage"))

	keymap("n", "<leader>e", vscm("workbench.view.explorer"))
	keymap("n", "<leader>k", vscm("workbench.action.tasks.runTask"))
	keymap("n", "<leader>r", function()
		vscm("code-runner.run")()
		vim.defer_fn(function()
			vscm("workbench.action.terminal.focus")()
		end, 100) -- 延迟 100ms
	end)

	keymap("n", "<leader>[", vscm("editor.fold"))
	keymap("n", "<leader>]", vscm("editor.unfold"))

	keymap("n", "<leader> ", vscm("workbench.action.quickOpen"))
	keymap("n", "<leader>p", vscm("workbench.action.showCommands"))
	keymap("n", "<leader>o", vscm("workbench.action.openRecent"))

	keymap("n", "]d", vscm("editor.action.marker.next"))
	keymap("n", "[d", vscm("editor.action.marker.prev"))
	keymap("n", "gd", vscm("editor.action.revealDefinition"))
	keymap("n", "gb", vscm("workbench.action.navigateBack"))
	keymap("n", "gf", vscm("workbench.action.navigateForward"))
	keymap("n", "gs", vscm("workbench.action.gotoSymbol"))
	keymap("n", "gS", vscm("workbench.action.showAllSymbols"))

	keymap("n", "J", vscm("workbench.action.previousEditor"))
	keymap("n", "K", vscm("workbench.action.nextEditor"))
	keymap("n", "L", vscm("editor.action.showHover"))

	keymap("n", "zh", vscm("workbench.action.navigateLeft"))
	keymap("n", "zl", vscm("workbench.action.navigateRight"))
	keymap("n", "zj", vscm("workbench.action.navigateDown"))
	keymap("n", "zk", vscm("workbench.action.navigateUp"))
	keymap("n", "zp", "zt", {
		remap = true,
	})

	-- = 扩大选中范围 (向外扩展：单词 -> 语句 -> 块 -> 函数 -> 类)
	keymap({ "n", "v" }, "-", vscm("editor.action.smartSelect.expand"), {
		desc = "VSCode: 扩大选中范围",
	})
	-- - 缩小选中范围
	keymap({ "n", "v" }, "_", vscm("editor.action.smartSelect.shrink"), {
		desc = "VSCode: 缩小选中范围",
	})

	-- 视觉行 jk
	keymap("n", "j", function()
		return vim.v.count == 0 and "gj" or "j"
	end, {
		expr = true,
		remap = true,
	})
	keymap("n", "k", function()
		return vim.v.count == 0 and "gk" or "k"
	end, {
		expr = true,
		remap = true,
	})

	-- 经典保存
	keymap({ "i", "v" }, "<C-s>", "<Esc>:w<CR>", {
		noremap = true,
		silent = true,
	})
end
