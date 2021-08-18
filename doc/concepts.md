# 概念



[Lua 5.3 术语中英对照表 (cloudwu.github.io)](http://cloudwu.github.io/lua53doc/glossary.html)



| -               |      |      |
| --------------- | ---- | ---- |
| lexical scoping |      |      |

## ENV

在`Lua5.1`中有`getfenv` 和 `getupvalue`两个函数，分别用于获取函数的环境表和上值，两者既有些相似又有些区别。在`Lua5.2`中，`getfenv`已经被废弃，而新增`_ENV`作为函数的上值。

