# mpv播放器折腾记录
从萌新到大白，<s>用前嫌麻烦</s> 用后真香系列

![](https://github.com/hooke007/MPV_lazy/blob/master/%E7%95%8C%E9%9D%A2%E5%AF%B9%E6%AF%94.jpg)
![](https://github.com/hooke007/MPV_lazy/blob/master/%E9%AB%98%E7%BA%A7%E6%92%AD%E6%94%BE%E5%88%97%E8%A1%A8.png)

MPV播放器介绍 https://github.com/mpv-player/mpv （右上方附有懒人包

这里是一些备份，原内容已迁移至仓库内 [10]_从零开始制作整合包.html (Github不支持网页预览，手册下载后阅读）  
建议直接下载原档后修改，自行新建文本编辑注意编码格式应为UTF-8，换行符为Unix，否则MPV可能无法识别

旧版BOX界面和缩略图脚本 https://github.com/hooke007/MPV_lazy_osc

```
本地文件树简易结构
    ...\mpv-lazy\
        mpv.exe & mpv.com
        mpv-BenchMark.conf
        mpv-？？模式.bat

    ...\mpv-lazy\portable_config\
            input.conf
            mpv.conf
            mvtools-???.vpy
            svpflow-???.vpy

    ...\mpv-lazy\portable_config\scripts\
                autoload.lua
                cycle-adevice.lua
                ontop-playback.lua
                open-file-dialog.lua
                playlistmanager.lua

    ...\mpv-lazy\portable_config\script-opts\
                autoload.conf
                console.conf
                osc.conf
                playlistmanager.conf
                stats.conf
                thumbnailer.conf

    ...\mpv-lazy\portable_config\shaders\
                ?????.glsl
                ?????.hook
```
