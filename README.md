# _MPV懒人包快速说明_ v20200507

* 载入视频时默认暂停，需手动点击开始播放（或`空格键`），最好适当留时间和性能给缩略图缓存完毕再开始播放（移动至进度条查看建立的完成度）

* 默认不对超过1小时的视频建立缩略图缓存（所耗时间较长），可按`shift+t`手动开始建立

* 默认不开启anime4k滤镜，手动使用“`CTRL+1~3`”选择预设方案，1号仅降噪，<font color=blue>推荐3号效果显著</font>，`CTRL+0`为清除所有glsl滤镜（慎用，因为会清除cscale这样的基础必要算法，非特殊情况应使用预设`CTRL+9`只保留csale算法）

* 默认不开启补帧算法，`CTRL+4`开启/关闭mvtools补帧方案<font color=blue>标准版（推荐）</font>;`CTRL+5`开启/关闭mvtools补帧方案测试版;`CTRL+6`开启/关闭mvtools补帧方案高级版（没有变态的CPU慎用）。<font color=red>同一时间请只开启一个mvtools补帧滤镜</font>。CTRL+` 清除所有vf滤镜

  

## **注意事项**

<font color=red>请不要放在中文目录下运行！！！</font>非Administrator用户若放在C盘需确保安置路径具有<font color=orange>写入权限</font>（可能引起脚本无效化）

缩略图缓存文件夹是`X:\\C:\\Users\\你的用户名\\AppData\\Local\\Temp\\mpv_thumbs_cache`
播放器缓存文件夹在`X:\\mpv-lazy-xxxxxxxx\\portable_config\\shaders_cache`，如长时间使用后占地太大可清理

想让其作为默认播放器使用请先运行如下文件
`X:\\mpv-lazy-xxxxxxxx\\installer\mpv-install.bat`

有MPV使用基础可以自行修改配置文件以调整性能占用（每行首字为 # 的是不启用的）
`X:\\mpv-lazy-xxxxxxxx\\portable_config\\mpv.conf`

可自行修改缩略图缓存相关设置（默认为300像素，最少每20秒间隔）
`X:\\mpv-lazy-xxxxxxxx\\portable_config\\lua-settings\\mpv_thumbnail_script.conf`

标准版补帧方案脚本中，可自行修改补帧帧率（默认为 `dfps = 60000` 即60.000帧）
例：`X:\\mpv-lazy-xxxxxxxx\\portable_config\\mvtools-standard.py`



## **鼠标控制**

左键 双击 切换 全屏/窗口化

右键 单机 切换 暂停/播放

前进/后退按钮 切换到播放列表中的下一个/上一个条目

滚轮向上/向下 向前/向后搜索10秒

滚轮向左/右轮 减少/增加音量



## **键盘快捷键**

`1`和`2` 调整对比度
`3`和`4` 调整亮度
`5`和`6` 调整伽玛
`7`和8 调整饱和度
`9`和`0` `/`和`*` 调整音量
`F8` 显示播放列表
`<`和`>`切换播放列表中的上/下一个
`[`和`]` 调整播放速度
`backspace` 重置播放速度
`左`和`右` 往前/后5秒
`上`和`下` 往前/后1分钟
`Alt+0` 将视频窗口调整为原始大小的一半
`Alt+1` 将视频窗口调整为原始大小
`Alt+2` 调整视频窗口的大小以使其原始大小增加一倍
`空格` 暂停/播放
`i` <font color=green>显示有关当前播放文件的统计信息</font>，例如编解码器，帧速率，丢帧数等。 此时按`1,2,3,4`分别显示不同页面的信息
`shift+i` 作用同上，此时统计信息常驻
`s` 截图
`f` 手动全屏
`t` 手动播放器置顶



# 其它

mpv懒人包的其他更新地址：https://bbs.vcb-s.com/thread-5843-1-1.html

关于`mpv.conf`内参数设定的全面描述文档：https://mpv.io/manual/master/

我用过的最好的基于libmpv的第三方播放器：https://bbs.vcb-s.com/thread-4699-1-1.html （体验帖）

https://kikoplay.fun/ （官网）
