--[[ 
    使用debug库的字符串插值
    http://lua-users.org/wiki/StringInterpolation
]]
-- "nil" value that can be stored in tables.
local mynil_mt = { __tostring = function() return tostring(nil) end }
local mynil = setmetatable({}, mynil_mt)

-- Retrieves table of all local variables (name, value)
-- in given function <func>.  If a value is Nil, it instead
-- stores the value <mynil> in the table to distinguish a
-- a local variable that is nil from the local variable not
-- existing.
-- If a number is given in place of <func>, then it
-- uses that level in the call stack.  Level 1 is the
-- function that called get_locals.
-- Note: this correctly handles the case where two locals have the
-- same name: "local x = 1 ... get_locals(1) ... local x = 2".
-- This function is similar and is based on debug.getlocal().
function get_locals(func)
    local n = 1
    local locals = {}
    func = (type(func) == "number") and func + 1 or func
    while true do
        local lname, lvalue = debug.getlocal(func, n)
        if lname == nil then break end  -- end of list
        if lvalue == nil then lvalue = mynil end  -- replace
        locals[lname] = lvalue
        n = n + 1
    end
    return locals
end


-- Interpolates variables into string <str>.
-- Variables are defined in table <table>.  If <table> is
-- omitted, then it uses local and global variables in the
-- calling function.
-- Option level indicates the level in the call stack to
-- obtain local variable from (1 if omitted).
function interp(str, table, level)
    local use_locals = (table == nil)
    table = table or getfenv(2)
    if use_locals then
        level = level or 1
        local locals = get_locals(level + 1)
        table = setmetatable(locals, { __index = table })
    end
    local out = string.gsub(str, '$(%b{})',
    function(w)
        local variable_name = string.sub(w, 2, -2)
        local variable_value = table[variable_name]
        if variable_value == mynil then variable_value = nil end
        return tostring(variable_value)
    end
    )
    return out
end

-- Interpolating print.
-- This is just a wrapper around print and interp.
-- It only accepts a single string argument.
function printi(str)
    print(interp(str, nil, 2))
end

-- Pythonic "%" operator for srting interpolation.
getmetatable("").__mod = interp