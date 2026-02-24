return {
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = {
                'asm',
                'bash',
                'c',
                'cpp',
                'diff',
                'html',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'vim',
                'vimdoc',
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
    },

    -- Show current function/class context at top of screen
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = { mode = 'cursor', max_lines = 3 },
    },

    -- Indent guides
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },
}
