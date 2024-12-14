local M = {}

local curl = require 'plenary.curl'

local function _get_verse_identifiers(input)
  if type(input) ~= 'string' then
    return false, 'Input must be a string, got ' .. type(input)
  end
  local valid_books = {
    ['Genesis'] = 'GEN',
    ['Exodus'] = 'EXO',
    ['Leviticus'] = 'LEV',
    ['Numbers'] = 'NUM',
    ['Deuteronomy'] = 'DEU',
    ['Joshua'] = 'JOS',
    ['Judges'] = 'JDG',
    ['Ruth'] = 'RUT',
    ['1 Samuel'] = '1SA',
    ['2 Samuel'] = '2SA',
    ['1 Kings'] = '1KI',
    ['2 Kings'] = '2KI',
    ['1 Chronicles'] = '1CH',
    ['2 Chronicles'] = '2CH',
    ['Ezra'] = 'EZR',
    ['Nehemiah'] = 'NEH',
    ['Esther'] = 'EST',
    ['Job'] = 'JOB',
    ['Psalms'] = 'PSA',
    ['Proverbs'] = 'PRO',
    ['Ecclesiastes'] = 'ECC',
    ['Song of Solomon'] = 'SNG',
    ['Isaiah'] = 'ISA',
    ['Jeremiah'] = 'JER',
    ['Lamentations'] = 'LAM',
    ['Ezekiel'] = 'EZK',
    ['Daniel'] = 'DAN',
    ['Hosea'] = 'HOS',
    ['Joel'] = 'JOL',
    ['Amos'] = 'AMO',
    ['Obadiah'] = 'OBA',
    ['Jonah'] = 'JON',
    ['Micah'] = 'MIC',
    ['Nahum'] = 'NAM',
    ['Habakkuk'] = 'HAB',
    ['Zephaniah'] = 'ZEP',
    ['Haggai'] = 'HAG',
    ['Zechariah'] = 'ZEC',
    ['Malachi'] = 'MAL',
    ['Matthew'] = 'MAT',
    ['Mark'] = 'MRK',
    ['Luke'] = 'LUK',
    ['John'] = 'JHN',
    ['Acts'] = 'ACT',
    ['Romans'] = 'ROM',
    ['1 Corinthians'] = '1CO',
    ['2 Corinthians'] = '2CO',
    ['Galatians'] = 'GAL',
    ['Ephesians'] = 'EPH',
    ['Philippians'] = 'PHP',
    ['Colossians'] = 'COL',
    ['1 Thessalonians'] = '1TH',
    ['2 Thessalonians'] = '2TH',
    ['1 Timothy'] = '1TI',
    ['2 Timothy'] = '2TI',
    ['Titus'] = 'TIT',
    ['Philemon'] = 'PHM',
    ['Hebrews'] = 'HEB',
    ['James'] = 'JAS',
    ['1 Peter'] = '1PE',
    ['2 Peter'] = '2PE',
    ['1 John'] = '1JN',
    ['2 John'] = '2JN',
    ['3 John'] = '3JN',
    ['Jude'] = 'JUD',
    ['Revelation'] = 'REV',
  }
  local verse_pattern = '^([1-3]?%s-[A-Z][a-z]+)%s?%d*-?%d*%s*$'

  local book_name = input:match(verse_pattern)
  if not book_name then
    return false, "Invalid format. Expected format: 'Book', 'Book 1' or 'Book 1-3'"
  end
  if not valid_books[book_name] then
    return false, string.format("Invalid book name: '%s'", book_name)
  end
  local numbers = input:match '.+%s+(.+)$'
  local first_num, second_num = 0, 0
  if numbers then
    first_num, second_num = numbers:match '(%d+)%-?(%d*)'
    first_num = first_num ~= '' and tonumber(first_num) or 0
    second_num = second_num ~= '' and tonumber(second_num) or 0
    if first_num > 0 and second_num > 0 and second_num <= first_num then
      return false, 'Second verse number must be greater than first number'
    end
  end

  return true, {
    book = valid_books[book_name],
    start_verse = first_num,
    end_verse = second_num,
  }
end

local function _split_trim_insert(obj, str)
  local split = string.gsub(str, '\\n', '\n')
  split = string.gsub(split, '(%[%d+%])', '\n%1')
  split = string.gsub(split, '¶ ', '')
  split = string.gsub(split, '^%s+(.+)%s+', '%1')
  for part in split:gmatch '[^\r\n]+' do
    -- Trim spaces, newlines, and ¶ characters from each part
    table.insert(obj, part)
  end
end

local function _get_passage(input)
  local is_vaid, result = _get_verse_identifiers(input)
  if not is_vaid then
    return false, result
  end

  local passage_obj
  local verses = {}
  local version = '7142879509583d59-01'

  if result.start_verse == 0 then
    local output = curl.request {
      url = string.format(
        'https://api.scripture.api.bible/v1/bibles/%s/passages/%s?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=true&include-verse-numbers=true&include-verse-spans=false&use-org-id=false',
        version,
        result.book
      ),
      method = 'GET',
      accept = 'application/text',
      headers = {
        api_key = '330fbe8f5137ac7770e00c7cf6fbbf4d',
      },
    }
    if not output.body then
      return false, output
    end

    passage_obj = vim.json.decode(output.body)
    _split_trim_insert(verses, passage_obj.data.content)
  end

  if result.start_verse > 0 and result.end_verse > 0 then
    local output = curl.request {
      url = string.format(
        'https://api.scripture.api.bible/v1/bibles/%s/passages/%s.%d-%s.%d?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=true&include-verse-numbers=true&include-verse-spans=false&use-org-id=false',
        version,
        result.book,
        result.start_verse,
        result.book,
        result.end_verse
      ),
      method = 'GET',
      accept = 'application/text',
      headers = {
        api_key = '330fbe8f5137ac7770e00c7cf6fbbf4d',
      },
    }
    if not output.body then
      return false, output
    end

    passage_obj = vim.json.decode(output.body)
    _split_trim_insert(verses, passage_obj.data.content)
  end

  if result.start_verse > 0 and result.end_verse == 0 then
    local output = curl.request {
      url = string.format(
        'https://api.scripture.api.bible/v1/bibles/%s/chapters/%s.%d?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false',
        version,
        result.book,
        result.start_verse
      ),
      method = 'GET',
      accept = 'application/text',
      headers = {
        api_key = '330fbe8f5137ac7770e00c7cf6fbbf4d',
      },
    }
    if not output.body then
      return false, output
    end

    passage_obj = vim.json.decode(output.body)
    _split_trim_insert(verses, passage_obj.data.content)
  end

  return true, verses
end
M.get_passage = _get_passage

local function _get_valid_books()
  return {
    'Genesis',
    'Exodus',
    'Leviticus',
    'Numbers',
    'Deuteronomy',
    'Joshua',
    'Judges',
    'Ruth',
    '1 Samuel',
    '2 Samuel',
    '1 Kings',
    '2 Kings',
    '1 Chronicles',
    '2 Chronicles',
    'Ezra',
    'Nehemiah',
    'Esther',
    'Job',
    'Psalm',
    'Proverbs',
    'Ecclesiastes',
    'Song of Solomon',
    'Isaiah',
    'Jeremiah',
    'Lamentations',
    'Ezekiel',
    'Daniel',
    'Hosea',
    'Joel',
    'Amos',
    'Obadiah',
    'Jonah',
    'Micah',
    'Nahum',
    'Habakkuk',
    'Zephaniah',
    'Haggai',
    'Zechariah',
    'Malachi',
    'Matthew',
    'Mark',
    'Luke',
    'John',
    'Acts',
    'Romans',
    '1 Corinthians',
    '2 Corinthians',
    'Galatians',
    'Ephesians',
    'Philippians',
    'Colossians',
    '1 Thessalonians',
    '2 Thessalonians',
    '1 Timothy',
    '2 Timothy',
    'Titus',
    'Philemon',
    'Hebrews',
    'James',
    '1 Peter',
    '2 Peter',
    '1 John',
    '2 John',
    '3 John',
    'Jude',
    'Revelation',
  }
end
M.get_valid_books = _get_valid_books

return M
