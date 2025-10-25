local M = {}

function M.run_command_in_float(command, title, success_msg, failure_msg)
    -- Create floating buffer
    local buf = vim.api.nvim_create_buf(false, true)

    local width = math.floor(vim.api.nvim_get_option('columns') * 0.8)
    local height = math.floor(vim.api.nvim_get_option('lines') * 0.8)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = math.floor((vim.api.nvim_get_option('lines') - height) / 2),
        col = math.floor((vim.api.nvim_get_option('columns') - width) / 2),
        border = 'rounded',
        title = title
    })

    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    vim.fn.jobstart(command, {
        stdout_buffered = true,
        stderr_buffered = true,

        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
            end
        end,

        on_stderr = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
            end
        end,

        on_exit = function(_, exit_code)
            if exit_code == 0 then
                vim.api.nvim_win_set_config(win, {
                    title = 'Success!',
                    title_pos = 'center'
                })
                vim.notify(success_msg, vim.log.levels.INFO)

                vim.defer_fn(function()
                    vim.api.nvim_win_close(win, true)
                end, 3000)
            else
                vim.api.nvim_win_set_config(win, {
                    title = 'Fail!',
                    title_pos = 'center'
                })
                vim.notify(failure_msg, vim.log.levels.ERROR)
            end
        end
    })
end

return M
