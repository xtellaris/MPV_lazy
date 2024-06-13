// CuNNy 4x12
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


//!DESC [CuNNy_4x12_vk] -in
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
	r0 += V4(-2.012e-02, 3.409e-02, 2.003e-02, 2.149e-02) * s0_0_0;
	r1 += V4(1.332e-02, -1.546e-03, -2.167e-02, 4.247e-03) * s0_0_0;
	r2 += V4(-3.831e-02, 5.725e-02, -1.723e-02, -9.611e-04) * s0_0_0;
	r0 += V4(5.948e-03, -1.790e-01, -7.113e-01, -5.762e-01) * s0_0_1;
	r1 += V4(-1.763e-01, 6.230e-01, 6.170e-02, 5.957e-01) * s0_0_1;
	r2 += V4(2.924e-02, -9.287e-02, 5.798e-02, -8.915e-03) * s0_0_1;
	r0 += V4(-1.618e-02, 4.424e-02, 1.642e-03, -2.212e-01) * s0_0_2;
	r1 += V4(1.433e-01, 1.243e-01, -4.078e-02, -5.934e-01) * s0_0_2;
	r2 += V4(-2.993e-02, 1.788e-02, 6.303e-02, 3.710e-04) * s0_0_2;
	r0 += V4(8.472e-02, -1.248e-01, -2.251e-02, 3.462e-02) * s0_1_0;
	r1 += V4(-9.073e-02, -8.324e-03, 3.989e-02, -4.260e-02) * s0_1_0;
	r2 += V4(-2.655e-02, 8.505e-01, 3.367e-02, -7.721e-03) * s0_1_0;
	r0 += V4(-1.527e-01, 3.251e-01, 1.194e-02, 5.362e-01) * s0_1_1;
	r1 += V4(-5.765e-01, -6.300e-01, -1.876e-01, -5.195e-01) * s0_1_1;
	r2 += V4(4.352e-01, -8.340e-01, 7.430e-02, -8.301e-01) * s0_1_1;
	r0 += V4(3.108e-01, -7.590e-02, 6.973e-01, 1.981e-01) * s0_1_2;
	r1 += V4(7.084e-01, -1.057e-01, 1.557e-01, 5.599e-01) * s0_1_2;
	r2 += V4(-1.362e-01, -7.918e-03, -4.514e-01, -8.818e-03) * s0_1_2;
	r0 += V4(-1.370e-02, 3.357e-02, -9.465e-03, -7.160e-02) * s0_2_0;
	r1 += V4(4.683e-02, -5.313e-03, -1.703e-02, 3.918e-02) * s0_2_0;
	r2 += V4(-1.328e-02, -3.637e-03, -1.572e-03, 1.077e-02) * s0_2_0;
	r0 += V4(8.350e-02, -9.353e-02, 3.341e-02, 8.667e-02) * s0_2_1;
	r1 += V4(-5.833e-02, 1.627e-02, 5.711e-01, -4.602e-02) * s0_2_1;
	r2 += V4(-7.077e-02, 2.292e-02, 5.385e-03, 8.406e-01) * s0_2_1;
	r0 += V4(-1.665e-01, 4.454e-02, -2.348e-02, -1.594e-03) * s0_2_2;
	r1 += V4(-5.277e-03, -1.593e-02, -5.351e-01, 6.424e-03) * s0_2_2;
	r2 += V4(4.407e-02, -1.204e-02, 8.571e-03, 5.629e-03) * s0_2_2;
	r0 += V4(-4.380e-03, 9.884e-02, 3.921e-06, 1.640e-02);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(1.702e-02, 4.461e-03, 1.353e-02, 2.207e-04);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(1.932e-02, 9.612e-03, 2.204e-01, 2.222e-04);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), vec4(r2));
}

//!DESC [CuNNy_4x12_vk] -conv1
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
	r0 = D(r0, s0_0_0, 0xF7082224, 0xF806100C, 0xFB0807E0, 0xCF272B0E);
	r1 = D(r1, s0_0_0, 0x09F6E205, 0x0EEFECE3, 0x0500FFF3, 0x0D10FEC8);
	r2 = D(r2, s0_0_0, 0x0FFAE8D7, 0xF8FB0C14, 0x05FAF42A, 0xF8100FEB);
	r0 = D(r0, s0_0_1, 0xBF2558FC, 0x0AF601F4, 0xFC00150C, 0xE8102BCD);
	r1 = D(r1, s0_0_1, 0x06F7FE13, 0xE6CAE406, 0x00FDF1FD, 0x0CF4E4D2);
	r2 = D(r2, s0_0_1, 0x02F91D15, 0x08FD1615, 0xF90310F8, 0x0CF7C40A);
	r0 = D(r0, s0_0_2, 0x070CE9E6, 0xFF02E018, 0x0002F1F9, 0xFE093724);
	r1 = D(r1, s0_0_2, 0x05FC07FA, 0x7FD4EE22, 0x01FD0C1C, 0xF9FA1AE0);
	r2 = D(r2, s0_0_2, 0x00FC0E1A, 0x0001ECE7, 0xFA061412, 0x0DF9ED39);
	r0 = D(r0, s0_1_0, 0x01142505, 0x040806D6, 0xE6170B1A, 0x9728ECCE);
	r1 = D(r1, s0_1_0, 0xFBFB09EA, 0xBF1BFDCB, 0xF00A15EB, 0xE8FBF70B);
	r2 = D(r2, s0_1_0, 0x10B54028, 0xEE2915E1, 0xED1DEFD2, 0xF4073AF2);
	r0 = D(r0, s0_1_1, 0xEA04F4F5, 0xF018FE2D, 0x000ADD04, 0x0AF3F239);
	r1 = D(r1, s0_1_1, 0x0DFEBE02, 0x81A1CE37, 0xF512B91C, 0x0C04FD44);
	r2 = D(r2, s0_1_1, 0x150C27E8, 0xFA1E01FA, 0xEA041AF3, 0xFAC8D97F);
	r0 = D(r0, s0_1_2, 0xF2210711, 0xF8082ED6, 0xEF0E1C0B, 0x0018E8FA);
	r1 = D(r1, s0_1_2, 0x140341F9, 0xEFBE2B09, 0x13F444EF, 0x13DBFB30);
	r2 = D(r2, s0_1_2, 0xF305F6FA, 0xDE10FFF5, 0x30FAFFEA, 0x0CEB3FC6);
	r0 = D(r0, s0_2_0, 0x0C1B10E9, 0x00FB0F12, 0xFF160C0A, 0xAE1FB5F2);
	r1 = D(r1, s0_2_0, 0x12F5E30F, 0x172B2F11, 0xF80B08FC, 0xFCE528EB);
	r2 = D(r2, s0_2_0, 0xF508F003, 0x11EC0303, 0x409E341B, 0xF8090AF0);
	r0 = D(r0, s0_2_1, 0xD373C2F0, 0xE92BD7FE, 0x1316ED08, 0x7F0EEFF8);
	r1 = D(r1, s0_2_1, 0xF8F546F7, 0xD30DF8E3, 0xDA1DDBF0, 0xE31A160B);
	r2 = D(r2, s0_2_1, 0x2D81E516, 0xD526F21D, 0x817F9B0D, 0xF806D820);
	r0 = D(r0, s0_2_2, 0xD232C930, 0xC70CF801, 0x0801E6F6, 0x081D0C2D);
	r1 = D(r1, s0_2_2, 0x1FF7FCFA, 0x33FE2FFC, 0x1B0B241D, 0x2981F3F4);
	r2 = D(r2, s0_2_2, 0xFEF7E9F4, 0xF701D100, 0x14EC0AF9, 0x09F8461F);
	r0 = D(r0, s1_0_0, 0x100DFCE6, 0x00FC0904, 0xFEE60DFD, 0xEAFC01BA);
	r1 = D(r1, s1_0_0, 0xEBF205FA, 0x24BACB14, 0xFDEE02F7, 0x24F60B0F);
	r2 = D(r2, s1_0_0, 0x0623FB10, 0xF8F60D14, 0xED0907F3, 0x04FE01EA);
	r0 = D(r0, s1_0_1, 0xDF0023BE, 0xF5D8100C, 0xFDE40B0F, 0x16A80E00);
	r1 = D(r1, s1_0_1, 0xF0FA0818, 0x81B919D9, 0x009B02E3, 0x17C3DDEF);
	r2 = D(r2, s1_0_1, 0xFCF8FE07, 0x01050108, 0x030A09FE, 0xED1EF600);
	r0 = D(r0, s1_0_2, 0xF018DDE0, 0xF5F702FC, 0xF8F9FEFA, 0xFF300BE0);
	r1 = D(r1, s1_0_2, 0xFC09FB06, 0xDECE9FF5, 0xFA1DFEFF, 0x25F72D07);
	r2 = D(r2, s1_0_2, 0x00F90902, 0xFC0CFCFB, 0xECECFFF5, 0xFBAEFCF5);
	r0 = D(r0, s1_1_0, 0x2DDD0DDA, 0x02EB00DE, 0x0108FAF5, 0xF32F050D);
	r1 = D(r1, s1_1_0, 0xD61C1E2E, 0x4935FBEB, 0x050EF7FA, 0x0A1A0DEB);
	r2 = D(r2, s1_1_0, 0xFD2BEC21, 0x05F622D1, 0x1CEC0D14, 0xF5CDF80F);
	r0 = D(r0, s1_1_1, 0xD3EF0F45, 0x083D0825, 0x0221FCF3, 0x150ECC2D);
	r1 = D(r1, s1_1_1, 0xF4224318, 0x4BEC277F, 0x2C09EC7F, 0xF938D404);
	r2 = D(r2, s1_1_1, 0x0A0081DD, 0x371726D8, 0x40D3EE1F, 0x2B0315B9);
	r0 = D(r0, s1_1_2, 0xEBFEC8E2, 0x091911FE, 0x04050F00, 0xE102B7DE);
	r1 = D(r1, s1_1_2, 0xFF0BFA03, 0xD61D271E, 0xFC101700, 0xD6E152F0);
	r2 = D(r2, s1_1_2, 0x13F70205, 0x06F111F3, 0x0822F30C, 0x340E3F39);
	r0 = D(r0, s1_2_0, 0x1511FE04, 0x030CF70B, 0x170605EF, 0x1401F7FC);
	r1 = D(r1, s1_2_0, 0xD2F10F01, 0x0E0120E6, 0xF6070DFE, 0x0C24EA32);
	r2 = D(r2, s1_2_0, 0x0E03FC0E, 0xF3FCF01A, 0x0AF9B619, 0x0CFFFDED);
	r0 = D(r0, s1_2_1, 0x2F03FDF7, 0xFF053604, 0x2CFDCAF7, 0x0CE4ECD8);
	r1 = D(r1, s1_2_1, 0xF9F9080E, 0x4EF702BE, 0x010100F9, 0x97FA14E8);
	r2 = D(r2, s1_2_1, 0x22F004F3, 0x400107F0, 0x37FC7ABA, 0x2CF3DFEB);
	r0 = D(r0, s1_2_2, 0x0BF310FC, 0x2AFA3FFE, 0x0E040A03, 0xEAFF10EC);
	r1 = D(r1, s1_2_2, 0xF901E4FA, 0x1F0305E9, 0xFBFFFAED, 0xE718AB21);
	r2 = D(r2, s1_2_2, 0x1206010F, 0x07FD0F05, 0x060DF901, 0x1CFDD3E6);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xF7D2FFEE, 0xFE02000D, 0x08050600, 0x29100701);
	r1 = D(r1, s0_0_0, 0x06100005, 0x39130FDA, 0x0E0104F7, 0x10E007F8);
	r2 = D(r2, s0_0_0, 0x011FFAE5, 0xEE04020A, 0x0318F2EC, 0x0519FCF7);
	r0 = D(r0, s0_0_1, 0xFE14F70B, 0x1E110F14, 0x15F51016, 0x66CB1524);
	r1 = D(r1, s0_0_1, 0x20021926, 0x0916BAD9, 0x180B030A, 0x1A14F9EF);
	r2 = D(r2, s0_0_1, 0xEFF8F4F9, 0x34EE0421, 0x28220427, 0xE4180BD8);
	r0 = D(r0, s0_0_2, 0xC00A0344, 0x29EFF911, 0xF70001F4, 0xFCD8FEC8);
	r1 = D(r1, s0_0_2, 0x16EDFA1A, 0xB12DDD3F, 0xDDFDF525, 0xD00D07E6);
	r2 = D(r2, s0_0_2, 0x0B0301F2, 0xFEFFF002, 0xE7D3F738, 0x81F3F2C5);
	r0 = D(r0, s0_1_0, 0xF8F804DA, 0x0EF3FEE8, 0xDCDBF9DA, 0x2EFAFB23);
	r1 = D(r1, s0_1_0, 0xF521F50D, 0xDCE5F302, 0xFE06FE00, 0x13FE03F1);
	r2 = D(r2, s0_1_0, 0xFE7F04FF, 0x08E9FB09, 0xABDE05F3, 0xFDEA06C4);
	r0 = D(r0, s0_1_1, 0xD60D2ADF, 0xF51811F2, 0x7F19F1F0, 0xC562E4C1);
	r1 = D(r1, s0_1_1, 0x39193BE0, 0x1AF722D0, 0x1512FDC8, 0xB7FA28E9);
	r2 = D(r2, s0_1_1, 0x81F9817F, 0x35007F15, 0x81F93B06, 0x0F7FF1D1);
	r0 = D(r0, s0_1_2, 0xEDFAF308, 0x4003042E, 0xFC02261A, 0x81EC8120);
	r1 = D(r1, s0_1_2, 0x02F90312, 0x9EDA811E, 0xD4CC8105, 0x81E5BE19);
	r2 = D(r2, s0_1_2, 0x03EB1D2C, 0xFAFE30CC, 0xD71F2103, 0xFAD2507F);
	r0 = D(r0, s0_2_0, 0x08000010, 0x01FFFDF9, 0x0421FC13, 0x060D0424);
	r1 = D(r1, s0_2_0, 0xFDF10206, 0xFEFD0BF0, 0xFCEE01E4, 0xF90709E5);
	r2 = D(r2, s0_2_0, 0x04CEFD12, 0x030202E8, 0x05F305EF, 0x00E902EB);
	r0 = D(r0, s0_2_1, 0xF9080E10, 0x0EFFF407, 0xFBFB0807, 0xF9EFD502);
	r1 = D(r1, s0_2_1, 0x160C0AD0, 0x0AE6F5CB, 0x001601F2, 0xF7F8EDED);
	r2 = D(r2, s0_2_1, 0xF923DF16, 0x0708F6F2, 0xE52581EF, 0xFA1727E2);
	r0 = D(r0, s0_2_2, 0x0016FEED, 0x0D06D8DF, 0x0705FAFF, 0xF31EE6FC);
	r1 = D(r1, s0_2_2, 0xFAF8FE11, 0x04E43339, 0x02FFF323, 0x0101D756);
	r2 = D(r2, s0_2_2, 0x031CFFFF, 0xFD0BECFF, 0xFBE8F7DE, 0x0DF60B28);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.053e-02, 1.007e-02, 5.474e-03, -2.785e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-5.505e-02, 9.005e-02, 2.859e-02, 5.969e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-3.490e-01, 7.216e-02, 1.111e-02, -1.668e-01);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_4x12_vk] -conv2
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
	r0 = D(r0, s0_0_0, 0x03030D04, 0x0D0F1301, 0x08FD35FF, 0xF80817ED);
	r1 = D(r1, s0_0_0, 0xEDFD00F2, 0x06FD0B13, 0xF8EF07F6, 0xE6EC0DFE);
	r2 = D(r2, s0_0_0, 0x2B0DC118, 0x0F0BF6EE, 0x07EFF0FB, 0xFF15FB1A);
	r0 = D(r0, s0_0_1, 0x08F0F8F9, 0x11EE04F9, 0xEFAF1E6C, 0x0C0BD5D9);
	r1 = D(r1, s0_0_1, 0x0D22EA1D, 0xEAE41605, 0x18161FFE, 0x0B1A0F12);
	r2 = D(r2, s0_0_1, 0xF57ECBF1, 0xF11FEDB1, 0x0A55EE06, 0x1FF0F3FA);
	r0 = D(r0, s0_0_2, 0x0303F1FF, 0x04F7FE01, 0xFFF907ED, 0xF7812C0F);
	r1 = D(r1, s0_0_2, 0x030B0B08, 0xEE170D01, 0xF9EC0E0E, 0x12F00DF9);
	r2 = D(r2, s0_0_2, 0x0CF5040C, 0xD7141310, 0x09EEFB03, 0xF20305FF);
	r0 = D(r0, s0_1_0, 0xFA020CFE, 0x03FBEBF6, 0x100E31E4, 0x131AF4F3);
	r1 = D(r1, s0_1_0, 0x01F9FDFE, 0x59FBDF1F, 0xFE1BE6F7, 0x2DEBD603);
	r2 = D(r2, s0_1_0, 0x08051B02, 0xD4FF1F23, 0x04020CF2, 0x3A090010);
	r0 = D(r0, s0_1_1, 0x2903C2F6, 0x24190109, 0x41BAF88F, 0x1F528144);
	r1 = D(r1, s0_1_1, 0x17FB2DFF, 0xBFEC2AFE, 0x1E262017, 0xEA0556F9);
	r2 = D(r2, s0_1_1, 0xF1030FDF, 0x01DECAC8, 0x5A11EA1D, 0x1710C8E3);
	r0 = D(r0, s0_1_2, 0x08EFFDF4, 0xFCF9FB01, 0x140EF1E8, 0xEACD300C);
	r1 = D(r1, s0_1_2, 0x2CC5FF26, 0xF51F05FC, 0xEA050004, 0x15F1F40D);
	r2 = D(r2, s0_1_2, 0x09000201, 0xEA5E15DE, 0x09F8F80E, 0x09FFEF0B);
	r0 = D(r0, s0_2_0, 0x060004FA, 0x0A0103F8, 0x1E080207, 0xF50EF310);
	r1 = D(r1, s0_2_0, 0x140CF510, 0xF50B1701, 0xF104F0FE, 0xDB08EC1A);
	r2 = D(r2, s0_2_0, 0xF303FCF5, 0xF7ECFC0C, 0x0A00F807, 0x2D0505FD);
	r0 = D(r0, s0_2_1, 0x020CF3FE, 0xFAFA0106, 0x30F3FAE1, 0xFB220800);
	r1 = D(r1, s0_2_1, 0x1D0608EA, 0x0F03F9F0, 0xF50405F8, 0x0CFC00F6);
	r2 = D(r2, s0_2_1, 0x0C030314, 0xB4FF07E4, 0xF20105F1, 0x08F1E504);
	r0 = D(r0, s0_2_2, 0xF9010002, 0xFA0203FB, 0x1B0CF63E, 0x07FF0605);
	r1 = D(r1, s0_2_2, 0xFB1C0A05, 0x111F0203, 0xF70905EA, 0x260406FF);
	r2 = D(r2, s0_2_2, 0x08FB0301, 0xB8E60A01, 0xF805FD00, 0x0A0500FA);
	r0 = D(r0, s1_0_0, 0x09F5FA01, 0x11FDF3E5, 0x1AD9E314, 0x0004FAD6);
	r1 = D(r1, s1_0_0, 0x061117F3, 0x01E9FE0C, 0xF6040F03, 0xEB0707FC);
	r2 = D(r2, s1_0_0, 0xFEF205FE, 0xF7052DF6, 0x010705F6, 0x0506F306);
	r0 = D(r0, s1_0_1, 0xF4FF0003, 0xF9F801F0, 0x0BE7A730, 0x3D070618);
	r1 = D(r1, s1_0_1, 0x2B0A030D, 0x06F505F5, 0x00C20CF9, 0x19F5F5F7);
	r2 = D(r2, s1_0_1, 0x050F0F11, 0xEE0C2EDE, 0xFBE1F503, 0xFF030809);
	r0 = D(r0, s1_0_2, 0x0502FC16, 0x02FDFE0C, 0xD40AE1DF, 0xFAFAEFDC);
	r1 = D(r1, s1_0_2, 0x0F01F7E6, 0xFDFE04EF, 0xFAE909F8, 0xF2F10BE6);
	r2 = D(r2, s1_0_2, 0x0CF9F2F4, 0x2E04FDF7, 0xF6020709, 0x0202F1F8);
	r0 = D(r0, s1_1_0, 0x08F8FC03, 0x0317F9F9, 0x18FBE3DE, 0x2600FEE9);
	r1 = D(r1, s1_1_0, 0x1DFF07EC, 0x13A4FC20, 0xFD110EEC, 0xFD1113EF);
	r2 = D(r2, s1_1_0, 0x150BEA0F, 0x14E10131, 0x0CF9FC02, 0x0D0FF7F3);
	r0 = D(r0, s1_1_1, 0xFF1BF1C6, 0x0311FB3D, 0xF7CD1FAE, 0x2081E2FA);
	r1 = D(r1, s1_1_1, 0x39C92F2C, 0x261BF441, 0x01D8FE4E, 0x19671225);
	r2 = D(r2, s1_1_1, 0x0704E6F7, 0x81FBE1F1, 0x1FF6FF05, 0xF923E90F);
	r0 = D(r0, s1_1_2, 0xF7F70721, 0xFEFA0611, 0xD310F9EE, 0x18B10F21);
	r1 = D(r1, s1_1_2, 0x3081C6AE, 0xF000EFAB, 0x0DF8F5F5, 0xFCDFF5F1);
	r2 = D(r2, s1_1_2, 0x0C0AFDF3, 0xD70F1AC9, 0x0DE6FF30, 0x0CFEFC0A);
	r0 = D(r0, s1_2_0, 0xFB0307FF, 0xFEFD13FD, 0xE430E5F3, 0xFA100BF3);
	r1 = D(r1, s1_2_0, 0x00080CE7, 0x10D6090C, 0x060D06F0, 0xFCF30801);
	r2 = D(r2, s1_2_0, 0xFFFE0AFA, 0x0EE10111, 0xFA0AFEF2, 0xE409E407);
	r0 = D(r0, s1_2_1, 0x0410EEF9, 0x030203FF, 0xD339DADC, 0x0E0506FD);
	r1 = D(r1, s1_2_1, 0x19ED23F6, 0x0305F407, 0xF8FCF309, 0xDE010DFA);
	r2 = D(r2, s1_2_1, 0xFE08EAF5, 0x51BA3124, 0xFD082106, 0x0220E20D);
	r0 = D(r0, s1_2_2, 0x020E0216, 0xFE02FC02, 0x21F8EE2F, 0xFF0FDCFF);
	r1 = D(r1, s1_2_2, 0x070013FC, 0xF41AFFE1, 0xF302F300, 0xF0EFFE05);
	r2 = D(r2, s1_2_2, 0x0AF7FC0F, 0x03F32BF6, 0x06FE02FA, 0xF40FE806);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x07FDFBFB, 0x02030B0A, 0x11EDDCF0, 0x010E1BFF);
	r1 = D(r1, s0_0_0, 0xF7F60909, 0x1316ECEA, 0x270AF30D, 0xF8F408FB);
	r2 = D(r2, s0_0_0, 0xFCFF0626, 0xFDEF0EF4, 0x13FE02FB, 0x04FBFC07);
	r0 = D(r0, s0_0_1, 0x090D0305, 0x07180B16, 0xF9E8DFDE, 0xFE38EEF9);
	r1 = D(r1, s0_0_1, 0x09EBFE1D, 0xFF26F904, 0x130BF617, 0x08F4FF37);
	r2 = D(r2, s0_0_1, 0x1AFFF7F9, 0xF8E527DF, 0x0AE2FA19, 0xFBEA030B);
	r0 = D(r0, s0_0_2, 0x0500F216, 0x0103FF11, 0x0FBC0433, 0xEA2B44E3);
	r1 = D(r1, s0_0_2, 0x0BC21A08, 0xF421FE0D, 0xFF1BF5EA, 0x0E260411);
	r2 = D(r2, s0_0_2, 0xFAFA1607, 0x270300F0, 0xFB0EF403, 0xFEF307F8);
	r0 = D(r0, s0_1_0, 0x0AFC00F9, 0x0CFC230F, 0xD7E520EA, 0x120C21FD);
	r1 = D(r1, s0_1_0, 0xD6001A06, 0x6C07DC03, 0x01152EEE, 0xE0FF150E);
	r2 = D(r2, s0_1_0, 0xDC07E403, 0xBBFBDFF5, 0xE9FF0AF9, 0x15060405);
	r0 = D(r0, s0_1_1, 0x03152BFD, 0x050308E3, 0xB312122B, 0x472AEFDA);
	r1 = D(r1, s0_1_1, 0x810BA719, 0xDD04DCF6, 0xED26CFFC, 0x81FAD5B0);
	r2 = D(r2, s0_1_1, 0x040C060A, 0x83EB2563, 0x16F80B2D, 0x0DFC0434);
	r0 = D(r0, s0_1_2, 0x09113313, 0x0203F604, 0x0EFD56A7, 0x00129A4E);
	r1 = D(r1, s0_1_2, 0x13F39A7F, 0x0325E4EA, 0xF212D4E4, 0x2108D5F2);
	r2 = D(r2, s0_1_2, 0xF90BF010, 0x0AF93996, 0x04F0FE2E, 0x181AF701);
	r0 = D(r0, s0_2_0, 0xFC01FC04, 0xFDFFFB0C, 0x06FC0800, 0xF506120B);
	r1 = D(r1, s0_2_0, 0xFFFF1207, 0x0405ECFB, 0xF80725FD, 0x010A00F4);
	r2 = D(r2, s0_2_0, 0xF3030612, 0x1303D1D2, 0xF7010BFD, 0xFB06F802);
	r0 = D(r0, s0_2_1, 0xF60317FB, 0xFAFF0206, 0x1BF132FE, 0xE911ECFD);
	r1 = D(r1, s0_2_1, 0xEF0309FB, 0xEF0EDB48, 0xFF0714EF, 0xEEFD0704);
	r2 = D(r2, s0_2_1, 0x04FE0AEB, 0xFD08DEF7, 0x0002FC27, 0x0BF920F4);
	r0 = D(r0, s0_2_2, 0x050410EE, 0xFFFE04FE, 0x20ECD8FB, 0xD512F6F4);
	r1 = D(r1, s0_2_2, 0x07FF0D07, 0xFE19F9DD, 0xFF06FEEE, 0x0EF8F20C);
	r2 = D(r2, s0_2_2, 0x09FCF609, 0x1223EB3C, 0xFBFC0EFB, 0x07FB2AFB);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(1.504e-02, -2.305e-02, 2.327e-02, 5.573e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(4.184e-02, -5.303e-03, -2.836e-02, -9.337e-03);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(1.755e-02, -7.069e-03, -1.208e-02, 1.337e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_4x12_vk] -conv3
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
	r0 = D(r0, s0_0_0, 0x09FFF8F9, 0x010100FD, 0x0FF40200, 0x0EE20108);
	r1 = D(r1, s0_0_0, 0xFBFBFC10, 0x04F5FFEE, 0x04090002, 0x02F9FA04);
	r2 = D(r2, s0_0_0, 0xF118FA09, 0xFD09020F, 0xF709FB00, 0xEDEAFE10);
	r0 = D(r0, s0_0_1, 0xF5FC0512, 0xF8F7FF0C, 0xFA1BEE37, 0x1707DE00);
	r1 = D(r1, s0_0_1, 0x040DF510, 0x00050BEB, 0x0401FAF5, 0x05EEEDFE);
	r2 = D(r2, s0_0_1, 0xF4140DE3, 0xFA06F917, 0x09E105E5, 0x09F2FD00);
	r0 = D(r0, s0_0_2, 0xFC020301, 0x0902FBF8, 0xE30F070F, 0xE5FE150C);
	r1 = D(r1, s0_0_2, 0xFFFE07F7, 0x02010EF3, 0xFE0207F8, 0x09ED0505);
	r2 = D(r2, s0_0_2, 0xF4070DF4, 0xFEF508FE, 0x02E3EE0C, 0xFCF8F915);
	r0 = D(r0, s0_1_0, 0xF2EAFCD0, 0xEE00FB06, 0xFD2102FE, 0x150105DB);
	r1 = D(r1, s0_1_0, 0xE7200B09, 0x0712F409, 0xDF05F5FB, 0x07040113);
	r2 = D(r2, s0_1_0, 0xE2072CE3, 0xFFF805DF, 0xF7EDFF1A, 0xD80007B4);
	r0 = D(r0, s0_1_1, 0xE810D0EC, 0xDB022607, 0xD4FB05EB, 0x1D478AF5);
	r1 = D(r1, s0_1_1, 0x0103EA34, 0x050949D5, 0x03FD0BF9, 0x0D21F602);
	r2 = D(r2, s0_1_1, 0xF4F9C4C8, 0xC1FCBC50, 0xEEB4CA47, 0xE9EA1E1E);
	r0 = D(r0, s0_1_2, 0xF600D002, 0x0DF6D602, 0xCC18C621, 0xF8FEF5FA);
	r1 = D(r1, s0_1_2, 0xFC04FB05, 0xFC061500, 0x01FD0502, 0xF72112E9);
	r2 = D(r2, s0_1_2, 0xF3FF25FD, 0x03F218F6, 0xF8F60E1C, 0x07F8DE12);
	r0 = D(r0, s0_2_0, 0xEDFD0509, 0xFF010500, 0xF526FCFF, 0xF3FE0100);
	r1 = D(r1, s0_2_0, 0xF4050704, 0x0C0AEEF8, 0xE30C0FED, 0xDB02FED9);
	r2 = D(r2, s0_2_0, 0x040511F1, 0xFFFB0708, 0xFBED0516, 0x02D5FC2C);
	r0 = D(r0, s0_2_1, 0xD9F43C17, 0xF1FB100B, 0xC6230EF2, 0xFE131508);
	r1 = D(r1, s0_2_1, 0x0AFE3CFF, 0x07FEE8FD, 0xF8FEDB11, 0xD814F504);
	r2 = D(r2, s0_2_1, 0x04000100, 0xF8FB0609, 0xF0F90000, 0xF7F44F0B);
	r0 = D(r0, s0_2_2, 0xF7FC2404, 0x0AF9F00D, 0x1BFACCE9, 0xF2F6EF0C);
	r1 = D(r1, s0_2_2, 0x0100FE05, 0x03070EFA, 0x07F9E60D, 0xF2F3D111);
	r2 = D(r2, s0_2_2, 0xFAFE14F3, 0xFBFFF0FF, 0xF1F5F607, 0xFFF3F813);
	r0 = D(r0, s1_0_0, 0xF2F8080F, 0x04FC06F2, 0xEAF40E0F, 0xD4F20F21);
	r1 = D(r1, s1_0_0, 0xFAFD0407, 0xF80301F7, 0xFA0401EC, 0xFB04020C);
	r2 = D(r2, s1_0_0, 0x0803FE0F, 0xFAFD0F10, 0x170EF9F3, 0x0B09030F);
	r0 = D(r0, s1_0_1, 0x07FB0913, 0x160105FA, 0xFF02FFE0, 0xBA0A2B24);
	r1 = D(r1, s1_0_1, 0xFF0EF3FF, 0x04FB0AF9, 0xFCFF0DFC, 0xE914030F);
	r2 = D(r2, s1_0_1, 0x0304EE16, 0x0EF0F8F4, 0x0A09EF15, 0x02FDFAF9);
	r0 = D(r0, s1_0_2, 0x03000001, 0x0802FA04, 0x16F5E20D, 0x09040806);
	r1 = D(r1, s1_0_2, 0x02F9FA04, 0xFAF406F8, 0xFFFB0201, 0xFD050004);
	r2 = D(r2, s1_0_2, 0xFD0CF803, 0xFBF7FE02, 0xF1070CFE, 0x030F0006);
	r0 = D(r0, s1_1_0, 0x06F70621, 0xFD0009EA, 0xFA07D2EA, 0xF3F1020C);
	r1 = D(r1, s1_1_0, 0x1307E9CF, 0xFA060CF0, 0xF50910EF, 0x15FDF1F7);
	r2 = D(r2, s1_1_0, 0x0EE7F730, 0xFCF30BFE, 0x16FE0904, 0x0F0327EE);
	r0 = D(r0, s1_1_1, 0x0E40DD40, 0x2FFC09F2, 0xF32C30E5, 0xE42C0931);
	r1 = D(r1, s1_1_1, 0x0FE5E8E3, 0x0B1511FF, 0x1930F4CE, 0x26E309EA);
	r2 = D(r2, s1_1_1, 0xCEFF081B, 0x0B1DDFFB, 0x0FECF2EB, 0x1803D70D);
	r0 = D(r0, s1_1_2, 0xFFF004F7, 0x03E5F9FC, 0x1404F62C, 0x1010FB0E);
	r1 = D(r1, s1_1_2, 0x021EF903, 0xFAFE09FC, 0x07F9F0FC, 0x0B10EF17);
	r2 = D(r2, s1_1_2, 0xE6FB0602, 0x0DF2EBFD, 0x1809E60D, 0x0B00FDFD);
	r0 = D(r0, s1_2_0, 0xFA09010A, 0x070003EC, 0x010AFF04, 0xEC03020E);
	r1 = D(r1, s1_2_0, 0xFE04FCFC, 0x0703FA03, 0x00FA0AEF, 0xF90E0CEC);
	r2 = D(r2, s1_2_0, 0xFCF6FC16, 0xF5020612, 0xF8FF0C04, 0xF70703E0);
	r0 = D(r0, s1_2_1, 0x10FAF629, 0x0FF00BF8, 0xFDF30428, 0x010D0313);
	r1 = D(r1, s1_2_1, 0xF0F20302, 0xFDF9050C, 0x15F5F6F1, 0x0B49E0DE);
	r2 = D(r2, s1_2_1, 0xF905F20E, 0xFEFFF90D, 0x01FA0AFE, 0x00DA09F8);
	r0 = D(r0, s1_2_2, 0x05F7F6FD, 0x08F001FB, 0xFEFF0203, 0x00F80AFE);
	r1 = D(r1, s1_2_2, 0x01F9FF07, 0x040AF704, 0x02FCFFF6, 0xFDF0F7E9);
	r2 = D(r2, s1_2_2, 0xF6F802FF, 0xFDFDFE00, 0x0800030B, 0x08F00702);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x0C0B07F5, 0x09FC01FE, 0x0712FEED, 0x082A04E5);
	r1 = D(r1, s0_0_0, 0xF903F2F9, 0x06FFF5FB, 0x05FAF407, 0x04FE10FA);
	r2 = D(r2, s0_0_0, 0xECE20413, 0x011009FF, 0x070808FF, 0xF4F80C13);
	r0 = D(r0, s0_0_1, 0x1D04FCF8, 0xFDFAF303, 0x00EDC71B, 0x2E0E25E7);
	r1 = D(r1, s0_0_1, 0xFEF3FB13, 0x0BF3F602, 0xFCF8FEFC, 0x170227EE);
	r2 = D(r2, s0_0_1, 0x070F09FB, 0xFC020001, 0xE3082BF8, 0xFB0CFDFB);
	r0 = D(r0, s0_0_2, 0x0001FF02, 0xFD04FD03, 0xF5F6FE04, 0x0BF5FC10);
	r1 = D(r1, s0_0_2, 0x080103FA, 0x0E04FC02, 0xFD0604FF, 0x2EFF03FF);
	r2 = D(r2, s0_0_2, 0xFCFE0302, 0xF9FA01F9, 0xF9FD00F6, 0xEDF70200);
	r0 = D(r0, s0_1_0, 0xF0FFEBF9, 0x04EF0604, 0xF0DF30F9, 0xECFBDD06);
	r1 = D(r1, s0_1_0, 0x03EAF80E, 0x0AFCEDF5, 0xF0F3FB03, 0x0002FA03);
	r2 = D(r2, s0_1_0, 0x03070A14, 0xFC1DFDFC, 0xFDFF030A, 0xEE040814);
	r0 = D(r0, s0_1_1, 0x0DFF37E9, 0xF1E2FA0F, 0x2CB70934, 0x2DDBF7AC);
	r1 = D(r1, s0_1_1, 0xECF7EB28, 0x0EF806FB, 0x06DF001F, 0xEDF2BCEE);
	r2 = D(r2, s0_1_1, 0x26150A15, 0xFD271B03, 0xC529180B, 0xE00F14EC);
	r0 = D(r0, s0_1_2, 0x0301F60C, 0xFD0FF70A, 0x1CF2E645, 0xF7F3071A);
	r1 = D(r1, s0_1_2, 0xF2FA04F7, 0x1108FAFE, 0x00010318, 0xECE8F3C6);
	r2 = D(r2, s0_1_2, 0x0DFE0A00, 0x02F306FC, 0xFBF50BDB, 0xDDFD0503);
	r0 = D(r0, s0_2_0, 0x05ED07FB, 0x000E05F9, 0x000302FB, 0xFDF80D00);
	r1 = D(r1, s0_2_0, 0x05F40502, 0x0905F5FD, 0x090FF20F, 0xE407FE16);
	r2 = D(r2, s0_2_0, 0xFAEA0004, 0x02EF0A00, 0x07001205, 0x0BF21905);
	r0 = D(r0, s0_2_1, 0xFDEE0EF3, 0x0819F406, 0x08EFE310, 0xFCFC0E15);
	r1 = D(r1, s0_2_1, 0xF9F1000E, 0xFE00F712, 0xE82F0742, 0xE6150B40);
	r2 = D(r2, s0_2_1, 0x12E6FEE3, 0x05FC05FD, 0x021C0B0E, 0x0B010FF6);
	r0 = D(r0, s0_2_2, 0xF0F605DE, 0xF4080008, 0x1DE1ED1B, 0x07F60216);
	r1 = D(r1, s0_2_2, 0x03F904FB, 0x03F9FBF8, 0xF803FF13, 0xE91A0129);
	r2 = D(r2, s0_2_2, 0x06F303F6, 0x09FB09F5, 0xFCFC0802, 0xEFFD0C03);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-2.658e-03, -1.399e-02, -3.580e-02, -1.218e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-1.820e-02, 6.694e-04, -1.869e-02, -1.414e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-7.460e-03, -1.156e-02, -4.827e-03, -1.352e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_4x12_vk] -conv4
//!HOOK LUMA
//!COMPUTE 24 8 8 8
//!BIND conv3
//!BIND LUMA
//!SAVE conv4
//!WIDTH LUMA.w 3 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
#define l0(x, y) (conv3_mul * texelFetch(conv3_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(0, 0), 0))
#define l1(x, y) (conv3_mul * texelFetch(conv3_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(1, 0), 0))
#define l2(x, y) (conv3_mul * texelFetch(conv3_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(2, 0), 0))
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
	r0 = D(r0, s0_0_0, 0x02F8ED1C, 0x02F7FFF9, 0xFE0217F4, 0xF9090D0D);
	r1 = D(r1, s0_0_0, 0x01FCFC08, 0x04011CF1, 0x0101FD07, 0x00FC0301);
	r2 = D(r2, s0_0_0, 0x020001FC, 0xFFF60306, 0x00FE040B, 0x02FD0002);
	r0 = D(r0, s0_0_1, 0x08060408, 0x00051800, 0x03FBEF0C, 0xFF05DD1B);
	r1 = D(r1, s0_0_1, 0xFDFF020F, 0xF70FE427, 0x03F90909, 0x0203FCFA);
	r2 = D(r2, s0_0_1, 0x04080DF4, 0xFAFC0215, 0xFEFE060D, 0x00000A0A);
	r0 = D(r0, s0_0_2, 0xFDFF07FB, 0x01FC01FC, 0xFC0509FB, 0xFA0203F7);
	r1 = D(r1, s0_0_2, 0x0608FE0C, 0x0A14E228, 0x01010300, 0x02FE01FE);
	r2 = D(r2, s0_0_2, 0x01FE0603, 0xFD02FE0D, 0xFFFE0304, 0x00FE0502);
	r0 = D(r0, s0_1_0, 0xD62803E8, 0xF6E731ED, 0xBC2C23C2, 0xFCE5CCFD);
	r1 = D(r1, s0_1_0, 0xFEFD0105, 0x03FBFEE4, 0x04DD00F5, 0xFDFB07EF);
	r2 = D(r2, s0_1_0, 0xFE031606, 0xFC050103, 0xFDF4F2F3, 0xFA07FEF8);
	r0 = D(r0, s0_1_1, 0xC512C9F4, 0xF31D37CD, 0xDFE50CE9, 0xD7E50BD0);
	r1 = D(r1, s0_1_1, 0x00F7FCB6, 0xB12EFFDB, 0xEB05F4DA, 0xF10422F3);
	r2 = D(r2, s0_1_1, 0xE62327C7, 0xEE06F902, 0xFC0332F2, 0xF2FE3602);
	r0 = D(r0, s0_1_2, 0xFB04F6FF, 0xFDFFF4FD, 0x08040501, 0xFF07EC13);
	r1 = D(r1, s0_1_2, 0xD60CE003, 0xDD0507E9, 0xFD01FB00, 0xFD0202FE);
	r2 = D(r2, s0_1_2, 0xF7F1F702, 0xFCFFF7FC, 0xFF03FC05, 0xFE030306);
	r0 = D(r0, s0_2_0, 0xF5E70205, 0xF5030401, 0xE401FB02, 0xEBFDF902);
	r1 = D(r1, s0_2_0, 0xFF07FA04, 0xF11CFA0B, 0xFB06FE01, 0xFB01FDFD);
	r2 = D(r2, s0_2_0, 0x04F4FEFC, 0x0000FDFF, 0xF904FE03, 0xF903FF00);
	r0 = D(r0, s0_2_1, 0xF207FAFC, 0xF7FE09F8, 0xF6FE0B07, 0xED19F304);
	r1 = D(r1, s0_2_1, 0xC302FCFF, 0xE1E1F616, 0xF1FC03F9, 0xF5FEFCFF);
	r2 = D(r2, s0_2_1, 0xBB1C0AF9, 0xFEFCFEFE, 0xF8FD0200, 0xF9FD02FF);
	r0 = D(r0, s0_2_2, 0x0203FDFD, 0xFD00FFFF, 0xFC03FDFC, 0xEEFB04FF);
	r1 = D(r1, s0_2_2, 0xE5FE0902, 0xF9050600, 0x00FFFF03, 0x0201FFFF);
	r2 = D(r2, s0_2_2, 0xEFF6160A, 0x000000FD, 0xFEFFFD01, 0x00010001);
	r0 = D(r0, s1_0_0, 0x060A01FD, 0x07010BFE, 0xFBF9F1F6, 0xF21504FE);
	r1 = D(r1, s1_0_0, 0xFD0002FE, 0x17F50211, 0xF4040501, 0x060502FF);
	r2 = D(r2, s1_0_0, 0x09FE0500, 0x1201FB04, 0xF80101FF, 0xFD020301);
	r0 = D(r0, s1_0_1, 0x150E020C, 0xEDF9F203, 0x02181F03, 0x0C22F0F7);
	r1 = D(r1, s1_0_1, 0xF00A0B03, 0xDB2906F0, 0xE7F3FF01, 0xFC030102);
	r2 = D(r2, s1_0_1, 0xDAF8F8F9, 0x1F25E948, 0xF106F90E, 0xFC07FD0B);
	r0 = D(r0, s1_0_2, 0x0A0402F9, 0xFEFF04F4, 0xFFFAEF01, 0x00F4F6E8);
	r1 = D(r1, s1_0_2, 0xFE10EFF5, 0xF51DEB1C, 0x00050003, 0xFD030600);
	r2 = D(r2, s1_0_2, 0x070801FD, 0xFFFE0012, 0xFCFF0105, 0xFC020001);
	r0 = D(r0, s1_1_0, 0xC129021E, 0xF10103F1, 0xFDF6F201, 0xEDFEFD03);
	r1 = D(r1, s1_1_0, 0x00FD0502, 0x33FEDE07, 0x0A06FEFC, 0x0303FCFB);
	r2 = D(r2, s1_1_0, 0xFDFA0409, 0xEE05FF03, 0x0C05FA11, 0x030301FE);
	r0 = D(r0, s1_1_1, 0x030CFF12, 0x10F6F623, 0xFFF719E3, 0x23F412F2);
	r1 = D(r1, s1_1_1, 0x1107EC11, 0xFBFEB63A, 0x204BEC52, 0x093C0A15);
	r2 = D(r2, s1_1_1, 0x20F4EEEC, 0xF6F82404, 0x10251B06, 0x09421703);
	r0 = D(r0, s1_1_2, 0xF80EECFC, 0xFFFF10F6, 0x03FBFD09, 0x0DFFF42C);
	r1 = D(r1, s1_1_2, 0x07F8033B, 0x070215F7, 0x00040408, 0x0008FB00);
	r2 = D(r2, s1_1_2, 0xEEF815F1, 0xFF030CF9, 0xFF00FE0A, 0xFE02F806);
	r0 = D(r0, s1_2_0, 0x1204E0F7, 0x0204FA02, 0x08FF0601, 0x0A02EEFC);
	r1 = D(r1, s1_2_0, 0xF803F6FE, 0xE1011B03, 0xF607FA04, 0x0102FF02);
	r2 = D(r2, s1_2_0, 0x0301FAFC, 0x03FFFF00, 0x00FE0606, 0x020004FF);
	r0 = D(r0, s1_2_1, 0xFF06ED02, 0x05F90005, 0x02FFF6FE, 0xFEF90C09);
	r1 = D(r1, s1_2_1, 0x060118F9, 0x18FC0EEB, 0xFDFC0B02, 0xFF01FA05);
	r2 = D(r2, s1_2_1, 0x05FBFE0F, 0x0200FC02, 0x02FB0DFB, 0xFE01FDFF);
	r0 = D(r0, s1_2_2, 0x09F50DFC, 0x0001FEF8, 0x00FC0506, 0x05FE05FB);
	r1 = D(r1, s1_2_2, 0xFFFCFB01, 0xF80AEA07, 0x00020301, 0x00010102);
	r2 = D(r2, s1_2_2, 0x0102FEEB, 0xFF00FE02, 0x01FF05FF, 0xFF02FDFF);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x07E6F9FE, 0x01010C00, 0xEDFA0103, 0xFF1AF9FB);
	r1 = D(r1, s0_0_0, 0xFC09F8FC, 0xE7E4F607, 0xFFFF0300, 0xFF0A0400);
	r2 = D(r2, s0_0_0, 0x0603FD00, 0x0601FDFE, 0x0301FDFF, 0x02FEFF00);
	r0 = D(r0, s0_0_1, 0x0A02F011, 0x01FAFDFA, 0x0E0501E5, 0xDF0B07EE);
	r1 = D(r1, s0_0_1, 0x0206F6FF, 0xD11D02F2, 0xFD0304FC, 0x00FB00FE);
	r2 = D(r2, s0_0_1, 0xF4F50800, 0x22EEFBFB, 0x05FDFFFB, 0x0AFCFA01);
	r0 = D(r0, s0_0_2, 0x0501FDFE, 0xFFFB04FE, 0xF300FF08, 0x0CF70401);
	r1 = D(r1, s0_0_2, 0xD50B0601, 0xD212F901, 0xFC020003, 0x0301FEFE);
	r2 = D(r2, s0_0_2, 0x03FD05F7, 0x01FEFEF6, 0xFDFF0000, 0xFC00FF00);
	r0 = D(r0, s0_1_0, 0xF232E9E3, 0x0BF73AF9, 0x081368F8, 0x0DF4F4DD);
	r1 = D(r1, s0_1_0, 0x05010100, 0x0DEAF109, 0x060709FE, 0x07FA45FD);
	r2 = D(r2, s0_1_0, 0xFDF30304, 0x00ED0DF8, 0x08F729FA, 0x000403FA);
	r0 = D(r0, s0_1_1, 0xE12DAEB3, 0xE3FCFAD8, 0x21D207BB, 0x46DAF3C9);
	r1 = D(r1, s0_1_1, 0x0DFF08F0, 0x46CFD5D2, 0x11E5E802, 0xEA17F7DA);
	r2 = D(r2, s0_1_1, 0xEA0B53EB, 0xDC22E69A, 0x0DF3F9FF, 0x08FBF8F2);
	r0 = D(r0, s0_1_2, 0xF703FB0D, 0x220002FE, 0xF411FD08, 0x1107F203);
	r1 = D(r1, s0_1_2, 0x42E3CEDC, 0x29DDF2D1, 0x0DF7FFF3, 0xFFFD0109);
	r2 = D(r2, s0_1_2, 0x35F009A6, 0x0AF6F8F5, 0x0700FD01, 0xFD00FC08);
	r0 = D(r0, s0_2_0, 0x0EC8020E, 0x06E51A03, 0x0000FF00, 0x06F2F810);
	r1 = D(r1, s0_2_0, 0xFEF5FEFF, 0xEF0406FD, 0x03EC09FE, 0x0000FE02);
	r2 = D(r2, s0_2_0, 0x00010300, 0x0001FC02, 0xFF04F9FF, 0x0101FE00);
	r0 = D(r0, s0_2_1, 0x1DF01A13, 0xEC1FFDEB, 0xF9030106, 0x0F17FE1D);
	r1 = D(r1, s0_2_1, 0x0609F306, 0xCD0BF100, 0xF31102F4, 0x03FC080D);
	r2 = D(r2, s0_2_1, 0x02FF11FE, 0x0DF5070B, 0xFCFFF9F5, 0x02FBFE0A);
	r0 = D(r0, s0_2_2, 0x0FFD0A02, 0x10E704FE, 0xF90DFA01, 0xEE0BF4F2);
	r1 = D(r1, s0_2_2, 0xF310F911, 0xF0000316, 0xFEFDFF00, 0xFE02FF01);
	r2 = D(r2, s0_2_2, 0x0ADB04EF, 0x00020200, 0x04FCFF00, 0x02FDFF04);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.449e-02, -1.040e-02, -7.748e-03, -1.456e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-1.329e-02, -1.964e-02, -3.285e-03, -1.136e-03);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-1.163e-02, -6.243e-03, -2.814e-03, -2.440e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_4x12_vk] -out-shuffle
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv4
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
#define l0(x, y) V4((conv4_mul * texelFetch(conv4_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(0, 0), 0)))
#define l1(x, y) V4((conv4_mul * texelFetch(conv4_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(1, 0), 0)))
#define l2(x, y) V4((conv4_mul * texelFetch(conv4_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(2, 0), 0)))
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
	r0 += M4(3.318e-03, -2.012e-03, -5.236e-03, -1.779e-04, 8.346e-03, 3.452e-03, -1.703e-02, 1.770e-03, -7.092e-03, -6.424e-03, -3.243e-03, 3.940e-05, -7.984e-02, 1.241e-02, 3.988e-02, 9.481e-03) * s0_0_0;
	r0 += M4(-1.118e-02, -1.661e-02, -2.289e-02, -1.638e-02, 5.579e-02, -1.208e-01, -1.114e-02, 1.255e-02, 1.899e-02, -2.446e-04, -2.728e-02, -2.451e-03, 5.221e-02, -2.617e-02, 7.109e-04, 1.655e-02) * s0_0_1;
	r0 += M4(-3.950e-03, 1.016e-02, -2.925e-03, -1.020e-02, -5.869e-03, 2.459e-02, -2.535e-04, -2.988e-03, -8.093e-04, -6.482e-03, -4.731e-04, -4.024e-03, 5.158e-03, 6.365e-04, -1.583e-03, 5.126e-03) * s0_0_2;
	r0 += M4(-1.889e-03, -6.386e-03, -2.004e-03, 1.334e-03, 8.657e-02, 8.423e-03, 1.019e-01, 1.629e-02, -3.652e-03, -1.668e-02, -1.935e-02, -9.869e-03, 2.397e-02, -2.444e-03, 3.136e-02, 2.533e-02) * s0_1_0;
	r0 += M4(-3.384e-01, -9.825e-02, 3.175e-01, 7.416e-02, 2.114e-01, -2.388e-01, 3.483e-01, -4.034e-01, -4.844e-01, 2.880e-01, 8.738e-02, 6.761e-02, 6.913e-02, 2.743e-01, -1.053e-01, -3.596e-01) * s0_1_1;
	r0 += M4(2.218e-03, -9.974e-02, -4.951e-04, 1.519e-01, -5.294e-03, 2.853e-02, -1.194e-02, 5.450e-02, 2.247e-02, 8.435e-02, 1.821e-02, 2.252e-02, -1.616e-02, -2.104e-02, -1.534e-02, -2.289e-02) * s0_1_2;
	r0 += M4(-9.692e-04, -1.569e-03, -8.208e-03, 9.646e-04, -1.082e-02, 9.927e-04, 1.058e-02, 8.486e-03, 2.456e-03, -3.407e-03, 1.432e-02, -8.627e-03, -1.252e-03, 8.853e-04, -4.801e-03, -1.818e-03) * s0_2_0;
	r0 += M4(2.168e-02, 3.896e-03, -1.657e-02, -7.228e-03, 1.204e-02, 7.399e-03, 2.371e-02, -2.356e-02, 4.260e-02, -8.090e-03, -6.345e-02, 8.032e-02, -1.495e-02, -1.025e-02, 5.702e-02, 4.181e-02) * s0_2_1;
	r0 += M4(-4.472e-03, -7.679e-03, -2.392e-02, -2.132e-02, 1.001e-03, 3.290e-03, -2.539e-03, 5.697e-03, 7.319e-03, 2.711e-03, 4.933e-03, -2.553e-03, -9.479e-04, -1.366e-02, 5.673e-03, 2.164e-02) * s0_2_2;
	r0 += M4(1.585e-02, 4.833e-03, 1.110e-02, -1.155e-02, 3.740e-02, 1.975e-03, -5.813e-03, 8.132e-05, 3.789e-02, -5.097e-03, -7.365e-03, 6.329e-03, -2.020e-03, -1.993e-03, 1.359e-03, 1.567e-03) * s1_0_0;
	r0 += M4(-2.961e-02, 4.544e-03, -1.027e-02, -7.093e-03, -6.402e-02, 1.536e-02, 2.193e-02, 1.449e-02, 1.173e-01, 1.671e-01, 2.110e-04, 1.230e-02, 4.948e-02, 1.003e-01, 4.108e-03, -1.089e-02) * s1_0_1;
	r0 += M4(-3.476e-03, -2.463e-03, -1.256e-03, -5.746e-04, 1.070e-02, -2.714e-02, 2.779e-03, 9.172e-03, 2.138e-05, 1.044e-02, -6.495e-04, 4.295e-04, -7.608e-05, 2.073e-02, 9.759e-04, -2.553e-04) * s1_0_2;
	r0 += M4(3.597e-01, 1.362e-02, -3.972e-01, 6.271e-02, 5.365e-02, -2.374e-02, -6.404e-02, 2.158e-02, -1.185e-01, 3.526e-02, -2.080e-01, 3.594e-02, -9.822e-02, 4.624e-03, -6.323e-02, -8.314e-03) * s1_1_0;
	r0 += M4(-1.401e-02, -7.033e-03, 4.381e-02, 5.066e-02, 1.018e-01, 2.408e-01, -2.982e-02, -3.291e-01, 9.922e-02, 1.536e-01, 3.237e-02, -4.248e-01, 2.779e-01, -4.485e-01, 1.987e-01, 1.633e-01) * s1_1_1;
	r0 += M4(2.024e-03, 2.739e-03, 4.065e-03, -1.438e-02, -6.121e-03, 5.840e-03, -9.841e-03, 2.644e-02, 3.251e-04, 2.753e-02, -1.539e-02, 3.101e-02, -3.388e-03, 1.022e-01, 4.001e-05, 8.479e-02) * s1_1_2;
	r0 += M4(-1.054e-02, -3.762e-04, 2.353e-02, -2.001e-03, -2.575e-02, -1.304e-02, 4.968e-02, -1.400e-02, 1.108e-02, -4.055e-03, -5.798e-03, 5.042e-03, -1.122e-02, 5.872e-03, -6.665e-02, -3.138e-03) * s1_2_0;
	r0 += M4(2.907e-03, 3.875e-03, -6.179e-03, -4.501e-03, -9.327e-04, -1.119e-02, -1.528e-02, 3.671e-02, 1.265e-03, 5.264e-03, 2.297e-02, 6.640e-02, -5.676e-02, -2.568e-02, -7.882e-02, -2.140e-01) * s1_2_1;
	r0 += M4(1.452e-06, -4.576e-04, 8.682e-04, -6.055e-03, -1.209e-04, -9.293e-04, -2.496e-03, -6.731e-03, 1.251e-04, -1.538e-03, -2.260e-03, 1.212e-02, 1.288e-03, 1.470e-02, -1.357e-02, 2.043e-02) * s1_2_2;
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 += M4(-5.399e-02, 4.579e-02, 4.268e-02, 3.272e-03, -1.345e-02, -6.087e-03, -3.922e-03, -1.467e-03, 1.135e-03, 9.551e-03, 7.965e-03, -1.232e-03, 4.456e-02, 3.399e-03, -2.091e-03, -9.246e-05) * s0_0_0;
	r0 += M4(-7.805e-03, 2.117e-02, -5.268e-03, -9.139e-03, 2.057e-02, 2.118e-02, -7.168e-05, 8.951e-04, -1.996e-01, -1.683e-01, -6.719e-03, -9.152e-03, 1.794e-01, 1.411e-01, 3.284e-02, 1.818e-02) * s0_0_1;
	r0 += M4(-1.181e-04, -2.878e-03, -2.659e-04, 4.850e-04, -8.367e-04, 5.828e-03, -1.450e-03, -6.853e-04, -4.296e-03, -1.767e-02, 1.852e-03, -8.275e-03, 1.286e-02, -6.385e-03, -1.359e-03, 1.368e-02) * s0_0_2;
	r0 += M4(-1.248e-02, 1.362e-01, -5.252e-01, 2.505e-01, -1.237e-01, 3.960e-02, -3.000e-02, -1.769e-03, 7.515e-02, 1.602e-02, 6.065e-02, 1.023e-02, 1.792e-01, -1.870e-02, 1.743e-01, -6.081e-03) * s0_1_0;
	r0 += M4(-1.393e-02, 1.393e-02, -6.068e-03, 1.116e-01, -9.985e-02, -3.723e-01, 8.179e-02, 4.675e-02, 7.513e-02, -4.100e-02, -3.768e-01, -4.065e-01, -4.971e-01, 1.851e-01, -1.466e-01, 2.933e-01) * s0_1_1;
	r0 += M4(5.579e-04, -4.744e-03, 5.190e-04, -6.021e-03, -1.326e-02, 1.581e-02, 4.705e-03, 4.015e-03, 1.595e-02, 8.116e-02, 1.802e-02, 9.950e-02, -1.321e-02, -1.665e-01, -1.200e-02, -1.924e-01) * s0_1_2;
	r0 += M4(-3.259e-02, 2.030e-03, 2.455e-02, 1.703e-02, -2.031e-03, -1.399e-02, 1.116e-01, 1.396e-02, 7.795e-04, -6.109e-04, 2.547e-02, 1.059e-02, -8.101e-06, 1.383e-04, 4.235e-02, -9.675e-03) * s0_2_0;
	r0 += M4(-2.839e-03, -2.935e-03, 1.657e-03, 4.984e-03, 3.491e-02, 6.907e-02, 1.440e-01, 2.744e-01, -2.068e-02, -4.908e-03, 1.134e-01, 6.266e-02, 6.815e-02, 2.423e-02, -2.484e-02, 7.202e-02) * s0_2_1;
	r0 += M4(-3.869e-04, 8.949e-04, -2.543e-04, -7.565e-05, -5.071e-03, -1.395e-02, 1.725e-02, 1.056e-02, 1.246e-04, 4.654e-03, 4.375e-03, 3.860e-02, -1.197e-03, -1.585e-02, 7.811e-03, -5.628e-02) * s0_2_2;
	r0 += V4(-2.639e-08, -1.492e-08, -2.905e-08, -1.491e-08);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
