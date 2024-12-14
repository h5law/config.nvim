local function create_popup(items)
  -- Calculate window size and position
  local width = 15
  local height = 1
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, { string.format('     %s', items) })

  -- Window options
  local opts = {
    title = ' Clock :: Time ',
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
  vim.api.nvim_win_set_option(win, 'titlestring', ' Clock :: Time ')
  vim.api.nvim_win_set_option(win, 'number', false)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
end

return {
  create_popup = create_popup,
}
