return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        cmd = 'Neotree',
        keys = {
            { '<leader>n', '<cmd>Neotree toggle<CR>', desc = 'Toggle [N]eo-tree' },
        },
        opts = {},
    },
}
