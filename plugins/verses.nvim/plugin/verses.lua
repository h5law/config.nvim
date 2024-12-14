local popup = require 'verses.popup'
local parser = require 'verses.parse'

vim.api.nvim_create_user_command('VersesChapters', function(opts)
  if opts.args and opts.args ~= '' then
    local is_valid, result = parser.get_passage(opts.args)

    if is_valid then
      popup.create_popup(opts.args, result)
    else
      popup.create_popup('Invalid chapter format', {
        result,
        'Usage: :VersesChapters John 1-3',
      })
    end
  else
    popup.create_popup('No chapter reference provided', {
      'Usage: :VersesChapters John 1-3',
    })
  end
end, {
  nargs = '?',
  desc = 'Show chapter popup',
  complete = function(ArgLead, CmdLine, CursorPos)
    -- Basic completion for book names
    local books = require('verses.parse').get_valid_books()
    -- Filter based on what user has typed
    local matches = {}
    for _, book in ipairs(books) do
      if book:lower():sub(1, #ArgLead) == ArgLead:lower() then
        table.insert(matches, book)
      end
    end

    return matches
  end,
})
