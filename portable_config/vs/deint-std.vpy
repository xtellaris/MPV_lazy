### nnedi3作参考，进行反交错

import vapoursynth as vs
from vapoursynth import core

input = video_in

edi_core = 2
GPU = -1
# 使用的核心 1=nnedi3 // 2=znedi3 // 3=nnedi3cl
# 使用OpenCL加速的设备（仅支持nnedi3cl）

if edi_core == 1 :
	ref = core.nnedi3.nnedi3(clip=input, field=3)
if edi_core == 2 :
	ref = core.znedi3.nnedi3(clip=input, field=3)
if edi_core == 3 :
	ref = core.nnedi3cl.NNEDI3CL(clip=input, field=3, device=GPU)
output = core.yadifmod.Yadifmod(clip=input, edeint=ref, order=1, mode=1)

output.set_output()
