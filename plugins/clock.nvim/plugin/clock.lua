local popup = require 'clock.popup'

vim.api.nvim_create_user_command('ShowClock', function()
  popup.create_popup(os.date '%H:%M')
end, {
  nargs = '?',
  desc = 'Show clock popup',
})
