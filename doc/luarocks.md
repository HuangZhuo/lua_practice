- [luarocks](https://luarocks.org/)
- [luarocks.trend](https://luarocks.org/stats/dependencies)

## step by step
1. install lua&luarocks
```cmd
choco install lua
choco install luarocks
```
虽然使用`choco`安装`lua`已经自带`luarocks`，但是不是最新的`luarocks`版本

2. make `cl` valid on windows
```
"%VS120COMNTOOLS%"vsvars32.bat
```

3. install rock
```
luarocks install penlight --tree 3rd
```
这样脚本和`dll`都会生成到`3rd`文件夹

## Use Luarocks in Windows
search **luarocks add tree** with `bing`
> A common request I've heard is “I wish LuaRocks worked like npm and let me install modules in the current directory.” I'm glad to report it already can! I've written this guide to clear up any confusion about how and where LuaRocks installs modules.

[Using LuaRocks to install packages in the current directory](https://leafo.net/guides/customizing-the-luarocks-tree.html)


## Tips
### 加载`lfs`模块报错
> error loading module 'lfs' from file '3rd/lib/lua/5.1/lfs.dll':...

`lua.exe`需要设置为x86版本，而`lua-debug`插件默认用的是`x86_64`版本的`lua.exe`，有两种办法：
1. 修改默认解释器版本
   > "luaArch": "x86"
2. 修改解释器路径(根据环境变量换成默认的`lua.exe`)
   > "luaexe": "${workspaceFolder}/lua.exe",
