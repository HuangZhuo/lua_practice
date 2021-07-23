print('------------------')
print('_VERSION', _VERSION)
print('_ENV', _ENV)
print('package.path', package.path)
print('package.cpath', package.cpath)
print('[global]arg:')
local tmp = {}
for k, v in pairs(arg) do
    tmp[#tmp + 1] = {k, v}
end
table.sort(tmp, function(a, b)
    return a[1] < b[1]
end)
for _, v in ipairs(tmp) do
    print(unpack(v))
end
print('------------------')

require('test')
