local function is_terminal_like(buf)
    local bt = vim.bo[buf].buftype
    return bt == "terminal" or bt == "prompt"
end

local function is_normal_edit(buf)
    return vim.bo[buf].buftype == ""
end

local function set_universal_keymaps(buf)
    local opts = { buffer = buf, silent = true }
    local function with_desc(desc)
        return { buffer = buf, silent = true, desc = desc }
    end

    vim.keymap.set({ "n", "x" }, "j", "gj", opts)
    vim.keymap.set({ "n", "x" }, "k", "gk", opts)
    vim.keymap.set({ "n", "x" }, "H", "^", opts)
    vim.keymap.set({ "n", "x" }, "L", "$", opts)
    vim.keymap.set({ "n", "x" }, "J", "L", opts)
    vim.keymap.set({ "n", "x" }, "K", "H", opts)
    vim.keymap.set({ "n", "x" }, "W", "b", opts)

    vim.keymap.set("n", "<esc><esc>", "<cmd>HiClear<cr>", opts)
    vim.keymap.set("n", "<leader><leader>", "<cmd>HiWord<cr>", with_desc("highlight the word"))

    vim.keymap.set("n", "<leader>q", "<cmd>BufRemove<cr>", with_desc("remove buffer"))
end

local function set_normal_keymaps(buf)
    local function with_desc(desc)
        return { buffer = buf, silent = true, desc = desc }
    end

    vim.keymap.set("n", "<leader>a", "<cmd>vsplit<cr>", with_desc("split vertical"))
    vim.keymap.set("n", "<leader>s", "<cmd>split<cr>", with_desc("split horizontal"))

    vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>", with_desc("next buffer"))
    vim.keymap.set("n", "<s-tab>", "<cmd>bprev<cr>", with_desc("prev buffer"))

    vim.keymap.set("n", "<leader>e", "<cmd>PickFiles<cr>", with_desc("files (pick)"))
    vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<cr>", with_desc("grep (pick)"))
    vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<cr>", with_desc("buffers (pick)"))

    vim.keymap.set("n", "<leader>w", "<cmd>Files<cr>", with_desc("explorer"))
    vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", with_desc("undotree"))

    vim.keymap.set("n", "<leader>t", "<cmd>Term<cr>", with_desc("terminal"))
    vim.keymap.set("n", "<leader>m", "<cmd>lua MiniMap.toggle()<cr>", with_desc("minimap"))

    vim.keymap.set("n", "<leader>f", function()
        require("conform").format({
            async = true,
            lsp_format = "fallback",
        })
    end, with_desc("format"))
end

local function set_lsp_keymaps(buf)
    local function with_desc(desc)
        return { buffer = buf, silent = true, desc = desc }
    end

    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, with_desc("rename (lsp)"))
    vim.keymap.set("n", "<leader>d", vim.lsp.buf.hover, with_desc("hover docs (lsp)"))
    vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, with_desc("code action (lsp)"))
end

return {
    setup = function()
        local group = vim.api.nvim_create_augroup("keymaps", { clear = true })

        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            callback = function(args)
                if is_terminal_like(args.buf) then
                    return
                end

                set_universal_keymaps(args.buf)

                if is_normal_edit(args.buf) then
                    set_normal_keymaps(args.buf)
                end
            end,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = group,
            callback = function(args)
                set_lsp_keymaps(args.buf)
            end,
        })
    end,
}
