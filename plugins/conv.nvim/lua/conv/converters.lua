local M = {}

local function binaryToHex(input)
  if not input or input == '' or type(input) ~= 'string' then
    return -1
  end
  local str = (input:gsub('%s+', ''))
  if str:sub(1, 2):lower() == '0b' then
    str = str:sub(3)
  end
  str = string.match(str, '^([01]+)$')
  if str == '' or str == nil then
    return -2
  end
  local bin = tonumber(str, 2)
  return '0x' .. string.format('%x', bin)
end

local function binaryToDecimal(input)
  if not input or input == '' or type(input) ~= 'string' then
    return -1
  end
  local str = (input:gsub('%s+', ''))
  if str:sub(1, 2):lower() == '0b' then
    str = str:sub(3)
  end
  str = string.match(str, '^([01]+)$')
  if str == '' or str == nil then
    return -2
  end
  local dec = tonumber(str, 2)
  return string.format('%d', dec)
end

local function hexToBinary(input)
  if not input or input == '' or type(input) ~= 'string' then
    return -1
  end
  local str = (input:gsub('%s+', ''))
  if str:sub(1, 2):lower() == '0x' then
    str = str:sub(3)
  end
  str = string.match(str, '^([a-fA-F0-9]+)$')
  if str == '' or str == nil then
    return -2
  end
  local hex = tonumber(str, 16)
  local t = {}
  for _ = 1, 32 do
    hex = bit.rol(hex, 1)
    table.insert(t, bit.band(hex, 1))
  end
  str = table.concat(t)
  return '0b' .. string.match(str, '^0*([01]+)$')
end

local function hexToDecimal(input)
  if not input or input == '' or type(input) ~= 'string' then
    return -1
  end
  local str = (input:gsub('%s+', ''))
  if str:sub(1, 2):lower() == '0x' then
    str = str:sub(3)
  end
  str = string.match(str, '^([a-fA-F0-9]+)$')
  if str == '' or str == nil then
    return -2
  end
  local dec = tonumber(str, 16)
  return string.format('%d', dec)
end

M.binaryToHex = binaryToHex
M.binaryToDecimal = binaryToDecimal
M.hexToBinary = hexToBinary
M.hexToDecimal = hexToDecimal

return M
