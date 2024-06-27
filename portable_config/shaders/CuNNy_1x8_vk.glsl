// CuNNy 1x8
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


//!DESC [CuNNy_1x8_vk] -in
//!HOOK LUMA
//!COMPUTE 16 8 8 8
//!BIND LUMA
//!SAVE in
//!WIDTH LUMA.w 2 *
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
#define l0(x, y) F(LUMA_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(1, 1) + ivec2(0, 0)) + vec2(0.5)) * LUMA_pt).r)
shared F G[1][10][10];
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
			G[0][ay][ax] = l0(x - 1, y - 1);
		}
	}
	barrier();
	F s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2;
	V4 r0, r1;
	r0 = V4(0.0); r1 = V4(0.0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2];
	r0 += V4(-2.590e-01, -6.916e-02, -8.695e-02, 4.579e-02) * s0_0_0;
	r1 += V4(-1.011e-03, -5.351e-02, 1.322e-03, -5.779e-02) * s0_0_0;
	r0 += V4(5.215e-01, 8.069e-01, 2.194e-01, -1.244e-01) * s0_0_1;
	r1 += V4(-7.411e-02, 2.842e-01, 9.047e-03, -1.177e-03) * s0_0_1;
	r0 += V4(2.965e-01, -3.204e-02, -2.998e-02, 8.276e-02) * s0_0_2;
	r1 += V4(5.390e-03, -7.593e-02, -3.475e-03, -9.406e-02) * s0_0_2;
	r0 += V4(6.273e-02, 6.030e-02, -4.528e-02, 2.732e-02) * s0_1_0;
	r1 += V4(-1.293e-02, -2.170e-03, -2.762e-02, -2.548e-01) * s0_1_0;
	r0 += V4(-6.616e-01, -7.680e-01, -3.463e-01, 6.923e-01) * s0_1_1;
	r1 += V4(7.755e-01, -4.254e-01, -6.468e-03, 8.848e-01) * s0_1_1;
	r0 += V4(-3.495e-02, 8.636e-03, 7.056e-02, -7.211e-01) * s0_1_2;
	r1 += V4(-1.209e-01, 1.190e-01, -7.480e-01, -4.461e-01) * s0_1_2;
	r0 += V4(1.691e-01, 3.645e-03, -5.293e-01, -6.158e-02) * s0_2_0;
	r1 += V4(5.323e-02, 7.856e-02, 2.200e-02, -7.446e-02) * s0_2_0;
	r0 += V4(9.381e-02, -3.309e-02, 7.174e-01, 3.197e-02) * s0_2_1;
	r1 += V4(-2.283e-01, -6.426e-01, -8.782e-02, 8.288e-02) * s0_2_1;
	r0 += V4(-1.977e-01, 2.497e-02, 3.354e-02, 2.940e-02) * s0_2_2;
	r1 += V4(9.449e-02, 7.192e-01, 8.418e-01, -1.635e-02) * s0_2_2;
	r0 += V4(-2.231e-03, -1.841e-03, -2.561e-03, 6.261e-04);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(6.099e-03, 7.110e-04, -5.396e-03, -2.850e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
}

//!DESC [CuNNy_1x8_vk] -conv1
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
#define l0(x, y) in_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0)) + vec2(0.5)) * in_pt)
#define l1(x, y) in_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0)) + vec2(0.5)) * in_pt)
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
	r0 = D(r0, s0_0_0, 0x030401FD, 0x9735D5A7, 0x07FA09FF, 0xFF05EEFD);
	r1 = D(r1, s0_0_0, 0xF9FFF810, 0x04FF0003, 0x38DFFBF4, 0x0C03FBFC);
	r0 = D(r0, s0_0_1, 0x0104F5FE, 0xFA665AA8, 0x0CF3FDFE, 0x150AF2DE);
	r1 = D(r1, s0_0_1, 0xD9D1EE37, 0x030DFD00, 0xEA050901, 0x02FEFDF6);
	r0 = D(r0, s0_0_2, 0xFC00FD05, 0x06312CE8, 0x010103FB, 0x000607EC);
	r1 = D(r1, s0_0_2, 0x1418EAFB, 0x070B07FC, 0xF0FC0EF4, 0xEA130202);
	r0 = D(r0, s0_1_0, 0x15FA0807, 0x81E3309F, 0xF4CEFD06, 0x19FEFDFB);
	r1 = D(r1, s0_1_0, 0x32EB1113, 0xFEFEF60B, 0x1EE9D5D2, 0x17FD0303);
	r0 = D(r0, s0_1_1, 0x25F34AFD, 0xCDDD3ABC, 0x38E5FFFC, 0x2FF67D09);
	r1 = D(r1, s0_1_1, 0xB6B62FE6, 0xC3DFDC1B, 0xB3A652D7, 0x26E37F00);
	r0 = D(r0, s0_1_2, 0xF7ECF504, 0xEE0A46E5, 0xF0F2F204, 0xF9E40009);
	r1 = D(r1, s0_1_2, 0xD83ABE1D, 0x94EAC610, 0xD22EBD1A, 0xCDF6CA01);
	r0 = D(r0, s0_2_0, 0xE6FCF400, 0xCE110F81, 0xC9E8ABE3, 0x15FCF9F6);
	r1 = D(r1, s0_2_0, 0xE9001501, 0x05010DFC, 0xF5F5F0E1, 0x07FDFCF8);
	r0 = D(r0, s0_2_1, 0x0601DE02, 0xE7D8B7F2, 0x3F005DE1, 0x0E0125EF);
	r1 = D(r1, s0_2_1, 0x14EE4519, 0x180F24E7, 0xDFD81D35, 0xFDFF1FF9);
	r0 = D(r0, s0_2_2, 0x05F6D803, 0x0FFF2FD3, 0xEAD203FF, 0xFA04F5FD);
	r1 = D(r1, s0_2_2, 0x161DA210, 0x36EC3FBF, 0xDBFCD00C, 0xF9FAE5FA);
	r0 = D(r0, s1_0_0, 0x01F3FAFA, 0x1E392B7F, 0xFEFEEBFC, 0x032908EA);
	r1 = D(r1, s1_0_0, 0x008EFAF3, 0xFD0AFF05, 0x20E129CC, 0x07EB01F1);
	r0 = D(r0, s1_0_1, 0x001409F0, 0xE6D7EAE6, 0xF9060B0B, 0xCC071A66);
	r1 = D(r1, s1_0_1, 0xFB16D90D, 0xFA0AFC18, 0xDA06F534, 0xF9290CE7);
	r0 = D(r0, s1_0_2, 0xFFFE0218, 0xF210F5D9, 0x06F70301, 0xFBFC0913);
	r1 = D(r1, s1_0_2, 0xFCE7F611, 0xF1E6FCFE, 0xEC05F32A, 0xF5F4083F);
	r0 = D(r0, s1_1_0, 0xF65DF606, 0x8B181FDD, 0x1ECFF534, 0xFBFDFAE8);
	r1 = D(r1, s1_1_0, 0x05DFC894, 0x0ACD06F6, 0x2D097C17, 0xF12302FC);
	r0 = D(r0, s1_1_1, 0xF832F3C2, 0x03E1260C, 0xDFF707B2, 0xE819FFD2);
	r1 = D(r1, s1_1_1, 0x965381CF, 0xF68115FA, 0x81D3BED2, 0xF113F6A9);
	r0 = D(r0, s1_1_2, 0x07FEFD33, 0x19FDFCC7, 0x05FCFE0E, 0x1203F5EF);
	r1 = D(r1, s1_1_2, 0x0D02F37F, 0x5A1834F4, 0x650801E4, 0x5A00F041);
	r0 = D(r0, s1_2_0, 0x11FBFEFC, 0x1F081B5C, 0x690C04EC, 0x01FD05E8);
	r1 = D(r1, s1_2_0, 0x0BE40FFA, 0xFA0AFBF3, 0x27012D07, 0x0AFF01F4);
	r0 = D(r0, s1_2_1, 0x08060312, 0xE2EB10EB, 0xDA0233DD, 0xF2FEFB08);
	r1 = D(r1, s1_2_1, 0x301FAD27, 0x057FFC36, 0xD9FC08FE, 0x19040C07);
	r0 = D(r0, s1_2_2, 0xFFFF02F4, 0xF7F907C8, 0x17FC0336, 0xFEFF0405);
	r1 = D(r1, s1_2_2, 0xED0CF6EC, 0xCC17DCD5, 0x1908F7FF, 0x02FF0003);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.810e-03, -7.263e-03, -6.213e-03, -6.183e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-7.251e-03, -4.239e-03, -9.470e-03, -2.777e-03);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
}

//!DESC [CuNNy_1x8_vk] -out-shuffle
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv1
//!BIND LUMA
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
//!COMPONENTS 1
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
#define l0(x, y) conv1_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0)) + vec2(0.5)) * conv1_pt)
#define l1(x, y) conv1_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0)) + vec2(0.5)) * conv1_pt)
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[2][10][10];
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
			vec4 v0 = l0(x - 1, y - 1) * 1.0000000e+00;
			vec4 v1 = l1(x - 1, y - 1) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0;
	vec4 f0;
	r0 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xFB03FF05, 0xFF04FFFD, 0x02FD0108, 0x000500F8);
	r0 = D(r0, s0_0_1, 0xFA4E0220, 0xF6A10027, 0x051EFDFE, 0x01D7010E);
	r0 = D(r0, s0_0_2, 0xFFF50200, 0x01270506, 0x00FDFC00, 0x010AFBFC);
	r0 = D(r0, s0_1_0, 0xF8F602F4, 0xFF05FF05, 0xE100FFDA, 0x0306FF0D);
	r0 = D(r0, s0_1_1, 0x1B05DEC5, 0x06F708B3, 0xF8282539, 0xD9B90206);
	r0 = D(r0, s0_1_2, 0xFB0500FE, 0x0805C901, 0xFEFB0300, 0x02212E11);
	r0 = D(r0, s0_2_0, 0xFBFF02FE, 0xF6FF00FD, 0x10F90007, 0xF3FF00FB);
	r0 = D(r0, s0_2_1, 0x06FC1112, 0x0EFC0C0F, 0x1401E2F8, 0x2F0200F8);
	r0 = D(r0, s0_2_2, 0xFF01F804, 0xFB040B03, 0xFD0314FE, 0xFC03F501);
	r0 = D(r0, s1_0_0, 0x04FE2FBD, 0x03FF26ED, 0xF8FED134, 0x0601C10F);
	r0 = D(r0, s1_0_1, 0xFBE80215, 0xF81408CA, 0xFA09FD0C, 0xF9FA0030);
	r0 = D(r0, s1_0_2, 0x010401FD, 0xFA02FF0E, 0x000300FD, 0xFFFF01F9);
	r0 = D(r0, s1_1_0, 0x2204EF02, 0xFCFAF1FD, 0x380606FE, 0xF4F80C05);
	r0 = D(r0, s1_1_1, 0xD6BFFE33, 0x2124FF35, 0xE8A803C9, 0x1F4000D5);
	r0 = D(r0, s1_1_2, 0x040700FE, 0xED0C0002, 0x04060006, 0xF30D01FC);
	r0 = D(r0, s1_2_0, 0x03000002, 0x09010000, 0xF90000FA, 0x0D020001);
	r0 = D(r0, s1_2_1, 0x040A00F8, 0xFAF700FD, 0xF005000B, 0xF7F500FC);
	r0 = D(r0, s1_2_2, 0xFD0100FE, 0xFFFF00FB, 0xFF020002, 0xF5000007);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-8.458e-05, -5.883e-05, -1.067e-04, -9.416e-05);
	f0 = tanh(f0);
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(f0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(f0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(f0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(f0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
