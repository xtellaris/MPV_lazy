// CuNNy 2x12 DS
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


//!DESC [CuNNy_2x12_DS_vk] -in
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
	r0 += V4(-4.177e-03, 2.782e-04, -2.407e-01, 5.976e-02) * s0_0_0;
	r1 += V4(-1.885e-03, -1.588e-02, -4.580e-01, -2.081e-02) * s0_0_0;
	r2 += V4(5.112e-01, 2.276e-02, -4.680e-02, 2.362e-02) * s0_0_0;
	r0 += V4(1.241e-02, -6.005e-03, -4.364e-02, -6.332e-02) * s0_0_1;
	r1 += V4(-8.210e-01, -1.373e-01, -3.218e-01, 1.565e-01) * s0_0_1;
	r2 += V4(-2.744e-01, -1.848e-01, 3.640e-02, 2.210e-02) * s0_0_1;
	r0 += V4(-2.245e-03, -5.563e-04, 2.946e-01, -6.569e-01) * s0_0_2;
	r1 += V4(-4.590e-03, 7.832e-01, 2.223e-01, 3.038e-01) * s0_0_2;
	r2 += V4(1.100e-01, 3.972e-02, 2.216e-02, 1.633e-02) * s0_0_2;
	r0 += V4(8.565e-01, -3.760e-02, 1.630e-01, 2.534e-01) * s0_1_0;
	r1 += V4(-2.714e-03, 3.209e-02, -1.131e-01, 7.788e-02) * s0_1_0;
	r2 += V4(2.490e-02, -1.270e-01, 8.581e-02, -5.557e-02) * s0_1_0;
	r0 += V4(-8.265e-01, -8.192e-01, -6.582e-01, 8.388e-02) * s0_1_1;
	r1 += V4(8.135e-01, -6.080e-01, 6.434e-01, -9.108e-01) * s0_1_1;
	r2 += V4(2.657e-02, 1.027e+00, 5.506e-01, 1.372e-01) * s0_1_1;
	r0 += V4(-3.223e-02, -2.191e-02, 2.053e-03, 5.784e-02) * s0_1_2;
	r1 += V4(9.607e-03, -2.484e-02, 2.621e-02, 1.653e-01) * s0_1_2;
	r2 += V4(-3.385e-02, -6.021e-02, 1.759e-01, 4.241e-02) * s0_1_2;
	r0 += V4(2.386e-02, 2.085e-02, 4.605e-01, -9.923e-02) * s0_2_0;
	r1 += V4(3.670e-03, -2.370e-02, 2.310e-01, -2.618e-02) * s0_2_0;
	r2 += V4(-3.505e-02, 2.398e-02, 1.376e-02, 3.955e-01) * s0_2_0;
	r0 += V4(-4.407e-02, 8.336e-01, 3.135e-01, 2.568e-01) * s0_2_1;
	r1 += V4(1.303e-02, 5.560e-03, 1.205e-01, 3.549e-02) * s0_2_1;
	r2 += V4(3.098e-02, -1.732e-01, -5.879e-01, -8.847e-01) * s0_2_1;
	r0 += V4(2.196e-02, 3.825e-02, -2.929e-01, 9.124e-02) * s0_2_2;
	r1 += V4(-6.298e-03, -7.447e-03, -3.445e-01, 1.131e-01) * s0_2_2;
	r2 += V4(-1.203e-02, 3.067e-02, -2.369e-01, 2.718e-01) * s0_2_2;
	r0 += V4(-1.256e-03, 1.807e-02, -3.174e-03, -5.903e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(-3.361e-03, -7.450e-04, -2.947e-03, 5.171e-04);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(1.346e-02, 3.407e-02, 1.632e-02, 3.905e-02);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), vec4(r2));
}

//!DESC [CuNNy_2x12_DS_vk] -conv1
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
	r0 = D(r0, s0_0_0, 0xEBD50DE3, 0x0301DEF3, 0xFD03FBFC, 0xE8F8F100);
	r1 = D(r1, s0_0_0, 0x0306EBFD, 0xFB13FD01, 0x182AF100, 0x0E050F10);
	r2 = D(r2, s0_0_0, 0x031720FE, 0xFD0E18FD, 0x050937FF, 0x07F02DF7);
	r0 = D(r0, s0_0_1, 0xE8EBE4CF, 0x0CFFF6FD, 0xFAFB5E01, 0xDFFE4D39);
	r1 = D(r1, s0_0_1, 0xE305F616, 0x0914FC05, 0x0A3400F3, 0x373CA1E6);
	r2 = D(r2, s0_0_1, 0x09048D00, 0x1316B2F7, 0x201595C8, 0xFAEE9CF0);
	r0 = D(r0, s0_0_2, 0xF5D11C07, 0x06FFEEFA, 0xFFF2D90D, 0x0417FC26);
	r1 = D(r1, s0_0_2, 0x09141313, 0x021DE9E9, 0x0537F200, 0xF3102687);
	r2 = D(r2, s0_0_2, 0x091901CB, 0x031309E8, 0xFDEF4602, 0xFFD94201);
	r0 = D(r0, s0_1_0, 0x07D338F5, 0x18F13501, 0x010005F5, 0xB2C7EC23);
	r1 = D(r1, s0_1_0, 0xFBEE1AB8, 0x061A1EF7, 0xFC0E2107, 0x00121911);
	r2 = D(r2, s0_1_0, 0x0C0A30E7, 0x030E0DFB, 0x2710EFF4, 0x03FEDEF3);
	r0 = D(r0, s0_1_1, 0xEEA881F5, 0x0BF20BF9, 0xF0F9D030, 0x41EF81BD);
	r1 = D(r1, s0_1_1, 0x07F5FD81, 0xEF253D1F, 0x213835D1, 0x0AEC1438);
	r2 = D(r2, s0_1_1, 0xEF1A973D, 0xE4F75E31, 0x26E110F2, 0xD8C99E29);
	r0 = D(r0, s0_1_2, 0xF2B435E5, 0xF7F03838, 0x02EC1D27, 0xF3FA1A85);
	r1 = D(r1, s0_1_2, 0x010BF4EA, 0x1035F81E, 0x1648E2BD, 0x215A1BAC);
	r2 = D(r2, s0_1_2, 0x0F1D3F06, 0x071BC17F, 0x0804F817, 0xF3DD133B);
	r0 = D(r0, s0_2_0, 0x20D21106, 0xD5E44E1D, 0xE8FE08FA, 0x650AFE17);
	r1 = D(r1, s0_2_0, 0x3602FDFF, 0xFA19E4E3, 0x1C13F5F4, 0xEB16DCE4);
	r2 = D(r2, s0_2_0, 0xF1FCFFF7, 0xFB0401EF, 0xE2FB06F7, 0xE3E92013);
	r0 = D(r0, s0_2_1, 0xE8B72222, 0xFBCA0009, 0x04010907, 0xCADA0E9F);
	r1 = D(r1, s0_2_1, 0xE9EB1813, 0xF51C00DB, 0x181BEBE0, 0xE01608F3);
	r2 = D(r2, s0_2_1, 0xFBF90405, 0xE409FFDC, 0xE9FEF407, 0xEEDC1135);
	r0 = D(r0, s0_2_2, 0x0AC91606, 0xFDECF2E6, 0xF2FB00ED, 0x10EF04FE);
	r1 = D(r1, s0_2_2, 0xFC00040B, 0xFF14F0D0, 0x122EEFD2, 0x0612050E);
	r2 = D(r2, s0_2_2, 0xF4FA080F, 0x010CF6F1, 0x0606021C, 0x08F8F70B);
	r0 = D(r0, s1_0_0, 0x0D22F2E5, 0x0405FFF5, 0xEF01080A, 0x03250907);
	r1 = D(r1, s1_0_0, 0x1500F205, 0xF8FBFF17, 0xF4EBF82A, 0x17EEFE06);
	r2 = D(r2, s1_0_0, 0x2EFEE4FC, 0x0EF8F104, 0x1DF40BEF, 0xF203F4F2);
	r0 = D(r0, s1_0_1, 0x3F3CE8CF, 0x000A02F4, 0xFA0609F8, 0xEEFC1321);
	r1 = D(r1, s1_0_1, 0xF4030E0B, 0xFBE4060B, 0xE1D01F1C, 0x6901C3D0);
	r2 = D(r2, s1_0_1, 0x2704F4E9, 0x14EEEF07, 0x2201E3E7, 0xF02E00F5);
	r0 = D(r0, s1_0_2, 0xB4243514, 0x0321F6E4, 0x0C08FB10, 0xDCE00923);
	r1 = D(r1, s1_0_2, 0xF6000308, 0x01E3FB0B, 0xF7D00409, 0xE9EC0904);
	r2 = D(r2, s1_0_2, 0x18FEF2FE, 0xFDF2FCFF, 0xFA1207ED, 0x061A000D);
	r0 = D(r0, s1_1_0, 0x032BDBB1, 0x1204D4F9, 0xFF09FA0C, 0xE4ED1D48);
	r1 = D(r1, s1_1_0, 0xCA02D8B3, 0xDDF81416, 0xE9F43017, 0xF0E81341);
	r2 = D(r2, s1_1_0, 0x080404B9, 0xE70EFDE9, 0x16FEF4C4, 0x2F1DE395);
	r0 = D(r0, s1_1_1, 0xF23823B7, 0xDBF70F02, 0xC71050C8, 0x192FAAB3);
	r1 = D(r1, s1_1_1, 0x3A25DFC2, 0xD9E93441, 0x23A11FE7, 0xBDD54BF7);
	r2 = D(r2, s1_1_1, 0xEECA1E61, 0xD5EE2F6F, 0xC6F0E81A, 0xA1313F7F);
	r0 = D(r0, s1_1_2, 0x10361869, 0xFF1A070B, 0x140BEC26, 0x18FFFBF2);
	r1 = D(r1, s1_1_2, 0xED071006, 0xF1E7F80D, 0xE4C61503, 0x5CC3CA81);
	r2 = D(r2, s1_1_2, 0x00FC060A, 0xE1E60FE4, 0xEAFBF5A8, 0xE502F3C8);
	r0 = D(r0, s1_2_0, 0xF720BDE4, 0xC60F5112, 0x0C01FFFD, 0x26FBD82F);
	r1 = D(r1, s1_2_0, 0x0015D0A9, 0x25F5C6D4, 0x29D9FBDC, 0x0E03FA05);
	r2 = D(r2, s1_2_0, 0x0908E8D1, 0x0BFE13F1, 0x150D2008, 0x0F13F614);
	r0 = D(r0, s1_2_1, 0xF546E54C, 0xE205195B, 0x12062750, 0xDD2F8181);
	r1 = D(r1, s1_2_1, 0xED0A288F, 0x2DDE1DF6, 0x15B9028B, 0x0BECF617);
	r2 = D(r2, s1_2_1, 0xE2010C7F, 0x24012AC6, 0xF208403D, 0x19EEFD7F);
	r0 = D(r0, s1_2_2, 0xFF44D8CD, 0xFAF301E6, 0x1407F9EC, 0x2413F4D4);
	r1 = D(r1, s1_2_2, 0xFB130B27, 0x0BE5F91B, 0xF8B109F5, 0xFCEBFDC3);
	r2 = D(r2, s1_2_2, 0xF4FE05BB, 0x04F1FD6F, 0x02FBFE1C, 0x410BE6CA);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x0048E209, 0x11F8F80B, 0x0CF9EA07, 0xCE06000D);
	r1 = D(r1, s0_0_0, 0x7F0BCC08, 0x02FFF701, 0xFFF9C5FD, 0x00DC09F5);
	r2 = D(r2, s0_0_0, 0x38F6F708, 0x03FF06FD, 0x20EB1FFB, 0xF233EE07);
	r0 = D(r0, s0_0_1, 0xCF252C08, 0x051A11F3, 0xF2EF070A, 0x0F35CF23);
	r1 = D(r1, s0_0_1, 0x23F9D0F1, 0xE31B3D0F, 0x4210B808, 0xBE0D190D);
	r2 = D(r2, s0_0_1, 0xD07F75ED, 0xE2101AFA, 0x2413B5F7, 0xB3011407);
	r0 = D(r0, s0_0_2, 0xDC810FE0, 0x0AEF13FE, 0x0D1BE603, 0xF036FD04);
	r1 = D(r1, s0_0_2, 0xFCE418FE, 0x0712F70D, 0xEFF2140E, 0xDDFBAFCA);
	r2 = D(r2, s0_0_2, 0xF1C7F705, 0x0F03E106, 0x2C0D0CD4, 0x461FC42A);
	r0 = D(r0, s0_1_0, 0x20081F31, 0x9C02E819, 0x0AF8F903, 0xEAF0F7FB);
	r1 = D(r1, s0_1_0, 0xD1425EE8, 0x0925ECF4, 0x0C07C6EC, 0x1BE5DBE5);
	r2 = D(r2, s0_1_0, 0x11D6F608, 0x0913D80F, 0x0A00F508, 0xE0191D0E);
	r0 = D(r0, s0_1_1, 0xEA3D8F00, 0x19E7B4F8, 0x1E1EBA24, 0x1765DAEC);
	r1 = D(r1, s0_1_1, 0xCF1A1CDE, 0x26CFC40F, 0x250F7F14, 0x0CEEEE1E);
	r2 = D(r2, s0_1_1, 0x0907C726, 0x36CF17EE, 0xFAD87FC9, 0xE044CBD6);
	r0 = D(r0, s0_1_2, 0x06D90BEA, 0xEEF7150C, 0xEE0A2EFE, 0xE204EBCC);
	r1 = D(r1, s0_1_2, 0xF9E5D0F5, 0x141CF4FC, 0x020CE101, 0x0B21387F);
	r2 = D(r2, s0_1_2, 0x0906F512, 0x1A27E814, 0xF6F70435, 0xE10EE4E5);
	r0 = D(r0, s0_2_0, 0xFF030E22, 0xF8FE0401, 0x00FC0DFA, 0xF9143C0C);
	r1 = D(r1, s0_2_0, 0x0C0A0A21, 0xF4F70DEF, 0xFCE335D0, 0xF70CF5EE);
	r2 = D(r2, s0_2_0, 0xFD0CE8EA, 0xF6FD1FFA, 0xF4FB070D, 0x0FEB0D13);
	r0 = D(r0, s0_2_1, 0x051FF819, 0xEDF63FFB, 0x03FF4FF1, 0xF8D239B3);
	r1 = D(r1, s0_2_1, 0x12E117FD, 0xF30045E3, 0xF90027E5, 0x10E5F736);
	r2 = D(r2, s0_2_1, 0x14F9F9FD, 0xFCFE1304, 0xFC06C4FC, 0x04F7061B);
	r0 = D(r0, s0_2_2, 0x07DFF603, 0xFE16D116, 0xF9F90FA1, 0x18070C45);
	r1 = D(r1, s0_2_2, 0x0C09F616, 0x0703FCE6, 0x030EE958, 0x010F0AEC);
	r2 = D(r2, s0_2_2, 0x06FB07EF, 0x09FBF9F1, 0x0109E135, 0xF10D37FE);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(1.946e-02, -1.492e-03, -1.172e-02, 2.164e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-3.839e-02, -2.168e-02, -3.579e-02, 2.007e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-8.042e-03, -2.441e-02, -3.813e-02, -3.926e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_2x12_DS_vk] -conv2
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
	r0 = D(r0, s0_0_0, 0xF60DFBFA, 0xFF0003FD, 0x000103FF, 0x000C02EA);
	r1 = D(r1, s0_0_0, 0xFF0EF705, 0x000F05F2, 0x080405FD, 0x000FF905);
	r2 = D(r2, s0_0_0, 0xF002FEF7, 0xD231E7DA, 0xFFFB030C, 0x01010405);
	r0 = D(r0, s0_0_1, 0xEFF9F8F6, 0xF407F5FD, 0xF9020C00, 0xF3FA17E2);
	r1 = D(r1, s0_0_1, 0xEDF30800, 0xE0EA1D0B, 0xF1FA1501, 0xF3FEFB02);
	r2 = D(r2, s0_0_1, 0xEC0AE6EB, 0xF6DF13FF, 0xF0F6F70E, 0xFE03000D);
	r0 = D(r0, s0_0_2, 0x0309EDFE, 0xF5001CFC, 0xFEFD15FE, 0xF2FD15EE);
	r1 = D(r1, s0_0_2, 0xD711FF07, 0xC11ADDE9, 0xF10FF809, 0xF006FFFE);
	r2 = D(r2, s0_0_2, 0x020506EB, 0xFB0AF5F8, 0xFB00FBF9, 0xF901EE00);
	r0 = D(r0, s0_1_0, 0xD605F4F5, 0xF1090A00, 0xF4050405, 0xE50AF8F5);
	r1 = D(r1, s0_1_0, 0xF5FDFEF8, 0xEFFC04E3, 0xF40BF9E9, 0xF3F0FE02);
	r2 = D(r2, s0_1_0, 0xD614FE0B, 0xD26AD5D9, 0xF60411D7, 0xF8DB24DD);
	r0 = D(r0, s0_1_1, 0xD625F309, 0xDE4E090A, 0xD8F90FFC, 0xDD080511);
	r1 = D(r1, s0_1_1, 0x9606F93F, 0x9130062B, 0xD7DD0836, 0xE037FD11);
	r2 = D(r2, s0_1_1, 0xD146DCE6, 0x10D01220, 0xEA133FD8, 0xE9EB4BD6);
	r0 = D(r0, s0_1_2, 0xDDFD06F8, 0x02FA0F00, 0x0407FEFD, 0xF1061EFB);
	r1 = D(r1, s0_1_2, 0xFCF3F8F6, 0xC6F6E5EB, 0xD20803FD, 0xF0F5FEFF);
	r2 = D(r2, s0_1_2, 0xE5F4FAF2, 0x02F804F7, 0xD70631F6, 0xEA0430F4);
	r0 = D(r0, s0_2_0, 0x1005FCF4, 0x0306FD09, 0xFEF8FF01, 0x11F902F4);
	r1 = D(r1, s0_2_0, 0xF602FF14, 0x01F302E7, 0xE2F5021B, 0xEEF70202);
	r2 = D(r2, s0_2_0, 0xF8FF03FE, 0x00DCF4EC, 0xF3EF021E, 0xB20AFA20);
	r0 = D(r0, s0_2_1, 0xDDD1030D, 0xFDE7FCF4, 0x11EB0B16, 0x04DA06F3);
	r1 = D(r1, s0_2_1, 0xF8F3F6EB, 0xE103FB09, 0xEB16F3F1, 0xFDFEFDF5);
	r2 = D(r2, s0_2_1, 0xF003F610, 0x10020F0A, 0xEBE0E410, 0xBAEFDE22);
	r0 = D(r0, s0_2_2, 0xE90300F8, 0x11FD0A02, 0x0BFCFBFC, 0x03000C00);
	r1 = D(r1, s0_2_2, 0x050502FF, 0x051304F0, 0x16EEFD05, 0x0A020300);
	r2 = D(r2, s0_2_2, 0xF403F6F1, 0x000EFBFA, 0x07F1FD14, 0xFBF4EC10);
	r0 = D(r0, s1_0_0, 0x0401F702, 0x07F70019, 0xF003080C, 0x01FEFE14);
	r1 = D(r1, s1_0_0, 0x0301F60D, 0x051ED628, 0xFC10F4F4, 0xF3FEF30A);
	r2 = D(r2, s1_0_0, 0x00FF1607, 0x20F6BC81, 0xF60C1F14, 0xF5F5161A);
	r0 = D(r0, s1_0_1, 0x09FE08E6, 0xFE0BF7F5, 0xEBFB0916, 0x09001CE8);
	r1 = D(r1, s1_0_1, 0x1FF619BC, 0xFAE31BCF, 0xE0F9F9FB, 0xFF02FBF3);
	r2 = D(r2, s1_0_1, 0x0102FAF8, 0x0D033CBC, 0xE7F0330A, 0x01FC0912);
	r0 = D(r0, s1_0_2, 0x0AFB0D0B, 0xF80305F2, 0xE9FFFE05, 0xED0CFCF1);
	r1 = D(r1, s1_0_2, 0xF70BFBD2, 0x0905FCF5, 0xF6FF02CC, 0x0102FDF5);
	r2 = D(r2, s1_0_2, 0x10F60F0F, 0xFE02FC0B, 0x0BF8150D, 0x02000603);
	r0 = D(r0, s1_1_0, 0xFB02FB1C, 0xF1FD19FC, 0xEFF80705, 0xF507F51C);
	r1 = D(r1, s1_1_0, 0xFF0CF120, 0x1814E12A, 0xF901E839, 0x03F7FFFE);
	r2 = D(r2, s1_1_0, 0xEA0C1CE3, 0xCBCBCF81, 0xFBED14DC, 0x1F0216EF);
	r0 = D(r0, s1_1_1, 0xE9D82BC0, 0xF4E9ECF0, 0xF9DEC3C3, 0xD6BE0FA7);
	r1 = D(r1, s1_1_1, 0x81F0198D, 0x95C70897, 0xC0E11181, 0xF6F9EBEA);
	r2 = D(r2, s1_1_1, 0x12E9C5D0, 0xE51302D7, 0x09EDF5A5, 0x0C28F8A2);
	r0 = D(r0, s1_1_2, 0x1413DACD, 0xFDF909DD, 0x0301F9DA, 0x16F817C8);
	r1 = D(r1, s1_1_2, 0x34EDEFBA, 0x0C08F3A6, 0x28CBEDD4, 0xF80103D1);
	r2 = D(r2, s1_1_2, 0x060BFAD0, 0x09FAFA0A, 0x1812F8BD, 0x1003FAEE);
	r0 = D(r0, s1_2_0, 0xF6FE0013, 0xF0FEFFFD, 0xEF02EB00, 0xE9FFF71A);
	r1 = D(r1, s1_2_0, 0xF2FC0803, 0xF407FD25, 0x02FF0311, 0xF800FB04);
	r2 = D(r2, s1_2_0, 0xFF10FF1D, 0xE3D803CE, 0x00FB18F9, 0xCDF11BD4);
	r0 = D(r0, s1_2_1, 0x080FFCF9, 0xE302F1EB, 0xC10216F2, 0xEF13ECFC);
	r1 = D(r1, s1_2_1, 0x0C06F111, 0xB0E806A0, 0xDCEAF4E4, 0xE4EF00DD);
	r2 = D(r2, s1_2_1, 0xCFF20FF1, 0x152501EE, 0xBFD92893, 0xC5A24981);
	r0 = D(r0, s1_2_2, 0x12EF03CF, 0xF00EFE04, 0xF2ED16F0, 0x11FCFBF6);
	r1 = D(r1, s1_2_2, 0xFD040603, 0x280CCBED, 0x08140E03, 0x0713F5FB);
	r2 = D(r2, s1_2_2, 0x11FF03DB, 0x01F8FE0A, 0xEEDE28C6, 0x19E526AA);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xF8FF0C03, 0xFC0AF802, 0x050AFE03, 0xF9071308);
	r1 = D(r1, s0_0_0, 0xF1FB0E03, 0xEFFC1F14, 0x17FDFB04, 0xF4FE1905);
	r2 = D(r2, s0_0_0, 0xF90AEEFE, 0xF914F228, 0x0219DAFC, 0x0CFEF9F7);
	r0 = D(r0, s0_0_1, 0xF119ED04, 0x0BFDF10A, 0xFB04FEFF, 0x17F9F3FF);
	r1 = D(r1, s0_0_1, 0x1518E103, 0x1410F1FD, 0xF40EFF09, 0x0304FE04);
	r2 = D(r2, s0_0_1, 0xEF10F003, 0x170AF0E3, 0xF017E2E9, 0xF2FA01F8);
	r0 = D(r0, s0_0_2, 0x04F600F9, 0x0C05FAFB, 0xFB0AFD02, 0xF80E04FE);
	r1 = D(r1, s0_0_2, 0xFAFD0AFD, 0xF10C0600, 0x08060902, 0x06010101);
	r2 = D(r2, s0_0_2, 0x0606F7F6, 0xF00C0003, 0xF50FF9F5, 0xFB03FCFD);
	r0 = D(r0, s0_1_0, 0xE4090903, 0x03F7E504, 0xFA041BFA, 0xEC0124FC);
	r1 = D(r1, s0_1_0, 0xF2010703, 0xD3021006, 0xDD0619FD, 0x0D111DFF);
	r2 = D(r2, s0_1_0, 0x06F8D10B, 0xB4E54912, 0x1AE90310, 0x170AE403);
	r0 = D(r0, s0_1_1, 0x13CA19FC, 0xEBDC1EF5, 0x1FDE270F, 0xFDD12CE5);
	r1 = D(r1, s0_1_1, 0x29C327FA, 0x1BB91DF2, 0x47C310FF, 0xFEEF0203);
	r2 = D(r2, s0_1_1, 0xF3BA4223, 0x2BF7F7D9, 0x49A70118, 0x3701D60D);
	r0 = D(r0, s0_1_2, 0xF6120601, 0x0307F4F5, 0xFAF5050C, 0xDFF3F2EF);
	r1 = D(r1, s0_1_2, 0xF513FDF8, 0xF03CEDFC, 0xE42EF4FD, 0x021EEEFB);
	r2 = D(r2, s0_1_2, 0xFD0601F1, 0xF818F60C, 0x00EEFE00, 0x03080002);
	r0 = D(r0, s0_2_0, 0x00F9FBFD, 0x05FDFA06, 0xFAFC1414, 0x00FF0101);
	r1 = D(r1, s0_2_0, 0xFD03FEFD, 0xE5FC0204, 0x0608F1FD, 0x02FB0902);
	r2 = D(r2, s0_2_0, 0xF4F6F905, 0xF2F61F1F, 0xD50BE708, 0xE403EF07);
	r0 = D(r0, s0_2_1, 0xF8E02203, 0x06F72218, 0xFBF7EF29, 0xFDED2F17);
	r1 = D(r1, s0_2_1, 0xF3F211FE, 0x15DC2501, 0xEA011A1B, 0xFBF511FF);
	r2 = D(r2, s0_2_1, 0xEBF10B2E, 0xFE00FECD, 0xE8140521, 0xE804FE09);
	r0 = D(r0, s0_2_2, 0xECFB0003, 0x000002EA, 0x040AF60C, 0xFEFD0EF8);
	r1 = D(r1, s0_2_2, 0x05F8FD03, 0xF621F1FE, 0x19E3FBE5, 0x0206FBF2);
	r2 = D(r2, s0_2_2, 0xFA0EFFFF, 0x0112EC13, 0xF41AFBF3, 0xF516F6ED);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.226e-02, -1.230e-02, -1.547e-02, -1.048e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-1.952e-02, -1.997e-02, -1.887e-02, -1.102e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-1.738e-02, -2.521e-02, -1.523e-02, -1.496e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_2x12_DS_vk] -out-shuffle
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
#define l0(x, y) V4((conv2_mul * texelFetch(conv2_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(0, 0), 0)))
#define l1(x, y) V4((conv2_mul * texelFetch(conv2_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(1, 0), 0)))
#define l2(x, y) V4((conv2_mul * texelFetch(conv2_raw, clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(3, 1) + ivec2(2, 0), 0)))
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
	r0 += M4(-1.976e-01, 3.183e-02, 1.491e-02, 3.430e-02, 4.460e-02, -5.657e-03, -6.718e-03, 1.800e-03, -9.155e-02, 1.607e-02, 1.117e-02, 2.250e-03, 2.154e-02, 4.441e-03, -1.703e-02, -5.727e-03) * s0_0_0;
	r0 += M4(1.392e-01, 5.282e-02, -2.977e-02, 3.310e-02, 1.285e-01, 1.624e-01, 2.128e-02, 5.896e-03, -7.017e-02, -2.339e-01, -8.119e-02, -3.919e-02, 5.261e-02, 8.612e-02, -1.322e-02, -1.315e-02) * s0_0_1;
	r0 += M4(3.895e-04, 3.633e-03, -1.893e-03, -1.812e-02, 6.945e-03, -2.003e-02, 1.149e-02, -8.524e-03, 4.090e-03, 4.626e-02, -1.578e-02, -3.519e-02, 4.287e-05, 1.083e-02, -7.046e-04, 2.792e-03) * s0_0_2;
	r0 += M4(1.602e-01, -4.041e-02, -3.792e-02, 5.041e-02, 4.554e-02, 3.148e-03, 1.284e-01, -7.857e-03, 3.674e-02, 1.500e-02, -1.026e-01, 9.123e-03, -1.724e-01, 1.722e-02, -9.936e-02, 9.213e-04) * s0_1_0;
	r0 += M4(-1.440e-01, 1.163e-01, 1.467e-01, -4.424e-01, -3.372e-01, -5.579e-02, -5.197e-02, 2.378e-01, 1.018e-01, 8.179e-02, 1.948e-01, -3.798e-02, 6.169e-02, -2.627e-01, 2.358e-01, 5.954e-02) * s0_1_1;
	r0 += M4(-8.471e-03, 4.000e-02, -1.973e-02, 8.667e-02, 3.206e-02, -1.421e-01, -1.922e-02, -1.799e-01, -3.232e-03, 2.632e-02, 1.051e-02, 9.739e-02, -7.267e-03, 7.385e-02, -1.963e-03, 8.911e-02) * s0_1_2;
	r0 += M4(-1.157e-03, -7.035e-03, -6.194e-03, -2.084e-02, 3.997e-02, 1.059e-02, -1.254e-02, 3.771e-03, -2.653e-03, -5.918e-03, 1.359e-02, 1.090e-02, -6.839e-03, 8.522e-04, -8.705e-03, 1.666e-02) * s0_2_0;
	r0 += M4(6.930e-03, 2.296e-03, 3.624e-02, 6.897e-02, 2.925e-02, 2.412e-02, -2.839e-02, -6.323e-02, -5.117e-03, -4.710e-03, 1.278e-03, 7.695e-03, 1.420e-02, 9.126e-03, -7.018e-02, -9.399e-02) * s0_2_1;
	r0 += M4(1.412e-02, 6.925e-04, -2.013e-02, 3.919e-02, -9.299e-03, 4.852e-03, 2.522e-03, 5.535e-03, 1.780e-03, 3.345e-03, 3.076e-04, 7.774e-03, 9.443e-04, 5.994e-03, -2.007e-03, -8.878e-03) * s0_2_2;
	r0 += M4(-4.857e-02, 1.702e-02, 2.582e-02, -7.983e-03, 3.297e-02, 1.015e-02, 6.833e-03, 1.419e-02, 8.271e-02, -2.732e-02, -4.132e-02, 2.056e-03, 3.918e-02, -1.214e-02, -1.347e-02, 4.390e-03) * s1_0_0;
	r0 += M4(-3.071e-02, 2.210e-02, 8.251e-03, 9.103e-03, 8.375e-02, -1.626e-01, -1.725e-02, -1.123e-02, -2.797e-02, 7.202e-02, 1.564e-02, 1.916e-02, -9.149e-02, 4.387e-02, 3.163e-02, -8.259e-05) * s1_0_1;
	r0 += M4(-5.463e-03, 1.059e-03, 6.161e-03, -5.237e-03, -1.404e-02, 5.662e-04, -9.542e-03, -3.638e-03, -6.181e-03, -1.005e-02, -1.424e-03, 2.929e-02, 2.475e-02, 2.763e-02, 1.499e-02, 8.258e-03) * s1_0_2;
	r0 += M4(9.974e-02, 2.275e-02, -6.646e-02, -2.021e-02, 7.007e-02, 9.665e-03, 8.325e-02, -1.715e-04, -2.017e-01, 2.870e-02, 8.693e-02, 3.700e-02, 5.230e-02, 5.015e-04, 1.333e-01, -8.899e-03) * s1_1_0;
	r0 += M4(2.549e-01, -3.535e-01, -7.451e-02, 2.437e-01, 1.323e-01, -1.467e-01, 2.901e-01, -2.822e-01, 1.649e-01, 7.690e-02, 1.450e-01, -4.152e-01, -9.848e-02, -9.011e-02, -4.128e-01, -6.401e-02) * s1_1_1;
	r0 += M4(-1.181e-02, 2.528e-03, 1.437e-02, -8.180e-02, -5.696e-03, -3.333e-02, -1.998e-02, -2.780e-02, -6.467e-03, -1.974e-02, -1.346e-02, 5.576e-02, -1.570e-02, 2.216e-01, 3.650e-02, 2.299e-01) * s1_1_2;
	r0 += M4(-2.351e-02, 2.984e-02, -1.412e-02, -3.235e-02, -1.937e-02, 3.925e-03, -1.563e-02, 8.869e-03, 7.946e-03, 3.521e-03, -4.724e-02, 2.396e-02, 1.047e-02, 8.982e-03, -1.551e-02, 4.865e-03) * s1_2_0;
	r0 += M4(-3.431e-02, -5.109e-03, -3.642e-02, 1.092e-01, 2.862e-03, -1.038e-03, -7.449e-03, -9.175e-03, 1.478e-03, -2.054e-03, 2.596e-02, 5.043e-02, -4.147e-02, -1.406e-02, 3.190e-02, -5.364e-02) * s1_2_1;
	r0 += M4(-1.363e-02, 6.817e-03, 6.493e-03, -4.896e-02, -1.005e-02, 7.987e-03, -2.542e-03, 4.084e-03, -1.163e-03, -8.925e-03, -3.510e-03, -5.056e-03, 3.045e-02, -1.628e-03, -4.946e-03, 1.050e-02) * s1_2_2;
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 += M4(4.991e-02, 2.305e-03, 9.795e-03, 2.615e-03, -4.099e-03, 1.958e-03, -4.758e-03, 1.062e-03, 1.179e-02, -9.771e-03, 1.581e-02, 4.361e-03, 5.212e-02, 1.733e-02, 3.882e-04, -8.455e-03) * s0_0_0;
	r0 += M4(-1.410e-01, -1.153e-01, 3.699e-02, -2.507e-02, 8.615e-03, -4.595e-03, 5.060e-03, -1.708e-03, 5.264e-02, 8.075e-02, 2.089e-02, 3.465e-02, -3.812e-01, -1.533e-01, 2.088e-01, 8.669e-02) * s0_0_1;
	r0 += M4(5.815e-03, -1.732e-02, 7.743e-04, 2.195e-02, -4.004e-02, 1.052e-03, 1.047e-02, 1.548e-03, 9.496e-04, 8.863e-03, 6.785e-03, 1.116e-02, 3.378e-02, -1.363e-01, -1.522e-02, 1.150e-01) * s0_0_2;
	r0 += M4(5.726e-02, -3.317e-03, 1.303e-01, 9.720e-03, 5.670e-04, -1.175e-03, 1.176e-03, 1.071e-03, 4.990e-02, -1.801e-02, -5.984e-02, -1.064e-02, -8.537e-03, 1.023e-02, 3.885e-03, -6.505e-03) * s0_1_0;
	r0 += M4(2.459e-02, 2.046e-01, -2.998e-01, 8.959e-02, 3.705e-03, -1.688e-02, -1.676e-02, -2.015e-02, 2.244e-01, 1.909e-01, -3.740e-01, -3.014e-01, -9.338e-02, -7.023e-02, 2.527e-01, 1.243e-01) * s0_1_1;
	r0 += M4(5.603e-03, -8.179e-02, 1.079e-02, -1.086e-01, -2.853e-01, 3.525e-01, -1.529e-01, 1.579e-01, -9.571e-03, 7.300e-02, 9.913e-03, -1.215e-01, -1.223e-02, -4.988e-02, -1.324e-02, 1.548e-01) * s0_1_2;
	r0 += M4(-5.892e-04, 3.789e-03, 9.247e-03, -1.008e-03, -2.931e-03, 1.056e-03, -2.370e-03, -4.931e-04, -1.886e-02, -4.641e-03, 2.606e-02, 8.426e-03, -1.217e-03, -1.450e-03, -1.390e-03, 1.381e-03) * s0_2_0;
	r0 += M4(-4.315e-03, -5.095e-03, 7.495e-02, 5.674e-02, 2.270e-03, -1.922e-02, 7.582e-03, -1.931e-02, -2.167e-02, -2.312e-02, 5.109e-02, 5.896e-02, 1.570e-02, 9.058e-03, -3.505e-02, -2.764e-02) * s0_2_1;
	r0 += M4(-2.119e-03, -1.400e-02, 1.764e-02, -3.043e-03, -1.401e-02, 1.288e-02, -1.548e-01, 1.880e-01, -4.971e-03, -9.489e-03, 1.249e-02, 3.308e-02, 3.935e-04, 6.321e-03, -3.738e-03, -2.250e-02) * s0_2_2;
	r0 += V4(-3.742e-05, -4.748e-05, -5.385e-05, -6.337e-05);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
