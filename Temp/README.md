# 杂物

## 快速对比不同cscale（色度升频）算法
一般视频看不出来？正常，首先人眼对亮度平面的敏感度远高于色度平面；其次，因为你没有444的母源作为基准参考线。

**chroma-444.png** 当基准， **chroma-420.jpg** 是经过预处理的色度半采样成品，分别打开多个mpv空窗口，分别拖入进行对比。

在开始比较前，你可能需要做以下准备：  
在 **mpv.conf** 中设置 防止1秒读图后自动关闭
```
image-display-duration=inf
```
在 **input.conf** 中添加以下这行代码，就可以在运行时使用快捷键快速切换色度升频的算法，即时观看差异。
```
Ctrl+c   cycle-values cscale "bilinear" "spline36" "sinc" "lanczos" "jinc" "bicubic" "catmull_rom"
```
（当然也别忘了和可能是目前最好的色度升频算法 **KrigBilateral** 作对比）

我的简单测试结果：从左上到右下分别是 无损源 bilinear catmull_rom KrigBilateral
![](https://github.com/hooke007/MPV_lazy/blob/master/Temp/444-bilinear-catrom-krig-ty.png)
