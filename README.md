# mpv播放器折腾记录
从萌新到大白，<s>用前嫌麻烦</s> 用后真香系列

![](%E7%95%8C%E9%9D%A2%E5%AF%B9%E6%AF%94.jpg)
![](%E9%AB%98%E7%BA%A7%E6%92%AD%E6%94%BE%E5%88%97%E8%A1%A8.png)

MPV播放器 https://github.com/mpv-player/mpv  
各文件夹内的md也有进一步的说明

这里是我的设置备份，原内容（_系列手册）已迁移至 [我的主页#系列手册](https://hooke007.github.io/#%E7%B3%BB%E5%88%97%E6%89%8B%E5%86%8C)

建议直接下载本仓库内的原档文件进行修改，自行新建文本编辑注意编码格式应为UTF-8，换行符为Unix，否则MPV可能无法识别

旧版BOX界面和缩略图脚本 https://github.com/hooke007/MPV_lazy_osc

## 本地文件树结构
我使用的是便携设置 https://mpv.io/manual/master/#files-on-windows  
此时在 `mpv.conf` 中 `~~/`引用的相对路径即指向 `...\mpv-lazy\portable_config\`
```
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
                Thumbnailer.lua
                Thumbnailer_OSC.lua
                Thumbnailer_Worker.lua

    ...\mpv-lazy\portable_config\script-opts\
                autoload.conf
                console.conf
                osc.conf
                playlistmanager.conf
                stats.conf
                thumbnailer.conf
                Thumbnailer_OSC.conf
                ytdl_hook.conf

    ...\mpv-lazy\portable_config\shaders\
                ?????.glsl
                ?????.hook
```
我也使用便携版Python和VapourSynth  
即解压所有包内文件到 `mpv.exe` 的同级
```
    ...\mpv-lazy\
        python.exe
        VapourSynth.dll
        xxxx.py
        等等文件
    ...\mpv-lazy\vapoursynth64\plugins\
                这里放置自行添加的vs插件
```

## 懒人包
懒人包是解压即可使用的完整解决方案  
下载见 [release](https://github.com/hooke007/MPV_lazy/releases)
