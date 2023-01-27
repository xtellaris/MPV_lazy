### NL-means降噪
### 追求速度应使用着色器版本，例如 ../shaders/nlmeans.glsl

import vapoursynth as vs
from vapoursynth import core

input = video_in
fmt_in = input.format.id

############
# 用户选项 #
############

Blur_mode = 2
Nlm_core = 1
Frame_num = 1
Radius_sw = 2
Radius_snw = 2
Strength = 3.0
GPU = 0
## <0|1|2> 分离模式。0为不使用
## 降噪核心 1=OpenCL // 2=cpu
## 降噪帧数（整数）
## 搜索窗口半径（整数）
## 近邻窗口半径（整数）
## 降噪强度（浮点）
## 指定opencl显卡加速设备

cut0 = core.resize.Bilinear(clip=input, format=vs.YUV444P16)

if Blur_mode == 0 :
	blur = cut0
elif Blur_mode == 1 :
	blur = core.rgvs.RemoveGrain(clip=cut0, mode=20)
	blur = core.rgvs.RemoveGrain(clip=blur, mode=20)
	blur = core.rgvs.RemoveGrain(clip=blur, mode=20)
elif Blur_mode == 2 :
	blur = core.std.Convolution(clip=cut0, matrix=[1, 1, 1, 1, 1, 1, 1, 1, 1])
	blur = core.std.Convolution(clip=blur, matrix=[1, 1, 1, 1, 1, 1, 1, 1, 1])
	blur = core.std.Convolution(clip=blur, matrix=[1, 1, 1, 1, 1, 1, 1, 1, 1])

if Blur_mode :
	diff = core.std.MakeDiff(clipa=cut0, clipb=blur)
	if Nlm_core == 1 :
		cut1 = core.knlm.KNLMeansCL(clip=diff, d=Frame_num, a=Radius_sw, s=Radius_snw, h=Strength,
			channels="auto", wmode=2, wref=1.0, rclip=None, device_type="GPU", device_id=GPU)
	elif Nlm_core == 2 :
		cut1 = core.nlm_ispc.NLMeans(clip=diff, d=Frame_num, a=Radius_sw, s=Radius_snw, h=Strength,
			channels="AUTO", wmode=2, wref=1.0, rclip=None)
	merge = core.std.MergeDiff(clipa=blur, clipb=cut1)
else :
	if Nlm_core == 1 :
		cut1 = core.knlm.KNLMeansCL(clip=blur, d=Frame_num, a=Radius_sw, s=Radius_snw, h=Strength,
			channels="auto", wmode=2, wref=1.0, rclip=None, device_type="GPU", device_id=GPU)
	elif Nlm_core == 2 :
		cut1 = core.nlm_ispc.NLMeans(clip=blur, d=Frame_num, a=Radius_sw, s=Radius_snw, h=Strength,
			channels="AUTO", wmode=2, wref=1.0, rclip=None)

output = core.resize.Bilinear(clip=merge if Blur_mode else cut1, format=fmt_in)

output.set_output()
