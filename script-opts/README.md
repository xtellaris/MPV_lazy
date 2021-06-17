该文件夹下存放mpv脚本的对应配置文件  

通常配置文件名与所属脚本同名，实际遵脚本开发者设定为准。

以下为mpv内置脚本所使用的设置文件：
```
console.conf
osc.conf
stats.conf
ytdl_hook.conf
```

为什么不用官方的mpv参数 `--script-opts=key1=value1,key2=value2,...`  
不嫌烦和乱的话完全没有问题，只有在脚本所需更改的选项数量极少的情况下，我才会使用。  
[#options-script-opts](https://mpv.io/manual/master/#options-script-opts)
