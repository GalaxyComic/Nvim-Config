local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "williamboman/mason.nvim",
        priority = 1000,
        config = function()
            require("mason").setup({
                PATH = "prepend",
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        after = "mason.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "rust_analyzer", "omnisharp" },
            })
        end,
    },
    { "junegunn/fzf" },
    { "junegunn/fzf.vim" },
    { "stevearc/conform.nvim" },
    { "windwp/nvim-autopairs" },
    { "goolord/alpha-nvim" },
    { "oneslash/helix-nvim", version = "*" },
    { "neovim/nvim-lspconfig" },
    { "numToStr/Comment.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
})

local cmp = require("cmp")
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
    completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged, cmp.TriggerEvent.InsertEnter },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
})

local nvim_lsp = require("lspconfig")
local function on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover" }))
    vim.keymap.set(
        "n",
        "<leader>d",
        vim.diagnostic.open_float,
        vim.tbl_extend("force", opts, { desc = "LSP: Show Diagnostics" })
    )
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = {
    pyright = {},
    rust_analyzer = {},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
            },
        },
    },
    omnisharp = {
        cmd = {
            "dotnet",
            "/home/" .. vim.fn.getenv("USER") .. "/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll",
        },
    },
}

require("mason-lspconfig").setup_handlers({
    function(server_name)
        local opts = servers[server_name] or {}
        opts.capabilities = capabilities
        opts.on_attach = on_attach
        require("lspconfig")[server_name].setup(opts)
    end,
})
