![](https://github.com/hooke007/MPV_lazy/blob/master/%E7%95%8C%E9%9D%A2%E5%AF%B9%E6%AF%94.jpg)

# 从零开始制作MPV懒人包 v20210131

## **内部组件及整合列表**
  **=== mpv-x86_64-20210103-git** 本体

https://sourceforge.net/projects/mpv-player-windows/files/64bit/

解压后主程序`mpv.exe`所在位置新建`\portable_config\`文件夹，该文件夹内放置`input.conf`和`mpv.conf`

  **=== 系列手册**

  **=== libEGL & libGLESv2** 
  
通常你可以在Chromium/Firefox的根目录里找到，将两个`.dll`文件放在`mpv.exe`旁

  **=== VapourSynth64-Portable-R52** 环境支持

https://github.com/vapoursynth/vapoursynth/releases

便携版解压至`mpv.exe`所在位置（`vapoursynth64`文件夹应在`mpv.exe`旁）

  **=== python-3.8.7-embed-amd64** 环境支持

https://www.python.org/downloads/

便携版解压至`mpv.exe`所在位置（`python.exe`应在`mpv.exe`旁）

  **=== ffmpeg-4.3.1-static** 独立程序

https://ffmpeg.org/download.html#build-windows

静态库版只需要把`ffmpeg.exe`放在`mpv.exe`旁

  **=== SourceHanSans.ttc** 思源黑体

https://github.com/adobe-fonts/source-han-sans/releases

直接安装该字体或置于`\fonts\`文件夹内

### 脚本.lua置于`\portable_config\scripts\`，脚本对应.conf配置文件置于`\portable_config\script-opts\`

  **== Thumbnailer** 缩略图引擎
  
  https://github.com/deus0ww/mpv-conf/tree/master/scripts + https://github.com/deus0ww/mpv-conf/tree/master/script-opts

  **== on_top_only_while_playing** 播放时自动置顶（需配合配置文件中的--ontop参数）
  
  https://github.com/kungfubeaner/mpv-ontop-only-while-playing-lua

  **== autoload** 自动加载同级目录视频
  
  https://github.com/mpv-player/mpv/tree/master/TOOLS/lua

  **== open-file-dialog** 快捷键 `Ctrl+o` 手动加载额外的视频文件
  
  https://github.com/elig0n/mpv-open-file-dialog

  **== playlistmanager** 高级播放列表
  
  https://github.com/jonniek/mpv-playlistmanager

### 着色器.hook .glsl置于`\portable_config\shaders\` （来源见系列手册[01]）

  **== Krig** 高级cscale

  **== Anime4K_v3.1** 动漫方向的视频画面优化

  **== ACNet_1.0.0** 动漫方向的人工智能视频画面优化

  **== FSRCNNX** 快速超分辨率卷积神经网络 放大算法

  **== RAVU** 快速准确的图像超分辨率算法（fscnnx的下位代替）
  
  **== NNEDI3** 可当作放大算法

  **== SSimDownscaler** 高级缩小算法

  **== SSimSuperRes** 对mpv内置放大算法的修正

  **== Adaptive Sharpen** 自适应锐化
  
  **== CAS** 对比度自适应锐化
  
  **== Noise static** 优化静态噪点

### 补帧的dll置于`\vapoursynth64\plugins\`，补帧脚本vpy可置于`\portable_config\`

  **== mvtools-v23-win64** 及附属补帧脚本
  
  https://github.com/dubhater/vapoursynth-mvtools/releases

  **== svpflow** 补帧引擎（发布帖有其他坛友的脚本）

## Github不支持预览html 系列手册请下载后阅读

# 以上步骤执行完基本完成，完善好属你自己的配置方案，打包好就可以到处随意使用了

更懒一点？成品更新地址：https://bbs.vcb-s.com/thread-5843-1-1.html
