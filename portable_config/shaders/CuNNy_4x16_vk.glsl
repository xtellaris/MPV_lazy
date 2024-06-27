// CuNNy 4x16
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


//!DESC [CuNNy_4x16_vk] -in
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND LUMA
//!SAVE in
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
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
	ivec2 opos = pos * ivec2(2, 2);
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
	V4 r0, r1, r2, r3;
	r0 = V4(0.0); r1 = V4(0.0); r2 = V4(0.0); r3 = V4(0.0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2];
	r0 += V4(-3.721e-01, -1.040e-02, -9.630e-02, 2.021e-02) * s0_0_0;
	r1 += V4(-5.673e-02, -3.727e-02, -2.476e-02, 4.163e-02) * s0_0_0;
	r2 += V4(1.509e-02, -2.965e-04, -4.122e-02, 8.558e-03) * s0_0_0;
	r3 += V4(-9.613e-03, -1.064e-02, 3.004e-03, -6.781e-03) * s0_0_0;
	r0 += V4(3.799e-01, -1.623e-03, 1.125e-02, -6.088e-02) * s0_0_1;
	r1 += V4(3.130e-01, -5.492e-01, -1.506e-01, -1.023e-01) * s0_0_1;
	r2 += V4(1.247e-02, 4.357e-02, -5.981e-03, -9.395e-03) * s0_0_1;
	r3 += V4(6.758e-02, 3.396e-02, 7.821e-03, 1.343e-02) * s0_0_1;
	r0 += V4(2.704e-02, 9.309e-03, 1.302e-02, -2.450e-03) * s0_0_2;
	r1 += V4(-4.456e-02, 2.092e-02, 6.063e-03, 1.714e-02) * s0_0_2;
	r2 += V4(3.098e-02, -4.744e-02, -1.121e-02, 7.597e-04) * s0_0_2;
	r3 += V4(-5.992e-02, -1.515e-02, -1.211e-02, -9.165e-03) * s0_0_2;
	r0 += V4(3.481e-01, 2.110e-02, 3.998e-01, 1.101e-02) * s0_1_0;
	r1 += V4(1.755e-02, 4.170e-02, -9.263e-02, -7.342e-02) * s0_1_0;
	r2 += V4(4.697e-01, 5.630e-01, 4.391e-01, 6.325e-01) * s0_1_0;
	r3 += V4(-7.633e-03, -1.588e-02, -9.459e-03, 1.333e-01) * s0_1_0;
	r0 += V4(-3.486e-01, -6.280e-01, -1.115e-01, -3.561e-01) * s0_1_1;
	r1 += V4(-1.782e-01, 4.872e-01, 1.447e-01, 4.610e-01) * s0_1_1;
	r2 += V4(-7.703e-01, -2.143e-01, -4.089e-01, -6.309e-01) * s0_1_1;
	r3 += V4(4.432e-01, 1.776e-01, 2.214e-02, 5.654e-01) * s0_1_1;
	r0 += V4(-2.729e-02, 6.152e-01, 2.192e-02, -2.596e-01) * s0_1_2;
	r1 += V4(4.047e-02, 4.547e-02, 6.693e-02, -2.691e-02) * s0_1_2;
	r2 += V4(1.577e-02, 2.522e-02, 2.951e-02, -7.940e-04) * s0_1_2;
	r3 += V4(-4.073e-01, 2.480e-01, 5.335e-01, 6.779e-02) * s0_1_2;
	r0 += V4(1.338e-02, -1.252e-02, -7.490e-02, -1.678e-02) * s0_2_0;
	r1 += V4(-1.041e-02, -5.678e-03, -1.809e-02, 2.906e-02) * s0_2_0;
	r2 += V4(1.902e-01, -2.427e-01, -3.878e-01, 8.578e-03) * s0_2_0;
	r3 += V4(-9.453e-03, 3.238e-02, 5.493e-03, -1.164e-01) * s0_2_0;
	r0 += V4(-1.630e-02, 1.016e-03, -3.309e-02, 4.462e-01) * s0_2_1;
	r1 += V4(7.935e-02, 7.451e-02, 1.101e-01, -4.399e-02) * s0_2_1;
	r2 += V4(2.352e-03, -1.329e-01, 4.106e-01, -6.397e-03) * s0_2_1;
	r3 += V4(-1.289e-02, -3.710e-01, -5.467e-01, -5.810e-01) * s0_2_1;
	r0 += V4(3.850e-05, 1.220e-02, -6.486e-03, 2.185e-01) * s0_2_2;
	r1 += V4(-2.259e-02, -6.470e-02, -7.110e-02, -4.916e-03) * s0_2_2;
	r2 += V4(4.733e-03, 1.404e-02, -2.460e-02, -2.435e-03) * s0_2_2;
	r3 += V4(7.487e-03, -5.813e-02, -5.312e-03, -6.011e-02) * s0_2_2;
	r0 += V4(1.592e-03, 7.534e-03, -3.539e-03, 7.836e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(9.119e-03, 8.638e-03, 4.386e-02, 6.551e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(-1.406e-02, -5.717e-03, 1.004e-02, 3.735e-04);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r2));
	r3 += V4(1.307e-02, 2.017e-02, 1.778e-06, 1.096e-02);
	r3 = max(r3, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r3));
}

//!DESC [CuNNy_4x16_vk] -conv1
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND in
//!BIND LUMA
//!SAVE conv1
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[4][10][10];
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
			vec2 p;
			vec4 r, g, b, a;
			p = vec2(clamp(pos + ivec2(x - 1, y - 1), ivec2(0), sz) * ivec2(2, 2) + ivec2(1, 1)) * in_pt;
			r = in_gather(p, 0);
			g = in_gather(p, 1);
			b = in_gather(p, 2);
			a = in_gather(p, 3);
			vec4 v0 = vec4(r.w, g.w, b.w, a.w) * 1.0000000e+00;
			vec4 v1 = vec4(r.z, g.z, b.z, a.z) * 1.0000000e+00;
			vec4 v2 = vec4(r.x, g.x, b.x, a.x) * 1.0000000e+00;
			vec4 v3 = vec4(r.y, g.y, b.y, a.y) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
			G[2][ay][ax] = int(packSnorm4x8(v2));
			G[3][ay][ax] = int(packSnorm4x8(v3));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0, r1, r2, r3;
	vec4 f0, f1, f2, f3;
	r0 = ivec4(0); r1 = ivec4(0); r2 = ivec4(0); r3 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x04110AFD, 0xF9F21008, 0x0500FF01, 0xBC011E03);
	r1 = D(r1, s0_0_0, 0xF510F2FA, 0x0F0EECFC, 0x1B0BEDFE, 0xF0190CEF);
	r2 = D(r2, s0_0_0, 0xDAF70F08, 0x12E1F803, 0x080613FB, 0x2CECCBFC);
	r3 = D(r3, s0_0_0, 0xE3FFECFE, 0x0FDCEA08, 0xF402F60D, 0xECF6E2FF);
	r0 = D(r0, s0_0_1, 0x20141E06, 0xD8FC1CFB, 0xF3DDFAF2, 0x1AFE1015);
	r1 = D(r1, s0_0_1, 0x17031900, 0x04F1080E, 0xFBFC1919, 0x00FE070A);
	r2 = D(r2, s0_0_1, 0x2A151B0D, 0x79E8FC09, 0x2213BEE7, 0x16E80814);
	r3 = D(r3, s0_0_1, 0x811806FA, 0xF3E30AFF, 0xD9E4221E, 0x08F11507);
	r0 = D(r0, s0_0_2, 0xFDEDFAFA, 0x13FB0810, 0xFCECF802, 0x05080CE2);
	r1 = D(r1, s0_0_2, 0xFDF9FBFB, 0xD3F4E6DC, 0xEC10FAFF, 0x1A1C0C19);
	r2 = D(r2, s0_0_2, 0x01EF011D, 0x081FF6FE, 0xEBC0F8EE, 0xF5F9F90D);
	r3 = D(r3, s0_0_2, 0x1928FFFE, 0xFEDC0A3F, 0x0D05F907, 0xF9FAFCFF);
	r0 = D(r0, s0_1_0, 0x0C113AFD, 0x150FEAF9, 0x110820F8, 0x040AD9ED);
	r1 = D(r1, s0_1_0, 0xFEE3010E, 0xE8EB1C01, 0xFB033BFA, 0xD908FD16);
	r2 = D(r2, s0_1_0, 0xDBFAA110, 0xFE0035E9, 0xAFEF4F09, 0x21FD46FB);
	r3 = D(r3, s0_1_0, 0x11F906F7, 0x2700CC0E, 0xE6E0BD12, 0x060C00F8);
	r0 = D(r0, s0_1_1, 0xFF21EF1D, 0xF4019F0F, 0x29E941CD, 0x32DE1DFC);
	r1 = D(r1, s0_1_1, 0x1522F6FC, 0x37F44C09, 0xFC187FFA, 0xEB1033FC);
	r2 = D(r2, s0_1_1, 0x0D0AD6EF, 0x0C0AC61C, 0xD63FEDF6, 0xF31413F5);
	r3 = D(r3, s0_1_1, 0x0BFAE947, 0xC0035426, 0x39E20C2F, 0x090C1124);
	r0 = D(r0, s0_1_2, 0xFDFFF6E2, 0x1003F535, 0xF522F5FA, 0xEB19FEC9);
	r1 = D(r1, s0_1_2, 0x052101EE, 0x0B3B12E1, 0x02C605EA, 0x048FCD3D);
	r2 = D(r2, s0_1_2, 0xE6EC0023, 0xF6F0EB31, 0x09C42019, 0x29FD1ECD);
	r3 = D(r3, s0_1_2, 0x04E000D9, 0xE562F801, 0xF160EAC8, 0xF7F4F9F6);
	r0 = D(r0, s0_2_0, 0x07F423F7, 0x05FEEEFC, 0x01F3C61A, 0x0917BFE3);
	r1 = D(r1, s0_2_0, 0xCCF138FA, 0x0411E907, 0x06F107FA, 0xB8FE050E);
	r2 = D(r2, s0_2_0, 0xF30AF400, 0xFD0808F8, 0xF30900FD, 0xEAF4EC04);
	r3 = D(r3, s0_2_0, 0x0600FDFC, 0x04F50AE5, 0xF1FFF210, 0x0002FF02);
	r0 = D(r0, s0_2_1, 0xF9230004, 0x012019CE, 0x020B3AEF, 0x0407091F);
	r1 = D(r1, s0_2_1, 0xFEF2E63F, 0xFD083C21, 0x02041E32, 0x051730EA);
	r2 = D(r2, s0_2_1, 0x0CE51FC4, 0x110C2E14, 0x0E391F05, 0xEC10B027);
	r3 = D(r3, s0_2_1, 0xFCEEFF09, 0x00001E9A, 0x160606F9, 0x030E11FA);
	r0 = D(r0, s0_2_2, 0xFFF9090A, 0xF71706FF, 0xFB180129, 0x18EAF81C);
	r1 = D(r1, s0_2_2, 0xFC3002FE, 0xEFDE01F3, 0xFBF4FE24, 0xF219E71D);
	r2 = D(r2, s0_2_2, 0x061503FD, 0xF20203FA, 0x0409FE1B, 0x0A06FAE6);
	r3 = D(r3, s0_2_2, 0x02F90004, 0xFE060BFB, 0xF62305F9, 0x02FD0CF7);
	r0 = D(r0, s1_0_0, 0x0BF0FC04, 0xFEEF060B, 0xF91803FF, 0x1D19E9E8);
	r1 = D(r1, s1_0_0, 0xEC0701F6, 0x0005F5F8, 0x12FFFD0C, 0x0010F604);
	r2 = D(r2, s1_0_0, 0x09F1E4E3, 0xE5F31706, 0xE50EFCFB, 0xFAFC0500);
	r3 = D(r3, s1_0_0, 0x2A190318, 0x32090225, 0x17E6131C, 0xFD000702);
	r0 = D(r0, s1_0_1, 0xE4F70F00, 0xF5F80CFE, 0xDCF903EF, 0xE9FA07E4);
	r1 = D(r1, s1_0_1, 0x0AEE02FC, 0xEBE607D8, 0x1EF800FC, 0xF2DF0D08);
	r2 = D(r2, s1_0_1, 0xF2FA1B06, 0xBDF40418, 0xD5240407, 0xFCFE0B1C);
	r3 = D(r3, s1_0_1, 0x48F5F4DF, 0x0A140A1C, 0xF30F01ED, 0x08FD050A);
	r0 = D(r0, s1_0_2, 0x07020908, 0xFB1BFBFE, 0xFAF8F8F8, 0xF00C0506);
	r1 = D(r1, s1_0_2, 0xF9EA02F3, 0x080EF6F0, 0xF8F10200, 0xF4FDFBE1);
	r2 = D(r2, s1_0_2, 0xDF0309E7, 0xE7090303, 0xF0EF0A09, 0x16FCFDF3);
	r3 = D(r3, s1_0_2, 0x12F50417, 0x000FF9E2, 0x09F0FD0A, 0xF5F102F9);
	r0 = D(r0, s1_1_0, 0xE028041E, 0xF104F804, 0x03F1E0E8, 0xFD06360D);
	r1 = D(r1, s1_1_0, 0xFDF00FDD, 0xFC03F4E1, 0xE91705F0, 0xEE00E7FB);
	r2 = D(r2, s1_1_0, 0x04EAA61E, 0xEC0BDFEE, 0xEF09CBE8, 0x1F0420E6);
	r3 = D(r3, s1_1_0, 0xE5EE0FE8, 0x15FFDCDD, 0xFA0204E5, 0x030308FD);
	r0 = D(r0, s1_1_1, 0x4E050911, 0xE4E104ED, 0xCAE3F0E5, 0xE9E8F9F2);
	r1 = D(r1, s1_1_1, 0x321DD61A, 0x00E2C60C, 0xFC142A45, 0x0D29474A);
	r2 = D(r2, s1_1_1, 0x1817401A, 0x080314FB, 0x1F0C15E4, 0x2809CED5);
	r3 = D(r3, s1_1_1, 0xCBE48139, 0x0EFFE128, 0x02F3EDFC, 0xD00EF716);
	r0 = D(r0, s1_1_2, 0x151B0A0C, 0x010AFC15, 0x2318F809, 0x0BEFBBEC);
	r1 = D(r1, s1_1_2, 0x21F5FAFB, 0x0B1E1AF5, 0x0C14F2E6, 0x0CEFDCC8);
	r2 = D(r2, s1_1_2, 0xF813061D, 0x13F2F708, 0x27E6DD12, 0xF613FF0B);
	r3 = D(r3, s1_1_2, 0x00001DF1, 0xF2D1FEFB, 0xE81D1905, 0x110CFB06);
	r0 = D(r0, s1_2_0, 0xDBF401D4, 0x0A08F6E4, 0x03E8EB1A, 0xFE030824);
	r1 = D(r1, s1_2_0, 0x33EC0121, 0xF400070D, 0xFDE42A0C, 0x070A1EF8);
	r2 = D(r2, s1_2_0, 0x0913E8F2, 0x1F041BE4, 0xFBF40A21, 0xE7DF0F32);
	r3 = D(r3, s1_2_0, 0xF1F20B07, 0xF6E7F9EB, 0x05021DED, 0xF9F522F6);
	r0 = D(r0, s1_2_1, 0xF701E90B, 0x1C160208, 0x18111A19, 0x180B3D19);
	r1 = D(r1, s1_2_1, 0x6A2D2B07, 0xF9EFF91B, 0x061AFADB, 0x2EFAEDBA);
	r2 = D(r2, s1_2_1, 0x11DF1FFC, 0x31E906E7, 0x13EFFB07, 0xDCE8CC2D);
	r3 = D(r3, s1_2_1, 0xED1BE7E7, 0xD9200C11, 0xEBFFC106, 0x220412F1);
	r0 = D(r0, s1_2_2, 0x0D010DF0, 0x12F2E2E9, 0x330B4B10, 0x0904CDF6);
	r1 = D(r1, s1_2_2, 0xFB0A0211, 0x10F9D946, 0xECF6F300, 0xE2210545);
	r2 = D(r2, s1_2_2, 0x01F321E8, 0x1904F323, 0x0AF9E8F9, 0xF70407F0);
	r3 = D(r3, s1_2_2, 0xE7F5FD00, 0xE5FA50D3, 0xF70B0115, 0x08F90DF7);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xECF9021C, 0x03F80109, 0x0A01F3FA, 0x4FD7F1C7);
	r1 = D(r1, s0_0_0, 0xEFF20413, 0x0304EEFA, 0xE813FB1F, 0xE8F5FB21);
	r2 = D(r2, s0_0_0, 0xB4CD2145, 0xF9170300, 0x29D91FC9, 0xE704190E);
	r3 = D(r3, s0_0_0, 0x060904F3, 0x1205FAF9, 0xF9F61A04, 0xF1120511);
	r0 = D(r0, s0_0_1, 0x2AC0F0ED, 0x10F914FC, 0xEE03F101, 0xFFCFD80F);
	r1 = D(r1, s0_0_1, 0xFBF70710, 0x04E6DB0D, 0xFD09150A, 0xE81AFAE4);
	r2 = D(r2, s0_0_1, 0xE236C7E2, 0xFCF10CEA, 0x81F36020, 0xEB181020);
	r3 = D(r3, s0_0_1, 0xEFBE0C16, 0x34E206EF, 0x37C951C6, 0x34EE0CF5);
	r0 = D(r0, s0_0_2, 0x0EF7F3F4, 0xE2E5270F, 0x01080801, 0xDBFB200D);
	r1 = D(r1, s0_0_2, 0xF102FC10, 0x92180A42, 0xDA1E0EF9, 0xF0DA0A08);
	r2 = D(r2, s0_0_2, 0xF0CB0439, 0xF1CD0104, 0x260D8137, 0xF70FB832);
	r3 = D(r3, s0_0_2, 0xAD34120C, 0x15260BF1, 0xEE1B24D6, 0x1009F3FB);
	r0 = D(r0, s0_1_0, 0x18F8F9E5, 0xDB08001D, 0xF9F30604, 0xC01A1527);
	r1 = D(r1, s0_1_0, 0xDC0A1D20, 0x26FDF4F0, 0x0CFD09F1, 0x2BFCF8D5);
	r2 = D(r2, s0_1_0, 0xDD08E932, 0x19180207, 0x221DFFE4, 0x04010500);
	r3 = D(r3, s0_1_0, 0xFFFF0C02, 0xF3FA20FF, 0x1A0101F7, 0xF409FF09);
	r0 = D(r0, s0_1_1, 0xDAD6DD1D, 0xFD0FEE05, 0x0A0DEEEB, 0xB134C506);
	r1 = D(r1, s0_1_1, 0xBF01380D, 0xD11B152F, 0x40D503C1, 0x572615B2);
	r2 = D(r2, s0_1_1, 0x544A20F6, 0x7FFA17C2, 0x1B2A29F7, 0xB6DCF92D);
	r3 = D(r3, s0_1_1, 0x17F7E6FD, 0x81EF007F, 0x7F18CA03, 0x7F1B1BEF);
	r0 = D(r0, s0_1_2, 0xF3F1F907, 0x7F0C9FE7, 0xB913081A, 0x8F38EE2D);
	r1 = D(r1, s0_1_2, 0xDF1FF117, 0xCCEF4CED, 0x6DE1C101, 0xC0DC8167);
	r2 = D(r2, s0_1_2, 0x17F53CC1, 0x2AFADC15, 0x60F7AAFC, 0xB5300F19);
	r3 = D(r3, s0_1_2, 0x320715F8, 0x81E0E3B8, 0x81E0EC14, 0x1404F0F5);
	r0 = D(r0, s0_2_0, 0x0803FEFA, 0xF7000E07, 0xF9FB0303, 0x12280BFA);
	r1 = D(r1, s0_2_0, 0xF616FB10, 0xF6FAF9FB, 0x03FC0502, 0x33FEE5D9);
	r2 = D(r2, s0_2_0, 0xF801E9FA, 0xEC07FF16, 0x03040FFB, 0xEB08F320);
	r3 = D(r3, s0_2_0, 0x06FC03F9, 0x07090300, 0x06FB01FB, 0xF9FF010E);
	r0 = D(r0, s0_2_1, 0xDCFAE9F9, 0xEFF4EA03, 0x18FA0E05, 0x7F0E1AFA);
	r1 = D(r1, s0_2_1, 0x81260042, 0x10EC11E8, 0xF60BFA00, 0x8908257F);
	r2 = D(r2, s0_2_1, 0x2B02F318, 0x1BF1F6F6, 0xC90D1C19, 0x0A2CF5FD);
	r3 = D(r3, s0_2_1, 0xEC0007FC, 0xB9FDFF23, 0x07E9FAF2, 0x1903FFFF);
	r0 = D(r0, s0_2_2, 0x06F3F8FC, 0x81E4232D, 0xC8F4F20B, 0x22EFD4BB);
	r1 = D(r1, s0_2_2, 0x1508F601, 0xDC130D46, 0xF107F2F7, 0x81D11427);
	r2 = D(r2, s0_2_2, 0xDFFAFD08, 0x040CEFF4, 0xC9E80709, 0x320D1A05);
	r3 = D(r3, s0_2_2, 0x04010700, 0xF60B07F6, 0xB5F5F820, 0x1305F603);
	r0 = D(r0, s1_0_0, 0xF7EA06FA, 0xFAFC03E2, 0x1507F51B, 0x15C62FE5);
	r1 = D(r1, s1_0_0, 0xFAFB0C05, 0x240B0701, 0xE8EA0B1B, 0x2A38C23D);
	r2 = D(r2, s1_0_0, 0x3157E811, 0x1D020300, 0xF5BFFBB5, 0xDF31E61B);
	r3 = D(r3, s1_0_0, 0xF1FC0A0D, 0x03FF2FF4, 0xEF55B210, 0x0021F90C);
	r0 = D(r0, s1_0_1, 0x2BE1F4FE, 0x17E300E9, 0x290C0715, 0x06D700FB);
	r1 = D(r1, s1_0_1, 0x1FEFF6E9, 0x17230824, 0x06210030, 0xCF22F91E);
	r2 = D(r2, s1_0_1, 0xA3FEEAD8, 0x1609E7E9, 0x812E93DC, 0x20DE1F10);
	r3 = D(r3, s1_0_1, 0x5720163B, 0x061106F7, 0x57E62B10, 0x2C05FA06);
	r0 = D(r0, s1_0_2, 0x00070304, 0xFBFBFAF7, 0xEE10F902, 0x13F61F00);
	r1 = D(r1, s1_0_2, 0x01FC0B06, 0xDF1FDA18, 0x0613EB0B, 0xCED12EF8);
	r2 = D(r2, s1_0_2, 0x32E61DFF, 0xD6100F02, 0x2AE5271A, 0x1CFA0A0C);
	r3 = D(r3, s1_0_2, 0x040AECF7, 0x2911C1FD, 0x1A0DE4F1, 0x0E0405FF);
	r0 = D(r0, s1_1_0, 0xFCCB3617, 0x080B1E15, 0x2DFA17FB, 0x9081CB28);
	r1 = D(r1, s1_1_0, 0xD9FB040B, 0x0BD51EF1, 0xE91400DD, 0x0C19EDB8);
	r2 = D(r2, s1_1_0, 0xE419242D, 0xF91109FD, 0xFFDF1415, 0xFEFCE2B9);
	r3 = D(r3, s1_1_0, 0xF20FF9E4, 0xFB8138CC, 0x0DEB41FE, 0xEA1CF704);
	r0 = D(r0, s1_1_1, 0x1FEAE506, 0x027FF93D, 0xABFA00CB, 0x81D8DBF9);
	r1 = D(r1, s1_1_1, 0xFC81E511, 0xD2160CE4, 0x1228F8AB, 0xDE8709A3);
	r2 = D(r2, s1_1_1, 0xB6130505, 0x08F2222F, 0x21F92DEB, 0x190819E1);
	r3 = D(r3, s1_1_1, 0x03F8F6D2, 0xE3F7E8E5, 0x1FD11F08, 0x05070303);
	r0 = D(r0, s1_1_2, 0x0B0BF1FB, 0xDC13CE19, 0x921808F7, 0x51E2280F);
	r1 = D(r1, s1_1_2, 0xF105FCF8, 0x05FDFCEE, 0xF7F40AFB, 0xBBC22DF3);
	r2 = D(r2, s1_1_2, 0x0E090914, 0x170D05FD, 0x14F100D3, 0xF1EE04E6);
	r3 = D(r3, s1_1_2, 0xF9F60A01, 0xFA0FEF0F, 0xDAFC131D, 0xFD050C0D);
	r0 = D(r0, s1_2_0, 0x03F11017, 0xF824E213, 0x010DEA07, 0xF130F9EC);
	r1 = D(r1, s1_2_0, 0x08D72426, 0x0F1AC8E7, 0x01ED1503, 0x1FD40D05);
	r2 = D(r2, s1_2_0, 0x1FF203D8, 0x040FEEE5, 0xE2FF0632, 0xFAF11324);
	r3 = D(r3, s1_2_0, 0xF4FB1719, 0x00E4113B, 0xFBF10FE9, 0xFC03FF05);
	r0 = D(r0, s1_2_1, 0x0AFF030A, 0xF7EAFBEB, 0xF514F1C7, 0xE716F703);
	r1 = D(r1, s1_2_1, 0x10F9091F, 0xF4F603ED, 0x0608F50B, 0xD0E52A1A);
	r2 = D(r2, s1_2_1, 0xFCFA0101, 0xFA0101FB, 0xF802083B, 0x10FEFA0F);
	r3 = D(r3, s1_2_1, 0xFB0009FF, 0x14DD180C, 0x09FF0103, 0x040105F7);
	r0 = D(r0, s1_2_2, 0x03F901FA, 0xF9E831F1, 0x09F80608, 0x070DEEF7);
	r1 = D(r1, s1_2_2, 0xFAFC040A, 0xFA031AFA, 0x0108FBFE, 0x0F03F313);
	r2 = D(r2, s1_2_2, 0x0303F8F4, 0x09FA0303, 0xF806F811, 0xFC12E811);
	r3 = D(r3, s1_2_2, 0xFF02FC01, 0x0101F9FC, 0xFFF30AF2, 0x01FEF8F6);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-6.840e-03, 5.666e-03, 9.529e-03, -9.542e-04);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-6.152e-01, 1.037e-02, -2.132e-02, -1.233e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(5.245e-03, 7.962e-04, 1.465e-03, 1.412e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), f2);
	f3 = vec4(r3) * 6.2000124e-05;
	f3 += vec4(1.853e-02, 9.352e-03, -6.964e-03, 5.769e-03);
	f3 = max(f3, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), f3);
}

//!DESC [CuNNy_4x16_vk] -conv2
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv1
//!BIND LUMA
//!SAVE conv2
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[4][10][10];
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
			vec2 p;
			vec4 r, g, b, a;
			p = vec2(clamp(pos + ivec2(x - 1, y - 1), ivec2(0), sz) * ivec2(2, 2) + ivec2(1, 1)) * conv1_pt;
			r = conv1_gather(p, 0);
			g = conv1_gather(p, 1);
			b = conv1_gather(p, 2);
			a = conv1_gather(p, 3);
			vec4 v0 = vec4(r.w, g.w, b.w, a.w) * 1.0000000e+00;
			vec4 v1 = vec4(r.z, g.z, b.z, a.z) * 1.0000000e+00;
			vec4 v2 = vec4(r.x, g.x, b.x, a.x) * 1.0000000e+00;
			vec4 v3 = vec4(r.y, g.y, b.y, a.y) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
			G[2][ay][ax] = int(packSnorm4x8(v2));
			G[3][ay][ax] = int(packSnorm4x8(v3));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0, r1, r2, r3;
	vec4 f0, f1, f2, f3;
	r0 = ivec4(0); r1 = ivec4(0); r2 = ivec4(0); r3 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xFBFD10E8, 0xF41907FC, 0x07FA37EC, 0xFF01E9FE);
	r1 = D(r1, s0_0_0, 0x05F7CE13, 0x06FD0907, 0xFD080B01, 0xFD160927);
	r2 = D(r2, s0_0_0, 0x0A95F6F8, 0x03F12217, 0x030A0C0F, 0x17B90B0C);
	r3 = D(r3, s0_0_0, 0x11150404, 0xF1102CE9, 0xFCD01EE9, 0xEA333A18);
	r0 = D(r0, s0_0_1, 0x0CDE01F5, 0xD40CDB16, 0x03EF02F4, 0xF5F31204);
	r1 = D(r1, s0_0_1, 0x29ECEE0B, 0x0FF30203, 0xF5FF0503, 0xD606EDED);
	r2 = D(r2, s0_0_1, 0x1CF91B14, 0xFEF00BE9, 0x07FC09F5, 0x1AAD07D9);
	r3 = D(r3, s0_0_1, 0x24FD381C, 0xE9F5DF1C, 0xF2F6150C, 0xE93A1200);
	r0 = D(r0, s0_0_2, 0xF1F10FFE, 0xDB11FFFA, 0x0FFF0210, 0xF302FEFC);
	r1 = D(r1, s0_0_2, 0x07F8E101, 0x07F4F1FC, 0x040404F3, 0xDA020903);
	r2 = D(r2, s0_0_2, 0x040100FA, 0x0C0BFDE9, 0x0B0000FE, 0x24F7F8E4);
	r3 = D(r3, s0_0_2, 0x1305FEFB, 0xFF0C0217, 0xFBFC16F3, 0xCB180E2A);
	r0 = D(r0, s0_1_0, 0x0200120D, 0xF814F822, 0x03FD28F5, 0x0607FAD8);
	r1 = D(r1, s0_1_0, 0xFEFDB80D, 0x0AF92209, 0xFDFBFCFE, 0xEE311417);
	r2 = D(r2, s0_1_0, 0x0FF1EEFB, 0x08DDF5FF, 0xFF0303EA, 0x0908E310);
	r3 = D(r3, s0_1_0, 0x18D207FB, 0x07E3E212, 0x03F11100, 0xD2353E24);
	r0 = D(r0, s0_1_1, 0xFAFB0908, 0xDE0BD7F9, 0xFAFC1EE7, 0xFDFF2141);
	r1 = D(r1, s0_1_1, 0xF72B1C02, 0x0D0717C8, 0xFEFFFC04, 0xBF1115A1);
	r2 = D(r2, s0_1_1, 0x1DF6D04A, 0x07030302, 0xFC06EC1F, 0xFADADAFC);
	r3 = D(r3, s0_1_1, 0xFC2CF523, 0xF7F8E1F1, 0xFE811763, 0xBB1F0C15);
	r0 = D(r0, s0_1_2, 0xFEFC1313, 0xEF0CE8FD, 0x09FD0E14, 0xFE0402F7);
	r1 = D(r1, s0_1_2, 0xDEF8E506, 0x1DE90E05, 0xFAFFFB06, 0xDD01F6FF);
	r2 = D(r2, s0_1_2, 0x0F1110F9, 0x04F8E0F8, 0x02FFFD05, 0x12E4D413);
	r3 = D(r3, s0_1_2, 0xEF09F213, 0xE70CFC01, 0x14F612EC, 0xF0361BF9);
	r0 = D(r0, s0_2_0, 0x020413FE, 0x0200F8F9, 0x0BF71313, 0xFE0305F9);
	r1 = D(r1, s0_2_0, 0xFE04FCE8, 0x0BFA09FB, 0x03FFF7FD, 0xFF1CEC1C);
	r2 = D(r2, s0_2_0, 0x11040A03, 0x04FB081B, 0xFC05F7FF, 0x0404F908);
	r3 = D(r3, s0_2_0, 0x0117E0E1, 0x07F1FCEE, 0xF90814D8, 0xF11B07CD);
	r0 = D(r0, s0_2_1, 0x06FD00FA, 0xF5080AE6, 0x01F5220E, 0x01FF09FD);
	r1 = D(r1, s0_2_1, 0xFD010312, 0x14FF2616, 0x02FF03FE, 0xFC010712);
	r2 = D(r2, s0_2_1, 0x100302DE, 0xFBF20900, 0x030104F4, 0x03FE0603);
	r3 = D(r3, s0_2_1, 0xFB0910DE, 0x000DD9E7, 0x09FA16EA, 0xBB13E9BF);
	r0 = D(r0, s0_2_2, 0x07FF1403, 0xFEF9F7F9, 0x0FFC0CFC, 0x0200FDFB);
	r1 = D(r1, s0_2_2, 0xF00418D5, 0x16FE0905, 0x02FE0500, 0xFB050AF5);
	r2 = D(r2, s0_2_2, 0x0E04F6E0, 0x00FEE706, 0x020206FC, 0x05FDEE14);
	r3 = D(r3, s0_2_2, 0xF0FEF4D1, 0xF3F50A06, 0x02FD1C02, 0xD71AEDF8);
	r0 = D(r0, s1_0_0, 0x000DFA1E, 0xF7EFFCFB, 0xCBFD0DF0, 0x100EFA02);
	r1 = D(r1, s1_0_0, 0xE6070402, 0xEEF9FC0E, 0x08FDF70C, 0x16F30C37);
	r2 = D(r2, s1_0_0, 0x36EE0AED, 0xF7FA0F0E, 0xFC02FBE3, 0xE0FF2514);
	r3 = D(r3, s1_0_0, 0xDB00E807, 0xAA1DE834, 0x08080AF5, 0x08DCEB04);
	r0 = D(r0, s1_0_1, 0xF11308BF, 0x4EEFF30D, 0xF7FBF981, 0x32F00E40);
	r1 = D(r1, s1_0_1, 0xE90F20E1, 0xED04FFE2, 0x1602FAD8, 0x1B1FEDE4);
	r2 = D(r2, s1_0_1, 0xE5F11BBC, 0xF61601F1, 0x0F0EF80C, 0x992537C2);
	r3 = D(r3, s1_0_1, 0xB2FC2490, 0x3BF6F381, 0x24F9075F, 0xCDEBBBF9);
	r0 = D(r0, s1_0_2, 0xF409F91A, 0xF3FC030F, 0xD8FE04FC, 0x0900011D);
	r1 = D(r1, s1_0_2, 0xE7F21C26, 0xEEFC00E2, 0xFB03FDFB, 0x23F6FBF2);
	r2 = D(r2, s1_0_2, 0xEE05FBC2, 0x00070AF8, 0xFFFC03FE, 0xF807FF06);
	r3 = D(r3, s1_0_2, 0xE5F90CD0, 0xDEF81D2D, 0x21FE0AFD, 0xF330A491);
	r0 = D(r0, s1_1_0, 0xDB140806, 0x1508ECF9, 0xDD06EDFF, 0xE6460EFD);
	r1 = D(r1, s1_1_0, 0xE808E1FE, 0xE517060E, 0x0000FC0E, 0x0A11DC2B);
	r2 = D(r2, s1_1_0, 0x03C3FA0D, 0x0AE509F8, 0xF8190A0C, 0xB7F30603);
	r3 = D(r3, s1_1_0, 0xAB4003F2, 0xD2F7F90D, 0x310209E5, 0xF70181E5);
	r0 = D(r0, s1_1_1, 0xFF13F510, 0x3524D5F9, 0xCD19F618, 0xF1D917F1);
	r1 = D(r1, s1_1_1, 0x46121400, 0xBE070317, 0x08030A10, 0x1421B901);
	r2 = D(r2, s1_1_1, 0xE3EB1C05, 0xC2F508E8, 0x0817F110, 0xE2DD2BF6);
	r3 = D(r3, s1_1_1, 0x81FFDE81, 0x2831DDEE, 0xF69B0E0C, 0xC41890F5);
	r0 = D(r0, s1_1_2, 0xF80D0502, 0xD7ED00F9, 0xE9FB07FE, 0x30FCFCF6);
	r1 = D(r1, s1_1_2, 0xEEFBF6FE, 0x0F15FA15, 0xF6FD040E, 0x2918F004);
	r2 = D(r2, s1_1_2, 0xFB1BF41E, 0x14E11408, 0xFD050203, 0x00F01702);
	r3 = D(r3, s1_1_2, 0xEB1FDC81, 0xF2D509F4, 0xF2E70C01, 0xF627E111);
	r0 = D(r0, s1_2_0, 0xF30205F7, 0x0DFEFE03, 0xF6F90306, 0x15EC08FD);
	r1 = D(r1, s1_2_0, 0x020A0002, 0xDAF303F4, 0x00FE07FB, 0xFCDFF8F6);
	r2 = D(r2, s1_2_0, 0xF41A02FD, 0xFAFF0902, 0xFEFE07FF, 0xF1F706F0);
	r3 = D(r3, s1_2_0, 0xBD11DDF9, 0xE8EE10F7, 0x1D1BF701, 0x0138A804);
	r0 = D(r0, s1_2_1, 0xEFF6FD06, 0x0328EB0A, 0x14EC0207, 0x17020401);
	r1 = D(r1, s1_2_1, 0xF2FEFD0F, 0xE8EA0DF2, 0x06EB0AFB, 0x1DF8050A);
	r2 = D(r2, s1_2_1, 0x0720F4FA, 0x2F01FB06, 0x050005FC, 0xFCF90EED);
	r3 = D(r3, s1_2_1, 0xE8B10B28, 0xDD170703, 0xFA1A06F2, 0x2316BE0D);
	r0 = D(r0, s1_2_2, 0xF4010100, 0x16FC06FE, 0x1703030A, 0x15F6FFFF);
	r1 = D(r1, s1_2_2, 0x0C0DF400, 0xFE1EFC01, 0x03FB02FE, 0x16010401);
	r2 = D(r2, s1_2_2, 0xF4F70101, 0x020BFBFF, 0xFC00FCFF, 0x000D01F0);
	r3 = D(r3, s1_2_2, 0x080BF4F4, 0x10EC17F8, 0x0E0FFEFA, 0xC5C6EBE4);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x02FE03FD, 0xFB0303FF, 0x05FA04FD, 0xFBFD00FE);
	r1 = D(r1, s0_0_0, 0xFF06FA0C, 0x05FFFB0B, 0x07FE0502, 0x1003E5F7);
	r2 = D(r2, s0_0_0, 0x01150006, 0x08000601, 0x0A06FE03, 0xFAEB05FA);
	r3 = D(r3, s0_0_0, 0xF911FB02, 0xF0FB021E, 0x1107FE0D, 0xF803F9F4);
	r0 = D(r0, s0_0_1, 0x06060704, 0x11F6F6E2, 0x09FD11F4, 0x1102FF00);
	r1 = D(r1, s0_0_1, 0x0205FD0A, 0xFE080205, 0xFD05F908, 0x0A11040F);
	r2 = D(r2, s0_0_1, 0x04FA0401, 0xCF171B0E, 0xF10EFB0B, 0xE70A0C02);
	r3 = D(r3, s0_0_1, 0x2C1DD218, 0x2BF9E50F, 0x0000FB03, 0x1911EAF2);
	r0 = D(r0, s0_0_2, 0x05020519, 0xE40907FD, 0xE3F308FE, 0xF719FF06);
	r1 = D(r1, s0_0_2, 0xF10EF20F, 0x03F4FEFE, 0x04000603, 0xFC0AF904);
	r2 = D(r2, s0_0_2, 0x0006000C, 0xF5F6FF17, 0x0AFC04FB, 0xF702221C);
	r3 = D(r3, s0_0_2, 0x2524EF0E, 0xFBFAFCFE, 0xFBFD060D, 0x1A13E4F6);
	r0 = D(r0, s0_1_0, 0xFB05E4F7, 0x071AFBF2, 0xF10B08FC, 0xE306F103);
	r1 = D(r1, s0_1_0, 0xF2EE1006, 0x0600FC0A, 0xF6050DF8, 0x1908F106);
	r2 = D(r2, s0_1_0, 0x0F03100C, 0xFC0A09F8, 0xF7FAF9FB, 0xF4FEFE12);
	r3 = D(r3, s0_1_0, 0xF123E417, 0xC9F52F09, 0x06F90D01, 0xFF1EF0FC);
	r0 = D(r0, s0_1_1, 0x002135FA, 0x0911DFF5, 0xFA20E01C, 0x23F503F4);
	r1 = D(r1, s0_1_1, 0xF6F4F6FE, 0xEF02130B, 0xF91FFC0A, 0x0AFC68FD);
	r2 = D(r2, s0_1_1, 0x10189DF5, 0xFF433319, 0x081B3403, 0xFBEE39FD);
	r3 = D(r3, s0_1_1, 0xE73EF40C, 0xFFEFD044, 0x42F9FB07, 0xD50318ED);
	r0 = D(r0, s0_1_2, 0xEE09F717, 0xFA11F3EC, 0x1CF50DE5, 0x03FB02ED);
	r1 = D(r1, s0_1_2, 0x0606EB11, 0x2200EDFB, 0x010D00F8, 0xFCFCE221);
	r2 = D(r2, s0_1_2, 0x1524F51C, 0x0C08FEFF, 0xFD0602F7, 0x0F0DFAE7);
	r3 = D(r3, s0_1_2, 0xEE3A0501, 0x08FE04E1, 0xFC0DE000, 0xDAE7EE2D);
	r0 = D(r0, s0_2_0, 0xFAFCFAFF, 0xF11BFEFD, 0xFA100506, 0xFDE30509);
	r1 = D(r1, s0_2_0, 0x06E70AFE, 0xFB020D09, 0xFD060402, 0xFF25F8D0);
	r2 = D(r2, s0_2_0, 0xFD040B0C, 0xFAEFFCFE, 0x02F90603, 0xF005FFE6);
	r3 = D(r3, s0_2_0, 0xEF2E150F, 0xFAFCFB20, 0x05000501, 0x1C0EF300);
	r0 = D(r0, s0_2_1, 0x0826F1FB, 0x0A2120F8, 0x012C14EF, 0x08DAFB18);
	r1 = D(r1, s0_2_1, 0xF8321B06, 0x00171508, 0x04110A08, 0xEF32E6EC);
	r2 = D(r2, s0_2_1, 0x18FE1421, 0x01001002, 0x00150306, 0x0DEB0410);
	r3 = D(r3, s0_2_1, 0x1212F3D5, 0xE0320529, 0x06D4CF0C, 0x1D110FED);
	r0 = D(r0, s0_2_2, 0x02F80B09, 0xFAFDFAF4, 0xFBFA16FA, 0x04F1FE01);
	r1 = D(r1, s0_2_2, 0xFEF3FA22, 0x01EE06FF, 0x030007FF, 0x0612EAFA);
	r2 = D(r2, s0_2_2, 0x04140D0D, 0xFEF1FE10, 0x01F9FEFE, 0x06E21005);
	r3 = D(r3, s0_2_2, 0x043407F6, 0x2401F40F, 0x1EDDF711, 0xF141EBFE);
	r0 = D(r0, s1_0_0, 0xF60413F8, 0x0902F502, 0x12EB0B0E, 0x01FFFB03);
	r1 = D(r1, s1_0_0, 0x06EC0600, 0x09FB0BF8, 0x000BF5FF, 0xFF07ECFC);
	r2 = D(r2, s1_0_0, 0xF5FF23FF, 0xFE0FF006, 0x08FCFE02, 0xFF0E0FF6);
	r3 = D(r3, s1_0_0, 0x0FFD28EE, 0xF809D6FF, 0x0BFB11FE, 0x16FEF606);
	r0 = D(r0, s1_0_1, 0xDE1511FE, 0xD62107F3, 0xD9031003, 0xFE0001FC);
	r1 = D(r1, s1_0_1, 0x0519F4F5, 0x080505FC, 0xFDF50506, 0xD517E8FE);
	r2 = D(r2, s1_0_1, 0xD82916EC, 0x44C4090E, 0x0DF0F90E, 0x0DD10905);
	r3 = D(r3, s1_0_1, 0x3107D803, 0xF80A04FA, 0xE50F10F3, 0xE407DE13);
	r0 = D(r0, s1_0_2, 0xFCF6F500, 0x08E80111, 0xF1FD0305, 0xFEFC0901);
	r1 = D(r1, s1_0_2, 0x11F3F6FA, 0xFB07F9FA, 0x01F60405, 0xF9F4F512);
	r2 = D(r2, s1_0_2, 0xF80605FB, 0xFAE80412, 0x08F7FE07, 0x24E0EB1D);
	r3 = D(r3, s1_0_2, 0xE922F0E3, 0xFEFD00FC, 0x1AF60404, 0xDA0C02FE);
	r0 = D(r0, s1_1_0, 0xFF0312F9, 0x0F0AE804, 0x03F2F61D, 0xFBFC11F1);
	r1 = D(r1, s1_1_0, 0xF61318DA, 0x0003F5F6, 0xFA06FAFD, 0xE824CDE7);
	r2 = D(r2, s1_1_0, 0x17FB2FF4, 0xEC020AF3, 0xF0FD06F4, 0xF6FCE404);
	r3 = D(r3, s1_1_0, 0x07EF2306, 0xCF07D1FD, 0xF9040AF6, 0xE419EFF8);
	r0 = D(r0, s1_1_1, 0x21FFDC52, 0x41FE1919, 0x20EA0439, 0x05EAEF00);
	r1 = D(r1, s1_1_1, 0x0337D8E7, 0x40CEFB0A, 0x67100217, 0x2EEDE20D);
	r2 = D(r2, s1_1_1, 0x0372279D, 0xC00AE731, 0xD609F80D, 0xF8072827);
	r3 = D(r3, s1_1_1, 0xE1AD8129, 0x570AFFEF, 0x86F31081, 0xD10302FB);
	r0 = D(r0, s1_1_2, 0xF7F70605, 0x03F90001, 0xE5FA0D0C, 0xFB110600);
	r1 = D(r1, s1_1_2, 0xF5DF19CA, 0x1B0EF7F7, 0xFE02FFFF, 0xF90706F8);
	r2 = D(r2, s1_1_2, 0xFA16F7F8, 0xFA23FCE1, 0x0704FBF6, 0xF10EF30F);
	r3 = D(r3, s1_1_2, 0x0339FCC3, 0xF50306F2, 0xE1FD1206, 0x07FE030E);
	r0 = D(r0, s1_2_0, 0x0CF80A00, 0xF507ED00, 0xF1F7FB0D, 0x03FEF70E);
	r1 = D(r1, s1_2_0, 0x040108F4, 0xF4F7F7FE, 0xFEFEFCFD, 0x090AEB00);
	r2 = D(r2, s1_2_0, 0xE20505F2, 0x090310ED, 0x0700FC01, 0x04FEFB08);
	r3 = D(r3, s1_2_0, 0xEFF73708, 0x0E09C4E5, 0x0708FB08, 0x0614ECF3);
	r0 = D(r0, s1_2_1, 0xFD0BFC26, 0x12E8F119, 0xF7F21427, 0xF00E17EC);
	r1 = D(r1, s1_2_1, 0xEF04EB1B, 0xB2F3F328, 0xF5FFFB14, 0xFF10DC35);
	r2 = D(r2, s1_2_1, 0xE02A4081, 0x071423F6, 0xFF00FD17, 0xFEF9F305);
	r3 = D(r3, s1_2_1, 0xDF13F91C, 0x05F3DF10, 0x270BF8B0, 0x33E02430);
	r0 = D(r0, s1_2_2, 0x03F6F9FB, 0xF90311F1, 0xEDFC14FC, 0x05011402);
	r1 = D(r1, s1_2_2, 0x1DECF100, 0xE1F3F918, 0x00FA0501, 0x0EFCF1FB);
	r2 = D(r2, s1_2_2, 0xEC060806, 0x120008E6, 0x00FE05FA, 0xF0F407FD);
	r3 = D(r3, s1_2_2, 0x04FB11F3, 0x062015E6, 0x14F703FD, 0xDC0AD202);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(1.254e-02, 1.412e-02, -9.490e-03, -7.843e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(8.865e-03, 1.325e-02, -7.967e-03, 1.303e-03);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-2.034e-03, 1.288e-02, 6.412e-03, 8.515e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), f2);
	f3 = vec4(r3) * 6.2000124e-05;
	f3 += vec4(1.287e-02, -9.545e-03, 1.203e-02, 4.862e-03);
	f3 = max(f3, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), f3);
}

//!DESC [CuNNy_4x16_vk] -conv3
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv2
//!BIND LUMA
//!SAVE conv3
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[4][10][10];
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
			vec2 p;
			vec4 r, g, b, a;
			p = vec2(clamp(pos + ivec2(x - 1, y - 1), ivec2(0), sz) * ivec2(2, 2) + ivec2(1, 1)) * conv2_pt;
			r = conv2_gather(p, 0);
			g = conv2_gather(p, 1);
			b = conv2_gather(p, 2);
			a = conv2_gather(p, 3);
			vec4 v0 = vec4(r.w, g.w, b.w, a.w) * 1.0000000e+00;
			vec4 v1 = vec4(r.z, g.z, b.z, a.z) * 1.0000000e+00;
			vec4 v2 = vec4(r.x, g.x, b.x, a.x) * 1.0000000e+00;
			vec4 v3 = vec4(r.y, g.y, b.y, a.y) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
			G[2][ay][ax] = int(packSnorm4x8(v2));
			G[3][ay][ax] = int(packSnorm4x8(v3));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0, r1, r2, r3;
	vec4 f0, f1, f2, f3;
	r0 = ivec4(0); r1 = ivec4(0); r2 = ivec4(0); r3 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x0205FBF2, 0xF6F1EE05, 0x041000FC, 0x03F01102);
	r1 = D(r1, s0_0_0, 0x0206FFFE, 0xFCF30504, 0x09F5FB04, 0xF700FB05);
	r2 = D(r2, s0_0_0, 0x0008F706, 0xF1F017F8, 0xEC1DFC0C, 0xF7F20403);
	r3 = D(r3, s0_0_0, 0x02EE0802, 0xFF10F50A, 0x010303FC, 0xF2F21200);
	r0 = D(r0, s0_0_1, 0x08FDF2EB, 0x080101FE, 0x0721FBFD, 0x0803FDFA);
	r1 = D(r1, s0_0_1, 0x150CEDFB, 0x101BF003, 0x04EEF009, 0x0CEC0105);
	r2 = D(r2, s0_0_1, 0x04080403, 0xE51514F8, 0xE227D905, 0x00FB09F6);
	r3 = D(r3, s0_0_1, 0x0B01FE07, 0xFE13E8EF, 0x1410FEFF, 0xFE22FD04);
	r0 = D(r0, s0_0_2, 0x17F1F204, 0x07ECFB0F, 0x0DF6F800, 0xF6F903FA);
	r1 = D(r1, s0_0_2, 0x05FBF101, 0x1EFFEB0D, 0xF90905F7, 0xFBF2FD10);
	r2 = D(r2, s0_0_2, 0x08F404FD, 0xFFF40E00, 0x08F8FA1C, 0xF3E21F00);
	r3 = D(r3, s0_0_2, 0x0C03F9FF, 0x061EEDFA, 0x27F8FE04, 0x0CF1FB08);
	r0 = D(r0, s0_1_0, 0xFCFD05FF, 0x1509F601, 0x02F9080D, 0xF417DF05);
	r1 = D(r1, s0_1_0, 0xECF90E0B, 0xE2F0F1F9, 0xF804FF07, 0x0DF61CF3);
	r2 = D(r2, s0_1_0, 0x0DF40108, 0x0F11DFEE, 0x1329030B, 0x1B15F2FC);
	r3 = D(r3, s0_1_0, 0xFE07FD04, 0x030210FA, 0xF7F8FC01, 0xE401F80A);
	r0 = D(r0, s0_1_1, 0xE6FE1A10, 0x07F70CD7, 0x1C031FFB, 0x1AD8FA34);
	r1 = D(r1, s0_1_1, 0xEAE61521, 0xAAEC240B, 0xD9F2F7F1, 0xC1DFF216);
	r2 = D(r2, s0_1_1, 0x23FB1909, 0x0811F8E6, 0x061CF606, 0x3909E5DB);
	r3 = D(r3, s0_1_1, 0x03EDF006, 0x001A102B, 0xF7131D21, 0x0CF013F2);
	r0 = D(r0, s0_1_2, 0x1E0AFB0A, 0xF3EE0A18, 0xFF05F918, 0xFB12F407);
	r1 = D(r1, s0_1_2, 0x06000A09, 0x08F90A28, 0xFBF818E4, 0x130FE516);
	r2 = D(r2, s0_1_2, 0xEFF406FC, 0x0B04F1E4, 0xF0F6251B, 0xEF05EDDD);
	r3 = D(r3, s0_1_2, 0x1EF1FD09, 0xFE05E607, 0x33FAF816, 0x1EEBFC1E);
	r0 = D(r0, s0_2_0, 0x00F4FEFC, 0xF6F40AFA, 0x0FFDFFFD, 0xF0090D0D);
	r1 = D(r1, s0_2_0, 0xF7FCF103, 0xECF7EEF8, 0xF6F806F8, 0x0AF8FF02);
	r2 = D(r2, s0_2_0, 0x09060AFF, 0xFF04180C, 0x03080EFC, 0x06042009);
	r3 = D(r3, s0_2_0, 0x02F80905, 0x07110B0B, 0x0601FBFC, 0xF90FEF00);
	r0 = D(r0, s0_2_1, 0x0707FAF0, 0x0BE5ED06, 0x1AFD1706, 0x07CB15F2);
	r1 = D(r1, s0_2_1, 0xFE11FBEE, 0x07F4E1EC, 0xE718E904, 0x0149D8E4);
	r2 = D(r2, s0_2_1, 0x10F60F0E, 0x0716F812, 0xEBFAF630, 0xFEDD0C21);
	r3 = D(r3, s0_2_1, 0x09E702FD, 0xEBEB0506, 0x02EB0CFF, 0xF6FB17FA);
	r0 = D(r0, s0_2_2, 0xFBF907FF, 0x09FCFAED, 0xFEF90203, 0x0A0BF6FB);
	r1 = D(r1, s0_2_2, 0x0201FEFB, 0xFAEF00F2, 0xF80201FE, 0xF701FEE3);
	r2 = D(r2, s0_2_2, 0x060301FF, 0x03F6FA18, 0xF2EE191E, 0x11FCFE03);
	r3 = D(r3, s0_2_2, 0x03F6FE0D, 0xF5EFFD13, 0xFFF20206, 0x14E1F604);
	r0 = D(r0, s1_0_0, 0x03100C02, 0xFE15E715, 0x00F922F4, 0x00F5F6FD);
	r1 = D(r1, s1_0_0, 0xFE010EFD, 0xFD09F5FC, 0xF60E0AFF, 0xFCFC09E8);
	r2 = D(r2, s1_0_0, 0x02FEFB07, 0x00E7D318, 0xD4ED0227, 0xFC00F71A);
	r3 = D(r3, s1_0_0, 0x02FAFD03, 0xF8F3DE0B, 0xFFFDF707, 0x03FE03F9);
	r0 = D(r0, s1_0_1, 0xFD251208, 0x25250011, 0x01F424FC, 0xF1FD0A1C);
	r1 = D(r1, s1_0_1, 0xFB0909F4, 0x03FC2609, 0xFB20E8EE, 0xFB0913E5);
	r2 = D(r2, s1_0_1, 0xFB00FCFE, 0x0302ED1A, 0x12F50125, 0x25170236);
	r3 = D(r3, s1_0_1, 0xF90F0106, 0xF10B0309, 0x0506110C, 0xF9F31C05);
	r0 = D(r0, s1_0_2, 0x0314F7FE, 0xFE080BF1, 0x040901FC, 0x1020EC07);
	r1 = D(r1, s1_0_2, 0x0111FCFB, 0x0007F7F0, 0xFAF101FA, 0xF5050401);
	r2 = D(r2, s1_0_2, 0x00060404, 0x0FF0F619, 0xC2F91AF8, 0x0F05FE12);
	r3 = D(r3, s1_0_2, 0x08EFF804, 0x08FDEC08, 0x10FEF6FF, 0x0DEFF907);
	r0 = D(r0, s1_1_0, 0x050BFCFD, 0xF5040F03, 0xF1F1F006, 0xF3FBFCFA);
	r1 = D(r1, s1_1_0, 0x00FFEE05, 0xF310DFFF, 0x0200EE14, 0x020710F5);
	r2 = D(r2, s1_1_0, 0x06011305, 0xD9FE21F9, 0x0EE11012, 0xF3EC29FE);
	r3 = D(r3, s1_1_0, 0xFAEF070B, 0x011617E5, 0xF6000207, 0xF3F1E803);
	r0 = D(r0, s1_1_1, 0x11F1F001, 0x1DD6FD02, 0x20AE06F4, 0x140D26F0);
	r1 = D(r1, s1_1_1, 0x085B0BF7, 0x2142C801, 0xE75FD8E9, 0x1013D50B);
	r2 = D(r2, s1_1_1, 0xECCB19FC, 0xFE2B2DFF, 0xAEAA1F06, 0xE2C23907);
	r3 = D(r3, s1_1_1, 0x0944FC0B, 0xEBD02405, 0xF7160717, 0x2B2A1E20);
	r0 = D(r0, s1_1_2, 0xF5150608, 0xF91CFB07, 0x001402FD, 0xF324DE00);
	r1 = D(r1, s1_1_2, 0xF80E0B0A, 0xEF10F615, 0x0ED00FF9, 0x12FAEAF0);
	r2 = D(r2, s1_1_2, 0xFF20FBFA, 0xFBFB0BEA, 0xBDF01502, 0x0018F3FE);
	r3 = D(r3, s1_1_2, 0xFBE806F6, 0xDB0315F9, 0xFAF7FEFA, 0xF8CD0BEF);
	r0 = D(r0, s1_2_0, 0xFA01FFF8, 0x0317FD0B, 0xFEFD01F4, 0x0A02F9FD);
	r1 = D(r1, s1_2_0, 0xFFEC0203, 0xFDFB05FC, 0xFDF80E01, 0xFB0404F7);
	r2 = D(r2, s1_2_0, 0x0117F4FE, 0x08060401, 0xFBF90703, 0x0D13F903);
	r3 = D(r3, s1_2_0, 0xFFFA0D09, 0x01F5FFF4, 0xFB0EFBFE, 0xFAE9FD03);
	r0 = D(r0, s1_2_1, 0x09F1FF00, 0xFB2AFF04, 0x0AE507FB, 0xFA3F0302);
	r1 = D(r1, s1_2_1, 0x0602EEF9, 0x00DF0603, 0xE4E7F7F6, 0x14F0E9E8);
	r2 = D(r2, s1_2_1, 0x0518F402, 0x0FFCEDFE, 0xE0C01520, 0xF63DFF0B);
	r3 = D(r3, s1_2_1, 0x020B0107, 0xF912FC0E, 0x06E70A07, 0x140B0508);
	r0 = D(r0, s1_2_2, 0xFAF30905, 0x0807FD01, 0x04F60503, 0x11FAF0FD);
	r1 = D(r1, s1_2_2, 0x01FD0004, 0x05FBFF01, 0xFDF907F7, 0xFEFF00FE);
	r2 = D(r2, s1_2_2, 0x020C02FD, 0xED2EFB02, 0xEBEF050F, 0x0423F7FC);
	r3 = D(r3, s1_2_2, 0xF6EF0506, 0x0719FEFE, 0xF6F40405, 0xFA09020D);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xFE02FAFD, 0x0201FEF6, 0x00FAFFFC, 0xFAFBFE17);
	r1 = D(r1, s0_0_0, 0xFCFE04F8, 0x010DF906, 0xEEFF06E8, 0xF905FC04);
	r2 = D(r2, s0_0_0, 0xFBFE01F5, 0x111DEF12, 0x0202FEE3, 0xFC0AF410);
	r3 = D(r3, s0_0_0, 0xFFFA08FE, 0x0512F8F7, 0x00040003, 0x0209FB0A);
	r0 = D(r0, s0_0_1, 0xFDED01F6, 0xEDF51001, 0xF7F30BFB, 0x0806FCEB);
	r1 = D(r1, s0_0_1, 0xFEF305FA, 0xF7E912FE, 0x0313F00A, 0xFCF70610);
	r2 = D(r2, s0_0_1, 0xFC09FCF6, 0x0E02EF09, 0xE8E527FB, 0x0BD90C21);
	r3 = D(r3, s0_0_1, 0xFDFAF9F9, 0xFC24E3D7, 0xF9DE10FC, 0xFFF604FC);
	r0 = D(r0, s0_0_2, 0xFDF20803, 0xF6F40EF5, 0xFBF608F9, 0xFB09F600);
	r1 = D(r1, s0_0_2, 0x00F103F8, 0xFAEE11F9, 0x050EF30E, 0xF2E51208);
	r2 = D(r2, s0_0_2, 0x0107FAFD, 0x040EFC10, 0xF6EA1E05, 0x000AFC0B);
	r3 = D(r3, s0_0_2, 0x0407FFFF, 0x00EB0811, 0x01FE09FD, 0x02FD06F5);
	r0 = D(r0, s0_1_0, 0xF8120702, 0xF8F211F2, 0x0103F0FE, 0xEE02FEE2);
	r1 = D(r1, s0_1_0, 0xF6150B06, 0x062CEE0E, 0xE51604DA, 0x00F6FD06);
	r2 = D(r2, s0_1_0, 0xFFF200F3, 0x2AE2F710, 0x1AE5F8FE, 0x01EA0FF2);
	r3 = D(r3, s0_1_0, 0xFEFE0506, 0x17E21312, 0x010FFE0A, 0x0E0DE30A);
	r0 = D(r0, s0_1_1, 0xE15616F0, 0x0B010A08, 0xF0F820F8, 0xD4CC3CC3);
	r1 = D(r1, s0_1_1, 0xEEFF13FD, 0xEFE6034D, 0x1929D63A, 0xE31AEFA4);
	r2 = D(r2, s0_1_1, 0xFB34FE02, 0x05A70109, 0xEB2829FA, 0x1719EEE5);
	r3 = D(r3, s0_1_1, 0xEDE40AEE, 0xDD0B22A4, 0xE1070CF9, 0xFAA71705);
	r0 = D(r0, s0_1_2, 0xF721FFF3, 0xFE06F502, 0xE80B05EB, 0xEF0A0311);
	r1 = D(r1, s0_1_2, 0xF5010402, 0xEF27030E, 0x16F6F818, 0xF531F0EC);
	r2 = D(r2, s0_1_2, 0x00FFF7F0, 0x1420F8FD, 0xFDE404FD, 0x1206E902);
	r3 = D(r3, s0_1_2, 0xFF130904, 0xF2081ECF, 0xFB2206EE, 0xF13109EE);
	r0 = D(r0, s0_2_0, 0x0AFFFE02, 0xF012F3F4, 0x0EDF0F03, 0xED09F7F2);
	r1 = D(r1, s0_2_0, 0x0902FA09, 0x1322EF0C, 0xFE0EF8FD, 0xF2F40AFA);
	r2 = D(r2, s0_2_0, 0x08F6FEF8, 0xEEF7F3F6, 0xF5FF1CFE, 0xE3F7F2F2);
	r3 = D(r3, s0_2_0, 0xFBF7FDFE, 0xF1F8FD06, 0x0501F8FC, 0x15030109);
	r0 = D(r0, s0_2_1, 0x0A010503, 0x03FEE4FC, 0xF9E5070A, 0xF2FCEC00);
	r1 = D(r1, s0_2_1, 0x09FC100C, 0x08FEFE14, 0x1313150D, 0xEA2033CF);
	r2 = D(r2, s0_2_1, 0x14DFF20E, 0xCA0807E5, 0x04E402FE, 0xF4F0DCFB);
	r3 = D(r3, s0_2_1, 0xF60106F6, 0xFC07E00A, 0x00EFF50D, 0xE7E30404);
	r0 = D(r0, s0_2_2, 0x07FCFFFB, 0x0CFEF905, 0x0BF900FC, 0x04ED0200);
	r1 = D(r1, s0_2_2, 0x07FDFC03, 0x19020600, 0xFC00FF06, 0x0B0910EF);
	r2 = D(r2, s0_2_2, 0xFBFAFE00, 0xDA0A0BFC, 0xFCE30006, 0xEDF5FE00);
	r3 = D(r3, s0_2_2, 0x0005FE03, 0xFAF4F6FE, 0xFF070AF7, 0xFE0709F1);
	r0 = D(r0, s1_0_0, 0xEFFDFCFA, 0xEE22E5FC, 0x12110BD7, 0x120EFF0B);
	r1 = D(r1, s1_0_0, 0xEF02F60E, 0x04FCF60E, 0xF2FCF909, 0xF4010AF6);
	r2 = D(r2, s1_0_0, 0xF80804EF, 0xE30F05E9, 0xC91733DD, 0xF70902E0);
	r3 = D(r3, s1_0_0, 0xF9FCFC05, 0xD91603FC, 0xFDFE04FD, 0x0D0B0402);
	r0 = D(r0, s1_0_1, 0x0AFBFF15, 0xEBF1FDF5, 0x18250EE3, 0xF508DF0A);
	r1 = D(r1, s1_0_1, 0x11F91423, 0x09E7EF33, 0xFA011206, 0x11F707FC);
	r2 = D(r2, s1_0_1, 0xED14F6E4, 0xEB15C702, 0x1AD530E8, 0x0410F4DF);
	r3 = D(r3, s1_0_1, 0xE4DD000D, 0xD919070F, 0xF8FCEF0F, 0x02F7F9FF);
	r0 = D(r0, s1_0_2, 0x04030301, 0x02F50104, 0x061415F5, 0x01FFFC07);
	r1 = D(r1, s1_0_2, 0x03020504, 0x09EE0120, 0x0705D1F9, 0x2F03F100);
	r2 = D(r2, s1_0_2, 0x080807F5, 0x14F80FF5, 0xE20800F7, 0xF6FCFDE8);
	r3 = D(r3, s1_0_2, 0xECF51806, 0xD8F70115, 0xFFFD0F0D, 0xF7FF1D00);
	r0 = D(r0, s1_1_0, 0xFC06FDF4, 0x1EF40B00, 0xFF3903D8, 0x1E0E150A);
	r1 = D(r1, s1_1_0, 0xFFF80B02, 0x02F108F5, 0xFFFD0A0D, 0x12E3F910);
	r2 = D(r2, s1_1_0, 0xF613EAF7, 0x21F5050B, 0x81E3FE08, 0x0EFB0200);
	r3 = D(r3, s1_1_0, 0x06F60E0B, 0x09D7FFF2, 0xFA02F9F8, 0xF11718F8);
	r0 = D(r0, s1_1_1, 0xDED4F80A, 0x186105EE, 0x0022E7E4, 0x0FD8E5FE);
	r1 = D(r1, s1_1_1, 0xCDC4FA09, 0xEDFFDFFC, 0xD0D00C01, 0xC6C1E536);
	r2 = D(r2, s1_1_1, 0xF30612F1, 0xFAE30821, 0x081C2BEE, 0x262F040A);
	r3 = D(r3, s1_1_1, 0xF0D6100B, 0xF7D11CF6, 0x01E92513, 0x08BBD8FA);
	r0 = D(r0, s1_1_2, 0x04110FFE, 0xF80108FE, 0xFB1C1DF3, 0x0AEBF005);
	r1 = D(r1, s1_1_2, 0xFD02FBF4, 0xF2E0F800, 0x1724EEF3, 0xF5F6E813);
	r2 = D(r2, s1_1_2, 0xF20AEAFE, 0x111BED17, 0x1308FFF4, 0x0F02ED08);
	r3 = D(r3, s1_1_2, 0xFDF70809, 0xF72BECFF, 0xFB08080E, 0xE4D90F0F);
	r0 = D(r0, s1_2_0, 0x0200FFFB, 0xD7EEFC0D, 0x0C0F01F8, 0xEFFFFA0B);
	r1 = D(r1, s1_2_0, 0x0AFD02FF, 0xFCF2F800, 0xF0F90C0C, 0x1C0FFD07);
	r2 = D(r2, s1_2_0, 0x040DFBF4, 0x04FCF307, 0xFF0B0905, 0xDEF6FD07);
	r3 = D(r3, s1_2_0, 0xF8FF0006, 0xD40201F6, 0xFC08FDFB, 0x0F0206FF);
	r0 = D(r0, s1_2_1, 0xFE12FB01, 0xEEF4FF0A, 0x03300CF5, 0xF6EBFEF8);
	r1 = D(r1, s1_2_1, 0x100DF700, 0x19F6EF02, 0x101A1706, 0x131B1007);
	r2 = D(r2, s1_2_1, 0xFD07F3FA, 0x0AF1FA03, 0xF70D1BFF, 0xDFF30204);
	r3 = D(r3, s1_2_1, 0xFFEF0700, 0xDCE103FE, 0xFAEF0001, 0xF808F603);
	r0 = D(r0, s1_2_2, 0xFEF60500, 0x0AF2FCF9, 0xF50F19F2, 0x0BF7F503);
	r1 = D(r1, s1_2_2, 0xFFFA0000, 0x11ED0109, 0x0106ECFC, 0x001B06FB);
	r2 = D(r2, s1_2_2, 0xFD05F3FB, 0xEB02EDFF, 0xF7E5050A, 0x05F6F202);
	r3 = D(r3, s1_2_2, 0xF4FA0B03, 0xECFDF40E, 0xF8F70AFE, 0xFAFB1101);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(1.039e-03, 2.128e-02, -3.155e-02, -8.864e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(6.438e-03, 1.688e-02, 7.329e-03, -1.895e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-1.216e-02, -2.740e-04, -2.466e-02, 5.757e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), f2);
	f3 = vec4(r3) * 6.2000124e-05;
	f3 += vec4(-1.236e-02, -8.513e-03, 8.053e-03, -2.244e-02);
	f3 = max(f3, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), f3);
}

//!DESC [CuNNy_4x16_vk] -conv4
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv3
//!BIND LUMA
//!SAVE conv4
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_spirv_intrinsics : require
spirv_instruction (extensions = ["SPV_KHR_integer_dot_product"], capabilities = [6019, 6018], id = 4450)
int dp4(int a, int b, spirv_literal int fmt);
#define D(r, s, a, b, c, d) r + ivec4(dp4(s, a, 0), dp4(s, b, 0), dp4(s, c, 0), dp4(s, d, 0))
shared int G[4][10][10];
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
			vec2 p;
			vec4 r, g, b, a;
			p = vec2(clamp(pos + ivec2(x - 1, y - 1), ivec2(0), sz) * ivec2(2, 2) + ivec2(1, 1)) * conv3_pt;
			r = conv3_gather(p, 0);
			g = conv3_gather(p, 1);
			b = conv3_gather(p, 2);
			a = conv3_gather(p, 3);
			vec4 v0 = vec4(r.w, g.w, b.w, a.w) * 1.0000000e+00;
			vec4 v1 = vec4(r.z, g.z, b.z, a.z) * 1.0000000e+00;
			vec4 v2 = vec4(r.x, g.x, b.x, a.x) * 1.0000000e+00;
			vec4 v3 = vec4(r.y, g.y, b.y, a.y) * 1.0000000e+00;
			G[0][ay][ax] = int(packSnorm4x8(v0));
			G[1][ay][ax] = int(packSnorm4x8(v1));
			G[2][ay][ax] = int(packSnorm4x8(v2));
			G[3][ay][ax] = int(packSnorm4x8(v3));
		}
	}
	barrier();
	int s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	ivec4 r0, r1, r2, r3;
	vec4 f0, f1, f2, f3;
	r0 = ivec4(0); r1 = ivec4(0); r2 = ivec4(0); r3 = ivec4(0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xF8FAF9FB, 0x03FFFAFF, 0x03020101, 0x0007FFFE);
	r1 = D(r1, s0_0_0, 0x06FE02FE, 0xFC050B04, 0x03FE0FFA, 0x0A04FA02);
	r2 = D(r2, s0_0_0, 0x040402FE, 0x020B0A06, 0xD1DDFE06, 0xF4F501E2);
	r3 = D(r3, s0_0_0, 0xFF03FBFA, 0x0300FEFD, 0x0003FCFC, 0xFFFFFEFF);
	r0 = D(r0, s0_0_1, 0xE70007F7, 0xFDFDFD07, 0x04FCFF01, 0xFAFBFDFF);
	r1 = D(r1, s0_0_1, 0x1716FFFA, 0x17F7E8FA, 0x1AAAF108, 0xF0FC05F5);
	r2 = D(r2, s0_0_1, 0x0807FBFD, 0x27F505E7, 0x1015EDEC, 0x10CE1919);
	r3 = D(r3, s0_0_1, 0xFBF60501, 0x14FCE902, 0xF9FE04FC, 0x08FAFB04);
	r0 = D(r0, s0_0_2, 0xFE04FF00, 0xFF0204FE, 0x01FD0100, 0xF4FD0209);
	r1 = D(r1, s0_0_2, 0x3B9AE808, 0xFD00F00A, 0x1AFCD708, 0x0408F8FD);
	r2 = D(r2, s0_0_2, 0xFFFF0102, 0xE9FD0107, 0xEFFD0302, 0x25F7F407);
	r3 = D(r3, s0_0_2, 0x00030100, 0x0001FB03, 0x06FE0104, 0x06FDFD02);
	r0 = D(r0, s0_1_0, 0x14EFFC02, 0x0204FEFF, 0x00FEFDFF, 0xE9060112);
	r1 = D(r1, s0_1_0, 0xFFFBFBF5, 0xFFFC0BEE, 0xF602FB00, 0x06010101);
	r2 = D(r2, s0_1_0, 0x01010000, 0xE5FE0114, 0xC681F904, 0x18E8F8D3);
	r3 = D(r3, s0_1_0, 0x03050101, 0x0A05FDF7, 0x04FF02FC, 0x04FDFCF6);
	r0 = D(r0, s0_1_1, 0x2FB0F400, 0x1406F7E9, 0x1103F40C, 0x12D8F608);
	r1 = D(r1, s0_1_1, 0x11F2EB03, 0xF6E4DF2E, 0x0C1BE903, 0x5DC7FA06);
	r2 = D(r2, s0_1_1, 0x00EFEF15, 0x2EA8EAFF, 0x14F5E5FF, 0xECC52744);
	r3 = D(r3, s0_1_1, 0x37E10A06, 0xEF9A0422, 0x39F80B1E, 0x0EF3F921);
	r0 = D(r0, s0_1_2, 0x13FBE40B, 0x01FFEC06, 0x18FEEBF5, 0xEFFEF9F7);
	r1 = D(r1, s0_1_2, 0xFF010818, 0xF4CDEBF5, 0xE9F4EFFF, 0x0CDDE7F6);
	r2 = D(r2, s0_1_2, 0x0603F7FD, 0xECFA11FF, 0xF10305FB, 0x1C06E214);
	r3 = D(r3, s0_1_2, 0x05FAEFF7, 0x0505F504, 0x02FFF7D7, 0x09F9F204);
	r0 = D(r0, s0_2_0, 0xF20600F3, 0x00FF010A, 0x08FFFBEB, 0xF700FE06);
	r1 = D(r1, s0_2_0, 0xFD0202FC, 0xFF06FB0A, 0xFF0100FC, 0x11FBF0DC);
	r2 = D(r2, s0_2_0, 0x00FDF2EF, 0xF3FCF409, 0xDBDFF10F, 0x280A0304);
	r3 = D(r3, s0_2_0, 0xFFFEFFF8, 0x00FAFF14, 0xFC01FFFA, 0x07FEFE08);
	r0 = D(r0, s0_2_1, 0xEBFED10C, 0xFD01E94B, 0x10E6EEEE, 0x000B0923);
	r1 = D(r1, s0_2_1, 0xFDFDFF00, 0x150803FF, 0x02FAFE00, 0xEFF3EC28);
	r2 = D(r2, s0_2_1, 0xFBFCF4F3, 0x0DFB06EE, 0x07FEF700, 0xF6FD02FF);
	r3 = D(r3, s0_2_1, 0xFFF9F714, 0x1310FE00, 0x04FEF910, 0x0FFEF627);
	r0 = D(r0, s0_2_2, 0xFD0300FC, 0x0906F104, 0xFA01F518, 0xFEFF0308);
	r1 = D(r1, s0_2_2, 0xFDFF05F9, 0x070AF10F, 0x00FE0C01, 0x1305070B);
	r2 = D(r2, s0_2_2, 0x0502F303, 0xFD000DFB, 0xF5020CF6, 0x0605FC03);
	r3 = D(r3, s0_2_2, 0x03FF00FD, 0x0004FA03, 0x01FFFEFA, 0x0006FC05);
	r0 = D(r0, s1_0_0, 0x0CFCFD09, 0x01010103, 0x01020000, 0xF8FEFF02);
	r1 = D(r1, s1_0_0, 0xFA010400, 0xF904FEFD, 0xFE00F7FE, 0x0107FDFF);
	r2 = D(r2, s1_0_0, 0xFFFDFD00, 0x0BFA00FA, 0x1FFCE506, 0x0AF6F6FF);
	r3 = D(r3, s1_0_0, 0xFFF8FC06, 0xF2FFFE00, 0x02FC0000, 0x03FE05FC);
	r0 = D(r0, s1_0_1, 0x0CF7FB17, 0x0EFF06FD, 0xFAFDFD01, 0xF001FD00);
	r1 = D(r1, s1_0_1, 0x0201DFF8, 0xCC1707EC, 0xDBF8B823, 0x0BE8FA0F);
	r2 = D(r2, s1_0_1, 0x00FA01FB, 0xF8F5ED15, 0x080C07FF, 0xE4E5EEFE);
	r3 = D(r3, s1_0_1, 0x07FC0509, 0xF6080BE9, 0x00F9000D, 0xF50007F3);
	r0 = D(r0, s1_0_2, 0x070002FD, 0x02FFFF04, 0xFFF9FB0E, 0xFBFD0303);
	r1 = D(r1, s1_0_2, 0x23D5F1FD, 0xEBF4FC0C, 0x04F10603, 0x06F1FF0B);
	r2 = D(r2, s1_0_2, 0xFDFF0101, 0xFE0D00FC, 0x04FF0103, 0x01E8FFFA);
	r3 = D(r3, s1_0_2, 0xFFFD0206, 0x050200FE, 0x01000307, 0xFAFBFE06);
	r0 = D(r0, s1_1_0, 0xE3FFE903, 0xFBFFFA00, 0x05FD0702, 0x0401FBF8);
	r1 = D(r1, s1_1_0, 0x0500FC03, 0x0702F103, 0x0AF70007, 0xF7EB0801);
	r2 = D(r2, s1_1_0, 0xFE02FEFB, 0x0BE909E2, 0x27DFA202, 0xE408ECFE);
	r3 = D(r3, s1_1_0, 0x06FFF8F8, 0x210AE60A, 0x00FFFFFD, 0xFBFF0108);
	r0 = D(r0, s1_1_1, 0x0801D012, 0xEA0CF915, 0x1802F8FC, 0x0FECF249);
	r1 = D(r1, s1_1_1, 0x15050B15, 0x10E0A84D, 0xF9FF0001, 0x1A0DC0E3);
	r2 = D(r2, s1_1_1, 0x14FAFE01, 0xE784D21E, 0xE9E70609, 0xD00CB515);
	r3 = D(r3, s1_1_1, 0xEFD1EE1A, 0x1CF5C348, 0xFDEDEB04, 0x2F0FF2ED);
	r0 = D(r0, s1_1_2, 0xFF02FF00, 0x03FD01FC, 0xFCFE05F2, 0x020AFB03);
	r1 = D(r1, s1_1_2, 0xEE12F7FB, 0x160AF015, 0x0110F70E, 0x0518F414);
	r2 = D(r2, s1_1_2, 0xFD0001FD, 0xFD19FE08, 0x0609F711, 0x02F00FDB);
	r3 = D(r3, s1_1_2, 0x090B00FE, 0x0CF400FC, 0x0A0AF623, 0xFF04FF03);
	r0 = D(r0, s1_2_0, 0xF40BF6FE, 0x0E07F9F7, 0x0F01F503, 0xF6FEFCFA);
	r1 = D(r1, s1_2_0, 0x02FFFEFE, 0xFFFC07FF, 0x01FF02FF, 0x0F0AF506);
	r2 = D(r2, s1_2_0, 0xFF00080B, 0x03FE0AF0, 0x0708FCF0, 0x0802FDF7);
	r3 = D(r3, s1_2_0, 0xFC010102, 0xFCFEFEF4, 0x01FD0102, 0x050200FA);
	r0 = D(r0, s1_2_1, 0x06FAFB14, 0x00F2E01A, 0x2BFB031E, 0xF6F0EE0F);
	r1 = D(r1, s1_2_1, 0x04F70300, 0xEC0401F4, 0xFDFE05FD, 0xF10CFF1B);
	r2 = D(r2, s1_2_1, 0xFA04F319, 0x06E5F016, 0x08FF0305, 0x02F7F404);
	r3 = D(r3, s1_2_1, 0x03FF0204, 0x01F403F8, 0x01020401, 0xF9FD03EF);
	r0 = D(r0, s1_2_2, 0x07FFFE08, 0x06F7FF07, 0x0009F901, 0xFC00FC05);
	r1 = D(r1, s1_2_2, 0x0402FE01, 0xFEF60007, 0xFFF6F905, 0x02F002F0);
	r2 = D(r2, s1_2_2, 0xFEF80205, 0x050BFDFD, 0x0B0DF809, 0xFC040906);
	r3 = D(r3, s1_2_2, 0x02FD0004, 0xFA070100, 0x02FEFD0C, 0x06FCFFFF);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x0802F20D, 0x0002FE04, 0xFD0500FD, 0x0101FDFE);
	r1 = D(r1, s0_0_0, 0xFD02FE04, 0xFDFC09F7, 0x03FEF000, 0x020BFE00);
	r2 = D(r2, s0_0_0, 0x0002FD00, 0xF2F706F6, 0xF509E91E, 0xFEFBF616);
	r3 = D(r3, s0_0_0, 0x0501FF01, 0xFCFF0202, 0x03FFFD00, 0x02FCFE00);
	r0 = D(r0, s0_0_1, 0x1002F8FB, 0x0406FDFE, 0x000504FB, 0xFC0005F6);
	r1 = D(r1, s0_0_1, 0xFEE5F10C, 0xE60C1712, 0xF6F3D7C2, 0x04020202);
	r2 = D(r2, s0_0_1, 0xFD0300FD, 0x0A0CF403, 0x0B0A0200, 0xE4CD04BB);
	r3 = D(r3, s0_0_1, 0x04FAF410, 0xF915130B, 0x02FDF60E, 0xFE08FC02);
	r0 = D(r0, s0_0_2, 0xFF020705, 0x00FFFEFD, 0x0301FFFE, 0x00FD0103);
	r1 = D(r1, s0_0_2, 0xD81A01ED, 0x0E07FAF9, 0xF7110F1D, 0x0DFDFDF9);
	r2 = D(r2, s0_0_2, 0xFF0100FC, 0xF80503F0, 0xFAFB05F9, 0x0FFFEF0D);
	r3 = D(r3, s0_0_2, 0x01FEFF08, 0x00FD0001, 0x05FF01FE, 0xFF02FF04);
	r0 = D(r0, s0_1_0, 0x0902FADD, 0xFBFC03FF, 0x02FCFE0F, 0x04FDF8FA);
	r1 = D(r1, s0_1_0, 0x04FEFE06, 0xF2FDF50A, 0x0000FA04, 0xFFF9EE13);
	r2 = D(r2, s0_1_0, 0x05F9F8FD, 0xFDD1FE17, 0xF9D0B4DA, 0xF41C00FE);
	r3 = D(r3, s0_1_0, 0xF9FB0006, 0x0006FEFD, 0xFCFA0104, 0xFE0804FF);
	r0 = D(r0, s0_1_1, 0xBF010A1B, 0xF7031B16, 0x0FF0F920, 0x2601E9F7);
	r1 = D(r1, s0_1_1, 0x0B19FCF2, 0x38F4AD9B, 0x10000EF3, 0xD0F31C04);
	r2 = D(r2, s0_1_1, 0x0AFDFB26, 0xF227F0D6, 0x0F13E00A, 0x00CDE7D7);
	r3 = D(r3, s0_1_1, 0xF9FD0BF7, 0x1ADAB6D2, 0xF6000200, 0x0BF4F1EF);
	r0 = D(r0, s0_1_2, 0x0900F115, 0xFB01FC06, 0xEF031104, 0x05FFF8F8);
	r1 = D(r1, s0_1_2, 0x18D2FEF0, 0xEBF0F10C, 0x08E4EBF5, 0xFD01E6F4);
	r2 = D(r2, s0_1_2, 0x04FDFA0E, 0xFEEBFDFA, 0x0301FAF2, 0xDF14FD06);
	r3 = D(r3, s0_1_2, 0xFA02F211, 0x0102030A, 0x0305F4FB, 0xFEFDF71A);
	r0 = D(r0, s0_2_0, 0xFAFBFFFF, 0xFDFDFDFB, 0x04FC01FC, 0x05FCF9FD);
	r1 = D(r1, s0_2_0, 0x00FCFEFC, 0xFEFE0102, 0xFD020002, 0x0E02FFF5);
	r2 = D(r2, s0_2_0, 0x0301FBFE, 0x0EF403FC, 0x08E9F608, 0xE0100005);
	r3 = D(r3, s0_2_0, 0x01FD0203, 0x02F8FCF7, 0x02FFFF01, 0xFE0101FE);
	r0 = D(r0, s0_2_1, 0x1BF6F6EE, 0x21FBEBD7, 0x11F3F4E7, 0x050102F7);
	r1 = D(r1, s0_2_1, 0x00FAFB03, 0x00FF06FE, 0x01FDFF05, 0x17E7E6ED);
	r2 = D(r2, s0_2_1, 0x0900F4EA, 0xF02FF403, 0x0419FE02, 0x27D504F2);
	r3 = D(r3, s0_2_1, 0x0603FEF8, 0xF80E0901, 0x05FD00F9, 0x06FC00FA);
	r0 = D(r0, s0_2_2, 0x05FCF800, 0xFBF9FCFB, 0x10EFF0F3, 0xFFFAFCF9);
	r1 = D(r1, s0_2_2, 0xFB110005, 0xFD0302FB, 0xFA0A00FC, 0xFDF40CFE);
	r2 = D(r2, s0_2_2, 0xF9FFFD0C, 0xFFD80603, 0xFBF00000, 0xFA06FD01);
	r3 = D(r3, s0_2_2, 0x00F5FF01, 0xFB0000FE, 0x01F9FD01, 0xFE00FF01);
	r0 = D(r0, s1_0_0, 0xFFFFF809, 0x02FEFB04, 0x0301FC00, 0xF60007FB);
	r1 = D(r1, s1_0_0, 0x080708F9, 0xE20C12F2, 0xDD040E01, 0x12FFFAFD);
	r2 = D(r2, s1_0_0, 0xFE0601FF, 0xFCFA1402, 0xE9270DF1, 0x1623E6FE);
	r3 = D(r3, s1_0_0, 0xFFFB0103, 0xF80D0CF5, 0xFBFE0003, 0xFB0600FF);
	r0 = D(r0, s1_0_1, 0x10FBED00, 0x05F6FA04, 0xFDFEFD09, 0x09040DFD);
	r1 = D(r1, s1_0_1, 0x161C10E6, 0x040D15ED, 0xF82E36D1, 0xE80CEE15);
	r2 = D(r2, s1_0_1, 0x04FF060B, 0x0B0BEE16, 0x03FDFA03, 0xE7211305);
	r3 = D(r3, s1_0_1, 0xFFF4FB04, 0x030009F2, 0x04F3FC01, 0xFBF907FC);
	r0 = D(r0, s1_0_2, 0x05FF04FF, 0x01FFFCFF, 0x03FEFC00, 0x05FBFCFB);
	r1 = D(r1, s1_0_2, 0xDD1E17ED, 0x13F5F3FE, 0x09FC01F6, 0x0BF4F90A);
	r2 = D(r2, s1_0_2, 0x03FC0606, 0xF10208F9, 0xFD0101FD, 0x0DF1E119);
	r3 = D(r3, s1_0_2, 0xFCF9F60B, 0x0D0103F4, 0xF4F5F80E, 0x01FDFC06);
	r0 = D(r0, s1_1_0, 0x28150ADC, 0xFBFE05FA, 0x02FA00FC, 0xF1F60610);
	r1 = D(r1, s1_1_0, 0xF4FBFB08, 0x03F70B02, 0x1400FDFA, 0xE20C0101);
	r2 = D(r2, s1_1_0, 0x000A08FE, 0xEDD22977, 0xE91E0C36, 0x2417D1D6);
	r3 = D(r3, s1_1_0, 0xF8000708, 0x2DF9F5F2, 0x04FC0401, 0x0101F7F5);
	r0 = D(r0, s1_1_1, 0xD24530BF, 0x00120CED, 0x17F60AED, 0x48D9FD08);
	r1 = D(r1, s1_1_1, 0xFD00D3F9, 0x35F8FAD9, 0x1DE80F0C, 0x4B181998);
	r2 = D(r2, s1_1_1, 0xE8EB0FFB, 0xED04CF3C, 0xE1DCD37F, 0xCD403A00);
	r3 = D(r3, s1_1_1, 0x4C11001D, 0xF11DFFF1, 0x0DFA0013, 0x131B0129);
	r0 = D(r0, s1_1_2, 0x19F3F8F8, 0x090402F5, 0xF0160CF4, 0x011106E8);
	r1 = D(r1, s1_1_2, 0x0B02E1F7, 0xEC2C07E2, 0xED0FFD0B, 0xEA3310E1);
	r2 = D(r2, s1_1_2, 0x05FA0101, 0xFB1709FD, 0x0A1104EB, 0xEBD2F332);
	r3 = D(r3, s1_1_2, 0x071005EB, 0x0DFAFFEA, 0xE517013A, 0x0B0202F9);
	r0 = D(r0, s1_2_0, 0xED021601, 0xFAF50A0D, 0xEB07F900, 0x05F4000B);
	r1 = D(r1, s1_2_0, 0x030602FB, 0x06F8FF03, 0xFB01FD02, 0x0E09EFE3);
	r2 = D(r2, s1_2_0, 0xF9FE02F4, 0xFEF5FF07, 0x0D03051D, 0x1E0FF1F2);
	r3 = D(r3, s1_2_0, 0x01FB04FD, 0xF1FE0406, 0x00FD0301, 0x00FFFE02);
	r0 = D(r0, s1_2_1, 0x09F1F524, 0x0BEE08EE, 0xE722D8FC, 0x0AF81CE5);
	r1 = D(r1, s1_2_1, 0xF6FDFA0A, 0xF01218EC, 0xFCFBFEFD, 0xCF0AC726);
	r2 = D(r2, s1_2_1, 0xEF3518F5, 0xFC10EF10, 0x1BE7F716, 0x03F3FDFE);
	r3 = D(r3, s1_2_1, 0xFD01F914, 0x0EFB1AE7, 0xFAFC0211, 0xFC02020A);
	r0 = D(r0, s1_2_2, 0x030207FC, 0x01F902F4, 0x12F0F8F9, 0xFCF80508);
	r1 = D(r1, s1_2_2, 0xFD0106F8, 0x0BF00D04, 0x0C0108F9, 0x0CEFF400);
	r2 = D(r2, s1_2_2, 0x05F90306, 0xF700090A, 0x070D0DEA, 0xFB02F904);
	r3 = D(r3, s1_2_2, 0xFCF60508, 0xFCFA0B0A, 0xFAF90010, 0x00F00608);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.569e-02, -6.989e-03, -1.518e-02, 2.297e-04);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-2.118e-02, -1.691e-02, -7.517e-03, -2.821e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-7.464e-03, -1.691e-02, -7.290e-03, -2.435e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), f2);
	f3 = vec4(r3) * 6.2000124e-05;
	f3 += vec4(8.456e-04, -1.364e-02, 9.600e-04, 2.741e-03);
	f3 = max(f3, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), f3);
}

//!DESC [CuNNy_4x16_vk] -out-shuffle
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
shared V4 G[4][10][10];
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
			vec2 p;
			p = vec2(clamp(pos + ivec2(x - 1, y - 1), ivec2(0), sz) * ivec2(2, 2) + ivec2(1, 1)) * conv4_pt;
			V4 sr0 = V4(conv4_gather(p, 0));
			V4 sg0 = V4(conv4_gather(p, 1));
			V4 sb0 = V4(conv4_gather(p, 2));
			V4 sa0 = V4(conv4_gather(p, 3));
			G[0][ay][ax] = V4(sr0.w, sg0.w, sb0.w, sa0.w);
			G[1][ay][ax] = V4(sr0.z, sg0.z, sb0.z, sa0.z);
			G[2][ay][ax] = V4(sr0.x, sg0.x, sb0.x, sa0.x);
			G[3][ay][ax] = V4(sr0.y, sg0.y, sb0.y, sa0.y);
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
	r0 += M4(6.708e-03, 3.521e-03, 1.546e-02, 2.814e-03, 4.114e-02, 9.071e-03, -1.121e-02, 4.345e-03, -1.114e-01, 2.043e-02, 5.440e-02, 1.704e-02, -1.305e-02, 3.542e-03, -4.491e-03, 8.717e-04) * s0_0_0;
	r0 += M4(-1.424e-02, -7.037e-02, 3.224e-02, 1.221e-02, 1.792e-01, 1.839e-01, 2.272e-02, 8.741e-03, 6.521e-03, -4.052e-01, 3.307e-02, 1.008e-01, 1.003e-01, 4.942e-02, 4.767e-04, 3.531e-03) * s0_0_1;
	r0 += M4(5.192e-03, 4.698e-02, -2.624e-03, -1.494e-03, 1.848e-02, 3.992e-02, 1.332e-03, 9.980e-03, -8.389e-03, 2.534e-02, 1.048e-02, 2.809e-02, -1.199e-03, 3.431e-02, 3.467e-04, -3.368e-03) * s0_0_2;
	r0 += M4(1.765e-02, 5.258e-03, 3.970e-02, -7.055e-03, 1.352e-02, -2.102e-03, -7.479e-02, 4.485e-03, 8.174e-03, 1.549e-03, -9.473e-04, -2.636e-03, -5.943e-02, 2.140e-03, -5.960e-02, -8.420e-04) * s0_1_0;
	r0 += M4(2.152e-01, 1.291e-01, -3.779e-01, 1.284e-01, 6.102e-03, 2.060e-02, -2.131e-01, -2.826e-01, -2.224e-02, 1.861e-02, 1.372e-01, 1.188e-01, -1.560e-02, -1.626e-01, 1.594e-01, -1.132e-02) * s0_1_1;
	r0 += M4(1.480e-02, 1.386e-03, -2.027e-03, -4.278e-02, 5.194e-03, 7.773e-03, -1.260e-02, -4.016e-02, -1.477e-03, -5.434e-03, 1.679e-03, 7.519e-03, -1.151e-03, 2.541e-02, 3.677e-05, 6.319e-02) * s0_1_2;
	r0 += M4(-1.150e-04, 1.610e-04, -2.489e-04, 2.414e-04, 1.091e-04, -5.375e-07, 3.946e-03, -2.562e-03, 2.240e-04, 5.743e-04, 9.071e-03, -7.232e-03, -1.669e-04, -1.370e-03, -1.240e-02, -1.314e-03) * s0_2_0;
	r0 += M4(-9.018e-03, -2.743e-03, -4.328e-03, -4.236e-02, -1.332e-03, -1.072e-03, 1.342e-02, 3.026e-02, -2.464e-04, 1.006e-03, -9.919e-03, -7.062e-03, 2.023e-03, 4.591e-03, -3.821e-02, -5.207e-02) * s0_2_1;
	r0 += M4(-5.804e-03, -2.333e-03, 7.835e-04, -2.817e-03, 4.062e-04, -4.353e-04, 5.940e-03, 4.546e-03, -1.331e-04, -5.877e-04, -4.540e-06, -2.988e-04, -1.580e-03, -1.477e-03, -4.675e-03, -4.934e-04) * s0_2_2;
	r0 += M4(2.517e-03, 8.224e-04, 2.421e-07, -3.350e-04, 3.118e-02, 8.333e-03, -4.468e-03, -8.483e-03, 1.217e-04, -4.470e-03, 9.264e-04, -1.745e-04, 4.185e-02, -6.370e-04, -2.549e-02, -3.598e-03) * s1_0_0;
	r0 += M4(-1.681e-05, 6.260e-03, -8.393e-07, 8.968e-04, -4.114e-02, 3.455e-02, -8.016e-04, -1.189e-02, -6.906e-03, -4.731e-03, -2.441e-04, -2.636e-04, -9.146e-02, 8.751e-02, -1.128e-02, -4.406e-03) * s1_0_1;
	r0 += M4(2.108e-06, 3.408e-03, -6.614e-04, -1.229e-04, -1.753e-03, -8.561e-03, -2.035e-04, 7.142e-04, 7.540e-07, -3.630e-03, 6.231e-05, 1.962e-05, -2.695e-03, -9.815e-04, 4.000e-03, -5.885e-03) * s1_0_2;
	r0 += M4(8.157e-02, 2.286e-02, 7.747e-03, -1.517e-02, -9.204e-02, -1.150e-03, 1.986e-02, 7.279e-03, -4.746e-02, -6.361e-03, 7.903e-03, 2.282e-02, -2.183e-02, 6.579e-03, 1.388e-02, -1.088e-02) * s1_1_0;
	r0 += M4(2.905e-02, -2.736e-03, 1.261e-02, -7.740e-03, 4.919e-02, -4.170e-01, 4.472e-02, 2.055e-01, 4.088e-02, 3.479e-02, -1.630e-02, 2.467e-02, 7.777e-02, 1.812e-01, 1.038e-01, -3.714e-01) * s1_1_1;
	r0 += M4(5.167e-04, -1.167e-03, 1.891e-03, 1.774e-04, -9.402e-03, 1.800e-02, -1.306e-03, -4.678e-03, -1.360e-03, -2.223e-02, 4.981e-04, 1.123e-03, 1.845e-03, -4.851e-03, -8.270e-03, 2.130e-02) * s1_1_2;
	r0 += M4(1.831e-01, -4.133e-02, -3.721e-01, 9.536e-02, -1.320e-04, 2.660e-03, 5.628e-02, 5.609e-03, 4.809e-02, -3.674e-03, 1.888e-03, -5.552e-03, -2.907e-03, -9.094e-03, 1.801e-02, 8.646e-03) * s1_2_0;
	r0 += M4(-1.861e-02, 3.066e-02, -1.914e-02, 1.998e-02, -1.711e-03, 1.983e-02, 2.498e-02, 7.957e-02, 5.381e-02, 2.163e-01, 6.328e-02, -4.161e-01, 9.306e-04, -3.258e-03, -9.079e-03, 3.528e-02) * s1_2_1;
	r0 += M4(9.447e-04, 2.174e-03, -4.049e-04, -2.084e-03, 1.728e-03, 7.085e-03, 9.218e-03, 8.838e-03, -5.413e-03, 2.899e-02, -9.774e-03, -1.436e-02, -1.060e-04, -4.676e-04, -7.052e-05, -2.433e-03) * s1_2_2;
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 += M4(2.718e-02, -1.654e-02, 1.201e-03, -8.071e-03, -1.004e-02, 8.532e-03, -1.056e-02, 3.587e-03, -2.535e-03, 8.469e-07, -1.238e-04, 1.426e-07, -1.966e-03, 2.002e-04, -9.344e-04, -1.985e-05) * s0_0_0;
	r0 += M4(-2.070e-01, 8.847e-02, -1.101e-01, -9.741e-02, 4.773e-02, -5.408e-02, -2.670e-03, 1.603e-02, 2.050e-02, -1.593e-02, 9.181e-03, -3.239e-03, 7.764e-03, -6.601e-03, -1.153e-03, -2.994e-03) * s0_0_1;
	r0 += M4(-2.519e-02, -1.284e-01, 7.819e-03, -1.362e-02, -3.361e-03, 7.965e-04, -1.714e-04, 3.885e-03, -4.261e-02, 8.210e-03, 1.077e-02, -1.208e-03, 1.586e-02, -9.480e-03, 5.235e-03, 4.836e-04) * s0_0_2;
	r0 += M4(-1.474e-04, -1.019e-03, 3.644e-02, -2.623e-03, 2.692e-02, 1.658e-02, 2.779e-02, 2.362e-02, 3.698e-04, -1.007e-06, -1.546e-03, -5.967e-07, 2.062e-03, -1.132e-02, -2.119e-02, -3.225e-03) * s0_1_0;
	r0 += M4(1.490e-02, 1.276e-02, 1.501e-01, 2.063e-01, 3.014e-01, -2.803e-01, 2.310e-01, -2.169e-01, -3.200e-02, -6.871e-03, 1.965e-03, -1.493e-02, -2.510e-01, 2.416e-01, -6.681e-02, 8.217e-02) * s0_1_1;
	r0 += M4(2.360e-03, 1.891e-03, 2.403e-04, -3.685e-03, -6.268e-03, -3.552e-02, -8.391e-03, -2.552e-02, -2.017e-01, 2.677e-01, -1.832e-01, 1.704e-01, 1.083e-02, 4.669e-03, 1.874e-02, -1.822e-02) * s0_1_2;
	r0 += M4(7.161e-06, 2.550e-05, -1.075e-06, 5.356e-07, -3.385e-03, 3.681e-03, -4.338e-03, 6.782e-03, -5.304e-05, 2.150e-07, -1.299e-06, 5.170e-07, 1.576e-02, -9.069e-03, 3.210e-02, -1.324e-02) * s0_2_0;
	r0 += M4(-1.245e-04, -3.938e-04, 1.579e-03, 2.235e-03, -2.738e-03, 1.419e-02, 1.081e-01, -1.218e-01, 2.318e-03, -7.956e-04, -1.467e-02, -9.663e-05, -1.124e-03, -1.947e-02, -1.706e-01, 1.459e-01) * s0_2_1;
	r0 += M4(1.416e-04, -1.624e-05, -1.355e-03, 1.673e-03, -4.425e-03, 6.279e-03, -5.037e-03, -7.895e-03, 1.338e-02, -9.064e-03, -4.763e-02, 7.163e-02, 1.274e-03, 1.177e-02, 1.366e-03, 2.078e-02) * s0_2_2;
	r0 += M4(2.183e-02, -1.948e-03, 9.342e-03, 8.191e-04, -1.595e-03, -1.974e-03, -7.125e-03, 2.213e-05, -6.094e-02, -3.941e-05, -2.683e-03, -6.575e-04, 3.552e-02, 1.451e-03, 6.680e-03, -2.239e-06) * s1_0_0;
	r0 += M4(-5.868e-02, -1.218e-01, -1.015e-02, 1.077e-02, 6.554e-03, -2.572e-02, -2.235e-03, 1.809e-03, -1.092e-02, 2.811e-02, 1.093e-03, -4.237e-03, 6.852e-02, 1.067e-01, 1.042e-03, -6.700e-03) * s1_0_1;
	r0 += M4(-4.438e-03, -9.736e-03, -1.838e-03, -3.976e-03, 9.034e-03, -3.962e-03, -2.415e-03, -7.569e-04, -3.448e-06, -7.480e-04, -1.489e-04, -6.929e-05, 5.538e-03, 1.993e-03, 1.230e-03, 4.807e-03) * s1_0_2;
	r0 += M4(8.879e-02, 1.070e-02, 8.151e-02, 2.255e-03, -1.797e-04, -9.826e-03, -8.936e-03, -1.195e-03, -1.732e-01, -2.243e-02, -2.085e-01, -2.077e-02, 1.233e-01, 1.535e-02, 1.265e-01, 5.822e-03) * s1_1_0;
	r0 += M4(1.684e-01, -1.198e-01, 3.732e-02, -3.256e-01, -4.075e-01, 3.528e-02, 2.817e-01, 7.266e-02, 2.764e-02, 1.978e-01, 5.753e-03, 1.674e-01, -2.368e-01, -7.259e-02, -7.776e-02, 1.772e-01) * s1_1_1;
	r0 += M4(1.415e-03, 6.263e-02, 2.330e-03, 3.938e-02, -6.769e-03, -1.538e-02, 4.397e-03, 4.690e-02, 2.379e-05, -1.137e-03, 1.782e-04, -1.402e-04, -1.040e-03, -7.349e-02, -6.588e-04, -6.567e-02) * s1_1_2;
	r0 += M4(1.363e-03, 2.056e-03, 2.996e-02, 8.209e-03, 3.176e-03, -1.268e-03, -1.679e-02, -7.088e-04, -1.239e-03, -1.411e-03, -2.754e-02, -2.906e-03, 1.149e-03, 1.544e-03, 1.418e-02, 5.380e-03) * s1_2_0;
	r0 += M4(-1.332e-04, -4.287e-03, 6.980e-02, 2.620e-02, 1.234e-02, -1.178e-02, 2.521e-02, 3.167e-02, 2.900e-04, 8.113e-04, 7.524e-03, 5.994e-02, 3.993e-03, 6.719e-03, -8.081e-02, -9.827e-02) * s1_2_1;
	r0 += M4(5.384e-04, -3.161e-04, 8.976e-04, 2.338e-02, 7.258e-03, -2.991e-03, -6.968e-03, 1.146e-03, 3.136e-07, 1.178e-03, 3.168e-05, 2.083e-04, -9.024e-04, -9.689e-04, -1.721e-03, -2.143e-02) * s1_2_2;
	r0 += V4(-1.478e-08, -1.485e-08, -1.492e-08, -1.479e-08);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
