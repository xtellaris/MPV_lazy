
import vapoursynth as vs
core = vs.core
clip = video_in

y,u,v = [core.std.ShufflePlanes(clip, i, vs.GRAY) for i in (0,1,2)]

y = core.nnedi3cl.NNEDI3CL(
                           y, field=0, dh=True, dw=True,
                           planes=0, nsize=4, nns=2,
                           qual=1, etype=0, pscrn=2,
                           device=-1
                           )

# nsize: 0=8x6 // 4=8x4
# nns: 0=16 // 1=32 // 2=64 // 3=128 // 4=256
# pscrn: 2 比 1 快但不支持浮点输入格式

u,v = [core.resize.Spline36(i, i.width*2, i.height*2) for i in (u,v)]
clip = core.std.ShufflePlanes([y,u,v], [0,0,0], vs.YUV)

clip.set_output()