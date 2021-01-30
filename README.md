![](https://github.com/hooke007/MPV_lazy/blob/master/%E7%95%8C%E9%9D%A2%E5%AF%B9%E6%AF%94.jpg)



# _MPV懒人包（附简易整合过程）_ v20210131



## **内部组件及整合列表**
  **=== mpv-x86_64-20210103-git** 本体

https://sourceforge.net/projects/mpv-player-windows/files/64bit/

（主程序`mpv.exe`所在位置新建`\portable_config\`文件夹，该文件夹内放置`input.conf`和`mpv.conf`）

  **=== libEGL & libGLESv2** 
  
通常你可以在Chromium/Firefox的安装目录里找到

两个`.dll`文件放在`mpv.exe`旁

  **=== VapourSynth64-Portable-R52** 环境支持

https://github.com/vapoursynth/vapoursynth/releases

便携版解压至`mpv.exe`所在位置（`vapoursynth64`文件夹应在`mpv.exe`旁）

  **=== python-3.8.7-embed-amd64** 环境支持

https://www.python.org/downloads/

便携版解压至`mpv.exe`所在位置（`python.exe`应在`mpv.exe`旁）

  **=== ffmpeg-4.3.1-static** 独立程序

https://ffmpeg.org/download.html#build-windows

静态库版只需要把`ffmpeg.exe`放在`mpv.exe`旁



### 脚本置于`\portable_config\scripts\`，脚本对应conf配置文件置于`\portable_config\script-opts\`

  **=== Thumbnailer** 缩略图引擎

  **=== on_top_only_while_playing** 播放时自动置顶（需配合配置文件中的--ontop参数）

  **=== autoload** 自动加载同级目录视频

  **=== open-file-dialog** 快捷键 `Ctrl+o` 手动加载额外的视频文件

  **=== playlistmanager** 高级播放列表



### 着色器置于`\portable_config\shaders\`

  **=== Krig** 高级cscale

  **=== Anime4K_v3.1** 动漫方向的视频画面优化

  **=== ACNet_1.0.0** 动漫方向的人工智能视频画面优化

  **=== FSRCNNX** 快速超分辨率卷积神经网络 放大算法

  **=== RAVU** 快速准确的图像超分辨率算法（fscnnx的下位代替）
  
  **=== NNEDI3** 可当作放大算法

  **=== SSimDownscaler** 高级缩小算法

  **=== SSimSuperRes** 对mpv内置放大算法的修正

  **=== Adaptive Sharpen** 自适应锐化
  
  **=== CAS** 对比度自适应锐化
  
  **=== Noise static** 优化静态噪点



### 补帧的dll置于`\vapoursynth64\plugins`，补帧脚本vpy可置于`\portable_config\`

  **=== mvtools-v23-win64** 及附属补帧脚本

  **=== svpflow** 补帧引擎（发布帖有其他坛友的脚本）



# 其它
mpv懒人包的更新地址：https://bbs.vcb-s.com/thread-5843-1-1.html

关于`mpv.conf`内参数设定的全面描述文档：https://mpv.io/manual/master/

界面UI及`osc.conf`修改指路：https://bbs.vcb-s.com/thread-5982-1-1.html (适用mpv原版/BOX分支，现版本改动较大）

Win10上我用过的最好的基于libmpv的第三方播放器：https://kikoplay.fun/ （官网）
