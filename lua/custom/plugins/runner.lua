-- CodeRunner
-- Track terminal buffers and their associated files
local terminal_files = {}

-- <leader>r = Save, run, and delete when terminal closes
vim.keymap.set('n', '<leader>r', function()
    vim.cmd 'write' -- AUTO-SAVE BEFORE RUNNING

    local ft = vim.bo.filetype
    local filepath = vim.fn.expand '%:p'
    local filename = vim.fn.expand '%:t:r'
    local dir = vim.fn.expand '%:p:h'
    local binary = dir .. '/' .. filename

    if ft == 'c' then
        vim.cmd(
            string.format(
                'split | terminal cd %s && gcc -Wall -Wextra %s -o %s && %s',
                vim.fn.shellescape(dir),
                vim.fn.shellescape(filepath),
                vim.fn.shellescape(filename),
                vim.fn.shellescape('./' .. filename)
            )
        )
    elseif ft == 'cpp' then
        vim.cmd(
            string.format(
                'split | terminal cd %s && g++ -Wall -Wextra %s -o %s && %s',
                vim.fn.shellescape(dir),
                vim.fn.shellescape(filepath),
                vim.fn.shellescape(filename),
                vim.fn.shellescape('./' .. filename)
            )
        )
    elseif ft == 'python' then
        vim.cmd('split | terminal python3 ' .. vim.fn.shellescape(filepath))
        vim.cmd 'startinsert'
        return
    else
        print('No runner for ' .. ft)
        return
    end

    vim.defer_fn(function()
        local term_buf = vim.api.nvim_get_current_buf()
        terminal_files[term_buf] = binary
    end, 100)

    vim.cmd 'startinsert'
end, { desc = 'Save, run, and delete binary on close' })

-- Auto-delete binary when terminal closes
vim.api.nvim_create_autocmd('TermClose', {
    callback = function(args)
        local binary = terminal_files[args.buf]
        if binary and vim.fn.filereadable(binary) == 1 then
            vim.fn.delete(binary)
            print('Deleted: ' .. binary)
        end
        terminal_files[args.buf] = nil
    end,
})

-- <leader>c = Save, compile to /tmp and keep
vim.keymap.set('n', '<leader>c', function()
    vim.cmd 'write' -- AUTO-SAVE BEFORE RUNNING

    local ft = vim.bo.filetype
    local filepath = vim.fn.expand '%:p'
    local filename = vim.fn.expand '%:t:r'

    if ft == 'c' then
        vim.cmd(
            string.format(
                'split | terminal gcc -Wall -Wextra %s -o /tmp/%s && /tmp/%s',
                vim.fn.shellescape(filepath),
                vim.fn.shellescape(filename),
                vim.fn.shellescape(filename)
            )
        )
    elseif ft == 'cpp' then
        vim.cmd(
            string.format(
                'split | terminal g++ -Wall -Wextra %s -o /tmp/%s && /tmp/%s',
                vim.fn.shellescape(filepath),
                vim.fn.shellescape(filename),
                vim.fn.shellescape(filename)
            )
        )
    elseif ft == 'python' then
        vim.cmd('split | terminal python3 ' .. vim.fn.shellescape(filepath))
    else
        print('No runner for ' .. ft)
        return
    end

    vim.cmd 'startinsert'
end, { desc = 'Save, compile to /tmp and run' })

-- Close terminal with double Escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>:q<CR>', { desc = 'Close terminal' })
return {}
