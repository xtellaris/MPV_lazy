
import vapoursynth as vs
core = vs.core

input = video_in

output = core.knlm.KNLMeansCL(
                              clip=input, d=1, a=2, s=3, h=2.4,
                              channels="Y", device_type="GPU", device_id=0
                              )
# d 时域半径（整数） a 空间域降噪区半径（整数） s 比较相似度时选取的邻域半径（整数） h 降噪强度（浮点）
# channels 处理通道 device_type 加速设备 device_id 双显卡平台注意修改适配独显/核显

output.set_output()
