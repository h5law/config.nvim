local function create_popup(title, items)
  -- Calculate window size and position
  local width = 60
  local height = 30 -- Add space for border
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, items)

  -- Window options
  local opts = {
    title = title,
    style = 'minimal',
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'rounded',
  }

  -- Create window
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Set window options
  vim.api.nvim_win_set_option(win, 'title', true)
  vim.api.nvim_win_set_option(win, 'titlestring', title)
  vim.api.nvim_win_set_option(win, 'wrap', true)
  vim.api.nvim_win_set_option(win, 'breakindent', true)
  vim.api.nvim_win_set_option(win, 'breakindentopt', 'shift:2')
  vim.api.nvim_win_set_option(win, 'showbreak', '↪ ')
  vim.api.nvim_win_set_option(win, 'linebreak', true)
  vim.api.nvim_win_set_option(win, 'cursorline', true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  -- Adjust window width to account for line number column
  local new_width = width + 6 -- Add space for line numbers
  vim.api.nvim_win_set_width(win, new_width)

  -- Recentre the window after adjusting width
  local new_col = math.floor((vim.o.columns - new_width) / 2)
  vim.api.nvim_win_set_config(win, {
    relative = 'editor',
    row = row,
    col = new_col,
    width = new_width,
    height = height,
  })

  -- Disable cursor movement past last line
  vim.api.nvim_create_autocmd('CursorMoved', {
    buffer = buf,
    callback = function()
      local cursor = vim.api.nvim_win_get_cursor(win)
      local line_count = vim.api.nvim_buf_line_count(buf)
      if cursor[1] > line_count then
        vim.api.nvim_win_set_cursor(win, { line_count, cursor[2] })
      end
    end,
  })

  -- Add keymaps
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })

  -- Add navigation keymaps
  vim.api.nvim_buf_set_keymap(buf, 'n', 'j', 'gj', { noremap = true, silent = true }) -- Move by visual lines
  vim.api.nvim_buf_set_keymap(buf, 'n', 'k', 'gk', { noremap = true, silent = true }) -- Move by visual lines
end

return {
  create_popup = create_popup,
}
