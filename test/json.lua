local tb = {
    k = 'v',
    a = { 1, 2, 3, 4 },
    b = {
        [1] = 1,
        [2] = 2,
        [5] = 5,
        [10] = 10,
        [1000] = 100,
    },
    c = { 1, nil, 3 },
    d = { 1, nil, 3, [10] = 10 },
    -- e: 会对稀疏数组做优化处理，将number key转为string key
    e = { 1, nil, 3, [100] = 100 },
}

-- pretty.dump(tb)
local str = json.encode(tb)
print(str)