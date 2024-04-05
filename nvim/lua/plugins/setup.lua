return {
    setup = function()
        local path_package = vim.fn.stdpath("data") .. "/site/"
        local mini_path = path_package .. "pack/deps/start/mini.nvim"
        if not vim.loop.fs_stat(mini_path) then
            vim.cmd('echo "Installing `mini.nvim`" | redraw')
            local clone_cmd =
                { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
            vim.fn.system(clone_cmd)
            vim.cmd("packadd mini.nvim | helptags ALL")
            vim.cmd('echo "Installed `mini.nvim`" | redraw')
        end

        local deps = require("mini.deps")
        deps.setup({ path = { package = path_package } })

        now = function(path)
            deps.now(function()
                require(path).now(deps.add)
            end)
        end

        later = function(path)
            deps.later(function()
                require(path).later(deps.add)
            end)
        end

        return now, later
    end,
}
