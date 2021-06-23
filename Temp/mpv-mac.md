记录 Intel MBP 16' 2020 折腾 iina、svp、mpv 相关

>最终放弃了这套链路转向了 vlc 和 movist pro  
至今mpv系在mac系统上只能使用 `vo=opengl`  
多种其他因素下造成了渲染效率低下+电量杀手

# mpv for MAC

1. MAS(app store)搜索安装 Xcode

2. 安装homebrew https://brew.sh/index_zh-cn  
打开终端 输入  
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`  
安装完输入 `brew`  
显示 Example usage。。。即安装成功

3. 升级homebrew自身  
`brew update`  
升级所有包（bottle版）  
`brew upgrade`

4. 安装mpv的git版  
`brew install mpv --HEAD`  
以后更新git版mpv应执行下列命令  
`brew reinstall mpv`

5. mpv设置文件的位置  
打开访达 `command+shift+g`  
前往 `~/.config/mpv/`  
此处新建 `mpv.conf`

我用的极简设置清单
```
input-ipc-server          = /tmp/mpvsocket # 支持svp mannager
opengl-early-flush        = no             # 补帧的兼容

macos-force-dedicated-gpu = yes            # 调用独显

#icc-profile-auto                          # 这块近99%的p3还不色彩管理的话辣眼睛
icc-cache-dir             = ~~/cache/

hr-seek-framedrop         = no             # 补帧跳转的音画同步
keep-open                 = yes
audio-file-auto           = fuzzy
sub-ass-force-margins     = yes
sub-auto                  = fuzzy
gpu-shader-cache-dir      = ~~/cache/
```

Q:我用svp配合iina补帧也要装mpv？  
A:是的没错

Q:不是有第三方编译好的mpv吗  
A:功能不全，而且你确定不用各方面都更好的iina？

# SVP for MAC

https://www.svp-team.com/zh/get/  
不使用它提供的过时的安装脚本，只安装svp.app  
（安装 .dmg/.app 总会吧。。。  

# IINA

IINA是MAC上基于libmpv的最佳前端  
https://github.com/iina/iina/releases  

IINA的优秀音乐模式让我把它作为了默认的本地音乐播放器

## 关联svp的特殊操作：  
打开终端 删除iina自带的libmpv库  
`rm /Applications/IINA.app/Contents/Frameworks/libmpv.1.dylib`  
软链原版libmpv的库  
`ln -s /usr/local/lib/libmpv.1.dylib /Applications/IINA.app/Contents/Frameworks/libmpv.1.dylib`

建议使用访达进行图形界面操作，顺便检验文件名和路径是否对应  
然后可以用svp调用iina补帧了，每次iina软件更新都要执行重新这两步

# 其它：

CotEditor 推荐作为默认文本编辑器  
https://github.com/coteditor/CotEditor/releases
