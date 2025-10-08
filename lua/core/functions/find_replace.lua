local M = {}

function M.find_and_replace()
    -- Get the current word under cursor for default value
    local current_word = vim.fn.expand('<cword>')
    
    -- Prompt for search pattern
    vim.ui.input({ prompt = 'Search pattern: ', default = current_word }, function(search_pattern)
        if not search_pattern or search_pattern == '' then return end
        
        -- Store the search pattern to highlight it
        vim.fn.setreg('/', search_pattern)
        vim.cmd('normal! n')
        
        -- Prompt for replacement
        vim.ui.input({ prompt = 'Replace with: ' }, function(replace_pattern)
            if not replace_pattern then return end
            
            -- Ask for confirmation type
            vim.ui.select({
                'All',
                'Confirm each',
                'Current line to end',
                'Only current line'
            }, {
                prompt = 'Replace mode:',
                format_item = function(item)
                    return item
                end,
            }, function(choice)
                if not choice then return end
                
                local cmd
                if choice == 'All' then
                    cmd = string.format('%%s/%s/%s/g', search_pattern:gsub('/', '\\/'), replace_pattern:gsub('/', '\\/'))
                elseif choice == 'Confirm each' then
                    cmd = string.format('%%s/%s/%s/gc', search_pattern:gsub('/', '\\/'), replace_pattern:gsub('/', '\\/'))
                elseif choice == 'Current line to end' then
                    cmd = string.format('.,$s/%s/%s/g', search_pattern:gsub('/', '\\/'), replace_pattern:gsub('/', '\\/'))
                else -- Only current line
                    cmd = string.format('.s/%s/%s/g', search_pattern:gsub('/', '\\/'), replace_pattern:gsub('/', '\\/'))
                end
                
                -- Execute the replacement
                local success, err = pcall(vim.cmd, cmd)
                if success then
                    local count = vim.fn.searchcount().total
                        -- Verifies if the variable count is greater than 0 in order to display the notification
                        if count > 0 then
                            vim.notify(string.format('Replaced %d occurrences', count), vim.log.levels.INFO)
                        end
                else
                    vim.notify('Error during replacement: ' .. err, vim.log.levels.ERROR)
                end
            end)
        end)
    end)
end

return M