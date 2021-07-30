--[[
  The following example illustrates string interpolation [1]
  by way of a preprocessor that runs as a customer searcher
  function in package.loaders.

  Tested in Lua 5.2.0-beta.
  Depends on
    file_slurp https://gist.github.com/1325400 (for loading files simply)
    luabalanced https://github.com/davidm/lua-balanced (for Lua parsing)

  [1] http://lua-users.org/wiki/StringInterpolation

  --DavidManura, 2011-11
--]]

-----------------------------------------------------
-- main.lua
-- main program

require 'meta'
require 'foo-m' . test()

-----------------------------------------------------
-- foo-m.lua
-- Example module that uses preprocessing.

--! code = require 'interpolate' (code)

local M = {}

local function printf(s, ...)
  local vals = {...}
  local i = 0
  s = s:gsub('\0[^\0]*\0', function()
    i = i + 1
    return tostring(vals[i])
  end)
  print(s)
end

function M.test()
  local x = 16
  printf("value is $(math.sqrt(x)) ")  --> This prints "value is 4"
end

return M

-------------------------------------------
-- meta.lua
-- Installs preprocessing loader.

local searcher0 = package.loaders[2]

local readfile = require 'file_slurp' . readfile
local LB = require 'luabalanced'

-- Process special comments starting with '--!'
local function extract(code)
  -- Parse out special comments.
  local metacode = ''
  LB.gsub(code, function(u, s)
    if u == 'c' then
      local stats = s:match'^%-%-%!(.*)'
      if stats then
        metacode = metacode .. stats
      end
    end
  end)
  -- Evaluate special comments.
  local E = setmetatable({code = code}, {__index = _G})
  local f = assert(load(metacode, nil, nil, E))
  f()
  return E.code
end


-- Custom searcher function that preprocesses modules
-- with names postfixed with '-m'.
local function searcher(name)
  if name:match'%-m$' then
    local filename, err = package.searchpath(name, package.path)
    if filename then
      local code = readfile(filename)
      code = extract(code)
      local f = assert(load(code, filename))
      return f
    end
  end
end
table.insert(package.loaders, 2, searcher)


-------------------------------------------------------------
--[[
interpolate.lua
Preprocessor that expands strings like
   "a $(b) c $(d*(e+f))"
to
  "a \0$(b)\0 c \0$(d*(e+f))\0", b, d*(e+f)
--]]

local LB = require 'luabalanced'

local function preprocess(code)
  local ts = {}
  LB.gsub(code, function(u, s)
    if u == 's' then
      local ar = {}
      s = s:gsub('%$(%b())', function(e)
        e = e:sub(2, -2)
        ar[#ar+1] = e
        return '\0' .. e .. '\0'
      end)
      local ars = table.concat(ar, ', ')
      if ars ~= '' then s = s .. ', ' .. ars end
    end
    ts[#ts+1] = s
  end)
  local code = table.concat(ts)
  return code
end

return preprocess

