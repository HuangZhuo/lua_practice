-- print(...) -- test.module.hello
module(..., package.seeall)

--[[ 
    module会创建一个名字为hello的表（或者链在一起的多个表），所有的non-local函数会定义在这个表中
    - 如果全局已经存在这个表，那个会直接用这个表
    - 如果全局存在这个变量，非table类型，那么会报`name conflict`异常
]]
local function init()
    print('init')
end

function foo()
    print('foo')

    -- 这里只能访问定义在foo函数前面的local functions
    -- bar() -- error!
end

local function bar()
    print('bar')
end