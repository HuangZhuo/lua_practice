--[[ 
    迭代器
    http://lua-users.org/wiki/ForTutorial
    http://lua-users.org/wiki/IteratorsTutorial
]]
TEST('for', function()
    for i = 1, 10 do
        i = i + 1
        print(i)
    end
    return true
end)

--[[ 
    使用闭包保存迭代状态
    现阶段对`闭包`的理解：函数访问外部局部变量的能力
]]
TEST('simple', function()
    -- list_iter 是创建迭代器的‘工厂函数’
    local list_iter = function(t)
        local i = 0
        local n = #t
        -- 返回一个闭包迭代器
        return function(...)
            pretty.dump({ ... })
            i = i + 1
            return i <= n and t[i] or nil
        end
    end
    local t = { 10, 20, 30 }
    for v in list_iter(t) do
        print(v)
    end
    return true
end)

--[[ 
    for语句结合迭代器的工作方式
]]
TEST('algorithm', function()
    -- Equivalent to "for var1, ···, varn in explist do block end"
    -- do
    --     local iterator, state, var1 = explist
    --     local var2, ..., varn
    --     while true do
    --         var1, ..., varn = iterator(state, var1)
    --         if var1 == nil then break end
    --         -- for block code
    --     end
    -- end
    return true
end)

--[[ 
    无状态迭代器
]]
TEST('my_ipairs', function()
    local function my_ipairs_iter(st, n)
        -- st: 状态常量
        -- n:  控制变量
        n = n or 0
        if n < #st then
            n = n + 1
            return n, st[n]
        end
    end
    local function my_ipairs(t)
        return my_ipairs_iter, t
    end

    local t = { 10, 20, 30 }
    for i, v in my_ipairs(t) do
        print(i, v)
    end
    return true
end)

--[[ 
    Lua 库中实现的 pairs 
]]
TEST('pairs', function()
    local function PAIRS(t)
        return next, t, nil
    end
    local t = {
        a = 1, b = 2
    }
    for k, v in PAIRS(t) do
        print(k, v)
    end
    return true
end)

--[[ 
    上面的迭代器，作用其实像是生成器，完成迭代功能的是for语句
    相反的，我们可以自己写函数，完成迭代
    比较：
    - for 更容易书写和理解
    - for 结构更灵活，可以使用 break 和 continue 语句
    - 迭代器风格函数写法中 return 语句只是从匿名函数中返回而不是退出循环
]]
TEST('table_walk', function()
    -- 迭代器风格函数
    local function table_walk(t, func)
        for k, v in pairs(t) do
            func(v, k)
        end
    end
    table_walk({ 1, 2, 3 }, print)
    return true
end)

TEST("next", function()
    local t = { a = 1, b = 2 }
    print(next(t)) -- a,1
    print(next(t, 'a')) -- b,2
    print(next(t, 'b')) -- nil
    return true
end)