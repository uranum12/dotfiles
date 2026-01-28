return {
    setup = function()
        local results = vim.fs.find(".nvim.lua", {
            upward = true,
            path = vim.fn.getcwd(),
            type = "file",
        })

        if #results > 0 then
            local config_path = results[1]
            local ok, err = pcall(dofile, config_path)
            if ok then
                vim.notify("Loaded project config: " .. config_path, vim.log.levels.INFO)
            else
                vim.notify("Error in project config " .. config_path .. ": " .. err, vim.log.levels.ERROR)
            end
        end
    end,
}
