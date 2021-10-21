-- init 3rd
require('pl')
require('dkjson')

--[[ 
    simple test wrapper func
    @tag    if a tag begins with '>' ,the func will call immediately
    @func   function to be tested
    return  wrapper function
]]
function TEST(tag, func, ...)
    local exenow = false
    if string.find(tag, '^>') then
        exenow = true
        tag = string.gsub(tag, '^>', '', 1)
    end

    local args = { ... }
    local wrap_func = function()
        print(string.format('---BEGIN TEST OF [%s]', tag))
        local ret = func(unpack(args))
        print(string.format('---FINISH TEST OF [%s]:%s', tag, tostring(ret)))
    end
    if exenow then
        wrap_func()
    else
        return wrap_func
    end
end

-- require('test.csv')-- test csv parce
-- require('test.module')
-- require("test.json")
-- require('test.string')
-- require('test.env')
-- require('test.number')
require('test.iter')
-- require('test.thread')
-- require('test.datetime')
