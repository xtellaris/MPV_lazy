![](https://github.com/hooke007/MPV_lazy/blob/master/%E7%95%8C%E9%9D%A2%E5%AF%B9%E6%AF%94.jpg)

# _MPV懒人包说明_ v20210118（卒于话多，一周后解封）

## **内部组件及整合列表**
**mpv-x86_64-20210103-git** 本体（主程序mpv.exe）

**libEGL & libGLESv2**

**VapourSynth64-Portable-R52** 环境支持

**python-3.8.7-embed-amd64** 环境支持

**ffmpeg-4.3.1-static** 独立程序


**Thumbnailer** 缩略图引擎

**on_top_only_while_playing** 播放时自动置顶（需配合配置文件中的--ontop参数）

**autoload** 自动加载同级目录视频

**open-file-dialog** 快捷键 `Ctrl+o` 手动加载额外的视频文件

**playlistmanager** 高级播放列表


**Krig** 高级cscale

**Anime4K_v3.1** 动漫方向的视频画面优化

**ACNet_1.0.0** 动漫方向的人工智能视频画面优化

**mvtools-v23-win64** 及附属补帧脚本

**svpflow** 补帧引擎（发布帖有其他坛友的脚本）


**FSRCNNX** 快速超分辨率卷积神经网络 放大算法

**ravu-zoom-r4** 快速准确的图像超分辨率算法（fscnnx的下位代替）

**SSimDownscaler** 高级缩小算法

**SSimSuperRes** 对mpv内置放大算法的修正

**Adaptive Sharpen** 自适应锐化


* 载入视频时默认暂停，需手动点击开始播放（ `鼠标右键` 或 `空格键` 或 `p` ），可适当留时间和性能给缩略图缓存完毕再开始播放（移动至进度条查看建立的完成度）
* 默认不开启**Krig**高级cscale色度升频，手动使用 `CTRL+1` 切换，更多相关注意事项见`input.conf`
* 默认不开启**ACNet**滤镜,手动使用 `CTRL+2` 选择预设方案
* 默认不开启**FSRCNNX**,手动使用 `CTRL+3` 选择预设方案
* 默认不开启**Anime4k**滤镜，手动使用 `CTRL+4` 选择预设方案，CTRL+` 为清除所有glsl滤镜
* 默认不开启**补帧**算法，`CTRL+6` 开启/关闭mvtools补帧方案通用版；`CTRL+7` 开启/关闭mvtools补帧方案高级版（没有变态的CPU慎用）。`CTRL+8` 开启svpflow倍帧滤镜2d动画版<font color=blue>（新）</font>，`CTRL+9` 开启svpflow补帧滤镜旧版（原anime）。<font color=red>同一时间请只开启一个补帧滤镜</font>。`CTRL+0` 清除所有vf滤镜

* 默认不预设 **SSimDownscaler** **SSimSuperRes** **ravu-zoom-r4** **adaptive-sharpen** 如何设置可参考 `input.conf` 和 `mpv.conf` 的相关参数以及 `shaders` 文件夹内的具体文件名。其他滤镜如何设定操作同理。

## **注意事项**
<font color=red>请不要放在中文目录下运行！！！</font>非Administrator用户若放在C盘须确保安置路径具有<font color=orange>写入权限</font>（可能引起脚本无效化）

<font color=orange>广色域屏</font>用户使用前应进行色彩管理相关设定（参见mpv.conf中的 `视频` 部分）

想让其作为默认播放器使用请先运行如下批处理文件，再修改win10视频类的默认打开文件
`X:\xxxxx\mpv-lazy\installer\mpv-install.bat`
要从计算机中删除此批处理的所有痕迹，请以管理员身份运行同目录下的 `mpv-uninstall.bat`
移动 `mpv.exe` 文件的路径后，需要重新执行该批处理

有MPV使用基础可以自行修改配置文件以调整性能占用（每行首字为 # 的是不启用的）
`X:\xxxxx\mpv-lazy\portable_config\mpv.conf`
而同目录下的 `input.conf` 则是当前的快捷预设方案

mvtools补帧方案的脚本中，可自行修改补帧帧率（默认为 `dfps = 60000` 即60.000帧）
例：`X:\xxxxx\mpv-lazy\portable_config\mvtools-xxxx.vpy`
svpflow补帧脚本也可设置，甚至可以调用显卡加速，具体方法用记事本打开查看
`X:\xxxxx\mpv-lazy\portable_config\svpflow-xxxx.vpy`

对 `shaders` 文件夹中的着色器/滤镜有补充说明
`X:\xxxxx\mpv-lazy\portable_config\shaders\0_说明.txt`

缩略图缓存文件夹
`C:\Users\你的用户名\AppData\Local\Temp\Thumbnailer`

## **鼠标控制 键盘快捷键**
`左键` 双击---切换---全屏/窗口化

`右键` 单机---切换---暂停/播放

`滚轮向上/向下` 向前/向后搜索10秒

`空格` 暂停/播放

`1`  `2` 调整对比度

`3`  `4` 调整亮度

`5`  `6` 调整伽玛

`7`  `8` 调整饱和度

`9`  `0` 调整音量

`F8` 显示<font color=orange>简易播放列表</font>（在osc的前后切换按钮上 `鼠标右键` 也可）

`[`  `]` 调整播放速度

`Backspace` 重置播放速度

`Shift+t` 手动播放器置顶（依然受on_top_only_while_playing脚本影响）

`f` 手动全屏

`Alt`+`1` 将视频窗口调整为原始大小

`s` 截图

`i` 显示有关当前<font color=green>播放文件的统计信息stats</font>，例如编解码器，帧速率，丢帧数等。 此时按 `1` `2` `3` `4` 分别显示不同页面的信息

`Shift`+`i` 作用同上，此时统计信息常驻


更多操作及自定义见 `input.conf`

## **高级播放列表操作**
`Shift`+`Enter` 打开高级列表，此时：（以下按键皆为动态绑定）

`↑`  `↓` 选择条目（当选中时，功能改变为移动该条目在列表中的位置）

`←`  `→` 选中/取消选中 当前选择的条目

`Backspace` 移除当前选择/选中的条目

`Enter` 播放当前选择/选中的条目

`Esc` 关闭高级播放列表（此时以上按键不再绑定，恢复其原来的功能）

# 其它
mpv懒人包的更新地址：https://bbs.vcb-s.com/thread-5843-1-1.html

关于`mpv.conf`内参数设定的全面描述文档：https://mpv.io/manual/master/

界面UI及`osc.conf`修改指路：https://bbs.vcb-s.com/thread-5982-1-1.html (适用mpv原版/BOX分支，现版本改动较大）

Win10上我用过的最好的基于libmpv的第三方播放器：https://kikoplay.fun/ （官网）
