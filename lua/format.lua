vim.api.nvim_create_user_command("ConformInfo", function()
    local conform = require("conform")
    local buf_ft = vim.bo.filetype
    local formatters = conform.list_formatters(buf_ft)

    if #formatters == 0 then
        print("No formatters available for filetype: " .. buf_ft)
    else
        local formatter_names = {}
        for _, f in ipairs(formatters) do
            table.insert(formatter_names, f.name)
        end
        print("Active formatters for " .. buf_ft .. ": " .. table.concat(formatter_names, ", "))
    end
end, {})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
    },
    formatters = {
        black = {
            command = "black",
            args = { "--line-length", "79", "-" },
            stdin = true,
        },
        stylua = {
            command = "stylua",
            args = { "--indent-type", "Spaces", "--indent-width", "4", "-" },
            stdin = true,
        },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
    },
})
