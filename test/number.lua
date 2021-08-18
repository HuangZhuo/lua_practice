TEST('>int_max', function()
    for i = 40, 52 do
        print('2^%d' % i, 2 ^ i)
    end
    -- 2^46	70368744177664.0
    -- 2^47	1.4073748835533e+14
    return true
end)