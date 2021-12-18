该文件夹下存放mpv的脚本

| 脚本名 | 功能 | 说明 |
| --- | --- | --- |
| autoload.lua | 自动加载同级目录的文件 | _脚本内及设置文件_ |
| cycle_adevice.lua | 快捷键切换音频 | _脚本内及设置文件_ |
| ontop_playback.lua | 仅在播放时启用置顶 | _脚本内及设置文件_ |
| open_dialog.lua | 快捷键载入文件/网址/高级次字幕 | https://github.com/hooke007/MPV_lazy/discussions/61 |
| osc_lazy.lua | 增强OSC界面 | https://github.com/hooke007/MPV_lazy/discussions/18 |
| playlistmanager.lua | 高级播放列表 | _脚本内及设置文件_ |
| thumbnailer*.lua (2) | 缩略图引擎 | _脚本内及设置文件_ |
|  |  |
| contextmenu_gui（组） | 图形化右键菜单 | https://github.com/hooke007/MPV_lazy/discussions/60 |

所有脚本均无预绑定的静态键位，查看 [input.conf](../input.conf)  的"LUA脚本"部分示例参考  
playlistmanager.lua存在动态绑定键位，查看对应配置文件 [playlistmanager.conf](../script-opts/playlistmanager.conf) 的相关部分

大部分脚本皆可独立使用  
**缩略图引擎** 必须依附 **增强OSC界面** 或 [Thumbnailer_OSC.lua](https://github.com/deus0ww/mpv-conf/tree/master/scripts) 使用  
**图形化右键菜单** 可选附加 **快捷键载入文件** 和 **高级播放列表**
