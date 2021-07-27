# CSV[^1]

- [CSV标准格式](https://www.iteye.com/blog/xinglu-1167826)
- [rfc4180](https://www.ietf.org/rfc/rfc4180.txt)
- [几种解析方法](http://lua-users.org/wiki/LuaCsv)

## 关键
1. **正确处理行，包括特殊情况的处理**
2. 如果有类型定义，将元素预转换
3. 如果有header key，将数据处理成键值对形式，并提供主键进行数据索引

[^1]:Comma-Separated Values