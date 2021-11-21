
import vapoursynth as vs
from vapoursynth import core

input = video_in

cut1 = core.fmtc.bitdepth(clip=input, bits=32)
ref = core.bm3dcuda_rtc.BM3D(
                             clip=cut1, sigma=[1,1,1], block_step=8, device_id=0
                             )
cut2 = core.bm3dcuda_rtc.BM3D(
                              clip=cut1, ref=ref, sigma=[1,1,1], block_step=7, device_id=0
                              )
# sigma 每平面的降噪强度 device_id 双显卡设备注意修改适配
output = core.fmtc.bitdepth(clip=cut2, bits=16)

output.set_output()
