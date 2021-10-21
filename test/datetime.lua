TEST('>day_of_year', function()
    -- https://stackoverflow.com/questions/32463938/lua-get-day-of-year/32469355#32469355
    local d1 = os.date("*t").yday
    local d2 = tonumber(os.date("%j"))
    print(d1, d2)
    return d1 == d2
end)