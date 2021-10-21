--[[ 
    协程
]]
TEST('basic', function()
    co = coroutine.create(function()
        print('hi')
    end)
    print(co, coroutine.status(co)) -- suspended
    coroutine.resume(co)            -- hi
    print(co, coroutine.status(co)) -- dead

    -- yield
    co = coroutine.create(function()
        for i = 1, 10 do
            print('co', i)
            coroutine.yield()
        end
    end)

    -- Lua 中一对 resume-yield 可以相互交换数据
    co = coroutine.create(function(a, b)
        -- 1. yield的参数传作为resume的返回值
        coroutine.yield(a + b, a - b)
    end)
    print(coroutine.resume(co, 20, 10)) -- ture 30  10
    print(coroutine.status(co))         -- suspended

    co = coroutine.create(function()
        -- 2. resume的参数作为yield的返回值
        print("co", coroutine.yield())

        coroutine.yield()
        -- 3. 协同代码结束时主函数返回的值都会传给相应的 resume
        return 6, 7
    end)
    coroutine.resume(co)
    coroutine.resume(co, 4, 5) --> co 4 5
    print(coroutine.resume(co))
    return true
end)

--[[ 
    全排列问题
    3*2*1
    1,2,3|    1,3,2|    2,1,3|    2,3,1|    3,1,2|    3,2,1
]]
TEST('permgen', function()
    local function permgen(a, n)
        if n == 1 then
            print(table.concat(a, ", "))
        else
            for i = 1, n do
                a[i], a[n] = a[n], a[i]
                permgen(a, n - 1)
                a[i], a[n] = a[n], a[i]
            end
        end
    end
    permgen({ 1, 2, 3 }, 3)
    return true
end)

--[[ 
    用作迭代器的协同
    思路：yield的参数可以作为resume的返回值，每次迭代其实就是resume一次
]]
TEST('>permgen_co', function()
    local function permgen(a, n)
        if n == 1 then
            coroutine.yield(a)
        else
            for i = 1, n do
                a[i], a[n] = a[n], a[i]
                permgen(a, n - 1)
                a[i], a[n] = a[n], a[i]
            end
        end
    end

    -- local function perm(a)
    --     local n = #a
    --     local co = coroutine.create(function() return permgen(a, n) end)
    --     return function()
    --         _, ret = coroutine.resume(co)
    --         return ret
    --     end
    -- end
    local function perm(a)
        return coroutine.wrap(function()
            return permgen(a, #a)
        end)
    end

    for v in perm { 1, 2, 3 } do
        print(table.concat(v, ", "))
    end

    return true
end)