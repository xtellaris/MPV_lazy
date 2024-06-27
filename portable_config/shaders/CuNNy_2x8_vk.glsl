// CuNNy 2x8
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


//!DESC [CuNNy_2x8_vk] -in
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
	r0 += V4(1.612e-01, -1.632e-02, -2.977e-03, -4.032e-02) * s0_0_0;
	r1 += V4(5.384e-02, -1.049e-01, -2.023e-01, -3.488e-02) * s0_0_0;
	r0 += V4(1.936e-01, -1.513e-02, -3.731e-03, 1.284e-01) * s0_0_1;
	r1 += V4(1.184e-01, 1.713e-02, 6.037e-01, 8.617e-02) * s0_0_1;
	r0 += V4(5.804e-02, 2.193e-02, 6.902e-03, -2.568e-01) * s0_0_2;
	r1 += V4(8.788e-02, -4.494e-02, 2.747e-01, -4.177e-02) * s0_0_2;
	r0 += V4(2.022e-01, 4.207e-02, 7.612e-01, 6.274e-02) * s0_1_0;
	r1 += V4(1.360e-02, 7.106e-01, 2.012e-01, 1.060e-01) * s0_1_0;
	r0 += V4(2.444e-01, 7.559e-01, 5.855e-03, 6.951e-01) * s0_1_1;
	r1 += V4(-4.625e-01, -2.940e-01, -6.035e-01, -7.380e-01) * s0_1_1;
	r0 += V4(-6.703e-02, -7.838e-01, -1.412e-02, -3.291e-01) * s0_1_2;
	r1 += V4(5.372e-01, 1.153e-01, -2.764e-01, 3.046e-02) * s0_1_2;
	r0 += V4(-6.412e-02, -2.351e-02, -7.698e-01, -8.762e-02) * s0_2_0;
	r1 += V4(1.938e-02, -7.078e-02, -1.751e-04, -7.338e-02) * s0_2_0;
	r0 += V4(1.940e-02, -3.142e-02, 9.781e-03, -3.452e-02) * s0_2_1;
	r1 += V4(3.990e-01, -4.389e-02, 4.144e-02, 2.127e-01) * s0_2_1;
	r0 += V4(-1.445e-02, 5.212e-02, 7.431e-03, -9.034e-02) * s0_2_2;
	r1 += V4(3.989e-02, 6.492e-02, -3.593e-02, 4.522e-01) * s0_2_2;
	r0 += V4(1.530e-02, -4.552e-04, 1.234e-06, -4.276e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(1.958e-02, -8.934e-04, 7.102e-03, 3.649e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
}

//!DESC [CuNNy_2x8_vk] -conv1
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
	r0 = D(r0, s0_0_0, 0x11FDC6F1, 0xFE0018FC, 0x1C0BBE11, 0xF7F928F9);
	r1 = D(r1, s0_0_0, 0x05FE0605, 0xF4F573FB, 0x2EF8C8F8, 0x17DFDC1A);
	r0 = D(r0, s0_0_1, 0x2CC0CC25, 0x0E0BFBFE, 0xFD81FEE2, 0x021A11F9);
	r1 = D(r1, s0_0_1, 0x02E80601, 0xCEDA1DE5, 0x1381FC0E, 0xF1F71212);
	r0 = D(r0, s0_0_2, 0x05130F31, 0x026EF903, 0xFF811D22, 0xFC3FF8F1);
	r1 = D(r1, s0_0_2, 0x0549FA08, 0x037FFBD3, 0x0CE4001F, 0xFD20F6E6);
	r0 = D(r0, s0_1_0, 0x1204C92A, 0xEEFB30FD, 0x22108124, 0xE20347D6);
	r1 = D(r1, s0_1_0, 0xFEF65F2C, 0xF8EEA733, 0x5319B7F3, 0xC5FB7F22);
	r0 = D(r0, s0_1_1, 0x0CE122CA, 0xD40750CE, 0x43BDD8FB, 0xCE1236D7);
	r1 = D(r1, s0_1_1, 0xC8D752F8, 0xEACCED5C, 0xE40414DD, 0xC70C0439);
	r0 = D(r0, s0_1_2, 0xDF4710A4, 0x0061F6C9, 0xBDBC312F, 0x034EFB02);
	r1 = D(r1, s0_1_2, 0xFB46F8DE, 0xC9271C0B, 0xF8DD07EA, 0x1AF8EBC5);
	r0 = D(r0, s0_2_0, 0xEA02FB0F, 0x00FDF4FF, 0xDD0739F8, 0xF800ECFD);
	r1 = D(r1, s0_2_0, 0xFD00FA11, 0x1402E1FB, 0xA41F7016, 0xEF041FF7);
	r0 = D(r0, s0_2_1, 0xD8005EB8, 0x00FD1CDF, 0xC5275ED8, 0xEEF434FA);
	r1 = D(r1, s0_2_1, 0xFBFB15DE, 0x220708F0, 0xEA440502, 0x19F9B741);
	r0 = D(r0, s0_2_2, 0xECFEFD2E, 0x0CF9F436, 0xDB220EF7, 0x0702F463);
	r1 = D(r1, s0_2_2, 0x07F6FC37, 0x0704130C, 0xF30AFB19, 0x0EDBE6FF);
	r0 = D(r0, s1_0_0, 0xD6070FDC, 0x0A000208, 0xE5FAE804, 0x18FF090C);
	r1 = D(r1, s1_0_0, 0xFFF9EF03, 0x5CE1ED16, 0xF6FF122A, 0xDCE3F0BA);
	r0 = D(r0, s1_0_1, 0x3AE70CE7, 0x2DFD050E, 0xF312FBF9, 0x34080532);
	r1 = D(r1, s1_0_1, 0x17F700F1, 0x1520E335, 0x0CEB20F7, 0x0A0E1018);
	r0 = D(r0, s1_0_2, 0xFFF20C0B, 0x02FE05FF, 0x13F826F7, 0x10FF03F5);
	r1 = D(r1, s1_0_2, 0xFC030FFF, 0x1A09F1E7, 0xFC001109, 0x0800E50A);
	r0 = D(r0, s1_1_0, 0x0018F1E8, 0x09FF0501, 0xB71EF7E3, 0x0AF81857);
	r1 = D(r1, s1_1_0, 0x121DE3CF, 0x8C810AB1, 0xE4E2DB85, 0xF7F1E9D9);
	r0 = D(r0, s1_1_1, 0x4DBE4B5F, 0x28022540, 0x38EE15D4, 0x1CE6FAA3);
	r1 = D(r1, s1_1_1, 0x00124123, 0xB2F422B4, 0x0CFF34FC, 0xEB184B4D);
	r0 = D(r0, s1_1_2, 0x1B10C303, 0x0509C6F3, 0x01036201, 0x0104F1F9);
	r1 = D(r1, s1_1_2, 0x060AEDEF, 0x1406E70D, 0x0EF922F3, 0x17F5E5EF);
	r0 = D(r0, s1_2_0, 0x0420F4FF, 0xFBED00FF, 0xF0090625, 0x0E02F7DF);
	r1 = D(r1, s1_2_0, 0x09EC02F7, 0x0D1CE918, 0xD3310B7F, 0x1A0909F8);
	r0 = D(r0, s1_2_1, 0x0EFC3506, 0x05F706FC, 0x0BFEDB14, 0xF824E613);
	r1 = D(r1, s1_2_1, 0x070CE7F7, 0xF5DEE41A, 0x131E81EC, 0x10F5E0D3);
	r0 = D(r0, s1_2_2, 0x10E622DA, 0xFDFC28FF, 0x0D04C3ED, 0x00FB0E00);
	r1 = D(r1, s1_2_2, 0xFD002002, 0xF4063305, 0x02F0D7FA, 0x04F2EAFC);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(1.050e-02, 4.449e-03, -8.421e-03, -8.087e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(6.856e-04, -7.561e-03, -5.804e-03, -6.040e-03);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
}

//!DESC [CuNNy_2x8_vk] -conv2
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
#define l0(x, y) conv1_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0)) + vec2(0.5)) * conv1_pt)
#define l1(x, y) conv1_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0)) + vec2(0.5)) * conv1_pt)
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
	r0 = D(r0, s0_0_0, 0x0301F3FF, 0x050A0304, 0xEBF920FC, 0xEEF71FFD);
	r1 = D(r1, s0_0_0, 0x0105FAFC, 0xE4F718FB, 0xFCF80804, 0x0503F3FD);
	r0 = D(r0, s0_0_1, 0x03F2F50B, 0xD9DF29F3, 0xB3DD281E, 0xADE1221F);
	r1 = D(r1, s0_0_1, 0x04F41403, 0xE281E92A, 0xED8D1BDD, 0x04030B04);
	r0 = D(r0, s0_0_2, 0xEBFBF60C, 0x13E0EDFD, 0xE1F8060F, 0xE4F20A0E);
	r1 = D(r1, s0_0_2, 0x07E5F306, 0xF7F1040F, 0x09F6F413, 0xF8F50907);
	r0 = D(r0, s0_1_0, 0x0605E503, 0xFC282BE9, 0xF9F30CF0, 0xF4E9F7DD);
	r1 = D(r1, s0_1_0, 0xFCF6FE05, 0xCDB848BC, 0x01EDA434, 0x0002EB03);
	r0 = D(r0, s0_1_1, 0x18FA34CE, 0xAA81F129, 0x19CE32AA, 0x63CFCEBA);
	r1 = D(r1, s0_1_1, 0xECA64F07, 0x1DA421A3, 0x12A37FBE, 0x08FD34EB);
	r0 = D(r0, s0_1_2, 0x13DDC212, 0x53C4E1E8, 0xF4EB10F1, 0x09F4F0EF);
	r1 = D(r1, s0_1_2, 0x60D0A204, 0x04FAF5FD, 0xFCF7B22B, 0x02EFC01E);
	r0 = D(r0, s0_2_0, 0xF4FE13EF, 0xFB1F1DED, 0x060FFEFE, 0x040E01FF);
	r1 = D(r1, s0_2_0, 0x0302FD04, 0x160EDA19, 0xF9F7030D, 0xFAFE0CFC);
	r0 = D(r0, s0_2_1, 0xD8B81AF5, 0xDBA225FF, 0x08F1F210, 0xE1FD46ED);
	r1 = D(r1, s0_2_1, 0x07F1F50D, 0x15FBEB1C, 0xF3C50306, 0xFBF004FA);
	r0 = D(r0, s0_2_2, 0x32D22FD7, 0x29DBC91C, 0x07FAFEFC, 0x0DFC13F3);
	r1 = D(r1, s0_2_2, 0x0FF6EF10, 0x13F9F901, 0x0CF6F201, 0x0BF601FB);
	r0 = D(r0, s1_0_0, 0x00FCFC07, 0xFE0300F4, 0x020208F2, 0x030906F3);
	r1 = D(r1, s1_0_0, 0x0400FDFE, 0x01000DED, 0x140002EF, 0xFC01FF09);
	r0 = D(r0, s1_0_1, 0xFAF80308, 0x1F04FBD4, 0x141916DC, 0x05121AEB);
	r1 = D(r1, s1_0_1, 0x0204F6F2, 0xFA190F01, 0x2B1AF5D7, 0xFE0001F4);
	r0 = D(r0, s1_0_2, 0x0BF60A05, 0x1FFDF70D, 0x17E81BEA, 0x18731CDB);
	r1 = D(r1, s1_0_2, 0x0400F509, 0x02320705, 0x15FBFD0D, 0x0C03FDFA);
	r0 = D(r0, s1_1_0, 0xFCFC030C, 0x3BF7F3B8, 0x10020ADD, 0xF1030B09);
	r1 = D(r1, s1_1_0, 0x0205FEF4, 0xFD0109EB, 0x0AFE05F9, 0xFF000106);
	r0 = D(r0, s1_1_1, 0x0B06F7D2, 0xE9F73823, 0x1C002532, 0x00112AF9);
	r1 = D(r1, s1_1_1, 0x1603FED7, 0xDE30C341, 0x4103DDC5, 0x09FCFFE3);
	r0 = D(r0, s1_1_2, 0xD43CFEFB, 0x7F08C8F2, 0xF11C0210, 0xF7A2012B);
	r1 = D(r1, s1_1_2, 0x0507D536, 0xD0DFF500, 0xDDF1023B, 0x2C13F560);
	r0 = D(r0, s1_2_0, 0xFC04F8F7, 0x11FBF6DF, 0x07FD0BFC, 0x10FA0CF1);
	r1 = D(r1, s1_2_0, 0xFE03FB06, 0xF9FC0710, 0x0B0005F3, 0x0101FEFA);
	r0 = D(r0, s1_2_1, 0xE818F60E, 0xFB031FF6, 0x05F422F2, 0x17F126E5);
	r1 = D(r1, s1_2_1, 0x0AFBFDFE, 0x1BE731E9, 0x1303050F, 0xFA06010E);
	r0 = D(r0, s1_2_2, 0x35010A0A, 0x220FC912, 0x0800060B, 0xFE0DF0FB);
	r1 = D(r1, s1_2_2, 0x17FBFBE2, 0x1EF109EC, 0x080AF80B, 0x09FEFEFD);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.090e-02, -1.166e-02, -1.145e-02, -1.243e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-8.395e-03, -1.102e-02, -1.168e-02, -5.690e-03);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
}

//!DESC [CuNNy_2x8_vk] -out-shuffle
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv2
//!BIND LUMA
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
//!COMPONENTS 1
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
#define l0(x, y) conv2_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0)) + vec2(0.5)) * conv2_pt)
#define l1(x, y) conv2_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0)) + vec2(0.5)) * conv2_pt)
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
	r0 = D(r0, s0_0_0, 0x01FD0006, 0xFD0400FA, 0x0000F9F2, 0x00000005);
	r0 = D(r0, s0_0_1, 0xF2100D02, 0xFB05EC19, 0x02FDFFFC, 0x01FF06CF);
	r0 = D(r0, s0_0_2, 0xFF00FDFE, 0xFB0504FE, 0x0000FFFF, 0x0000FF02);
	r0 = D(r0, s0_1_0, 0xFFFA01FC, 0x0004FF04, 0x08F60A1A, 0xFD07000C);
	r0 = D(r0, s0_1_1, 0x2CF82100, 0x23E6E7F8, 0xD0382BFD, 0xFA03C412);
	r0 = D(r0, s0_1_2, 0x01FDFB00, 0x00100200, 0x05FAFA01, 0xF90A0700);
	r0 = D(r0, s0_2_0, 0x00000101, 0x00010001, 0x00FD01FC, 0x020100FF);
	r0 = D(r0, s0_2_1, 0xFF00FD00, 0x000101FF, 0xFFE40100, 0xFAF103FF);
	r0 = D(r0, s0_2_2, 0xFE000000, 0xFEFA0000, 0x02FF0000, 0xFFF80200);
	r0 = D(r0, s1_0_0, 0xEE010008, 0x01FE00FE, 0x0100FFFF, 0x020100FF);
	r0 = D(r0, s1_0_1, 0x020308FE, 0xF6F8FF0C, 0x010400FF, 0xFD02FFFC);
	r0 = D(r0, s1_0_2, 0x00000002, 0x01FB05FF, 0x00010001, 0x00FE0001);
	r0 = D(r0, s1_1_0, 0x0F030710, 0xEEF7FC0A, 0xE002021D, 0xE9F70007);
	r0 = D(r0, s1_1_1, 0x07B0C6E2, 0x1E5004EB, 0x09D419EE, 0x18240614);
	r0 = D(r0, s1_1_2, 0x0000FE02, 0xFF11C0FC, 0x00FE0304, 0xFF022DF8);
	r0 = D(r0, s1_2_0, 0xFC00FF03, 0xFD010003, 0x0F0700FD, 0xFF00FE01);
	r0 = D(r0, s1_2_1, 0x000A0601, 0x02FB0202, 0x00E308F7, 0x051905F4);
	r0 = D(r0, s1_2_2, 0x00000000, 0x00F50600, 0x00010300, 0x0007FCFE);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-9.188e-05, -7.608e-05, -9.573e-05, -6.958e-05);
	f0 = tanh(f0);
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(f0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(f0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(f0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(f0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
