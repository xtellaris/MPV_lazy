// CuNNy 3x12
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


//!DESC [CuNNy_3x12_vk] -in
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
	r0 += V4(4.258e-02, 6.782e-03, 2.484e-01, -4.550e-02) * s0_0_0;
	r1 += V4(1.514e-02, 3.322e-03, -1.074e-02, 3.800e-01) * s0_0_0;
	r2 += V4(-8.075e-03, -5.828e-02, -4.598e-03, -2.185e-01) * s0_0_0;
	r0 += V4(1.100e-01, -1.493e-02, -1.938e-01, 2.866e-01) * s0_0_1;
	r1 += V4(-5.529e-02, -8.077e-01, -1.540e-01, -3.659e-01) * s0_0_1;
	r2 += V4(8.346e-04, -7.690e-02, 1.588e-03, -5.902e-01) * s0_0_1;
	r0 += V4(4.078e-02, 1.195e-02, -4.449e-02, 3.784e-01) * s0_0_2;
	r1 += V4(5.287e-02, -3.466e-03, -6.240e-03, -1.311e-01) * s0_0_2;
	r2 += V4(7.615e-03, 1.398e-01, -7.726e-04, 4.072e-01) * s0_0_2;
	r0 += V4(1.096e-02, -1.214e-02, -2.372e-01, -7.642e-02) * s0_1_0;
	r1 += V4(-5.838e-02, 4.194e-03, -1.471e-01, 2.550e-01) * s0_1_0;
	r2 += V4(3.584e-04, 1.124e-01, 4.185e-03, 6.004e-02) * s0_1_0;
	r0 += V4(-5.840e-01, -7.808e-01, -5.920e-01, -7.494e-01) * s0_1_1;
	r1 += V4(6.629e-01, 8.105e-01, 8.613e-01, 2.725e-01) * s0_1_1;
	r2 += V4(7.387e-01, -7.512e-01, 6.439e-03, 5.762e-01) * s0_1_1;
	r0 += V4(6.173e-02, 7.910e-01, 1.189e-01, 2.007e-01) * s0_1_2;
	r1 += V4(-6.567e-02, -6.028e-03, -1.023e-01, -4.280e-01) * s0_1_2;
	r2 += V4(-1.440e-03, -5.885e-02, -7.766e-03, -2.154e-01) * s0_1_2;
	r0 += V4(-4.313e-03, 3.055e-03, 1.979e-02, 1.260e-01) * s0_2_0;
	r1 += V4(2.395e-02, -6.127e-03, -3.891e-02, -1.978e-01) * s0_2_0;
	r2 += V4(9.259e-03, 5.510e-01, 8.245e-01, 1.553e-01) * s0_2_0;
	r0 += V4(1.820e-01, -4.644e-03, 2.163e-01, -4.558e-02) * s0_2_1;
	r1 += V4(-8.862e-02, -4.277e-03, -1.714e-01, 5.592e-03) * s0_2_1;
	r2 += V4(-1.544e-02, 1.755e-01, -8.262e-01, 2.927e-02) * s0_2_1;
	r0 += V4(4.434e-03, 7.228e-04, 4.655e-01, -7.633e-02) * s0_2_2;
	r1 += V4(1.211e-02, 9.734e-03, -8.916e-02, 2.104e-01) * s0_2_2;
	r2 += V4(-7.300e-01, -3.384e-02, 2.111e-03, -2.049e-01) * s0_2_2;
	r0 += V4(1.489e-01, -1.484e-05, -9.884e-04, 2.526e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(1.374e-02, 5.631e-06, 1.011e-02, 8.364e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(7.687e-07, 6.457e-04, -1.144e-04, 1.567e-03);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), vec4(r2));
}

//!DESC [CuNNy_3x12_vk] -conv1
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
	r0 = D(r0, s0_0_0, 0xFD0B1002, 0xFDD81501, 0xFD010A05, 0xF211E210);
	r1 = D(r1, s0_0_0, 0x04CA360D, 0x1F07DCE8, 0xF1CD59C5, 0x040F0B0A);
	r2 = D(r2, s0_0_0, 0x030224FD, 0xF904FD00, 0x0CF6E405, 0x09FB0808);
	r0 = D(r0, s0_0_1, 0xEF2F09DF, 0x01E2B525, 0x02081705, 0x0F43F8E2);
	r1 = D(r1, s0_0_1, 0xFCE212F3, 0x1D0E81DE, 0xD906E81B, 0x080F00E6);
	r2 = D(r2, s0_0_1, 0x02FE1DF2, 0x1416FF13, 0xEECBE808, 0x0504E010);
	r0 = D(r0, s0_0_2, 0x1641DF1B, 0x00F4FD07, 0xFF0108FA, 0xE819FF11);
	r1 = D(r1, s0_0_2, 0x13ED01E6, 0x050FE2F8, 0x43E7F3E9, 0x0E1000F4);
	r2 = D(r2, s0_0_2, 0xF50ED704, 0xFA080903, 0xFFEE0FED, 0xFDF70A00);
	r0 = D(r0, s0_1_0, 0xE43CE9DF, 0x01EBEB25, 0xF506110E, 0x814C9E1E);
	r1 = D(r1, s0_1_0, 0x28F98105, 0x1A03F817, 0xF7E2EC43, 0x241FBEE9);
	r2 = D(r2, s0_1_0, 0xF8F40FE4, 0xD5F94417, 0xE8FD04EF, 0xE4E01316);
	r0 = D(r0, s0_1_1, 0xE57FA0D2, 0xFE917FB6, 0xEA074DE4, 0xC44E18EC);
	r1 = D(r1, s0_1_1, 0x413A2245, 0xBDE667E4, 0xCB915CCC, 0xE5F7814C);
	r2 = D(r2, s0_1_1, 0xD6E219CB, 0xB9F37FDC, 0xE6EB7FEF, 0xE3D01036);
	r0 = D(r0, s0_1_2, 0xFD2DE122, 0x41C8E6EE, 0xF9FE0701, 0xEF1E08EB);
	r1 = D(r1, s0_1_2, 0xEAEA1FDE, 0x3CDDF327, 0x1EBF2325, 0xEFFCFFFE);
	r2 = D(r2, s0_1_2, 0xD42C817F, 0x0102160B, 0xF20B0C0D, 0xF6E31DD5);
	r0 = D(r0, s0_2_0, 0xD7FD0322, 0xF7FE2DE5, 0x0E03E1FC, 0x07219921);
	r1 = D(r1, s0_2_0, 0xCB041208, 0x1800E7FE, 0xFED718EF, 0xF6F72203);
	r2 = D(r2, s0_2_0, 0x0417E105, 0x3204D5FD, 0x02050604, 0xF6F226ED);
	r0 = D(r0, s0_2_1, 0xF729CFF8, 0x1DE22C35, 0xFE0F0904, 0xED2BCBFB);
	r1 = D(r1, s0_2_1, 0xF7EF25E5, 0xFA02E304, 0xF0F5AE18, 0x10FEE009);
	r2 = D(r2, s0_2_1, 0xEC11E9D3, 0x1225E319, 0xF007F90D, 0x030B0C15);
	r0 = D(r0, s0_2_2, 0xF206F7F0, 0x06FF14F7, 0xF20209FB, 0xEC0B00F5);
	r1 = D(r1, s0_2_2, 0x06FD130E, 0x0BFDF9FB, 0xE1F729F1, 0x0D09FBFA);
	r2 = D(r2, s0_2_2, 0x1812C61B, 0xF0FF05EF, 0xF504FC03, 0xFFF608F0);
	r0 = D(r0, s1_0_0, 0xF819F7F3, 0x1A0D1304, 0xFC03FE10, 0xDBEBDE30);
	r1 = D(r1, s1_0_0, 0xF7DE0424, 0x0EF608FC, 0x03012AE4, 0x0006FC11);
	r2 = D(r2, s1_0_0, 0x060FF205, 0xFC040406, 0xF7DA0E0F, 0xFB16FD18);
	r0 = D(r0, s1_0_1, 0xE9F914F9, 0x16130B0E, 0xFF00FC3F, 0xE0E9F254);
	r1 = D(r1, s1_0_1, 0x11DE05E3, 0xF5EC1F06, 0x0BA35ED7, 0x03D701C1);
	r2 = D(r2, s1_0_1, 0x01E8FCF8, 0xF60EF109, 0x003CE74D, 0xF31A03C4);
	r0 = D(r0, s1_0_2, 0xFAE4EF09, 0x100BF5E5, 0x05FA0413, 0xF30019F7);
	r1 = D(r1, s1_0_2, 0x06EA001F, 0x0C08FDED, 0xF64DC9FF, 0x090CEFDA);
	r2 = D(r2, s1_0_2, 0xF6FA06DD, 0x02FC110F, 0xFD230840, 0x03150724);
	r0 = D(r0, s1_1_0, 0xE4EE1EDC, 0xEBE539B5, 0x020405F1, 0xFC1EFC12);
	r1 = D(r1, s1_1_0, 0x0121061D, 0xF9F5E00E, 0x0E22E5F8, 0xF2F00E01);
	r2 = D(r2, s1_1_0, 0x0401FEF6, 0xFD03F8E4, 0x140FD8FB, 0x13F5FFE9);
	r0 = D(r0, s1_1_1, 0x05121194, 0xECB84837, 0x04EF2881, 0x08F7E2BA);
	r1 = D(r1, s1_1_1, 0x197FACE2, 0x03F87F09, 0xCCA92128, 0x197A8E50);
	r2 = D(r2, s1_1_1, 0xF5AE1806, 0x09E42212, 0xF2D47BCB, 0x02CA0F15);
	r0 = D(r0, s1_1_2, 0x192AAD37, 0x1217AF01, 0x02F10812, 0xF3F408E0);
	r1 = D(r1, s1_1_2, 0x0FF03835, 0x242181F6, 0xFA18E6F4, 0x15E61004);
	r2 = D(r2, s1_1_2, 0xF961CC2C, 0x14E2E7DB, 0xEFF71EC6, 0x09DDF906);
	r0 = D(r0, s1_2_0, 0x0CF7E22D, 0xF317FA29, 0x0001FDF2, 0x01F3C9E2);
	r1 = D(r1, s1_2_0, 0x0A0C04F1, 0xF817ECE4, 0x11EBBB02, 0x1010EF02);
	r2 = D(r2, s1_2_0, 0xDFF023F1, 0xFCFCDDFF, 0xFB14F4F7, 0x17F60F17);
	r0 = D(r0, s1_2_1, 0x0AFCC421, 0xBBD66FF6, 0xFA01462F, 0xDF002C0C);
	r1 = D(r1, s1_2_1, 0x0D2883C7, 0xFB0A32F3, 0xF95FBC13, 0x1FFC81F8);
	r2 = D(r2, s1_2_1, 0xF4FA6010, 0xE3DE5501, 0xE4EB36E3, 0xEECE32FB);
	r0 = D(r0, s1_2_2, 0xE2D90211, 0xFED62B18, 0xFB002AFE, 0xF50906F8);
	r1 = D(r1, s1_2_2, 0xFFE82CD9, 0x0601111A, 0xFB007F12, 0x05FEECFE);
	r2 = D(r2, s1_2_2, 0xEB178104, 0x02FD0B2E, 0x0417F2F0, 0xFC09170F);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x1016E63A, 0xF50212EA, 0x0103FB0A, 0x0FFCD059);
	r1 = D(r1, s0_0_0, 0x02E604EF, 0xFDF1110F, 0xF1E10316, 0x0F030681);
	r2 = D(r2, s0_0_0, 0x0B18F201, 0xF7FF0204, 0xFEF3F837, 0xEEDA0CDB);
	r0 = D(r0, s0_0_1, 0xFE31DC2C, 0xD64E1408, 0x0C11F70A, 0x3D1DDCFE);
	r1 = D(r1, s0_0_1, 0x130ACA32, 0xE0F918F8, 0x91F62C18, 0x0C81FCF2);
	r2 = D(r2, s0_0_1, 0x0AFCF2AA, 0x0724FD0D, 0x09F8D629, 0xFE9E141E);
	r0 = D(r0, s0_0_2, 0x0E07AF02, 0xF0B624EA, 0x03F709FE, 0x1012D916);
	r1 = D(r1, s0_0_2, 0x0781D300, 0xD7FB66EC, 0xE44808F7, 0x16F3E2F2);
	r2 = D(r2, s0_0_2, 0x0A81E704, 0xF8372BFE, 0xF6E244FF, 0xEA463FFF);
	r0 = D(r0, s0_1_0, 0x1404F11C, 0x08E81F13, 0x0D00010A, 0x5416C8FD);
	r1 = D(r1, s0_1_0, 0xEAF127D1, 0x0C0009F3, 0x26F21BD9, 0xF5F6FD0C);
	r2 = D(r2, s0_1_0, 0xFD1AE70B, 0x0B05090F, 0x2D040306, 0xF2F30B0D);
	r0 = D(r0, s0_1_1, 0x03E3B116, 0xD9B6CC2F, 0x1509DE1C, 0x45568CFA);
	r1 = D(r1, s0_1_1, 0x16D52BA4, 0x071C080B, 0x05B97559, 0x14E7B7CA);
	r2 = D(r2, s0_1_1, 0xEE55DFF8, 0x2833BA36, 0x0C02F1F1, 0x37D5DB35);
	r0 = D(r0, s0_1_2, 0x19468C00, 0xF004EE04, 0x07FEEC04, 0x2932F0F8);
	r1 = D(r1, s0_1_2, 0x11D91809, 0x0E08FAF8, 0xBD23FAF9, 0x0E27F906);
	r2 = D(r2, s0_1_2, 0x0DE189F3, 0x0B41E5F9, 0xF30A20FF, 0x0C0D19F9);
	r0 = D(r0, s0_2_0, 0x1505FF07, 0x22F50914, 0x1301FE00, 0x2D07E702);
	r1 = D(r1, s0_2_0, 0xDDFE07F8, 0xF803FAFA, 0xE8FD0702, 0x09010901);
	r2 = D(r2, s0_2_0, 0x040AEFEE, 0x1AFBF70B, 0x11FFF500, 0x01020610);
	r0 = D(r0, s0_2_1, 0x2CFBEDFC, 0xD4F70D00, 0x1A02FDF9, 0x2C02D8FB);
	r1 = D(r1, s0_2_1, 0x0D11060C, 0xF10010FF, 0x1DF60FDB, 0xEC04FD04);
	r2 = D(r2, s0_2_1, 0xCF0BF917, 0x20FAF1F5, 0x030CFDFE, 0xFF07F1FE);
	r0 = D(r0, s0_2_2, 0x1403D70B, 0xCEFC2405, 0x0102FD03, 0x070AE707);
	r1 = D(r1, s0_2_2, 0x17FA07FB, 0x08F901FA, 0xF109FFFD, 0x2505FCFB);
	r2 = D(r2, s0_2_2, 0x17F8F6FB, 0xEC04F50E, 0xEE05FC00, 0xE4090308);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(5.441e-02, -5.480e-03, 1.885e-02, 2.820e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-1.641e-02, 4.046e-02, 1.572e-02, -4.020e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-2.303e-02, -1.477e-02, 2.745e-03, -4.317e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_3x12_vk] -conv2
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
	r0 = D(r0, s0_0_0, 0xECD1200B, 0xF90D0904, 0x050BFDF4, 0x01FDFAF5);
	r1 = D(r1, s0_0_0, 0x08FBFBE4, 0xF6EBF009, 0xFAA8FF26, 0xF227F70D);
	r2 = D(r2, s0_0_0, 0xFFFCFEFE, 0x0408FBF3, 0x0916FCD6, 0x00E2050B);
	r0 = D(r0, s0_0_1, 0xEA4220BA, 0x072826D3, 0x0C500EE3, 0x1A0828E8);
	r1 = D(r1, s0_0_1, 0x1114EEFB, 0x053DF2EE, 0xC6BBF439, 0x2C0C1BBD);
	r2 = D(r2, s0_0_1, 0x0814FCFA, 0xFEF10005, 0xF3DC16ED, 0xF90BFC00);
	r0 = D(r0, s0_0_2, 0x16E9F707, 0x162403E7, 0x051306F3, 0x1F00F70B);
	r1 = D(r1, s0_0_2, 0x060CFC02, 0xFFF5D1F3, 0xEDE90B0B, 0x3D35D1BB);
	r2 = D(r2, s0_0_2, 0x0B3702F2, 0x000000FE, 0xF70506E6, 0x0629FCF6);
	r0 = D(r0, s0_1_0, 0xE13801D6, 0x0321E5F4, 0xFF2F02F5, 0xFE120A00);
	r1 = D(r1, s0_1_0, 0xFB3A05E1, 0x040DCCF3, 0x124716E1, 0xFF78D0EE);
	r2 = D(r2, s0_1_0, 0x06F6FA05, 0x0126FEF4, 0x1821E7DF, 0xF8F9070D);
	r0 = D(r0, s0_1_1, 0x39A000B6, 0xEA81E27F, 0xFBDCFDF9, 0xF0CBF120);
	r1 = D(r1, s0_1_1, 0xDC81F863, 0x1BDB0FCA, 0x347D39CF, 0xC042E0EE);
	r2 = D(r2, s0_1_1, 0x000E07EF, 0x0FBEECD4, 0xDED731C6, 0x0A5904E0);
	r0 = D(r0, s0_1_2, 0xE0311510, 0xD21FEED7, 0x03F1F605, 0xCD1309ED);
	r1 = D(r1, s0_1_2, 0xF0FD0404, 0x121AE9EF, 0x2DD8FC0A, 0xE4F50B04);
	r2 = D(r2, s0_1_2, 0xEC0CFBFD, 0x09190C07, 0xEB08EEC4, 0xEBE2F4EC);
	r0 = D(r0, s0_2_0, 0xFCF9FAF8, 0x0116090B, 0x01FB0204, 0xFCF8F3EC);
	r1 = D(r1, s0_2_0, 0xFC1D02EC, 0x0806F2F8, 0xEEED19D7, 0x112211D6);
	r2 = D(r2, s0_2_0, 0x05020304, 0xFA0701FE, 0x15F10BF6, 0x00F60400);
	r0 = D(r0, s0_2_1, 0xE4FA0200, 0x2BED15F0, 0xFA130012, 0xF50F24D5);
	r1 = D(r1, s0_2_1, 0x01EE1ADA, 0x04D2EB02, 0x0EBD28E9, 0x5CF91CEA);
	r2 = D(r2, s0_2_1, 0xFDF1F7F6, 0xF8FB090C, 0xD82B03FB, 0x0615FCF0);
	r0 = D(r0, s0_2_2, 0xEE1914E9, 0x290AFCD1, 0xE600F70B, 0x0907230B);
	r1 = D(r1, s0_2_2, 0x171510E8, 0xF412F4FA, 0xDE4113EE, 0xFDFA0205);
	r2 = D(r2, s0_2_2, 0x05FE0402, 0xF8000002, 0x01F711DD, 0x0EEB0CF9);
	r0 = D(r0, s1_0_0, 0x2D16E6F7, 0x0708FCE8, 0x01FC01FA, 0x05FBF905);
	r1 = D(r1, s1_0_0, 0x0007FD0D, 0x18FFED14, 0x22F5DD1E, 0x52F306DB);
	r2 = D(r2, s1_0_0, 0xFC0BF702, 0x03F90005, 0x1122F508, 0x03F500FF);
	r0 = D(r0, s1_0_1, 0x1C13FADC, 0x53F10CEA, 0x13FA0ED7, 0x06000601);
	r1 = D(r1, s1_0_1, 0xF20507F0, 0xEDF2F4DE, 0x2212F309, 0xCD9813EB);
	r2 = D(r2, s1_0_1, 0xF10A03F7, 0x1904FCF6, 0x5528E9FA, 0xF2FEFB07);
	r0 = D(r0, s1_0_2, 0x0C080004, 0x230AFBDA, 0x0E03FFF3, 0x050400FA);
	r1 = D(r1, s1_0_2, 0xF80102F7, 0x2B0301F7, 0x04F5F511, 0xB9EE0FC2);
	r2 = D(r2, s1_0_2, 0xD3FD0EE3, 0xFFFCFEF9, 0xD6FDFAE8, 0x05F909EB);
	r0 = D(r0, s1_1_0, 0x24010200, 0xF8F01AFF, 0x050A0BF1, 0x1CFF0600);
	r1 = D(r1, s1_1_0, 0x2D29E10C, 0xDB01F617, 0x9F102FF7, 0x81032CC6);
	r2 = D(r2, s1_1_0, 0xF807FF0C, 0x160106F4, 0xDA28EB06, 0x14FB0903);
	r0 = D(r0, s1_1_1, 0x2E36F2F1, 0x5A0DFD17, 0x2101FAE0, 0x4607D2F7);
	r1 = D(r1, s1_1_1, 0x59FFB906, 0x57E9CBFB, 0x81B5F5EF, 0x9E26EAA2);
	r2 = D(r2, s1_1_1, 0x21FA2AF2, 0x20FB18F1, 0x6A0112B4, 0x9514F010);
	r0 = D(r0, s1_1_2, 0xF203F3E2, 0x2F16FCDF, 0x2B0509F5, 0x1BECF113);
	r1 = D(r1, s1_1_2, 0x20FEFB2A, 0x250F08D6, 0x17F40004, 0x5A03C4A3);
	r2 = D(r2, s1_1_2, 0xF1050BEF, 0x0506FCF0, 0x4317EDF9, 0xF3FC00F6);
	r0 = D(r0, s1_2_0, 0xF90FDC05, 0xED03FBFB, 0x0808EBFC, 0xF7FEF3F8);
	r1 = D(r1, s1_2_0, 0x1C0CF4F9, 0xF0FD0AF2, 0x4EDA07C4, 0x73D1AABF);
	r2 = D(r2, s1_2_0, 0x040007FF, 0x0800F8FB, 0x24FAF2EA, 0x0902FB01);
	r0 = D(r0, s1_2_1, 0x2220DE00, 0x6903CFFC, 0xDD08FF0F, 0xA8DB28CD);
	r1 = D(r1, s1_2_1, 0x26FDF1B6, 0x1E06E7E6, 0xCCF826A6, 0x64F0F79B);
	r2 = D(r2, s1_2_1, 0x1701E202, 0xFF08F9F9, 0xEA19A80A, 0xFC05EC0E);
	r0 = D(r0, s1_2_2, 0x1A05FAEA, 0x3C0AF4FE, 0xED04FD13, 0xF3EA15C8);
	r1 = D(r1, s1_2_2, 0x24F613D5, 0xE400E8F5, 0xEF09E4D3, 0x13E009F8);
	r2 = D(r2, s1_2_2, 0x0D0108FB, 0xF5040200, 0x3A1F000A, 0x120DF701);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x08100B14, 0xF609F5FD, 0xFEFDF207, 0xFA02FA14);
	r1 = D(r1, s0_0_0, 0xE60106F7, 0x0104FB10, 0x200C152A, 0x2BFFD1DC);
	r2 = D(r2, s0_0_0, 0xFBFE0103, 0xF9000311, 0x0007F6F5, 0x0001030B);
	r0 = D(r0, s0_0_1, 0xF8FC09F3, 0xF0F3090D, 0xF2FCFC0A, 0x0DEEED08);
	r1 = D(r1, s0_0_1, 0x05F5EB26, 0xEDF70C18, 0x080F1715, 0x020EFD85);
	r2 = D(r2, s0_0_1, 0x07F3FCF7, 0xFA071712, 0x11041CF6, 0x0102F9E9);
	r0 = D(r0, s0_0_2, 0x02FAF333, 0xE61A0D0D, 0xF91002CC, 0x0205E10D);
	r1 = D(r1, s0_0_2, 0x0D01ECEB, 0xE809100B, 0x0CF91221, 0xFD28D41E);
	r2 = D(r2, s0_0_2, 0xFBFBE403, 0x0D00F227, 0x15F4EA11, 0xFFF7EA22);
	r0 = D(r0, s0_1_0, 0xCEF71728, 0x02FDDAE8, 0xF109ED14, 0xFFFC0204);
	r1 = D(r1, s0_1_0, 0xEBFF3535, 0xEE1FF20C, 0xE1DAE281, 0xCB14C9D9);
	r2 = D(r2, s0_1_0, 0xF00504EE, 0x0008FA15, 0xF009F0BD, 0x0BF5FD01);
	r0 = D(r0, s0_1_1, 0x00EE15C3, 0x3FF8F20F, 0xED110F05, 0x08DE4532);
	r1 = D(r1, s0_1_1, 0x4EFDE230, 0x1DCF3612, 0xE7D4F2FF, 0xD8FAF957);
	r2 = D(r2, s0_1_1, 0x25F90E16, 0xE40942DB, 0xEFF42A4E, 0xF713F9DD);
	r0 = D(r0, s0_1_2, 0x1EF7E642, 0x08140BC7, 0x0701F5F8, 0x0DED17CF);
	r1 = D(r1, s0_1_2, 0x04D500FB, 0xF413F128, 0xF924ED19, 0xF3593487);
	r2 = D(r2, s0_1_2, 0xE0082BFA, 0xFE0D0005, 0xEB1420CF, 0xD8F0440D);
	r0 = D(r0, s0_2_0, 0x06FA040E, 0x030BDB18, 0x0310FB02, 0xE51606E9);
	r1 = D(r1, s0_2_0, 0xE6161219, 0xFB33F01F, 0xF61CF0CB, 0xF62AE415);
	r2 = D(r2, s0_2_0, 0x0305F905, 0xFB0EFFFF, 0x040AECDC, 0xFDFDFD07);
	r0 = D(r0, s0_2_1, 0xF41A0CE0, 0xE6B0F1CD, 0x1224EA1D, 0xE72EC20E);
	r1 = D(r1, s0_2_1, 0xDC18ED14, 0xEF19201F, 0x00F316F6, 0xE225D181);
	r2 = D(r2, s0_2_1, 0xFDF91000, 0x0627FB1A, 0xFDE3292D, 0xEAFD0D1E);
	r0 = D(r0, s0_2_2, 0x0EFBF31D, 0xF3090509, 0xFE0CFF01, 0xFD3305E9);
	r1 = D(r1, s0_2_2, 0xEA030DDA, 0x0C040115, 0x16160105, 0xECE7F32D);
	r2 = D(r2, s0_2_2, 0x0DF7F304, 0xFE09FAFD, 0xF1FAF3EF, 0xFEFF03F9);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-2.171e-02, -1.552e-02, 5.913e-03, -7.842e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-1.022e-02, -1.293e-02, -1.120e-02, 3.281e-04);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-8.795e-03, -6.113e-03, -2.184e-02, -3.273e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_3x12_vk] -conv3
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
	r0 = D(r0, s0_0_0, 0x1C00F407, 0x0CFB0600, 0xFF030103, 0xFB0CE4FE);
	r1 = D(r1, s0_0_0, 0xFAF407FB, 0xFAF403FA, 0xF4F205F7, 0xF9F307FA);
	r2 = D(r2, s0_0_0, 0x16F5FB01, 0x08010001, 0x0701EE00, 0x040504FE);
	r0 = D(r0, s0_0_1, 0x460FF4F9, 0x3302F0FC, 0x0BF9F800, 0xFCF702F4);
	r1 = D(r1, s0_0_1, 0x0801F1F0, 0x0801EDEE, 0x01FFEFEF, 0x0800F1F0);
	r2 = D(r2, s0_0_1, 0x040BECFC, 0x29FFF403, 0x513AEE0C, 0x02EBCF04);
	r0 = D(r0, s0_0_2, 0x09FC0002, 0x0502FEFC, 0x0801FFF9, 0x0006FE01);
	r1 = D(r1, s0_0_2, 0x1602F204, 0x1602F002, 0x0F00F103, 0x1601F204);
	r2 = D(r2, s0_0_2, 0x1008F806, 0x0A0202FE, 0x1704F6EE, 0x1F17F302);
	r0 = D(r0, s0_1_0, 0xFCF3D602, 0xFAEBFCFA, 0x05040400, 0xF3EDE102);
	r1 = D(r1, s0_1_0, 0xEFFC03F3, 0xF20105F8, 0xF2FF09F2, 0xF1FB02F5);
	r2 = D(r2, s0_1_0, 0x02E6F0F1, 0xFDEFF6FC, 0x07FD0709, 0x01FF0000);
	r0 = D(r0, s0_1_1, 0xFC10D2CF, 0xE6FDE6FB, 0xEFECD810, 0xF90CFE08);
	r1 = D(r1, s0_1_1, 0x1301E9E8, 0x1503EAEA, 0x1302EBE8, 0x1502E8EA);
	r2 = D(r2, s0_1_1, 0x0BC9D910, 0xEF01ECEB, 0x3695A8F6, 0xF9DFE611);
	r0 = D(r0, s0_1_2, 0x0503FEFE, 0xFC08F905, 0x0303F0F4, 0x0004FD02);
	r1 = D(r1, s0_1_2, 0xEF13E9F5, 0xF115E8F9, 0xEF14EDF7, 0xF114E8F8);
	r2 = D(r2, s0_1_2, 0xF903FDF2, 0x07FEF50E, 0x1BE6E7E1, 0x12EDE8B7);
	r0 = D(r0, s0_2_0, 0x03EF0100, 0x05F90500, 0x0202FDFF, 0xFB09FFFF);
	r1 = D(r1, s0_2_0, 0x06F81000, 0xFBFC1600, 0x00F71000, 0xFEF313FD);
	r2 = D(r2, s0_2_0, 0x020402FF, 0x07FAFDF8, 0xF1130704, 0x000200FE);
	r0 = D(r0, s0_2_1, 0x020304F7, 0x04E9020A, 0x03EBFAFE, 0x00FF0206);
	r1 = D(r1, s0_2_1, 0xF4F60904, 0xF1F80700, 0xF5F70506, 0xF5F80A05);
	r2 = D(r2, s0_2_1, 0xFB080709, 0x05EEFD1E, 0xF01E00F3, 0x010101FB);
	r0 = D(r0, s0_2_2, 0x01020007, 0x000301F3, 0x0007FEEF, 0xFC0501FD);
	r1 = D(r1, s0_2_2, 0x02E8E7EA, 0x03EAE5E7, 0x03E7E2EA, 0x03E9E6EB);
	r2 = D(r2, s0_2_2, 0x0002FFFA, 0xFE03FEE8, 0xE3240F24, 0xF90B060B);
	r0 = D(r0, s1_0_0, 0xF60000F9, 0xFDFCFBF8, 0xFF0002FE, 0xFCFFFAFD);
	r1 = D(r1, s1_0_0, 0x130BF5E4, 0x1A0EF3E2, 0x180EF0DB, 0x160CF5E4);
	r2 = D(r2, s1_0_0, 0xFDF8F9F6, 0xFBFF00FB, 0x072110F7, 0xFEFEFAFE);
	r0 = D(r0, s1_0_1, 0x08E601DB, 0x01F702E7, 0x020504FC, 0xFE01FB0C);
	r1 = D(r1, s1_0_1, 0xFB0E02ED, 0x041000EB, 0xFF10F9E4, 0xFF0F02ED);
	r2 = D(r2, s1_0_1, 0x000905D0, 0x05F108EB, 0xEC45FB9E, 0x07030DF1);
	r0 = D(r0, s1_0_2, 0x02040201, 0x03F501FF, 0x05E804FC, 0x01FF0202);
	r1 = D(r1, s1_0_2, 0xF709F0EA, 0xFF0BEDE8, 0xFA0AEAE2, 0xFD0AEFEA);
	r2 = D(r2, s1_0_2, 0xF0FA02EE, 0x03F701FE, 0xE73EF9F8, 0xF001F6CD);
	r0 = D(r0, s1_1_0, 0xF50104F5, 0x000004FC, 0xFE01F0FE, 0x0CF90106);
	r1 = D(r1, s1_1_0, 0xF800F3E5, 0xF8FDF1E8, 0xF401EDE3, 0xF8FEF2E3);
	r2 = D(r2, s1_1_0, 0xFEFB0DF8, 0x00FE03F6, 0x13F709F3, 0x02FEFF00);
	r0 = D(r0, s1_1_1, 0xE60CE6DF, 0xECF9E7E8, 0xF8FF0AF6, 0x05FCF209);
	r1 = D(r1, s1_1_1, 0x05E60807, 0x06E50308, 0x04E40100, 0x05E60807);
	r2 = D(r2, s1_1_1, 0x08EABBE2, 0xDE0CDAE8, 0x1BE2E697, 0xF7FCE5F8);
	r0 = D(r0, s1_1_2, 0x08FCF504, 0xFF05FCFC, 0xF31BF6BC, 0x040208FF);
	r1 = D(r1, s1_1_2, 0xF2F0F1F8, 0xF2F0EFF7, 0xF2EFE9F4, 0xF1EFF1F9);
	r2 = D(r2, s1_1_2, 0x0CFE10FF, 0x061208F4, 0x06E71BE0, 0x18F021CF);
	r0 = D(r0, s1_2_0, 0x07FEF0FD, 0x02FFFDFB, 0x00FE03FF, 0xFAFEFF00);
	r1 = D(r1, s1_2_0, 0x12F5EC0E, 0x13F6EA08, 0x10FBEA0D, 0x12F9EE0A);
	r2 = D(r2, s1_2_0, 0x03FF03FE, 0x01FE08FD, 0xE9FB0008, 0x00000200);
	r0 = D(r0, s1_2_1, 0x03FF07FE, 0x06FFFFF2, 0x10FFDFFC, 0xFCFFFBFE);
	r1 = D(r1, s1_2_1, 0xF30CFA16, 0xF40EF811, 0xF012F818, 0xF310FA15);
	r2 = D(r2, s1_2_1, 0xEF0004FE, 0x13FCEEEE, 0xE604040C, 0xFDFFFB00);
	r0 = D(r0, s1_2_2, 0x00FEFB01, 0xFD0006FB, 0xFCFA1CF3, 0x00000202);
	r1 = D(r1, s1_2_2, 0xE5E4EAFE, 0xE5E9E9F9, 0xDFF0E401, 0xE5E9EAFD);
	r2 = D(r2, s1_2_2, 0xFE00FDFF, 0xF8FB07FF, 0xCE04EE03, 0xF000FE01);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x181402FD, 0x060B00FD, 0x00FDFE01, 0x1213FBF9);
	r1 = D(r1, s0_0_0, 0xD20702DF, 0xD90403E3, 0xD507FEE3, 0xCF07FEDD);
	r2 = D(r2, s0_0_0, 0x0A0C07FF, 0x08060000, 0xECFC02F2, 0x03FEFFFF);
	r0 = D(r0, s0_0_1, 0x020324F1, 0xFC0217F8, 0xFC060102, 0xFFF70901);
	r1 = D(r1, s0_0_1, 0xD2EBEFDF, 0xE1E9F0E3, 0xD5EBE9E0, 0xD0EBEDDF);
	r2 = D(r2, s0_0_1, 0x240B36E2, 0x04050DF9, 0xF10FF01B, 0x130B0F00);
	r0 = D(r0, s0_0_2, 0x02FD08FF, 0x04FB08FF, 0x03FC04FF, 0xFD01FA02);
	r1 = D(r1, s0_0_2, 0xE6FEEF0D, 0xECFCF010, 0xE6FEEC11, 0xE1FEED10);
	r2 = D(r2, s0_0_2, 0x00FE0EFD, 0x02FD08FE, 0x01FF0FF1, 0x060529EB);
	r0 = D(r0, s0_1_0, 0x24FB2113, 0xF4072115, 0x00FCFFFC, 0x3FE2FF14);
	r1 = D(r1, s0_1_0, 0xF7F7E8DE, 0xFBF9ECE8, 0xF3F8EDE6, 0xF2FCE7D9);
	r2 = D(r2, s0_1_0, 0x0A0B233F, 0xF8091917, 0x5B1802E8, 0xFBF80100);
	r0 = D(r0, s0_1_1, 0x261FF7F3, 0x17E757F6, 0x24F12409, 0xFB051302);
	r1 = D(r1, s0_1_1, 0xEEF4EBE3, 0xFBF7EFE9, 0xE9F3ECE6, 0xEEF9EBE1);
	r2 = D(r2, s0_1_1, 0x2ECA0518, 0x3CF026E7, 0x0BD5E4F9, 0x3E023841);
	r0 = D(r0, s0_1_2, 0x04FE10F8, 0xFD0EFC01, 0xFB1DFEF9, 0xFD05F403);
	r1 = D(r1, s0_1_2, 0xF6E5FC03, 0xF8E70006, 0xF1E5FD06, 0xF2E7FC02);
	r2 = D(r2, s0_1_2, 0x010FEBFF, 0xFB04F704, 0xFB0DCF0A, 0xFA22BDFE);
	r0 = D(r0, s0_2_0, 0x100D0AF8, 0xFD050409, 0xFEFBFF03, 0xF403F309);
	r1 = D(r1, s0_2_0, 0xF604F1E7, 0xF7FDF3E7, 0xF201EEE8, 0xF6FFF3E6);
	r2 = D(r2, s0_2_0, 0xFCFFFE08, 0x0C010726, 0xDFFAFEF8, 0xFE01FE02);
	r0 = D(r0, s0_2_1, 0x06F8F2FA, 0xF8090905, 0x170D1645, 0xFEFC0AFD);
	r1 = D(r1, s0_2_1, 0xCB09DDED, 0xDB04DFF2, 0xC60AD9EC, 0xCC0BDDEC);
	r2 = D(r2, s0_2_1, 0xFB090107, 0x0DEFFA28, 0xE0091208, 0xF8020109);
	r0 = D(r0, s0_2_2, 0x01FC0001, 0x0003FDFE, 0xFB07DE01, 0xFF02FD00);
	r1 = D(r1, s0_2_2, 0xEAF500EF, 0xF1F105F0, 0xE4F4FCE8, 0xE8F500EF);
	r2 = D(r2, s0_2_2, 0xFD01FF02, 0xFF0BF4FF, 0xF410020F, 0x02FF0501);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-3.207e-03, -2.127e-03, -3.314e-03, -2.763e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-2.312e-01, -1.909e-01, -1.665e-01, -1.896e-01);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-3.513e-03, -3.102e-03, -1.696e-02, -3.687e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_3x12_vk] -out-shuffle
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
	r0 += M4(5.914e-03, -1.432e-02, 7.037e-04, -1.714e-03, -1.188e-01, -1.871e-02, -1.021e-02, -1.122e-03, 1.671e-01, 8.285e-02, -3.275e-03, -1.950e-02, 3.900e-08, -1.093e-07, -1.904e-07, 1.871e-04) * s0_0_0;
	r0 += M4(-1.265e-01, -4.666e-03, 1.546e-03, 7.270e-03, 2.285e-03, -1.675e-01, -8.091e-03, -2.533e-02, 3.096e-04, 1.792e-01, -1.457e-03, 1.839e-02, 2.128e-02, -1.326e-02, -6.940e-04, -2.723e-03) * s0_0_1;
	r0 += M4(-1.132e-02, -7.739e-02, 4.751e-03, -1.009e-02, -1.606e-02, 4.063e-02, -5.169e-03, 1.303e-02, 4.774e-03, -1.434e-02, 2.113e-03, -7.055e-03, -3.838e-03, 5.294e-02, -1.842e-02, -1.308e-02) * s0_0_2;
	r0 += M4(5.481e-02, -7.174e-03, 5.505e-02, -1.577e-02, 6.030e-03, -2.088e-02, -1.851e-01, -2.099e-03, -1.156e-02, -2.252e-02, -5.322e-01, 1.450e-01, 2.525e-03, 3.041e-04, 1.992e-06, 1.049e-04) * s0_1_0;
	r0 += M4(1.282e-01, 2.159e-01, -3.951e-01, 9.605e-02, 1.975e-01, 1.841e-01, 1.824e-01, -8.375e-02, -6.190e-02, 2.119e-02, -2.159e-02, 2.259e-01, 2.386e-01, 7.856e-03, 1.613e-01, 8.964e-03) * s0_1_1;
	r0 += M4(-2.375e-02, -2.323e-02, -2.324e-02, -1.255e-01, 3.396e-03, 5.481e-02, 3.875e-03, 7.886e-02, -2.275e-03, -1.679e-02, -1.913e-03, -3.539e-02, -2.764e-01, -1.009e-01, -2.216e-02, 7.154e-02) * s0_1_2;
	r0 += M4(-3.802e-04, 2.775e-05, 1.903e-02, -1.549e-03, -1.168e-02, -4.615e-03, -3.772e-02, -4.406e-02, -1.795e-03, 4.430e-03, -4.061e-02, -2.948e-02, -2.964e-03, -2.524e-05, -3.166e-03, -1.548e-05) * s0_2_0;
	r0 += M4(-5.548e-03, -1.096e-03, 1.025e-01, 9.839e-02, -1.776e-02, -3.746e-03, 2.378e-02, 5.630e-02, -6.353e-03, 4.868e-03, -2.167e-02, -2.440e-02, -5.311e-04, 2.508e-03, 5.533e-02, -1.243e-02) * s0_2_1;
	r0 += M4(1.477e-02, 2.230e-03, 1.295e-02, 1.179e-02, 1.229e-03, -2.502e-03, -4.091e-03, 2.210e-03, -3.053e-04, -5.222e-04, 1.670e-03, -6.048e-03, 3.473e-02, 1.250e-03, -8.765e-02, -1.845e-02) * s0_2_2;
	r0 += M4(2.915e-02, 4.374e-02, -4.534e-02, -6.523e-02, -1.134e-01, -1.123e-01, -1.183e-01, -1.125e-01, 1.737e-02, 2.522e-02, 1.042e-01, 2.999e-02, 6.977e-02, 7.073e-02, 4.451e-03, -2.356e-02) * s1_0_0;
	r0 += M4(1.090e-01, 1.197e-01, 5.894e-02, 3.541e-02, 6.266e-02, 7.786e-02, 9.484e-02, 7.543e-02, 1.227e-02, 1.353e-02, 5.362e-02, 4.709e-02, 2.844e-02, 3.728e-02, 1.602e-02, 1.320e-02) * s1_0_1;
	r0 += M4(8.843e-02, 1.158e-01, 1.252e-03, 5.994e-03, 5.333e-03, 4.682e-03, -8.049e-03, 2.594e-03, 6.018e-02, 3.021e-02, 6.763e-04, 1.186e-02, 4.325e-02, 5.116e-02, 4.309e-02, 1.614e-02) * s1_0_2;
	r0 += M4(-4.147e-02, -4.457e-03, 3.354e-02, 3.398e-02, -5.982e-02, -6.177e-02, -6.117e-02, -7.067e-02, 2.671e-02, 2.012e-02, -4.657e-02, -8.841e-02, -5.728e-02, -5.070e-02, 3.864e-02, 2.734e-02) * s1_1_0;
	r0 += M4(-9.193e-02, -8.461e-02, 2.834e-02, 3.355e-03, -1.461e-02, -2.311e-02, -2.214e-02, -1.085e-02, 3.821e-02, 2.961e-02, -5.805e-02, -5.904e-02, 2.275e-02, 4.654e-02, 1.281e-01, 1.199e-01) * s1_1_1;
	r0 += M4(-6.908e-02, -6.197e-02, 5.824e-02, 2.804e-02, -7.914e-02, -7.692e-02, -6.846e-02, -7.802e-02, 5.060e-04, 6.348e-03, -8.012e-02, -9.867e-02, -3.967e-02, -1.257e-02, 7.555e-02, 7.307e-02) * s1_1_2;
	r0 += M4(-5.860e-02, -5.421e-02, 6.882e-02, 6.369e-02, 1.155e-02, 1.018e-02, 3.119e-03, 5.154e-03, -1.050e-01, -7.727e-02, -9.844e-02, -8.813e-02, 2.284e-01, 2.550e-01, 1.613e-01, 1.699e-01) * s1_2_0;
	r0 += M4(-4.060e-02, -4.826e-02, 7.349e-02, 7.002e-02, 1.878e-02, 1.547e-02, 9.358e-03, 1.308e-02, 7.030e-02, 4.437e-02, 9.009e-02, 8.004e-02, 3.618e-02, 2.336e-02, -3.818e-02, -4.324e-02) * s1_2_1;
	r0 += M4(-5.505e-02, -3.584e-02, 7.155e-02, 6.384e-02, 1.037e-01, 1.021e-01, 1.034e-01, 1.086e-01, -1.171e-01, -1.013e-01, -5.081e-02, -3.921e-02, 9.293e-02, 8.476e-02, 5.090e-02, 2.515e-02) * s1_2_2;
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 += M4(1.715e-02, 1.511e-02, -5.990e-05, -3.701e-04, 8.426e-02, 2.042e-02, 9.792e-03, 5.597e-03, 3.018e-02, 5.922e-04, -3.094e-03, -6.435e-04, 4.283e-02, 1.008e-02, -4.546e-04, 1.761e-03) * s0_0_0;
	r0 += M4(3.648e-02, 3.503e-02, 1.564e-03, -9.210e-04, 9.131e-02, 9.526e-02, 2.693e-02, 3.581e-02, 1.495e-02, 3.333e-02, -1.143e-02, -1.206e-02, -3.901e-03, 1.581e-02, -5.829e-04, -6.190e-04) * s0_0_1;
	r0 += M4(-1.134e-03, 1.162e-02, 5.314e-04, -3.340e-04, 1.272e-02, 7.523e-03, 1.358e-03, 3.791e-03, 7.476e-04, 8.784e-03, -1.154e-03, -3.524e-04, 3.300e-04, -2.919e-03, -1.015e-04, 9.374e-07) * s0_0_2;
	r0 += M4(-5.965e-02, 8.447e-03, 1.224e-02, 3.562e-03, -5.512e-04, 6.228e-03, 8.667e-02, 1.858e-02, -1.046e-01, 5.744e-03, 7.018e-02, -3.470e-03, -6.695e-01, 1.754e-01, 1.199e-01, 1.440e-01) * s0_1_0;
	r0 += M4(1.194e-01, -6.074e-01, 1.117e-01, 5.243e-02, 4.749e-02, -4.514e-02, 6.715e-02, -7.333e-01, -8.686e-02, -2.666e-01, 1.184e-01, 1.541e-01, 3.953e-03, 7.446e-02, -2.502e-02, 6.223e-02) * s0_1_1;
	r0 += M4(-2.480e-03, 2.858e-02, -1.587e-03, 2.744e-02, -2.071e-03, 3.405e-02, 6.754e-04, 3.107e-02, -3.260e-03, 1.452e-02, -7.036e-03, 2.471e-02, 1.393e-03, -1.581e-02, 6.512e-05, -7.827e-03) * s0_1_2;
	r0 += M4(6.741e-03, 4.103e-03, -4.907e-03, 1.102e-02, 2.482e-03, 5.813e-04, 1.894e-02, 1.935e-02, 8.771e-04, -9.251e-04, 3.650e-02, -1.046e-02, -4.141e-03, 3.121e-03, 8.362e-02, 2.687e-02) * s0_2_0;
	r0 += M4(-6.837e-03, 1.625e-02, 5.725e-02, 4.708e-02, 8.873e-03, -9.040e-03, 3.174e-02, 1.043e-02, 1.628e-02, 5.716e-03, -2.529e-02, 3.799e-02, 3.264e-04, -1.811e-02, -1.780e-02, 3.459e-02) * s0_2_1;
	r0 += M4(-1.801e-03, -6.516e-03, -1.474e-03, 8.956e-04, -3.013e-03, 8.568e-04, -1.766e-03, 1.813e-02, 9.367e-04, 1.242e-02, -4.848e-03, -2.155e-02, 5.855e-04, -1.079e-03, 1.151e-03, -2.636e-04) * s0_2_2;
	r0 += V4(-1.487e-08, -1.434e-08, -9.046e-09, -1.464e-08);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
