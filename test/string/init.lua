--[[ 
    http://lua-users.org/wiki/StringInterpolation
]]
TEST('dump_string_meta', function()
    pretty.dump(getmetatable(""))
    return true
end)

TEST('interp_simple', function()
    local function interp(s, tab)
        return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
    end
    print(interp("${name} is ${value}", { name = "foo", value = "bar" }))

    getmetatable("").__mod = interp
    print("${name} is ${value}" % { name = "foo", value = "bar" })
    -- Outputs "foo is bar"
    return true
end)

TEST('>interp_with_debug_lib', function()
    require('test.string.interp')
    world = 'world'
    local world = 'you'
    print(interp 'hello ${world}')
    world = nil
    print(world, _G['world'])
    return true
end)