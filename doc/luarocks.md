## Use Luarocks in Windows
> A common request I've heard is “I wish LuaRocks worked like npm and let me install modules in the current directory.” I'm glad to report it already can! I've written this guide to clear up any confusion about how and where LuaRocks installs modules.

[Using LuaRocks to install packages in the current directory](https://leafo.net/guides/customizing-the-luarocks-tree.html)

## Error
### 加载`lfs`模块报错
> error loading module 'lfs' from file '3rd/lib/lua/5.1/lfs.dll':\n\t%1 ������Ч�� Win32 Ӧ�ó���\r\n

`lua.exe`需要设置为x86版本，而`lua-debug`插件默认用的是`x86_64`版本的`lua.exe`，有两种办法：
1. 修改默认解释器版本
   > "luaArch": "x86"
2. 修改解释器路径(根据环境变量换成默认的`lua.exe`)
   > "luaexe": "${workspaceFolder}/lua.exe",

## step by step
