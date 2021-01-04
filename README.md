![](https://github.com/hooke007/MPV_lazy/blob/master/%E7%95%8C%E9%9D%A2%E5%AF%B9%E6%AF%94.jpg)

# _MPV懒人包说明_ v20210104

* 载入视频时默认暂停，需手动点击开始播放（`鼠标右键`或`空格键`），可适当留时间和性能给缩略图缓存完毕再开始播放（移动至进度条查看建立的完成度）
* 默认不开启**KrigBilateral**高级cscale色度升频,手动使用“`CTRL+1`”切换，更多相关注意事项见`input.conf`
* 默认不开启**ACNet**滤镜,手动使用“`CTRL+2`”选择预设方案
* 默认不开启**FSRCNNX**（快速超分辨率卷积神经网络）,手动使用“`CTRL+3`”选择预设方案
* 默认不开启**Anime4k**滤镜，手动使用“`CTRL+4`”选择预设方案，CTRL+` 为清除所有glsl滤镜
* 默认不开启**补帧**算法，`CTRL+6`开启/关闭mvtools补帧方案通用版;`CTRL+7`开启/关闭mvtools补帧方案高级版（没有变态的CPU慎用）。`CTRL+8`开启svpflow补帧滤镜2d动画版<font color=blue>（推荐）</font>，`CTRL+9`开启svpflow补帧滤镜真人/CG版。<font color=red>同一时间请只开启一个补帧滤镜</font>。`CTRL+0`清除所有vf滤镜

* 默认不预设 **SSimDownscaler** **SSimSuperRes** **ravu-zoom-r4** ,如何设置可参考`input.conf`和`mpv.conf`的相关参数以及`shaders`文件夹内的具体文件名。其他滤镜如何设定操作同理。

## **注意事项**
<font color=red>请不要放在中文目录下运行！！！</font>非Administrator用户若放在C盘须确保安置路径具有<font color=orange>写入权限</font>（可能引起脚本无效化）

<font color=orange>广色域屏</font>用户使用前应进行色彩管理相关设定（参见mpv.conf中的视频部分）

想让其作为默认播放器使用请先运行如下文件，再修改win10视频类的默认打开文件
`X:\xxxxx\mpv-lazy\installer\mpv-install.bat`

有MPV使用基础可以自行修改配置文件以调整性能占用（每行首字为 # 的是不启用的）
`X:\xxxxx\mpv-lazy\portable_config\mpv.conf`
而同目录下的`input.conf`则是当前的快捷预设方案

`X:\xxxxx\mpv-lazy\portable_config\scripts\autoload.lua`会自动加载同一层级目录下的所有文件，我默认只加载视频类，如果有其他需求用记事本打开修改。

mvtools标准版补帧方案脚本中，可自行修改补帧帧率（默认为`dfps = 60000`即60.000帧）
例：`X:\xxxxx\mpv-lazy\portable_config\mvtools-standard.vpy`
svpflow补帧脚本也可自行设置，甚至可以调用显卡加速，具体方法用记事本打开查看
`X:\xxxxx\mpv-lazy\portable_config\svpflow-.vpy`

高级播放列表的设定文件为
`X:\xxxxx\mpv-lazy\portable_config\script-opts\playlistmanager.conf`

缩略图缓存文件夹 `C:\Users\你的用户名\AppData\Local\Temp\Thumbnailer`，如长时间使用后占地太大可清理

## **鼠标控制 键盘快捷键**
`左键` 双击---切换---全屏/窗口化

`右键` 单机---切换---暂停/播放

`滚轮向上/向下` 向前/向后搜索10秒

`空格` 暂停/播放

`1`和`2` 调整对比度

`3`和`4` 调整亮度

`5`和`6` 调整伽玛

`7`和`8` 调整饱和度

`9`和`0` 调整音量

`F8` 显示<font color=orange>简易播放列表</font>（在osc的前后切换按钮上`鼠标右键`也可）

`[`和`]` 调整播放速度

`Backspace` 重置播放速度

`Shift+t` 手动播放器置顶（依然受on_top_only_while_playing脚本影响）

`f` 手动全屏

`Alt`+`1` 将视频窗口调整为原始大小

`s` 截图

`i` 显示有关当前<font color=green>播放文件的统计信息stats</font>，例如编解码器，帧速率，丢帧数等。 此时按`1`,`2`,`3`,`4`分别显示不同页面的信息

`Shift`+`i` 作用同上，此时统计信息常驻

更多操作及自定义见`input.conf`

## **高级播放列表操作**
`Shift`+`Enter` 打开高级列表，此时：（以下按键皆为动态绑定）

`上下` 选择条目

`左右` 选中当前选择的条目

`Backspace` 移除当前选中的条目

`Enter` 播放当前选中的条目

`Esc` 关闭高级播放列表（此时以上按键不再绑定，恢复其原来的功能）

# 其它
mpv懒人包的更新地址：https://bbs.vcb-s.com/thread-5843-1-1.html

关于`mpv.conf`内参数设定的全面描述文档：https://mpv.io/manual/master/

界面UI及`osc.conf`修改指路：https://bbs.vcb-s.com/thread-5982-1-1.html (适用mpv原版/BOX分支，现版本改动较大）

Win10上我用过的最好的基于libmpv的第三方播放器：https://kikoplay.fun/ （官网）
