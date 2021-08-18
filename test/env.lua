--[[ 
    ENV

    在 Lua 5.2、5.3及以上版本中实现 setfenv
    https://leafo.net/guides/setfenv-in-lua52-and-above.html

    > 如果您使用 Lua 5.1编写了程序，那么您可能遇到过函数 setfenv (以及相关的 getfenv)。Lua 5.2删除了那些有利于 _ ENV 变量的函数。_ ENV 变量是一个有趣的变化，可以完成许多相同的事情，但它不能直接替代。
]]
pretty.dump(debug)
print(setfenv == debug.setfenv) -- false, so what's the difference?

local function get_upvalue(fn, search_name)
    local idx = 1
    while true do
        local name, val = debug.getupvalue(fn, idx)
        if not name then break end
        if name == search_name then
            return idx, val
        end
        idx = idx + 1
    end
end

TEST('>print_upvalue', function()
    local number = 15
    -- number = 15
    local function lucky()
        -- 注意这里print也是全局作用域中的变量
        print("your lucky number: " .. number)
    end

    local print2 = print
    local function lucky2()
        print2("[2]your lucky number: " .. number)
    end

    -- print out the upvalues of the function lucky
    local idx = 1
    while true do
        local name, val = debug.getupvalue(lucky, idx)
        if not name then break end
        print('debug.getupvalue', name, val)
        idx = idx + 1
    end

    debug.setupvalue(lucky, get_upvalue(lucky, "number"), 22)
    lucky() --> your lucky number: 22
    lucky2()

    print(_G == getfenv(lucky)) -- true
    print(_G == debug.getfenv(lucky)) -- true

    print('getfenv(lucky2)', getfenv(lucky2))

    local idx = 1
    while true do
        local name, val = debug.getlocal(1, idx)
        if not name then break end
        print('debug.getlocal', name, val)
        idx = idx + 1
    end

    return true
end)