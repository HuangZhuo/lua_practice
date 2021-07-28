--[[ 
    ref: http://lua-users.org/wiki/LuaModuleFunctionCritiqued
    module 方法已不推荐使用
]]
require('test.module.hello')

-- 1. 会生成多余的全局表，污染全局空间
print(test)
print(test.module)
print(test.module.hello)
print(test.module.hello.foo)

-- 2. 模块的metatable.__index == _G (可以规避)
print(test.module.hello.print)
print(test.module.hello.test.module.hello == test.module.hello)

local env = getfenv(test.module.hello.foo)
print('env == test.module.hello', env == test.module.hello)

test.module.hello.foo()
pretty.dump(test.module.hello)
