return {
    {
        'OXY2DEV/markview.nvim',
        lazy = false,
    },
    {
        'alex-popov-tech/store.nvim',
        dependencies = { 'OXY2DEV/markview.nvim' },
        opts = {},
        cmd = 'Store',
    },
}
