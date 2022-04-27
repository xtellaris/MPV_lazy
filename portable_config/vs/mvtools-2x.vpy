### 倍帧，一般开销

import vapoursynth as vs
from vapoursynth import core

input = video_in

interpolation = 2
##运动补偿模式 1,2
recal = 1
##优化首次分析 0 否 1 是

vden = 1000
dden = 1000
vfps = container_fps * vden
dfps = container_fps * 2 * dden
##目标帧率=dfps/dden

if (container_fps < 32) :

	cut1 = core.std.AssumeFPS(clip=input, fpsnum=int(vfps), fpsden=vden)
	cut_s = core.mv.Super(clip=cut1, pel=1, sharp=0)
	cut_b = core.mv.Analyse(super=cut_s, blksize=32, isb=True, search=2)
	cut_f = core.mv.Analyse(super=cut_s, blksize=32, search=2)

	if recal == 0 :
		cut_b, cut_f = cut_b, cut_f
	if recal == 1 :
		cut_b = core.mv.Recalculate(super=cut_s, vectors=cut_b, blksize=16, search=2, searchparam=1, thsad=200)
		cut_f = core.mv.Recalculate(super=cut_s, vectors=cut_f, blksize=16, search=2, searchparam=1, thsad=200)

	if interpolation == 1 :
		output = core.mv.FlowFPS(clip=cut1, super=cut_s, mvbw=cut_b, mvfw=cut_f, num=dfps, den=dden, mask=1)
	if interpolation == 2 :
		output = core.mv.BlockFPS(clip=cut1, super=cut_s, mvbw=cut_b, mvfw=cut_f, num=dfps, den=dden)

output.set_output()
