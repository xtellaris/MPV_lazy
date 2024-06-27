// CuNNy fast
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


//!DESC [CuNNy_fast_vk] -in
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
	r0 += V4(9.911e-02, 7.754e-01, 1.674e-01, 1.110e-01) * s0_0_0;
	r1 += V4(-3.140e-01, -2.822e-01, -7.051e-01, -2.784e-02) * s0_0_0;
	r2 += V4(3.564e-02, 2.870e-03, -6.675e-03, -8.755e-02) * s0_0_0;
	r0 += V4(5.793e-02, -4.037e-02, 3.547e-01, 1.106e-01) * s0_0_1;
	r1 += V4(-4.347e-01, 2.768e-01, 7.663e-01, 7.560e-02) * s0_0_1;
	r2 += V4(-7.832e-01, -1.618e-01, -5.049e-04, 9.447e-02) * s0_0_1;
	r0 += V4(6.714e-02, 5.360e-03, 1.228e-02, -2.014e-02) * s0_0_2;
	r1 += V4(3.536e-01, 4.662e-01, -9.308e-04, -2.787e-03) * s0_0_2;
	r2 += V4(-6.138e-03, -2.639e-05, 8.768e-03, -1.401e-02) * s0_0_2;
	r0 += V4(3.215e-01, -7.086e-01, -3.754e-01, -4.535e-01) * s0_1_0;
	r1 += V4(-3.291e-01, -2.329e-01, -3.144e-02, -3.393e-02) * s0_1_0;
	r2 += V4(-2.397e-02, 7.730e-01, 7.912e-01, 7.246e-01) * s0_1_0;
	r0 += V4(-1.003e+00, -3.477e-02, -7.701e-01, 1.442e-01) * s0_1_1;
	r1 += V4(5.351e-01, -5.208e-01, -2.730e-02, -5.967e-02) * s0_1_1;
	r2 += V4(7.991e-01, -3.838e-01, -7.822e-01, -6.247e-02) * s0_1_1;
	r0 += V4(3.710e-01, 3.364e-03, 1.267e-01, -1.704e-02) * s0_1_2;
	r1 += V4(1.900e-01, 2.996e-01, 1.239e-03, 3.584e-01) * s0_1_2;
	r2 += V4(-2.068e-02, 1.823e-02, -1.261e-02, -8.521e-02) * s0_1_2;
	r0 += V4(-2.764e-02, -4.344e-02, 2.025e-01, 1.593e-01) * s0_2_0;
	r1 += V4(1.645e-01, 2.510e-01, 1.801e-02, -3.408e-02) * s0_2_0;
	r2 += V4(-1.566e-02, 2.590e-02, -1.740e-02, -6.520e-02) * s0_2_0;
	r0 += V4(1.312e-01, 5.507e-02, 3.866e-01, 1.519e-01) * s0_2_1;
	r1 += V4(5.428e-02, -1.844e-02, -1.232e-02, 2.219e-01) * s0_2_1;
	r2 += V4(-1.155e-02, -2.014e-01, 2.061e-02, -6.034e-01) * s0_2_1;
	r0 += V4(-2.351e-02, -1.173e-02, -1.142e-01, -8.081e-02) * s0_2_2;
	r1 += V4(-2.107e-01, -2.309e-01, -5.480e-03, -2.347e-01) * s0_2_2;
	r2 += V4(2.536e-02, -1.750e-02, -2.516e-03, 1.025e-01) * s0_2_2;
	r0 += V4(1.129e-02, 2.899e-06, 8.874e-03, -4.269e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(-1.994e-03, -1.077e-03, -1.803e-04, 2.286e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(-2.137e-04, 3.246e-03, -5.766e-08, -1.464e-03);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), vec4(r2));
}

//!DESC [CuNNy_fast_vk] -conv1
//!HOOK LUMA
//!COMPUTE 16 8 8 8
//!BIND in
//!BIND LUMA
//!SAVE conv1
//!WIDTH LUMA.w 2 *
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
	ivec2 opos = pos * ivec2(2, 1);
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
	ivec4 r0, r1;
	vec4 f0, f1;
	r0 = ivec4(0); r1 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x0A00FEF7, 0x43EDFA1B, 0x15EAF419, 0x1009FB04);
	r1 = D(r1, s0_0_0, 0x3AE10C0E, 0x0AF30BEA, 0x16F105F9, 0x0903FE08);
	r0 = D(r0, s0_0_1, 0xDC1107BE, 0xC0161FF4, 0xB00DFCE3, 0xFC10ED25);
	r1 = D(r1, s0_0_1, 0x0D04392A, 0xE5071BA9, 0x1208050B, 0xE9050007);
	r0 = D(r0, s0_0_2, 0xEA0009FC, 0xE60A2B14, 0xF4E70A00, 0xF920FF0B);
	r1 = D(r1, s0_0_2, 0xC0151C0D, 0xF4FA0AE5, 0xF7F1F40E, 0xE80301FC);
	r0 = D(r0, s0_1_0, 0x0A07FB13, 0x1C0BF846, 0x0202EE28, 0x0E0FF8F4);
	r1 = D(r1, s0_1_0, 0x0022F034, 0x0A04001F, 0xC674E974, 0x0D0C01FB);
	r0 = D(r0, s0_1_1, 0xF8183CA5, 0x1ED32EC5, 0x29DE15C4, 0xFA0D2AF2);
	r1 = D(r1, s0_1_1, 0xD4CAFDB6, 0xF11715C4, 0xA83F81D1, 0x07E422DC);
	r0 = D(r0, s0_1_2, 0x2BD57F24, 0x0205FBF9, 0x04EF1EF6, 0x19AF1309);
	r1 = D(r1, s0_1_2, 0x35FF1306, 0x1FFD7C06, 0x16FC1A0E, 0x19E91AFD);
	r0 = D(r0, s0_2_0, 0x0CFEFEFE, 0xDE19FE09, 0xF30AFEF4, 0x0408FD00);
	r1 = D(r1, s0_2_0, 0xFC07FC16, 0x10EBF704, 0x04DA093B, 0x03110001);
	r0 = D(r0, s0_2_1, 0xFC1614F8, 0x10F225F9, 0x0DFC2BD5, 0x0D07140F);
	r1 = D(r1, s0_2_1, 0x05ED04FD, 0x02F4FA10, 0x2109810C, 0xFA0410EA);
	r0 = D(r0, s0_2_2, 0xEEFB1109, 0x10EA3000, 0x0EFF1200, 0xEFE71307);
	r1 = D(r1, s0_2_2, 0x03FD2CFE, 0xF0FAD905, 0xFCE74C12, 0x04001200);
	r0 = D(r0, s1_0_0, 0x29FCFB05, 0xDDFDCD44, 0xE1F11A08, 0x11FDFE01);
	r1 = D(r1, s1_0_0, 0x220DA454, 0x47FDF903, 0x450603FE, 0x17FC08FB);
	r0 = D(r0, s1_0_1, 0xD5FC09E9, 0xF6F8DC24, 0xD1E50E07, 0x980AF201);
	r1 = D(r1, s1_0_1, 0xCFF6D84F, 0xEA0006EE, 0xE00707F0, 0xCC020504);
	r0 = D(r0, s1_0_2, 0x0219FEFB, 0x0018E01E, 0xFEFA0201, 0xF207F10E);
	r1 = D(r1, s1_0_2, 0x1AF5E024, 0x18090EEF, 0xFC020504, 0x0400FC05);
	r0 = D(r0, s1_1_0, 0x08F5EF0E, 0x15C0D246, 0x38F11EFB, 0x18F9EE10);
	r1 = D(r1, s1_1_0, 0xDBB4967E, 0xCEFAEB11, 0x27CF0C13, 0xF600FEFA);
	r0 = D(r0, s1_1_1, 0x2158FED8, 0x48FFC125, 0x16F402FE, 0x3830E201);
	r1 = D(r1, s1_1_1, 0x4E26B22B, 0x2038FBD9, 0xF4BEFEE4, 0x251CFBF0);
	r0 = D(r0, s1_1_2, 0x085FFA03, 0xF928E20D, 0x0A2306FE, 0x1676F409);
	r1 = D(r1, s1_1_2, 0xE512DA13, 0xF53C00F3, 0x0B1E04EF, 0x092EFD06);
	r0 = D(r0, s1_2_0, 0xFBF9F809, 0xFDDFD14C, 0xF7F3001C, 0xF4F9ED0A);
	r1 = D(r1, s1_2_0, 0x1ECCD941, 0xFCF7FA0B, 0x0512FE08, 0x0200F206);
	r0 = D(r0, s1_2_1, 0xEBF8F200, 0xDEF4C52B, 0x0C2CF304, 0xE6F0DC0C);
	r1 = D(r1, s1_2_1, 0xE8D1D715, 0xE0FF0302, 0xD281F81A, 0x00FCF4FD);
	r0 = D(r0, s1_2_2, 0x0032F602, 0xFC24F228, 0xFC1BFC0A, 0x175BFBFB);
	r1 = D(r1, s1_2_2, 0xF532F721, 0xFE2104FA, 0xFE23FDF6, 0x0039F706);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xF5090605, 0xF4E321D8, 0xFFE513F6, 0x030402FE);
	r1 = D(r1, s0_0_0, 0xFA160ACC, 0xF618FB07, 0xC937E714, 0xFF01FE00);
	r0 = D(r0, s0_0_1, 0x18DCF802, 0x27F8F9DC, 0xF1EB11E7, 0xFBBDFFF6);
	r1 = D(r1, s0_0_1, 0x7FB5E4D2, 0x3721DA14, 0x2368C30F, 0x16F5FAFC);
	r0 = D(r0, s0_0_2, 0x1511C80D, 0x38FBE900, 0xFDE10C00, 0x21AA0CF7);
	r1 = D(r1, s0_0_2, 0x40CF23F6, 0x021FC90E, 0x01FFF802, 0x07EDFFFF);
	r0 = D(r0, s0_1_0, 0xFEFCFDC1, 0xF203EAB0, 0xF9FFFBEC, 0xFA02FFBC);
	r1 = D(r1, s0_1_0, 0xED00F3B6, 0x03F50300, 0xBD812A1D, 0xFD05FCF9);
	r0 = D(r0, s0_1_1, 0xFD45013B, 0x03FB0719, 0x257FB20D, 0xEE2C0DED);
	r1 = D(r1, s0_1_1, 0x2511F9F8, 0xF726FB2B, 0xE8C559D8, 0x1A72E10B);
	r0 = D(r0, s0_1_2, 0x0465D21E, 0x0D1DD3F6, 0x0517F311, 0x1245DC3C);
	r1 = D(r1, s0_1_2, 0x0B22A9F5, 0xFB18EE06, 0x161CD011, 0x0F34C219);
	r0 = D(r0, s0_2_0, 0x0402FCEB, 0x08F9FAE2, 0x0104FD23, 0xF8FE01EF);
	r1 = D(r1, s0_2_0, 0x0803E3E4, 0xFDFB02EF, 0x0F881581, 0xFD09FF18);
	r0 = D(r0, s0_2_1, 0xFA0EFE0D, 0x020DDDF2, 0xFF2BFA6A, 0xF8FAFF14);
	r1 = D(r1, s0_2_1, 0x0D0DD3FF, 0xFDEA14F7, 0xDAAE21CE, 0x011FFD62);
	r0 = D(r0, s0_2_2, 0xFDF511FC, 0x06F00DE7, 0x041AF80E, 0x10F9031B);
	r1 = D(r1, s0_2_2, 0x00E91AE8, 0xF0CC2EF5, 0x1328F117, 0x0416FA15);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(2.155e-02, 4.201e-03, 1.631e-02, -1.021e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(2.783e-03, 1.491e-02, -1.658e-02, 1.757e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
}

//!DESC [CuNNy_fast_vk] -conv2
//!HOOK LUMA
//!COMPUTE 16 8 8 8
//!BIND conv1
//!BIND LUMA
//!SAVE conv2
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
#define l0(x, y) (conv1_mul * texelFetch(conv1_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0), 0))
#define l1(x, y) (conv1_mul * texelFetch(conv1_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0), 0))
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[2][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(2, 1);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			vec4 v0 = l0(x - 1, y - 1) * 1.0000000e+00;
			vec4 v1 = l1(x - 1, y - 1) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0, r1;
	vec4 f0, f1;
	r0 = ivec4(0); r1 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xFB08FC04, 0xEF0BFFF6, 0x0404F9FE, 0x00FFFE00);
	r1 = D(r1, s0_0_0, 0xFE0200F0, 0x010400FA, 0xFAFE03FD, 0xF704F8F9);
	r0 = D(r0, s0_0_1, 0x0A07FFEC, 0xE30DFE08, 0xFE030BEB, 0xF60B06F5);
	r1 = D(r1, s0_0_1, 0xDD03EC11, 0x0BFB09F1, 0xE50DFC0C, 0xF304EB06);
	r0 = D(r0, s0_0_2, 0xFD03FDF9, 0x0905F4FD, 0x03F509FC, 0x0D0EFBFA);
	r1 = D(r1, s0_0_2, 0x0A09FCF8, 0xFFF806FB, 0x0B09EEFC, 0x0904FCFD);
	r0 = D(r0, s0_1_0, 0x34FD0019, 0x1CFD0608, 0xD9020FED, 0x27F8E90C);
	r1 = D(r1, s0_1_0, 0xF4FA15E9, 0x01F9F912, 0x1806EEEB, 0x2CF5FBF5);
	r0 = D(r0, s0_1_1, 0xF80E0105, 0xED040A31, 0xE6F7D16A, 0xF7120A7F);
	r1 = D(r1, s0_1_1, 0x4EE9F70C, 0xC4F4FD3E, 0xF71D1022, 0x0BCE48F2);
	r0 = D(r0, s0_1_2, 0xF7D528EF, 0xEFBD0907, 0xF5E6040D, 0xF3D4F70F);
	r1 = D(r1, s0_1_2, 0xE097420C, 0x09F9EA0C, 0xF5D10D03, 0xFBC7EF0A);
	r0 = D(r0, s0_2_0, 0x1B02FDFC, 0xE9F607FA, 0x0CF814EC, 0x10FDF2EA);
	r1 = D(r1, s0_2_0, 0xFEFA0EFD, 0x23FCFED8, 0x260004E3, 0xFEFD05F3);
	r0 = D(r0, s0_2_1, 0xEF08F70E, 0xF2F0150E, 0x3C0002E4, 0xFBEE270B);
	r1 = D(r1, s0_2_1, 0xFD04F80B, 0x17D739F4, 0xFB001136, 0xF7FCFD17);
	r0 = D(r0, s0_2_2, 0xF50715F4, 0x00080C09, 0xF1BD3806, 0x0212100E);
	r1 = D(r1, s0_2_2, 0xFB06FF05, 0x03EEFC08, 0x0924EC07, 0x0210F303);
	r0 = D(r0, s1_0_0, 0xFEEBFD03, 0x03060800, 0xFC010201, 0x090303FF);
	r1 = D(r1, s1_0_0, 0xF1FF0B00, 0xFA0A0701, 0x0B0205FE, 0xF90C03FD);
	r0 = D(r0, s1_0_1, 0xF2BB0C05, 0x15FBF008, 0xF4FC16FD, 0xFDF10500);
	r1 = D(r1, s1_0_1, 0x21F4E601, 0xEADF0EFB, 0x14F5EC06, 0x00A0EB0F);
	r0 = D(r0, s1_0_2, 0x02090A00, 0xECFB0205, 0xFAE101F7, 0xEBF00500);
	r1 = D(r1, s1_0_2, 0xD1B9FA12, 0x0AEB04F9, 0xEBF30307, 0xECF9FF0D);
	r0 = D(r0, s1_1_0, 0x1CEFFBF9, 0xCA09EBF5, 0xFB0209F8, 0xFB0F0102);
	r1 = D(r1, s1_1_0, 0x05FE00F4, 0xFB0AEBFB, 0xFC020901, 0xF9FFF209);
	r0 = D(r0, s1_1_1, 0xD781E506, 0x73E4BFF9, 0x74F3A614, 0x02E5B6FD);
	r1 = D(r1, s1_1_1, 0x37F6220A, 0x7F87C70B, 0x61E5C5F3, 0x7FC43BC7);
	r0 = D(r0, s1_1_2, 0x2DFC09F5, 0x32E0EFF4, 0xF997E40C, 0x14D9E4FB);
	r1 = D(r1, s1_1_2, 0x7081F3AC, 0xDAFFED16, 0x28DCF1FA, 0x26D6EFF1);
	r0 = D(r0, s1_2_0, 0xFD0AF4F9, 0x060B0409, 0xFE00FBF5, 0x01010613);
	r1 = D(r1, s1_2_0, 0x020605F8, 0xF9FC0010, 0xF703FB05, 0x00060501);
	r0 = D(r0, s1_2_1, 0xE8F713E9, 0x0B0713DE, 0xF3FD1200, 0x060417D6);
	r1 = D(r1, s1_2_1, 0xF700DD09, 0x23051AAF, 0xD503F4D7, 0x0309E3EB);
	r0 = D(r0, s1_2_2, 0x05FF0CFE, 0xF30403EC, 0x39E808A7, 0xE70009EA);
	r1 = D(r1, s1_2_2, 0xF314FCF8, 0x04D9FFFA, 0xD60BFBFE, 0xE90EFB14);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-4.272e-03, -2.072e-02, -2.167e-02, -1.861e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-1.947e-02, -1.666e-02, -1.569e-02, -1.535e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
}

//!DESC [CuNNy_fast_vk] -out-shuffle
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv2
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
#define l0(x, y) V4((conv2_mul * texelFetch(conv2_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0), 0)))
#define l1(x, y) V4((conv2_mul * texelFetch(conv2_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0), 0)))
shared V4 G[2][10][10];
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
	r0 += M4(-8.019e-03, -1.225e-03, -1.641e-03, -2.824e-07, -2.305e-02, 1.077e-02, -4.294e-03, 1.160e-03, 8.576e-03, 2.316e-03, -2.559e-02, 1.134e-02, -3.298e-03, 3.211e-03, 9.861e-03, -6.407e-04) * s0_0_0;
	r0 += M4(1.140e-02, -3.740e-02, -1.233e-02, 4.041e-03, -1.001e-01, -1.067e-01, -2.313e-02, -1.704e-02, 1.322e-01, 6.567e-02, -1.791e-03, 3.517e-04, -1.169e-01, -9.195e-02, 1.195e-02, 2.159e-02) * s0_0_1;
	r0 += M4(-5.787e-02, -5.169e-02, 5.273e-03, 5.542e-03, -8.157e-03, -2.940e-04, -1.861e-03, -3.849e-02, -6.032e-03, -1.020e-02, -8.999e-04, -8.099e-03, 4.738e-03, -3.598e-02, -4.486e-03, 1.447e-02) * s0_0_2;
	r0 += M4(-1.091e-02, 7.420e-04, -3.177e-03, 3.294e-03, -5.261e-02, 1.234e-02, -3.639e-02, 2.390e-02, 5.405e-02, -2.960e-02, -5.310e-02, -5.137e-04, 4.039e-02, -2.338e-02, -1.100e-02, -6.977e-03) * s0_1_0;
	r0 += M4(2.646e-01, -7.793e-02, 3.057e-01, -6.068e-02, 1.391e-01, -2.266e-01, 2.046e-01, -1.323e-01, 1.714e-01, 1.206e-01, 2.143e-01, -8.014e-01, 8.765e-02, 3.334e-01, -2.110e-01, -6.514e-02) * s0_1_1;
	r0 += M4(-1.812e-01, 1.570e-01, -1.291e-01, 1.202e-01, -1.941e-02, 2.638e-01, 4.650e-02, 3.889e-01, -2.770e-03, 1.531e-02, -1.539e-02, 3.223e-02, 1.130e-03, -1.655e-01, 3.954e-03, -1.997e-01) * s0_1_2;
	r0 += M4(-2.143e-03, 2.121e-05, -1.603e-02, -4.344e-03, -1.790e-03, -1.257e-03, -2.826e-02, 3.472e-03, -2.318e-03, -6.705e-03, -4.629e-03, -5.022e-03, -1.844e-03, -2.768e-03, 3.625e-02, 4.565e-04) * s0_2_0;
	r0 += M4(-1.415e-04, -6.084e-04, -1.248e-02, -6.190e-02, 1.995e-02, 6.420e-03, -9.058e-02, -1.255e-01, -1.653e-03, -1.315e-02, 4.583e-02, 7.104e-02, -1.773e-02, -6.332e-03, 1.193e-01, 1.532e-01) * s0_2_1;
	r0 += M4(4.816e-03, 9.804e-03, -8.764e-02, -2.684e-02, 5.486e-03, 5.159e-03, -4.413e-02, -4.529e-02, 3.601e-03, -7.294e-03, -4.108e-04, 2.512e-02, -7.213e-03, -6.950e-03, 4.822e-02, 5.477e-02) * s0_2_2;
	r0 += M4(-1.046e-02, -8.644e-03, -3.223e-03, 7.918e-04, 2.349e-04, -1.800e-02, 2.077e-02, -8.336e-03, 1.752e-02, -5.922e-04, 1.447e-03, -7.823e-04, 2.518e-02, 1.321e-02, -7.061e-03, -8.742e-04) * s1_0_0;
	r0 += M4(3.683e-02, 4.250e-02, -8.667e-04, -1.192e-02, 2.073e-02, 1.018e-01, -2.575e-03, -1.870e-04, 1.987e-01, 1.812e-01, 6.909e-04, -1.959e-02, 4.961e-02, 3.402e-02, -8.073e-03, -2.488e-03) * s1_0_1;
	r0 += M4(4.322e-03, 2.106e-02, 2.313e-03, -5.875e-03, -7.139e-04, 5.056e-02, 1.263e-02, -1.040e-02, 4.230e-03, 2.962e-02, 6.019e-03, 4.161e-02, 6.747e-03, 1.654e-02, 1.488e-03, -5.105e-03) * s1_0_2;
	r0 += M4(2.813e-02, -1.579e-02, 5.970e-02, -2.180e-02, -5.958e-03, 1.596e-02, 5.322e-03, -1.527e-02, -2.619e-02, 2.557e-02, 1.138e-02, 8.455e-03, 8.102e-03, -9.774e-03, -4.474e-02, 8.529e-03) * s1_1_0;
	r0 += M4(2.358e-01, -7.559e-01, 8.716e-02, 1.251e-01, 1.773e-01, 2.031e-01, -9.437e-01, 1.984e-01, -1.854e-01, -2.026e-01, 1.204e-01, 2.329e-01, -9.389e-01, 2.406e-01, 1.489e-01, 1.052e-01) * s1_1_1;
	r0 += M4(-9.875e-03, 4.342e-02, -4.279e-04, 7.305e-03, -1.213e-02, 1.292e-01, 3.308e-02, 3.642e-03, 2.155e-02, -1.153e-01, -5.879e-02, -2.128e-01, 2.561e-02, -1.967e-03, 2.709e-03, 1.101e-01) * s1_1_2;
	r0 += M4(-2.723e-02, 1.200e-02, 8.520e-02, -2.681e-02, -1.054e-02, 6.466e-04, 2.778e-02, 9.001e-03, 5.862e-03, 4.347e-03, -1.630e-02, 6.431e-03, 1.790e-02, 1.870e-04, 2.748e-02, 4.192e-04) * s1_2_0;
	r0 += M4(-3.405e-02, 1.765e-02, 1.587e-01, 1.218e-01, -1.802e-02, -3.912e-03, 7.538e-02, 2.863e-02, 2.191e-02, 1.605e-02, -6.763e-02, -7.495e-02, -3.969e-02, -4.838e-02, 1.534e-02, 1.685e-01) * s1_2_1;
	r0 += M4(3.807e-03, -1.361e-02, -4.115e-03, -1.566e-02, -3.456e-03, -1.608e-02, -5.111e-03, -5.899e-03, -5.810e-03, 1.837e-02, 6.603e-03, -1.296e-02, 1.592e-02, -4.402e-02, -7.093e-03, 4.167e-02) * s1_2_2;
	r0 += V4(-6.633e-09, -1.383e-08, -5.645e-09, -1.212e-08);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
