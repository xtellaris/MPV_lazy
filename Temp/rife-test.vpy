## 性能警告：rtx 2070s lp 补帧 H265 360p 30→60fps 阵亡

import vapoursynth as vs
core = vs.core

input = video_in

cut1 = input.resize.Point(format=vs.RGBS, matrix_in_s="709")
cut2 = core.rife.RIFE(clip=cut1, model=0, gpu_id=0, gpu_thread=2, tta=False, uhd=False, sc=False, fp32=False)
# rife-v3.1（model=0）rife-v2.4（model=1）rife-anime（model=2）

output = cut2.resize.Point(format=vs.YUV444P16, matrix_s="709")

output.set_output()
