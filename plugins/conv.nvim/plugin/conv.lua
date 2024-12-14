local converters = require 'conv.converters'

vim.api.nvim_create_user_command('B2H', function(opts)
  if opts.args and opts.args ~= '' then
    local str = converters.binaryToHex(opts.args)
    if str == -1 then
      print 'Error converting string: Not a string'
    end
    if str == -2 then
      print 'Error converting string: Invalid binary format, no match'
    end
    print(str)
  end
end, {
  nargs = '?',
  desc = 'Convert the binary string into hexadecimal format',
})

vim.api.nvim_create_user_command('B2D', function(opts)
  if opts.args and opts.args ~= '' then
    local str = converters.binaryToDecimal(opts.args)
    if str == -1 then
      print 'Error converting string: Not a string'
    end
    if str == -2 then
      print 'Error converting string: Invalid binary format, no match'
    end
    print(str)
  end
end, {
  nargs = '?',
  desc = 'Convert the binary string into decimal format',
})

vim.api.nvim_create_user_command('H2B', function(opts)
  if opts.args and opts.args ~= '' then
    local str = converters.hexToBinary(opts.args)
    if str == -1 then
      print 'Error converting string: Not a string'
    end
    if str == -2 then
      print 'Error converting string: Invalid hexadecimal format, no match'
    end
    print(str)
  end
end, {
  nargs = '?',
  desc = 'Convert the hexadecimal string into binary format',
})

vim.api.nvim_create_user_command('H2D', function(opts)
  if opts.args and opts.args ~= '' then
    local str = converters.hexToDecimal(opts.args)
    if str == -1 then
      print 'Error converting string: Not a string'
    end
    if str == -2 then
      print 'Error converting string: Invalid hexadecimal format, no match'
    end
    print(str)
  end
end, {
  nargs = '?',
  desc = 'Convert the hexadecimal string into decimal format',
})
