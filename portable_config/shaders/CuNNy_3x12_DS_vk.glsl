// CuNNy 3x12 DS
// Copyright (c) 2024 cunnyplapper

// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3.0 of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this program.  If not, see <https://www.gnu.org/licenses/>.
/* ------------------------------------------------------------------- */


//!DESC [CuNNy_3x12_DS_vk] -in
//!HOOK LUMA
//!COMPUTE 24 8 8 8
//!BIND LUMA
//!SAVE in
//!WIDTH LUMA.w 3 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#ifdef GL_EXT_shader_explicit_arithmetic_types_float16
#	define V4 f16vec4
#	define M4 f16mat4
#	define F float16_t
#else
#	define V4 vec4
#	define M4 mat4
#	define F float
#endif
#define l0(x, y) F((LUMA_mul * texelFetch(LUMA_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(1, 1) + ivec2(0, 0), 0)).r)
shared F G[1][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(3, 1);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			G[0][ay][ax] = l0(x - 1, y - 1);
		}
	}
	barrier();
	F s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2;
	V4 r0, r1, r2;
	r0 = V4(0.0); r1 = V4(0.0); r2 = V4(0.0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2];
	r0 += V4(9.242e-03, 5.405e-02, -8.027e-03, -1.792e-03) * s0_0_0;
	r1 += V4(2.146e-01, 2.117e-02, 9.607e-03, 5.122e-01) * s0_0_0;
	r2 += V4(2.590e-02, 1.607e-02, 3.959e-02, -2.207e-02) * s0_0_0;
	r0 += V4(3.897e-02, 6.312e-01, 5.245e-02, -2.181e-02) * s0_0_1;
	r1 += V4(3.096e-01, -2.815e-02, 7.910e-01, -2.575e-01) * s0_0_1;
	r2 += V4(-3.155e-02, 3.093e-02, 2.800e-02, -2.180e-02) * s0_0_1;
	r0 += V4(-4.486e-02, 2.578e-01, -1.875e-02, 1.888e-02) * s0_0_2;
	r1 += V4(-2.958e-01, 8.667e-03, 2.939e-02, 1.303e-02) * s0_0_2;
	r2 += V4(-4.904e-02, 9.803e-04, -1.629e-01, 4.712e-02) * s0_0_2;
	r0 += V4(-8.122e-03, -2.034e-02, -2.885e-01, -6.289e-01) * s0_1_0;
	r1 += V4(2.096e-01, 8.889e-01, -5.048e-03, 2.571e-01) * s0_1_0;
	r2 += V4(-1.175e-01, -3.940e-01, 4.592e-03, -3.303e-02) * s0_1_0;
	r0 += V4(6.699e-01, -4.482e-01, 6.010e-01, -3.214e-01) * s0_1_1;
	r1 += V4(-5.934e-01, -8.770e-01, -7.918e-01, -4.172e-01) * s0_1_1;
	r2 += V4(5.332e-01, 8.929e-02, -9.917e-02, 6.465e-01) * s0_1_1;
	r0 += V4(-6.753e-01, -4.525e-01, -3.356e-01, 3.151e-02) * s0_1_2;
	r1 += V4(1.587e-01, -2.690e-02, -3.189e-02, -6.018e-02) * s0_1_2;
	r2 += V4(-1.970e-02, 3.283e-04, 2.681e-01, -7.587e-02) * s0_1_2;
	r0 += V4(4.430e-03, 8.503e-02, -1.681e-01, 8.827e-01) * s0_2_0;
	r1 += V4(-3.365e-01, 2.198e-02, -6.874e-03, 2.375e-02) * s0_2_0;
	r2 += V4(-5.959e-02, 6.566e-02, -1.639e-02, 1.082e-02) * s0_2_0;
	r0 += V4(6.428e-02, -1.675e-01, 2.710e-01, 9.530e-02) * s0_2_1;
	r1 += V4(1.213e-01, -1.731e-02, 7.868e-04, -8.179e-02) * s0_2_1;
	r2 += V4(-1.373e-01, 9.382e-03, 3.097e-04, -4.626e-02) * s0_2_1;
	r0 += V4(-6.446e-02, -1.605e-02, -9.870e-02, -4.767e-02) * s0_2_2;
	r1 += V4(2.065e-01, 5.110e-03, 3.665e-03, 3.926e-02) * s0_2_2;
	r2 += V4(-6.008e-03, 1.684e-03, 7.321e-02, 1.676e-02) * s0_2_2;
	r0 += V4(-2.008e-02, -2.226e-02, -8.131e-03, 3.776e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(-4.045e-03, 3.645e-03, 1.181e-03, 3.552e-02);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(5.778e-03, 1.699e-01, -2.702e-03, 2.111e-02);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), vec4(r2));
}

//!DESC [CuNNy_3x12_DS_vk] -conv1
//!HOOK LUMA
//!COMPUTE 24 8 8 8
//!BIND in
//!BIND LUMA
//!SAVE conv1
//!WIDTH LUMA.w 3 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
#define l0(x, y) (in_mul * texelFetch(in_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(0, 0), 0))
#define l1(x, y) (in_mul * texelFetch(in_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(1, 0), 0))
#define l2(x, y) (in_mul * texelFetch(in_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(2, 0), 0))
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[3][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(3, 1);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			vec4 v0 = l0(x - 1, y - 1) * 1.0000000e+00;
			vec4 v1 = l1(x - 1, y - 1) * 1.0000000e+00;
			vec4 v2 = l2(x - 1, y - 1) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
			G[2][ay][ax] = int(packSnorm4x8(v2));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0, r1, r2;
	vec4 f0, f1, f2;
	r0 = ivec4(0); r1 = ivec4(0); r2 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xFD070D22, 0x030FF421, 0xF6F2FF06, 0x0D06FD21);
	r1 = D(r1, s0_0_0, 0x050011FB, 0x02FF08FB, 0x0AF4013F, 0xF6FFF5E4);
	r2 = D(r2, s0_0_0, 0xFDFC3509, 0x0BEAFA7F, 0x04F0F600, 0xF80223FB);
	r0 = D(r0, s0_0_1, 0xF3E7F608, 0x140D03DA, 0xEB08FBCE, 0x3AFFF4D8);
	r1 = D(r1, s0_0_1, 0x12090918, 0x031A0805, 0xF8E70202, 0x1BFBD8E9);
	r2 = D(r2, s0_0_1, 0xE6FDEF21, 0x8513D41F, 0xF817F7F2, 0xEC330429);
	r0 = D(r0, s0_0_2, 0x0B02F4FF, 0x0A1902F1, 0x2D07F8F9, 0x27F8010A);
	r1 = D(r1, s0_0_2, 0xFB0AFE01, 0xF90A0101, 0xFAEF0002, 0x030BFDFA);
	r2 = D(r2, s0_0_2, 0x12E9070F, 0x2FD5120E, 0x060C0EFB, 0xC2230CED);
	r0 = D(r0, s0_1_0, 0x08140C53, 0xFDFC0007, 0x0A00CF7F, 0x07FBF7A7);
	r1 = D(r1, s0_1_0, 0xFF1BFA32, 0xFC34EABA, 0xDF49E3B9, 0xEE001320);
	r2 = D(r2, s0_1_0, 0x070106FA, 0x013E7F9C, 0xFD20160B, 0xF319131A);
	r0 = D(r0, s0_1_1, 0x22412AD1, 0x0A422109, 0xBC5F5E3A, 0x0526E219);
	r1 = D(r1, s0_1_1, 0x19320004, 0x2B22FCDD, 0xB502021C, 0xEE28F93D);
	r2 = D(r2, s0_1_1, 0xE901E4E7, 0xF0D8D2D4, 0x81F22113, 0x19F1EFE3);
	r0 = D(r0, s0_1_2, 0x08DEF524, 0xFCEC0A0D, 0xB5BCEB33, 0x081007EE);
	r1 = D(r1, s0_1_2, 0x08F3FF00, 0xF52802E8, 0xF7DCF916, 0xCAFAFF09);
	r2 = D(r2, s0_1_2, 0x9F2EF1EE, 0x1702FC04, 0xB612FFF5, 0x142B05E8);
	r0 = D(r0, s0_2_0, 0x020D07DA, 0x0807EC37, 0x04030FE5, 0x02F7F73E);
	r1 = D(r1, s0_2_0, 0x02FBEFE9, 0x06FBF210, 0x09D8FF2A, 0xFFFA020A);
	r2 = D(r2, s0_2_0, 0xFFF6E3B6, 0x0118FFD8, 0x02F2F129, 0xFE06FBF2);
	r0 = D(r0, s0_2_1, 0x0613FDCE, 0xF7FD01E4, 0x010AF2C6, 0xFEF3FCF3);
	r1 = D(r1, s0_2_1, 0xF8010020, 0xFC0DF6E7, 0x04E9F6EC, 0xF80C0B03);
	r2 = D(r2, s0_2_1, 0x070B0DE0, 0x06FFE219, 0xEF3112CE, 0x060DEE0D);
	r0 = D(r0, s0_2_2, 0x090606F6, 0xFA0B05F9, 0x08F4F708, 0x0301FE03);
	r1 = D(r1, s0_2_2, 0xF70508FA, 0xF8140AF4, 0x06290DEC, 0xFD12FCFF);
	r2 = D(r2, s0_2_2, 0x0DF80105, 0xFD2F01EB, 0xF209FBFB, 0xF11801F7);
	r0 = D(r0, s1_0_0, 0xFBF20F0A, 0x05070900, 0xFC040D00, 0x060EF5EB);
	r1 = D(r1, s1_0_0, 0x03F602FD, 0xFEFA08F6, 0xFCFE0405, 0xFF18F70F);
	r2 = D(r2, s1_0_0, 0xFBCD170D, 0x2B3424BC, 0xFFFC0724, 0x02DFF304);
	r0 = D(r0, s1_0_1, 0xFA0FDD02, 0x0508ED01, 0xF201ECE9, 0xFD05E0FC);
	r1 = D(r1, s1_0_1, 0x03F10205, 0xFFF2FDFF, 0xFCE7A124, 0xF61F1AFF);
	r2 = D(r2, s1_0_1, 0x00FCF413, 0xBFEC89D2, 0xEE051C1F, 0x0BF7FEE4);
	r0 = D(r0, s1_0_2, 0xF612F6F8, 0x06FF1AFC, 0x271732CD, 0x0A042F08);
	r1 = D(r1, s1_0_2, 0x03020AF6, 0x03010708, 0x0E0EF5FD, 0x03212BE1);
	r2 = D(r2, s1_0_2, 0x03FED60C, 0x150CB9FD, 0x080813F9, 0x01F1DB02);
	r0 = D(r0, s1_1_0, 0xF31B0A1A, 0xDEFF0E20, 0xFB2001E4, 0x0DE0F308);
	r1 = D(r1, s1_1_0, 0xF40A0314, 0xF3000616, 0xFC818128, 0x09E8ED13);
	r2 = D(r2, s1_1_0, 0xDB1913EE, 0xB6FCDCE2, 0xEAF10816, 0x10F9F7F4);
	r0 = D(r0, s1_1_1, 0x0EC9D616, 0xF6FE6000, 0x2981A4FC, 0x0D0317E4);
	r1 = D(r1, s1_1_1, 0x0C282503, 0x0A1C7FED, 0x42E38103, 0xF67F0002);
	r2 = D(r2, s1_1_1, 0x1CEF58FE, 0x620157D2, 0xFD81811F, 0x17F7F11D);
	r0 = D(r0, s1_1_2, 0xFCF2DA08, 0xEFEC0807, 0xEB0795E9, 0xED2319FE);
	r1 = D(r1, s1_1_2, 0xE8FC1101, 0xF40F4F06, 0x040CED07, 0xC611E8EB);
	r2 = D(r2, s1_1_2, 0x282900FF, 0xF41949EC, 0xF402EB13, 0xF01F63FF);
	r0 = D(r0, s1_2_0, 0xF12F0EF6, 0xF4301206, 0xF17F0DE0, 0x120BF7F0);
	r1 = D(r1, s1_2_0, 0xF30C0FFE, 0xFBF510FB, 0x0BEB133A, 0x1BF300FF);
	r2 = D(r2, s1_2_0, 0x0748FCEE, 0x1C87E51E, 0x12FF0410, 0x06D7FCF4);
	r0 = D(r0, s1_2_1, 0x26B01A26, 0xF3ECEB15, 0xF31030EC, 0xF346D5FD);
	r1 = D(r1, s1_2_1, 0xFC131111, 0x047EF108, 0x1B291F20, 0xF325ED00);
	r2 = D(r2, s1_2_1, 0x7F35E402, 0x290F07CE, 0x4D81DEF2, 0xF9F61D03);
	r0 = D(r0, s1_2_2, 0x32EE140A, 0x03F413FE, 0x37F405FA, 0xF02109FA);
	r1 = D(r1, s1_2_2, 0x05F2EE13, 0xBB023201, 0xE3FD2E18, 0x33C7E4F5);
	r2 = D(r2, s1_2_2, 0xFB160D00, 0xDD2602FD, 0x31F21209, 0xEA04050F);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xEDEC14C4, 0xDAF9FFF8, 0xF3E71238, 0x0B02E12E);
	r1 = D(r1, s0_0_0, 0xE80CF5FE, 0x152CFBFB, 0xFF101D12, 0xDADC0A1B);
	r2 = D(r2, s0_0_0, 0xECF318F5, 0xF5371E87, 0xFDFC15F9, 0x0C1709D7);
	r0 = D(r0, s0_0_1, 0xF2F2040F, 0xF700FCDC, 0x040B031E, 0xDFF7E60C);
	r1 = D(r1, s0_0_1, 0xF5D0F619, 0xDB0DFF07, 0xF8EACF13, 0xC62702A2);
	r2 = D(r2, s0_0_1, 0x0F0E3723, 0xF8071A0F, 0x03EF0DF0, 0xED0BF9F2);
	r0 = D(r0, s0_0_2, 0x162AEB00, 0xF810FCFC, 0xF7FCDBF7, 0xCEE806F3);
	r1 = D(r1, s0_0_2, 0x28FF0420, 0xFB0511D6, 0xF0051002, 0xEC15D0E3);
	r2 = D(r2, s0_0_2, 0x0000F5E6, 0xEA09E428, 0x013FCCF8, 0x1B11FAE2);
	r0 = D(r0, s0_1_0, 0x5FF6E6FF, 0xAA0328D9, 0xEA39E7E9, 0xF44508FF);
	r1 = D(r1, s0_1_0, 0x03FE10F5, 0x3507F41F, 0x6DD8CF3C, 0xED8F011B);
	r2 = D(r2, s0_1_0, 0x2E03E21E, 0x4881D2DF, 0x231AFE14, 0x1FE8F222);
	r0 = D(r0, s0_1_1, 0x0DF017E9, 0x7FF2D03B, 0x3B0EF4F8, 0x5AEE20E2);
	r1 = D(r1, s0_1_1, 0x9A42FFFD, 0x06FD07B5, 0xDC1F4FAA, 0x2C23292B);
	r2 = D(r2, s0_1_1, 0x0F190C0E, 0x1A15FEF2, 0xEDD402F5, 0x8103FE32);
	r0 = D(r0, s0_1_2, 0xA30F1D37, 0x0217FD0E, 0x01375A00, 0x2D023FDB);
	r1 = D(r1, s0_1_2, 0x5FF9D2D7, 0x02EAEADF, 0xE70225F8, 0x2022A311);
	r2 = D(r2, s0_1_2, 0xF0EB03C7, 0xE6F10A1D, 0xDEF6E813, 0x1414F2EF);
	r0 = D(r0, s0_2_0, 0x0B10F404, 0xEA10FDEF, 0xFAA40EEE, 0xE2F50A1C);
	r1 = D(r1, s0_2_0, 0xF8EFF4FE, 0xDB12EAFC, 0x060CE0E1, 0x2C1AEFF8);
	r2 = D(r2, s0_2_0, 0x0CBFE928, 0x14E5F4F5, 0x25D3E6F9, 0x100CE8EF);
	r0 = D(r0, s0_2_1, 0xF6100735, 0x26DDFF07, 0xF0F8EAED, 0x00E5E6EC);
	r1 = D(r1, s0_2_1, 0xEBF0031D, 0x01FA0A1D, 0xFEC519E1, 0xF31BF8F0);
	r2 = D(r2, s0_2_1, 0xDF3B0FF3, 0xEC250912, 0xF5490BF9, 0xF8E72803);
	r0 = D(r0, s0_2_2, 0xFAF2F8D5, 0x02F8130A, 0x0DFD3528, 0x010C11F9);
	r1 = D(r1, s0_2_2, 0x12F000E0, 0x0BFB0AF0, 0xFBFBDF34, 0x010520FB);
	r2 = D(r2, s0_2_2, 0xFFFF0DDD, 0xEB371715, 0xFEDD4903, 0x1409DF11);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-2.156e-02, 2.216e-02, -1.231e-01, -9.017e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(1.083e-01, 5.311e-02, -3.417e-02, 1.144e-01);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-1.265e-01, -1.696e-02, -1.687e-02, 9.839e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_3x12_DS_vk] -conv2
//!HOOK LUMA
//!COMPUTE 24 8 8 8
//!BIND conv1
//!BIND LUMA
//!SAVE conv2
//!WIDTH LUMA.w 3 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
#define l0(x, y) (conv1_mul * texelFetch(conv1_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(0, 0), 0))
#define l1(x, y) (conv1_mul * texelFetch(conv1_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(1, 0), 0))
#define l2(x, y) (conv1_mul * texelFetch(conv1_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(2, 0), 0))
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[3][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(3, 1);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			vec4 v0 = l0(x - 1, y - 1) * 1.0000000e+00;
			vec4 v1 = l1(x - 1, y - 1) * 1.0000000e+00;
			vec4 v2 = l2(x - 1, y - 1) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
			G[2][ay][ax] = int(packSnorm4x8(v2));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0, r1, r2;
	vec4 f0, f1, f2;
	r0 = ivec4(0); r1 = ivec4(0); r2 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x0DF80514, 0xFC040811, 0x1D0BF40A, 0x1BFF00F8);
	r1 = D(r1, s0_0_0, 0x1203FF04, 0x191E0CFF, 0x051C08F9, 0xFCFDFEFF);
	r2 = D(r2, s0_0_0, 0x10E1FEE8, 0xEFF205E7, 0x18E8FAEC, 0x1411EFF9);
	r0 = D(r0, s0_0_1, 0x0C05EE1F, 0xF9FD00F4, 0x030C01F4, 0xFD0208F4);
	r1 = D(r1, s0_0_1, 0x0600EFFE, 0xF221EC0E, 0x021E2AE3, 0x21010203);
	r2 = D(r2, s0_0_1, 0xE1F104D3, 0x03F70FED, 0x03D0F5D3, 0x0B20F503);
	r0 = D(r0, s0_0_2, 0x030FF3F3, 0xF4FF16E7, 0xF9070BF3, 0xFF0107F8);
	r1 = D(r1, s0_0_2, 0xF508FDFF, 0xF30D090E, 0xF6140315, 0xF50910E3);
	r2 = D(r2, s0_0_2, 0x08C90AE8, 0x0F04FB0E, 0x0BEC05FB, 0xED091004);
	r0 = D(r0, s0_1_0, 0xDCEC1A28, 0xFF09F90A, 0x6230002A, 0x15EB04F8);
	r1 = D(r1, s0_1_0, 0x13EA0B15, 0xEFE7CBEC, 0xFB10D9EB, 0xF2F9FEF7);
	r2 = D(r2, s0_1_0, 0xE5DA1CDC, 0xEFFA35EF, 0x00E418F4, 0x231B0803);
	r0 = D(r0, s0_1_1, 0xF904D141, 0xA4FCD2FF, 0x0DFF991E, 0xD2EB0D05);
	r1 = D(r1, s0_1_1, 0xEAFCEF18, 0xC4FE150A, 0x2AFEB9F4, 0xFCF0EA03);
	r2 = D(r2, s0_1_1, 0x14DE649A, 0xEFEB0904, 0x28D361EF, 0xF0FE14D1);
	r0 = D(r0, s0_1_2, 0x1B02F7FC, 0x00FC40E3, 0xFFFF12F7, 0x00F705F5);
	r1 = D(r1, s0_1_2, 0xF51919E0, 0x141AFBF6, 0xFB2C06E3, 0xF9F84CED);
	r2 = D(r2, s0_1_2, 0x0DD1EFF6, 0x1CFF0001, 0x0DE31704, 0xFA1DFBE8);
	r0 = D(r0, s0_2_0, 0xE8F9100D, 0x0605F8FB, 0x0114E2F5, 0x12F20FF8);
	r1 = D(r1, s0_2_0, 0x02F71402, 0x3AF018E1, 0x230FEC01, 0x15FC0400);
	r2 = D(r2, s0_2_0, 0xECD43AFE, 0xDEFDFDEE, 0x16EA1EF4, 0xFA1BDF07);
	r0 = D(r0, s0_2_1, 0x1211001F, 0x08FA21FC, 0xDF19F400, 0x16F60503);
	r1 = D(r1, s0_2_1, 0x46F41805, 0x23DE1AF9, 0x19F7FC05, 0x11F412FF);
	r2 = D(r2, s0_2_1, 0x31E408E9, 0xE4F418FB, 0x04080314, 0x1C13E426);
	r0 = D(r0, s0_2_2, 0x16F3160E, 0x0BE71CFF, 0xF008F4F9, 0xFFFC10F9);
	r1 = D(r1, s0_2_2, 0x0CFE26FE, 0xFE1410EF, 0x0505FEFC, 0x08FA14FF);
	r2 = D(r2, s0_2_2, 0xF6E429F3, 0x1416F8FA, 0x0012F603, 0x0311EF06);
	r0 = D(r0, s1_0_0, 0xFCF6F7F6, 0x00FB0EF4, 0xE90A1FFD, 0xFE17F0FA);
	r1 = D(r1, s1_0_0, 0x0207F8FE, 0x050AE0EE, 0xF30B0202, 0xFEFDF914);
	r2 = D(r2, s1_0_0, 0x091D04F7, 0x0401140B, 0xFD0CF709, 0x0DE5E216);
	r0 = D(r0, s1_0_1, 0x11F5F7FF, 0x0BFDF909, 0x0719120E, 0xFF1C03E9);
	r1 = D(r1, s1_0_1, 0xFF08FD02, 0xE1F8E4DA, 0xDF0ACE1D, 0xFCFD01F4);
	r2 = D(r2, s1_0_1, 0x101D0FD6, 0xF00214F2, 0x182530F2, 0xEACFD1FB);
	r0 = D(r0, s1_0_2, 0xFDF2F606, 0xFC2CF7FA, 0xFE11F4F5, 0xF70EF307);
	r1 = D(r1, s1_0_2, 0xFDF9F7FD, 0x07F1ED12, 0x090BE207, 0xFCF9E502);
	r2 = D(r2, s1_0_2, 0x0020F80D, 0x01FED5F7, 0x072BF508, 0x0112F804);
	r0 = D(r0, s1_1_0, 0x18E6FCB3, 0xFFF7E9E9, 0xFE29B80D, 0xFD0613F4);
	r1 = D(r1, s1_1_0, 0xFEFAF9D6, 0xE8021B1B, 0xEA111328, 0xFDFC0503);
	r2 = D(r2, s1_1_0, 0x021F0814, 0xDEE828C1, 0x051E0118, 0xF4CE3FD7);
	r0 = D(r0, s1_1_1, 0xFAE4C652, 0x2130F00A, 0x057F3CE0, 0x04EF1F0B);
	r1 = D(r1, s1_1_1, 0xFEC92C19, 0xF2A165F6, 0x47F33DFD, 0xF8E8E947);
	r2 = D(r2, s1_1_1, 0xEC38C7B1, 0xE5D31F36, 0xB3FDF51F, 0xEEEB300D);
	r0 = D(r0, s1_1_2, 0x0CB301E4, 0x07E911E1, 0xFA3C16FF, 0x060003F8);
	r1 = D(r1, s1_1_2, 0xFEBB0000, 0x04C7EBDF, 0xFDBF0ADA, 0x03EEF615);
	r2 = D(r2, s1_1_2, 0xFA30E3F6, 0x09B5D9E7, 0xFA579CDD, 0xF4F802E9);
	r0 = D(r0, s1_2_0, 0x03F4F1FC, 0xF601FD1B, 0xE5160913, 0x040AEE0C);
	r1 = D(r1, s1_2_0, 0x0B02F1F0, 0x1307DE16, 0xF5FCD334, 0x01FFFA09);
	r2 = D(r2, s1_2_0, 0x120B0FC5, 0x090E15D4, 0x060C15D7, 0x20FEFF09);
	r0 = D(r0, s1_2_1, 0x07EAE105, 0xF70F05EB, 0x061BF6EE, 0xFDFEEDFA);
	r1 = D(r1, s1_2_1, 0x14F6ED0A, 0xF7B1F613, 0xFEE4FF14, 0x0EF8EFF9);
	r2 = D(r2, s1_2_1, 0xD315FB10, 0xE4CF1B16, 0x1418D2CA, 0x241214D5);
	r0 = D(r0, s1_2_2, 0x15DD0DFB, 0x12FDFCF3, 0xF51608E3, 0x04F8F8F8);
	r1 = D(r1, s1_2_2, 0x04D6F5FB, 0xFAF5FAFB, 0xFCFC09DE, 0x04F6FAF7);
	r2 = D(r2, s1_2_2, 0x0520E7F9, 0xF5FBE0F3, 0x0218E921, 0x00E126EE);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x12F3F805, 0xF6FDFAF5, 0x172504A3, 0x1A05F613);
	r1 = D(r1, s0_0_0, 0x180700FE, 0x29010DFC, 0xFD0C06FB, 0x03020200);
	r2 = D(r2, s0_0_0, 0x19ECFA16, 0x1014FF06, 0x0C21F015, 0x30DB0203);
	r0 = D(r0, s0_0_1, 0xF6F3EC24, 0x09F8F9FF, 0x01070FFC, 0x0BFB011C);
	r1 = D(r1, s0_0_1, 0x06F0010C, 0x11CCFEF7, 0xD7FC0DFC, 0xF9EF000F);
	r2 = D(r2, s0_0_1, 0x25170314, 0x0FD512F6, 0x19EDFB17, 0x06D00613);
	r0 = D(r0, s0_0_2, 0x0AFAFA04, 0x24EBEE07, 0x18FE0FFE, 0x02F6FD0C);
	r1 = D(r1, s0_0_2, 0x12E301F6, 0xF5F8EF06, 0x041C08E8, 0x02020F22);
	r2 = D(r2, s0_0_2, 0x0A04011D, 0x01180AFE, 0x041E0610, 0x1DEB0FEE);
	r0 = D(r0, s0_1_0, 0x07F90702, 0x2FFCF30C, 0x043A08DE, 0xE2060203);
	r1 = D(r1, s0_1_0, 0x1C0401FF, 0x0813EBFC, 0xFFF3EEF5, 0x0100FA00);
	r2 = D(r2, s0_1_0, 0xCFDBE80F, 0xEDF71FFD, 0xDE260806, 0xA9F42BEE);
	r0 = D(r0, s0_1_1, 0x240FD201, 0x21E6E107, 0x050B2ABE, 0x03EEFF27);
	r1 = D(r1, s0_1_1, 0xE6DFF812, 0xFB09013E, 0xD3F206F7, 0xEE140708);
	r2 = D(r2, s0_1_1, 0x53F50454, 0xF8122E06, 0xB2CE3D21, 0xF1F327ED);
	r0 = D(r0, s0_1_2, 0xFAFEE2FD, 0x0DFCF715, 0x160307F6, 0xF40AF10F);
	r1 = D(r1, s0_1_2, 0xF9030E21, 0xE4F8E90F, 0x27F505FD, 0x0A02F719);
	r2 = D(r2, s0_1_2, 0xE928FF1E, 0x250A01F4, 0x13DD1610, 0x0CEF0AFB);
	r0 = D(r0, s0_2_0, 0xE9EEFB04, 0xFB12EDFF, 0xF321E7EF, 0x1506F809);
	r1 = D(r1, s0_2_0, 0x0A0503FE, 0x22F8FA0A, 0x180E0409, 0x08F90403);
	r2 = D(r2, s0_2_0, 0x0B05F719, 0x03012703, 0x2D12EF00, 0xD72F0FED);
	r0 = D(r0, s0_2_1, 0x03F6CF0F, 0x17E7FA0B, 0x033FFBEF, 0x0BF3080B);
	r1 = D(r1, s0_2_1, 0xF9EB0A07, 0xDAAC6006, 0x15BB21FE, 0x0EF00206);
	r2 = D(r2, s0_2_1, 0x0418F820, 0xF90D4010, 0xE145ED0C, 0xF814EAEA);
	r0 = D(r0, s0_2_2, 0xFEDED709, 0x12E10517, 0x03031A01, 0x01010008);
	r1 = D(r1, s0_2_2, 0x07030C06, 0xFB2CEBF2, 0x19F21EFC, 0x03F3FD06);
	r2 = D(r2, s0_2_2, 0x0B010002, 0x0B18E5FA, 0xE25DD3FF, 0xFC1809F7);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(4.843e-02, -6.295e-03, -6.277e-02, -1.083e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(3.202e-03, -2.203e-02, -2.180e-02, 5.087e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(1.529e-02, -2.319e-02, -1.844e-02, -4.064e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_3x12_DS_vk] -conv3
//!HOOK LUMA
//!COMPUTE 24 8 8 8
//!BIND conv2
//!BIND LUMA
//!SAVE conv3
//!WIDTH LUMA.w 3 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
#define l0(x, y) (conv2_mul * texelFetch(conv2_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(0, 0), 0))
#define l1(x, y) (conv2_mul * texelFetch(conv2_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(1, 0), 0))
#define l2(x, y) (conv2_mul * texelFetch(conv2_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(2, 0), 0))
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[3][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(3, 1);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			vec4 v0 = l0(x - 1, y - 1) * 1.0000000e+00;
			vec4 v1 = l1(x - 1, y - 1) * 1.0000000e+00;
			vec4 v2 = l2(x - 1, y - 1) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
			G[2][ay][ax] = int(packSnorm4x8(v2));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0, r1, r2;
	vec4 f0, f1, f2;
	r0 = ivec4(0); r1 = ivec4(0); r2 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x01030201, 0x05F70DF5, 0xFB01FE01, 0x0CFE06FC);
	r1 = D(r1, s0_0_0, 0xFA04FB01, 0xF4000100, 0xEC08F406, 0xFCFB0301);
	r2 = D(r2, s0_0_0, 0xFB0B0109, 0xF806FB0A, 0x01FEFD0B, 0xE405F60C);
	r0 = D(r0, s0_0_1, 0xFE00FAFF, 0x0D0921F6, 0xFA08FA08, 0xEA0CEB07);
	r1 = D(r1, s0_0_1, 0x0504FD0A, 0xFFFB0BFF, 0x24F01116, 0xFF030C07);
	r2 = D(r2, s0_0_1, 0x1AFC0CF2, 0x00FEFD05, 0xF8F90806, 0xF0FED920);
	r0 = D(r0, s0_0_2, 0x00010000, 0xFDE5F10D, 0x00FBFDFF, 0x1DF4FC0A);
	r1 = D(r1, s0_0_2, 0xFBFFFE03, 0x08F8F108, 0x03ECFF06, 0xFCF0FF0B);
	r2 = D(r2, s0_0_2, 0xFB030107, 0x010200FF, 0x00D8FD10, 0xEDF4F517);
	r0 = D(r0, s0_1_0, 0xEF04FD10, 0xFFFE04F7, 0xF9050009, 0x03FFF8FB);
	r1 = D(r1, s0_1_0, 0xF005020A, 0x0FFFFC05, 0x0C0304ED, 0x08FDE707);
	r2 = D(r2, s0_1_0, 0xE10B130B, 0x07020BF7, 0x07FFFA03, 0x290100F4);
	r0 = D(r0, s0_1_1, 0x1BE0030D, 0x1E0E28D2, 0x14EE1EE8, 0x39040BC7);
	r1 = D(r1, s0_1_1, 0x2ECFF40C, 0x0BF211F0, 0x24DECCF3, 0x220B17CE);
	r2 = D(r2, s0_1_1, 0x32DD1EE2, 0xF6C9F318, 0x170F07CD, 0x25BDC1B5);
	r0 = D(r0, s0_1_2, 0x01F803FE, 0xE2BBF510, 0xCDEAEF0E, 0x36D3EB09);
	r1 = D(r1, s0_1_2, 0xFDF4FA04, 0x25EEF604, 0xE8C2F604, 0x02E3FEF4);
	r2 = D(r2, s0_1_2, 0xEFE1F6FB, 0xFCF1FEFB, 0xE5DFF0E2, 0x109B06E2);
	r0 = D(r0, s0_2_0, 0x1709EDD9, 0xFEFAF908, 0x11FD0EFB, 0x00FDFC03);
	r1 = D(r1, s0_2_0, 0x0808F2E3, 0xFB000406, 0x020201FD, 0x0CFEF900);
	r2 = D(r2, s0_2_0, 0x02FF1510, 0x0706F4E9, 0x0AFE0300, 0xF200FF05);
	r0 = D(r0, s0_2_1, 0x10A4DE0E, 0x1700010B, 0xEBFBE6F1, 0x0C06FAFA);
	r1 = D(r1, s0_2_1, 0x0DFEE9FA, 0xF201FE04, 0x0306FFFF, 0xFA0602F3);
	r2 = D(r2, s0_2_1, 0x08E1F281, 0xFAF2EB06, 0xFDF812FE, 0xF6090B0D);
	r0 = D(r0, s0_2_2, 0xF9F3FB01, 0xE208F8F5, 0x14EBFAFB, 0xEEE8F907);
	r1 = D(r1, s0_2_2, 0xEEEEFA09, 0xEDF7F5FD, 0x02070003, 0x81818181);
	r2 = D(r2, s0_2_2, 0xE8A511D6, 0x03FCFE01, 0x81818181, 0xF6E7F011);
	r0 = D(r0, s1_0_0, 0xFEFE0101, 0xFA0FFBF8, 0xFEF804F5, 0x0AF7FB00);
	r1 = D(r1, s1_0_0, 0xFC04FB09, 0xFE0E0408, 0xF316F527, 0xFC0302F7);
	r2 = D(r2, s1_0_0, 0xEF06FD08, 0xF404FD02, 0xF900FDFE, 0xE605FDF8);
	r0 = D(r0, s1_0_1, 0x03FCFF04, 0x0FFAE128, 0x02F2FF06, 0xF1F1F621);
	r1 = D(r1, s1_0_1, 0xFDFCF702, 0xF92BF415, 0xE914EE00, 0xF016F106);
	r2 = D(r2, s1_0_1, 0x0711F9FC, 0x0102F7FF, 0xF620F313, 0xFAE2FD09);
	r0 = D(r0, s1_0_2, 0xFFFE0100, 0xEFF5EFE8, 0xF8F6FA03, 0xF5FBEFFF);
	r1 = D(r1, s1_0_2, 0xFDFFFA00, 0xF502FC0A, 0xFFFCF705, 0xFA0EF201);
	r2 = D(r2, s1_0_2, 0xFD07F60C, 0xFFFDFE01, 0x0407FB09, 0xFF0A1106);
	r0 = D(r0, s1_1_0, 0xE92BF320, 0x041BF5F3, 0xFDEAFF06, 0x0606FFF9);
	r1 = D(r1, s1_1_0, 0xF501F434, 0x050BFCF7, 0x04D8F60F, 0x030202FD);
	r2 = D(r2, s1_1_0, 0xF2FF011C, 0x0A0BE941, 0x11F9F8FF, 0x4905F00E);
	r0 = D(r0, s1_1_1, 0xFC09EE06, 0x16B5E431, 0x3F0AEF1C, 0xF307EB1C);
	r1 = D(r1, s1_1_1, 0x0620F320, 0x50FFECF2, 0x20F9DA23, 0x2110E432);
	r2 = D(r2, s1_1_1, 0x032FE0DE, 0x020AF70E, 0x0CFBE033, 0x2144BF19);
	r0 = D(r0, s1_1_2, 0x0000FE02, 0x1512E6EB, 0xFEF3ED28, 0x1E14E2F6);
	r1 = D(r1, s1_1_2, 0x07FBF40E, 0xFA22F7E8, 0xFF02F50D, 0xF00DE8F4);
	r2 = D(r2, s1_1_2, 0xF6F5F61F, 0x02FAFF0A, 0xEEF4F910, 0xE612EA15);
	r0 = D(r0, s1_2_0, 0x17BAED26, 0xF80200FE, 0x06FAF804, 0xF30DFC05);
	r1 = D(r1, s1_2_0, 0x05EFF217, 0xF0FD03FD, 0x0101FE03, 0xFEFCFF06);
	r2 = D(r2, s1_2_0, 0x02E008F5, 0x02E6F413, 0xFDFAFA0D, 0xDA0A0200);
	r0 = D(r0, s1_2_1, 0x0620DD06, 0xEBF3FBFB, 0x31F7F302, 0x0AE6F706);
	r1 = D(r1, s1_2_1, 0xEFF9E022, 0xEFF50609, 0xFB000300, 0xDFF5F519);
	r2 = D(r2, s1_2_1, 0x4620CF0A, 0xF90AEB18, 0xBBFAFEF8, 0xE2E20A11);
	r0 = D(r0, s1_2_2, 0xFCF8FF06, 0x1B030801, 0xE108F912, 0x00FD04FE);
	r1 = D(r1, s1_2_2, 0xF701FE08, 0x1B0BFFFD, 0xFC030004, 0x81818181);
	r2 = D(r2, s1_2_2, 0xC9C4FF41, 0xF7FEFD02, 0x8181D581, 0x170EF2F0);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x00FF0005, 0xFA0511ED, 0xFD0100FE, 0xF4FDFEF9);
	r1 = D(r1, s0_0_0, 0x0604FF01, 0x0B03F900, 0x04FAF40D, 0x050AFBF6);
	r2 = D(r2, s0_0_0, 0xFC0AF5FE, 0x0203020D, 0x05FFFBFE, 0x141107FB);
	r0 = D(r0, s0_0_1, 0xFFFD0406, 0x0BDAE614, 0x01F6FE12, 0xF0F4EE0E);
	r1 = D(r1, s0_0_1, 0xFBF50710, 0x01FE08F4, 0xD8E51DF1, 0x09F30C1E);
	r2 = D(r2, s0_0_1, 0x08F006FF, 0x07FD04FD, 0xFCF90417, 0x15FBE726);
	r0 = D(r0, s0_0_2, 0xFF01FC04, 0xEC0731D8, 0xF903FA08, 0xF0F509FB);
	r1 = D(r1, s0_0_2, 0xFC0208FD, 0x03FDF003, 0x0705EAF6, 0xFEF703F1);
	r2 = D(r2, s0_0_2, 0xEF0CFE04, 0xFC010007, 0xB6FFF0F0, 0xFAEF0F2B);
	r0 = D(r0, s0_1_0, 0x05E9FA16, 0x110810FC, 0xFEFFF80A, 0xF8FB05FE);
	r1 = D(r1, s0_1_0, 0x02DFF012, 0xFFF7FDFF, 0xF201F8EF, 0xFDF301F6);
	r2 = D(r2, s0_1_0, 0xFE0BF60D, 0x0ED9E603, 0xFFFCFEFD, 0x06DBF3DE);
	r0 = D(r0, s0_1_1, 0xE5F6F9D8, 0xEBEAF2F3, 0xEBE80AE9, 0xE6EDEDE6);
	r1 = D(r1, s0_1_1, 0xF0EE2ABF, 0x11EC09F5, 0x321513FE, 0x20DEEC12);
	r2 = D(r2, s0_1_1, 0xF1CF2DB8, 0xC90A06E3, 0x21F9DBFF, 0x1FBE2998);
	r0 = D(r0, s0_1_2, 0x05000005, 0x0E023EE5, 0xE20FD4F7, 0xF015F1F3);
	r1 = D(r1, s0_1_2, 0xCB0BD318, 0xF0F3F1EB, 0x1605F717, 0xCEFF43FF);
	r2 = D(r2, s0_1_2, 0xEA040F30, 0xFB01000C, 0xE8FF5516, 0x0109C2D4);
	r0 = D(r0, s0_2_0, 0xF906E9E2, 0x07000206, 0xF601F9FD, 0xFD0AFEFF);
	r1 = D(r1, s0_2_0, 0xF109F4F3, 0xFF0400FB, 0x0001FD00, 0xFDF6F904);
	r2 = D(r2, s0_2_0, 0xF9F6F215, 0xF010F7F4, 0xFBF5F90E, 0x001002F7);
	r0 = D(r0, s0_2_1, 0x420D0519, 0xF208FAF8, 0x03170BF3, 0xFA090402);
	r1 = D(r1, s0_2_1, 0x14080A1A, 0xF4FFFBFC, 0xFAFCFDFD, 0xF90A04F9);
	r2 = D(r2, s0_2_1, 0x15022DB6, 0x1F000111, 0xDC1E07F2, 0xE01EDD16);
	r0 = D(r0, s0_2_2, 0x00000001, 0x01050E00, 0x0706FE09, 0x0EF7030D);
	r1 = D(r1, s0_2_2, 0x19FB06FC, 0x1A050505, 0xF60002FD, 0xDB818181);
	r2 = D(r2, s0_2_2, 0xE2F4F300, 0x0501F9FE, 0x81818181, 0x2C0D0D0B);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.420e-02, -3.538e-02, -4.668e-02, -9.446e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-1.163e-02, -3.772e-02, -1.090e-02, -1.666e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-2.397e-02, -1.383e-02, -2.598e-03, -3.466e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_3x12_DS_vk] -out-shuffle
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv3
//!BIND LUMA
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
//!COMPONENTS 1
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#ifdef GL_EXT_shader_explicit_arithmetic_types_float16
#	define V4 f16vec4
#	define M4 f16mat4
#	define F float16_t
#else
#	define V4 vec4
#	define M4 mat4
#	define F float
#endif
#define l0(x, y) V4((conv3_mul * texelFetch(conv3_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(0, 0), 0)))
#define l1(x, y) V4((conv3_mul * texelFetch(conv3_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(1, 0), 0)))
#define l2(x, y) V4((conv3_mul * texelFetch(conv3_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(2, 0), 0)))
shared V4 G[3][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(2, 2);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			G[0][ay][ax] = l0(x - 1, y - 1);
			G[1][ay][ax] = l1(x - 1, y - 1);
			G[2][ay][ax] = l2(x - 1, y - 1);
		}
	}
	barrier();
	V4 s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	V4 r0;
	r0 = V4(0.0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 += M4(-1.541e-02, 3.217e-03, -1.391e-03, -3.528e-03, -2.070e-02, -8.758e-04, -1.258e-03, 5.599e-03, 7.946e-02, -4.662e-03, 2.045e-02, -5.268e-03, -6.565e-02, -2.679e-02, 1.265e-03, 8.283e-03) * s0_0_0;
	r0 += M4(4.359e-02, 2.562e-02, 2.976e-02, -3.636e-03, 1.877e-02, -1.934e-03, -8.835e-03, -1.351e-02, -7.967e-02, 1.679e-01, 5.090e-02, 8.472e-02, -3.712e-02, -1.028e-01, -6.726e-03, -1.777e-02) * s0_0_1;
	r0 += M4(3.235e-02, -5.925e-01, 1.032e-01, 1.665e-01, -3.558e-03, 1.102e-02, 9.785e-04, -1.828e-03, 5.257e-03, -9.497e-02, 1.052e-02, -4.772e-02, -1.002e-02, 2.877e-02, -4.835e-03, 1.416e-02) * s0_0_2;
	r0 += M4(1.042e-03, -1.219e-03, 6.203e-03, -3.924e-03, 6.714e-02, 1.607e-02, 1.956e-02, 6.703e-04, 2.850e-02, 2.935e-03, 9.106e-02, 2.558e-03, 5.950e-02, 4.384e-03, -1.978e-01, 2.422e-03) * s0_1_0;
	r0 += M4(4.143e-03, 1.405e-02, 4.529e-02, 1.768e-04, 1.538e-01, -3.818e-01, 1.062e-01, -7.041e-02, -3.958e-02, -3.943e-02, -2.672e-01, 8.995e-02, 2.310e-01, 1.958e-01, 3.059e-02, -3.759e-01) * s0_1_1;
	r0 += M4(-3.161e-02, -1.030e-03, 3.455e-02, 1.204e-01, -8.563e-03, 6.753e-02, -1.056e-02, 4.920e-02, -2.808e-03, -5.145e-04, -9.521e-03, -5.444e-02, -6.121e-03, 5.286e-02, 3.611e-03, 5.653e-02) * s0_1_2;
	r0 += M4(-4.772e-04, -7.187e-04, 6.169e-04, 6.542e-04, 4.005e-03, 2.349e-03, 4.944e-02, -5.001e-03, 4.973e-03, 3.519e-03, 2.967e-03, -5.446e-03, -3.968e-03, -3.474e-03, 4.324e-02, 3.875e-03) * s0_2_0;
	r0 += M4(1.033e-03, 1.588e-04, 1.781e-03, -3.376e-03, -3.715e-03, 4.348e-04, 9.985e-02, -1.880e-01, -3.154e-03, 3.528e-03, 2.167e-02, -4.468e-03, -1.187e-02, -1.509e-03, 6.042e-02, 8.699e-02) * s0_2_1;
	r0 += M4(-4.396e-04, 4.426e-04, -1.698e-03, 1.804e-03, -3.656e-03, 4.394e-03, -6.901e-03, 3.552e-02, -2.147e-03, -1.589e-03, 7.180e-04, -4.092e-04, 3.520e-03, -5.183e-03, -5.130e-03, 9.977e-03) * s0_2_2;
	r0 += M4(-1.777e-02, 5.188e-03, -1.335e-02, 1.436e-03, -2.537e-02, 7.405e-03, 8.656e-03, 8.484e-03, 8.194e-03, 9.867e-04, -2.035e-03, 3.172e-04, -1.041e-01, 4.594e-02, -1.295e-02, 3.045e-03) * s1_0_0;
	r0 += M4(8.468e-02, -4.270e-03, 7.248e-03, -6.274e-02, -1.764e-02, -5.741e-02, 1.676e-03, 7.851e-04, 7.739e-02, 5.382e-02, -9.653e-03, -1.376e-02, 1.388e-01, -4.169e-01, 5.380e-02, 7.851e-02) * s1_0_1;
	r0 += M4(-2.586e-03, 9.886e-02, 1.282e-03, 2.538e-02, 4.253e-03, 2.935e-03, 2.034e-04, 6.530e-05, 1.728e-02, 5.247e-02, -1.580e-03, -2.223e-04, -1.845e-02, 1.482e-02, -4.661e-03, 2.004e-02) * s1_0_2;
	r0 += M4(9.468e-03, 1.217e-03, 1.537e-03, -8.433e-03, 1.430e-01, 1.197e-02, -4.726e-03, 2.514e-02, 5.615e-03, -7.635e-03, 2.093e-02, 5.773e-03, 1.278e-01, 6.413e-02, -1.655e-01, 8.739e-02) * s1_1_0;
	r0 += M4(7.105e-02, 1.571e-02, -4.688e-01, 8.316e-03, -1.753e-01, 6.323e-02, -1.652e-01, -2.049e-01, -5.993e-01, -9.167e-02, 1.612e-01, 9.467e-02, 3.364e-01, -2.673e-02, 8.099e-02, -9.303e-01) * s1_1_1;
	r0 += M4(7.737e-04, 8.277e-02, 2.133e-02, 9.106e-02, 1.374e-03, -1.536e-02, -2.869e-05, -8.859e-04, 1.894e-03, 2.155e-02, 1.825e-02, 1.148e-01, 3.947e-03, 1.068e-01, -6.797e-03, 5.272e-02) * s1_1_2;
	r0 += M4(-4.086e-03, -1.623e-03, 1.156e-02, -6.109e-04, 2.402e-03, 7.411e-04, 7.637e-02, 8.601e-03, 4.811e-04, 1.598e-03, -2.096e-02, 7.339e-03, -3.115e-02, -1.403e-03, 1.741e-02, 1.225e-03) * s1_2_0;
	r0 += M4(-1.030e-02, -6.707e-03, 2.848e-02, 4.050e-03, 2.789e-02, 9.486e-03, 6.051e-02, 1.489e-01, -7.954e-03, 1.996e-02, 1.125e-01, -2.188e-02, 3.661e-04, -2.664e-02, 9.368e-02, 1.853e-01) * s1_2_1;
	r0 += M4(-3.706e-03, 2.953e-03, 2.771e-05, 8.460e-03, 9.604e-03, 8.949e-03, 1.923e-02, 7.647e-03, 1.929e-02, -7.295e-03, -1.129e-02, 4.382e-02, 3.010e-03, 6.500e-03, 9.224e-04, 2.393e-02) * s1_2_2;
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 += M4(1.065e-02, -2.704e-02, 2.731e-02, -2.410e-02, 5.430e-03, -2.904e-03, -2.140e-03, 1.376e-03, -5.759e-02, 1.553e-02, -9.732e-03, 2.475e-03, -1.849e-02, 2.056e-02, 1.154e-02, 1.009e-02) * s0_0_0;
	r0 += M4(-3.084e-01, 2.803e-01, -2.116e-01, 2.094e-01, 1.199e-01, 1.813e-02, -8.625e-03, -9.844e-04, 3.189e-03, 5.605e-01, -4.819e-02, 5.341e-02, -1.600e-02, -6.462e-02, 4.144e-02, 2.688e-02) * s0_0_1;
	r0 += M4(2.118e-02, -1.452e-04, 4.249e-04, -1.345e-03, 1.095e-01, 1.238e-01, -1.003e-02, 4.212e-02, 3.614e-02, -1.922e-02, 8.466e-03, -4.187e-02, -7.153e-04, 1.792e-02, -9.965e-04, 1.765e-03) * s0_0_2;
	r0 += M4(4.792e-03, -9.404e-04, -5.750e-03, -8.169e-03, -4.974e-03, -2.384e-03, -3.956e-03, 1.021e-03, -1.216e-01, -3.870e-03, 3.838e-01, 1.580e-02, -5.459e-03, -2.004e-02, 2.555e-02, -5.018e-03) * s0_1_0;
	r0 += M4(1.887e-02, 1.589e-02, -6.935e-02, 8.276e-02, -7.618e-02, -3.456e-02, 1.795e-01, -9.753e-03, -1.919e-01, -3.372e-01, 3.019e-01, 6.048e-01, 2.319e-01, 1.880e-01, -2.725e-01, -1.285e-02) * s0_1_1;
	r0 += M4(8.030e-03, 9.805e-03, 1.892e-02, -1.045e-02, 3.624e-02, -6.470e-02, 1.372e-01, -5.137e-01, -1.065e-02, -5.568e-02, 5.385e-03, 2.303e-02, 3.330e-02, 7.196e-02, 1.363e-02, -1.294e-01) * s0_1_2;
	r0 += M4(-1.064e-03, -4.062e-05, 5.930e-03, 1.724e-03, 1.875e-03, 1.574e-03, -1.065e-02, -2.254e-04, 4.019e-02, 7.210e-03, -3.942e-02, 9.345e-04, -4.197e-03, -1.318e-04, -2.818e-02, -2.114e-03) * s0_2_0;
	r0 += M4(-7.949e-03, 5.753e-05, -7.611e-03, 6.143e-03, 1.254e-02, 4.610e-03, -3.392e-02, 5.173e-03, 1.363e-02, 7.009e-02, -5.690e-02, -1.136e-01, -2.618e-02, -1.223e-02, 1.812e-02, -4.801e-02) * s0_2_1;
	r0 += M4(4.423e-03, -7.834e-03, 2.679e-03, 3.538e-03, 9.850e-03, -4.721e-03, -2.556e-02, -1.047e-02, 2.738e-04, -8.201e-03, 2.309e-03, -2.335e-02, -1.549e-02, -2.083e-02, -2.525e-03, 3.092e-02) * s0_2_2;
	r0 += V4(-5.366e-05, -5.227e-05, -4.245e-05, -4.751e-05);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
