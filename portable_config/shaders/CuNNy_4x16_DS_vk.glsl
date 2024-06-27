// CuNNy 4x16 DS
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


//!DESC [CuNNy_4x16_DS_vk] -in
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
	r0 += V4(2.939e-01, 1.363e-02, 3.350e-01, 3.592e-03) * s0_0_0;
	r1 += V4(1.046e-02, 3.834e-02, -6.598e-04, 9.548e-02) * s0_0_0;
	r2 += V4(4.235e-02, -1.038e-03, -4.482e-02, -8.792e-03) * s0_0_0;
	r3 += V4(-6.800e-02, -4.229e-01, 2.085e-02, -2.187e-02) * s0_0_0;
	r0 += V4(-3.585e-01, 7.735e-02, 6.028e-02, 1.880e-01) * s0_0_1;
	r1 += V4(5.554e-03, 1.533e-02, -7.391e-02, 1.833e-01) * s0_0_1;
	r2 += V4(-1.972e-01, -7.453e-04, -2.490e-02, 1.776e-02) * s0_0_1;
	r3 += V4(4.111e-01, 5.979e-01, 6.974e-01, -2.200e-02) * s0_0_1;
	r0 += V4(3.938e-02, 3.107e-02, -3.214e-02, 4.688e-02) * s0_0_2;
	r1 += V4(-1.934e-02, -1.435e-01, -6.070e-02, -2.733e-01) * s0_0_2;
	r2 += V4(-7.824e-02, -3.916e-03, 1.339e-01, 1.818e-02) * s0_0_2;
	r3 += V4(-5.776e-02, -2.264e-02, 2.337e-02, 4.557e-02) * s0_0_2;
	r0 += V4(5.254e-01, 3.503e-02, 2.666e-01, 1.968e-01) * s0_1_0;
	r1 += V4(-3.626e-02, -1.017e-01, 7.463e-03, -4.675e-02) * s0_1_0;
	r2 += V4(8.268e-02, -5.520e-01, 9.155e-02, 5.755e-03) * s0_1_0;
	r3 += V4(-7.482e-03, -2.295e-01, -1.973e-02, 1.336e-02) * s0_1_0;
	r0 += V4(-3.853e-01, -4.216e-01, -5.453e-01, -9.784e-01) * s0_1_1;
	r1 += V4(-6.880e-01, -5.682e-01, -4.111e-01, -5.044e-01) * s0_1_1;
	r2 += V4(-4.166e-02, 5.772e-01, 5.299e-01, 2.342e-03) * s0_1_1;
	r3 += V4(-1.290e-01, 5.090e-02, -6.919e-01, -5.996e-01) * s0_1_1;
	r0 += V4(-1.118e-01, 3.954e-02, -7.856e-02, 3.253e-02) * s0_1_2;
	r1 += V4(1.473e-04, 8.771e-02, -1.104e-01, 9.985e-02) * s0_1_2;
	r2 += V4(4.575e-01, -1.223e-02, -6.862e-02, 5.813e-01) * s0_1_2;
	r3 += V4(-4.296e-03, 2.188e-02, -2.198e-02, -3.427e-02) * s0_1_2;
	r0 += V4(6.016e-03, 1.036e-03, 2.791e-02, 4.451e-02) * s0_2_0;
	r1 += V4(9.612e-03, 6.796e-02, -2.079e-02, -4.557e-02) * s0_2_0;
	r2 += V4(-1.147e-01, -4.626e-02, -4.949e-02, 5.404e-03) * s0_2_0;
	r3 += V4(8.197e-03, 2.360e-02, -4.425e-03, 5.895e-01) * s0_2_0;
	r0 += V4(-3.890e-02, 1.075e-02, -1.705e-01, 1.218e-01) * s0_2_1;
	r1 += V4(7.068e-01, 3.232e-01, 5.992e-01, 1.886e-01) * s0_2_1;
	r2 += V4(2.228e-01, 1.942e-02, -3.330e-01, -8.621e-02) * s0_2_1;
	r3 += V4(1.576e-02, -2.430e-03, -4.541e-03, 3.958e-02) * s0_2_1;
	r0 += V4(3.361e-02, 4.054e-03, 1.339e-01, 4.020e-02) * s0_2_2;
	r1 += V4(1.437e-02, 2.733e-01, 7.380e-02, 3.017e-01) * s0_2_2;
	r2 += V4(-3.682e-01, 1.764e-02, -2.310e-01, -5.371e-01) * s0_2_2;
	r3 += V4(2.985e-02, -1.642e-02, 2.692e-04, -1.108e-02) * s0_2_2;
	r0 += V4(1.081e-02, 1.997e-01, 7.055e-06, 8.626e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(3.621e-03, 1.497e-02, -1.888e-02, -1.147e-02);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(-3.943e-03, -5.160e-03, -1.029e-02, -1.740e-02);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r2));
	r3 += V4(8.582e-03, 8.152e-03, 1.866e-03, -1.866e-03);
	r3 = max(r3, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r3));
}

//!DESC [CuNNy_4x16_DS_vk] -conv1
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
	r0 = D(r0, s0_0_0, 0xF00C0FF8, 0x10180DEA, 0xFF03F100, 0xF906F4F6);
	r1 = D(r1, s0_0_0, 0xF6070B02, 0x04FB0D05, 0x04FD0703, 0xFCF5F103);
	r2 = D(r2, s0_0_0, 0x20E4E515, 0x0302FE03, 0x09F10608, 0xEB09F5FB);
	r3 = D(r3, s0_0_0, 0xFD1412F2, 0xDCF0FF10, 0x0FFFF5F8, 0x07FBF203);
	r0 = D(r0, s0_0_1, 0x0B18FE02, 0xEC14F5DA, 0x19040F09, 0xFE0E17F2);
	r1 = D(r1, s0_0_1, 0x0907EE05, 0x1A102303, 0x0EFC160F, 0x47042706);
	r2 = D(r2, s0_0_1, 0x33EB0313, 0xFFFEE709, 0x0904DF06, 0xD6EA1F04);
	r3 = D(r3, s0_0_1, 0xEB07DEFA, 0xF6FCE910, 0xEB0FFC0A, 0xF1320CE6);
	r0 = D(r0, s0_0_2, 0x20FAF7FD, 0x1426FCDD, 0x1EFB0105, 0xFE10EBE9);
	r1 = D(r1, s0_0_2, 0xF009F5F2, 0xE917F8F2, 0x0AFB1808, 0xFEF60216);
	r2 = D(r2, s0_0_2, 0xF5E40806, 0x03FD0108, 0x0EF40E0B, 0xFA09F3F1);
	r3 = D(r3, s0_0_2, 0xDBF504F1, 0x04D31A23, 0x16E61212, 0xF4E4FD13);
	r0 = D(r0, s0_1_0, 0xE9010AFE, 0xC929C6E7, 0xE80803FB, 0xF60BFB0B);
	r1 = D(r1, s0_1_0, 0x0907DCF8, 0x060DF3FC, 0xEB080104, 0xFDFF0C0E);
	r2 = D(r2, s0_1_0, 0xFCE11715, 0x19FFF900, 0xF7040EFF, 0x0217E3E3);
	r3 = D(r3, s0_1_0, 0x0617F4EE, 0xFFF00521, 0xEFF90E0D, 0xF112F6F4);
	r0 = D(r0, s0_1_1, 0x2EFD03FE, 0xF94245DD, 0xB1E63911, 0x1FF0FB16);
	r1 = D(r1, s0_1_1, 0x341444F5, 0xD9069FD5, 0xE2C58113, 0xF63CF5E7);
	r2 = D(r2, s0_1_1, 0xEBE00301, 0xFFF90BEF, 0xB0FCE3E6, 0xF2FBDD0D);
	r3 = D(r3, s0_1_1, 0x7F3D54CE, 0xDFA2E1E2, 0x13FE01F9, 0x232226E1);
	r0 = D(r0, s0_1_2, 0xE6EB1422, 0xEF4AFAF9, 0x10F4062A, 0x13E32F7F);
	r1 = D(r1, s0_1_2, 0xFF13F706, 0x0A0F2CD5, 0x13DC0814, 0x0BE511FA);
	r2 = D(r2, s0_1_2, 0xE5DC2CD6, 0x02E0011B, 0xF7EE04FD, 0xEB0F04D9);
	r3 = D(r3, s0_1_2, 0xF2E3E407, 0x0BD1F1E5, 0x0710F2CB, 0xFEFBFF9E);
	r0 = D(r0, s0_2_0, 0xFA0BEAF1, 0xFA37F6EE, 0x04100EF6, 0x000AFBF0);
	r1 = D(r1, s0_2_0, 0xFCEEE91A, 0xFC170B06, 0x020CF7E2, 0x08F5FBF5);
	r2 = D(r2, s0_2_0, 0x120603F9, 0x0BEF040E, 0x00F4F919, 0x0C08EDF4);
	r3 = D(r3, s0_2_0, 0xE800F20A, 0x00E21212, 0xF20303F9, 0x031BFBF4);
	r0 = D(r0, s0_2_1, 0x24FF2AE1, 0xF44102EB, 0xF4FCE400, 0x02080FE9);
	r1 = D(r1, s0_2_1, 0xF1F71D2A, 0x07160518, 0x01010DF1, 0xFCF9FBFB);
	r2 = D(r2, s0_2_1, 0x15F6F3F1, 0x27CD4447, 0x0EFA1FF5, 0x07F2F6FF);
	r3 = D(r3, s0_2_1, 0xFE00E308, 0xFBFEF6DC, 0x06080614, 0x0530F2F5);
	r0 = D(r0, s0_2_2, 0x12D0EB0E, 0x053009FE, 0x1109F411, 0xF71AF717);
	r1 = D(r1, s0_2_2, 0xF9FB0552, 0x0733F70A, 0xF20C01F8, 0x01FDFEE5);
	r2 = D(r2, s0_2_2, 0x0821F804, 0x01D50441, 0x010EEE06, 0x191307EB);
	r3 = D(r3, s0_2_2, 0x02E71FF3, 0xE8E1F62C, 0x0F3DFC02, 0xEADA10D4);
	r0 = D(r0, s1_0_0, 0x0A330BC5, 0x17F513E2, 0xF4EE240C, 0x01FE18FD);
	r1 = D(r1, s1_0_0, 0x0EFB13EC, 0x09F8221B, 0xFDBE0E28, 0xD3E72718);
	r2 = D(r2, s1_0_0, 0x06FFED24, 0x00DB0B19, 0x0F030F02, 0xEF0016F8);
	r3 = D(r3, s1_0_0, 0x1623FBDC, 0x04E0EE02, 0x21FF02F8, 0x29FBD915);
	r0 = D(r0, s1_0_1, 0x09D6E92E, 0x231C1B03, 0xFB140B30, 0x0F0B2708);
	r1 = D(r1, s1_0_1, 0xFA0EF133, 0x2FDFDD40, 0xE3F1FE39, 0xE4DE1955);
	r2 = D(r2, s1_0_1, 0x08FFD7FE, 0x0626FFE4, 0x0109F204, 0x07E3EA39);
	r3 = D(r3, s1_0_1, 0x172918CE, 0xE837F9B2, 0x05F52FE3, 0xE9FC20D9);
	r0 = D(r0, s1_0_2, 0xFF09E518, 0x1BD4E31F, 0xFB0007E3, 0x100405C6);
	r1 = D(r1, s1_0_2, 0x08DDF221, 0x07FF0401, 0x0A19E3D5, 0xFCFE08F6);
	r2 = D(r2, s1_0_2, 0x0C1DF8B6, 0x07FE05ED, 0x0C0CFCE0, 0x0E14FBE8);
	r3 = D(r3, s1_0_2, 0x12EB030B, 0x011000D4, 0x2DE7E934, 0xF40706A6);
	r0 = D(r0, s1_1_0, 0x18FCF1E8, 0x3D39E210, 0x1CE820FF, 0x0507F211);
	r1 = D(r1, s1_1_0, 0xFC2F09DC, 0x2AEFF713, 0x18E1FCDC, 0x00DB44E1);
	r2 = D(r2, s1_1_0, 0xEFE7F814, 0x1B29F1E2, 0x1004EDFD, 0xEB16EEFF);
	r3 = D(r3, s1_1_0, 0xFD1008EC, 0xB90DF3F1, 0x0BE80FED, 0xEAF90262);
	r0 = D(r0, s1_1_1, 0xE6F3A2D9, 0x15F11FD2, 0xF607F2F1, 0x24E7C50A);
	r1 = D(r1, s1_1_1, 0x2FFC0D19, 0x3CC1E811, 0x0C1D11C5, 0xFFF7C11D);
	r2 = D(r2, s1_1_1, 0xFE2131FB, 0xF41AB981, 0x18481A6E, 0xEEF14B0F);
	r3 = D(r3, s1_1_1, 0x230F43DF, 0x11E7F10F, 0xC3A93E61, 0x232AE8E3);
	r0 = D(r0, s1_1_2, 0xEB002C2C, 0x1EDEE828, 0xF803180C, 0x1116130A);
	r1 = D(r1, s1_1_2, 0xFB000619, 0x140EEAFD, 0xE71307FC, 0x1419FBDF);
	r2 = D(r2, s1_1_2, 0x0718DBE9, 0xFC1F06AD, 0x1604FEF9, 0xF70100F9);
	r3 = D(r3, s1_1_2, 0x0CEF03FF, 0x1520FAE9, 0x2F0ECE81, 0x1C0A05D4);
	r0 = D(r0, s1_2_0, 0xFEF6F8FA, 0x09082200, 0xFAF30006, 0xF40EFF04);
	r1 = D(r1, s1_2_0, 0xF04C10BB, 0x1300E1FF, 0xFE07FDF9, 0x0AF80300);
	r2 = D(r2, s1_2_0, 0x00FC10F2, 0x161FD4EE, 0xFD29FEEE, 0xEBDC021D);
	r3 = D(r3, s1_2_0, 0xED1CEC13, 0xC8F0FB27, 0x3322DCEA, 0x43E8FC14);
	r0 = D(r0, s1_2_1, 0xC4ED371B, 0xF3E21A32, 0x17ECE518, 0xF70DFA02);
	r1 = D(r1, s1_2_1, 0x11EA350C, 0x0C23F8ED, 0xF512D0FE, 0xFAE2D72D);
	r2 = D(r2, s1_2_1, 0x1CE2DC24, 0x32261AB5, 0x17F4E911, 0xF9DDD03A);
	r3 = D(r3, s1_2_1, 0xFF310313, 0x1C14CD15, 0x3181E212, 0xFB2BFC0D);
	r0 = D(r0, s1_2_2, 0x070000ED, 0x15E5F418, 0xFDF2FF14, 0x0309EC0C);
	r1 = D(r1, s1_2_2, 0x15E100F5, 0xEE1007F2, 0xFFFD0819, 0x001BF6FC);
	r2 = D(r2, s1_2_2, 0xD6E71C28, 0xFC031EBD, 0xF8F70D06, 0xF9020719);
	r3 = D(r3, s1_2_2, 0x16FFE900, 0x0804FA16, 0xF4B02F09, 0xF5EEF71B);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xFD04F1E6, 0x021A4B1B, 0x2AE4FF00, 0xF2FCE7FC);
	r1 = D(r1, s0_0_0, 0x2E0D190C, 0xCE190AF3, 0x5302F237, 0x1A0B140B);
	r2 = D(r2, s0_0_0, 0x0CF80BF7, 0x1F171018, 0xEAEB1201, 0x032DE3DD);
	r3 = D(r3, s0_0_0, 0x0E0205F9, 0x11EBE10A, 0xADE30EFF, 0xAAEEFB14);
	r0 = D(r0, s0_0_1, 0x460DE218, 0xEE13470F, 0xF9DEC5EF, 0x7FB8E4E7);
	r1 = D(r1, s0_0_1, 0xAE1E21F4, 0x5803D932, 0xB508F927, 0x6FEBA8F8);
	r2 = D(r2, s0_0_1, 0xDE29F8F1, 0x28F4D8FB, 0x0B0BF4F1, 0xE20F20F9);
	r3 = D(r3, s0_0_1, 0x10030ED0, 0x7FEA13EE, 0x81C21BE0, 0x4E29CC06);
	r0 = D(r0, s0_0_2, 0x0B0FF414, 0xFE211206, 0x08F9FAF0, 0x0EF4C6ED);
	r1 = D(r1, s0_0_2, 0x03150C14, 0x0CFF2DFF, 0x0F0FD901, 0x0BF5EEF9);
	r2 = D(r2, s0_0_2, 0xF9FD3B02, 0x08F517F1, 0x0CFFFBFB, 0x0108DAFD);
	r3 = D(r3, s0_0_2, 0x08012BF8, 0x0EED2909, 0xFE0E65F8, 0x20EAD6E0);
	r0 = D(r0, s0_1_0, 0xE0120A32, 0xEB000E16, 0x19E81307, 0x11F8F013);
	r1 = D(r1, s0_1_0, 0xD21907FA, 0x0AE01BFE, 0x04E6EF00, 0x2494F515);
	r2 = D(r2, s0_1_0, 0xFC1205ED, 0x00EB02E8, 0x032D1BEA, 0xED41F6DE);
	r3 = D(r3, s0_1_0, 0x0B01050E, 0x0104F507, 0x220804F4, 0xE9EF0B0A);
	r0 = D(r0, s0_1_1, 0xE046000F, 0xC413210A, 0xF93A46FD, 0xB1591207);
	r1 = D(r1, s0_1_1, 0x1707F311, 0x1313040A, 0x05E5F8FF, 0x2D3810F7);
	r2 = D(r2, s0_1_1, 0x4BEE10E8, 0x0525F413, 0xF2CB170F, 0x33C21E03);
	r3 = D(r3, s0_1_1, 0x2CDFD7FD, 0xF907D3F8, 0xD9D7E42B, 0x2EE32548);
	r0 = D(r0, s0_1_2, 0x04DE3D0A, 0x0927BA03, 0x15F2CBF7, 0x03F0CE03);
	r1 = D(r1, s0_1_2, 0xFCEBC80D, 0xFFFD02F0, 0x15F06214, 0xFCF50C03);
	r2 = D(r2, s0_1_2, 0xE70C3508, 0xFAFE19FC, 0x0E014903, 0x070225E8);
	r3 = D(r3, s0_1_2, 0x00FD1A0F, 0xF7F2920B, 0xE54081FD, 0xFEFAEFE8);
	r0 = D(r0, s0_2_0, 0xDD13FA14, 0xE3FAE827, 0xF9070801, 0xFCFBFC02);
	r1 = D(r1, s0_2_0, 0xF41506F5, 0xE21FFC1F, 0xF0FEFE06, 0xF9070A19);
	r2 = D(r2, s0_2_0, 0x17FF03FB, 0x0B10090F, 0x07FCFB02, 0xFB04FAFA);
	r3 = D(r3, s0_2_0, 0xF00AFBF3, 0xE0140100, 0xF6090E0E, 0x09FAF545);
	r0 = D(r0, s0_2_1, 0x1AE60E17, 0xEEF5FA2B, 0x0603F9F5, 0xFB071AF2);
	r1 = D(r1, s0_2_1, 0x17E21DE8, 0xFEF0EB06, 0xF1261512, 0xF3031611);
	r2 = D(r2, s0_2_1, 0xFDF10909, 0x21C3FF0E, 0xFC00EE0F, 0xE91EFB00);
	r3 = D(r3, s0_2_1, 0x0813ECDB, 0x001105D8, 0x46BFEDFF, 0xD1E024FE);
	r0 = D(r0, s0_2_2, 0xE907D720, 0x06121010, 0x0B03EDF8, 0x020DD200);
	r1 = D(r1, s0_2_2, 0x0009D50A, 0xF806EE08, 0x09DF3507, 0xFD0740F6);
	r2 = D(r2, s0_2_2, 0x07F80509, 0x01F1060F, 0x02F5E608, 0xFD080CF8);
	r3 = D(r3, s0_2_2, 0xF611E2F9, 0x0E0009F3, 0xEEF4B240, 0x11314CD3);
	r0 = D(r0, s1_0_0, 0x00F6FEF8, 0xF5F802FF, 0x0D0503F4, 0xFE0109F6);
	r1 = D(r1, s1_0_0, 0xFB03FBFF, 0xE00506F7, 0x02F0021A, 0xF81A05F5);
	r2 = D(r2, s1_0_0, 0xF710F6FB, 0xFE0605EF, 0xFB0B02F1, 0x071303F2);
	r3 = D(r3, s1_0_0, 0x07F803F5, 0xF407030A, 0xFE0D0FCF, 0xFFF603DF);
	r0 = D(r0, s1_0_1, 0xFDFAFF05, 0xF2E6030E, 0xFB0702FF, 0xEEFE08F6);
	r1 = D(r1, s1_0_1, 0xDB030002, 0xD2E0FD0F, 0xF4F80F05, 0xE3E2F606);
	r2 = D(r2, s1_0_1, 0xFF190BF2, 0x0F02FA15, 0x13050006, 0xEB1005D4);
	r3 = D(r3, s1_0_1, 0xF90CFDFD, 0x451C09F1, 0xDD0903FC, 0xFBF0EF0D);
	r0 = D(r0, s1_0_2, 0xF800FD05, 0xC7F1FA11, 0xEFFA0601, 0x0D0F15F4);
	r1 = D(r1, s1_0_2, 0xE6FB0DFA, 0x01F6FF0C, 0x06F80108, 0x1B00FB08);
	r2 = D(r2, s1_0_2, 0x20F31200, 0xFB060004, 0xFB03FC03, 0x17FF0CE9);
	r3 = D(r3, s1_0_2, 0xD42000DA, 0x260BF20A, 0xF81301F7, 0x7F15CC10);
	r0 = D(r0, s1_1_0, 0x12F70F06, 0xF30FBD0C, 0xFFF9050A, 0x0C111406);
	r1 = D(r1, s1_1_0, 0xF2F2E926, 0xEEC5E600, 0x18F61414, 0x08D2F2D9);
	r2 = D(r2, s1_1_0, 0x0500F511, 0xF3EFF209, 0xF30CEAEF, 0x09F61804);
	r3 = D(r3, s1_1_0, 0xF921FDF9, 0xFB092201, 0x002DEC04, 0x09080CEA);
	r0 = D(r0, s1_1_1, 0x29EB081D, 0x9A87C9EB, 0xFEC623F1, 0x050C0C03);
	r1 = D(r1, s1_1_1, 0xCCB0F3FF, 0x137E0CF8, 0x2CF90FEA, 0x2981FE1B);
	r2 = D(r2, s1_1_1, 0x15130A02, 0xDFDE2BFB, 0x0C4411FB, 0x0856D019);
	r3 = D(r3, s1_1_1, 0xF4C5041F, 0x51E1F206, 0xC242FC19, 0xDB451413);
	r0 = D(r0, s1_1_2, 0x33BCE911, 0xF1D5A300, 0xFD2CE3EE, 0x0BCFCB17);
	r1 = D(r1, s1_1_2, 0xA5191509, 0xEE810FCF, 0xF2183C16, 0x1ABFD408);
	r2 = D(r2, s1_1_2, 0x062722DB, 0xE2F7EDF1, 0xEB0C001D, 0x091DF8EA);
	r3 = D(r3, s1_1_2, 0xEF10F21D, 0x0EB9EC10, 0x8181E207, 0xA99AF62B);
	r0 = D(r0, s1_2_0, 0x00F90207, 0xFACA06D3, 0x0013ED06, 0xFF000C12);
	r1 = D(r1, s1_2_0, 0x0ADFF707, 0x07FAF80F, 0x061A0FE0, 0x052E04F1);
	r2 = D(r2, s1_2_0, 0xFDFEFB20, 0x091FF4F8, 0x0313EA28, 0xF9DB0B2F);
	r3 = D(r3, s1_2_0, 0x031A02F2, 0xFE26010B, 0x1829F107, 0x06EFFAED);
	r0 = D(r0, s1_2_1, 0x0B360CEB, 0xD801C63A, 0x10140157, 0xF9F1E115);
	r1 = D(r1, s1_2_1, 0xE581E808, 0x0C4D2CFB, 0x1824FFC4, 0x08C62C2D);
	r2 = D(r2, s1_2_1, 0x0C2CE514, 0x161E1632, 0xF121FED5, 0x0947F0D6);
	r3 = D(r3, s1_2_1, 0xEB001DFC, 0x06BC39C6, 0x07810BE8, 0xE662D8D6);
	r0 = D(r0, s1_2_2, 0x0A1BF4F4, 0xD416C9EC, 0xFDF52905, 0xF4F395F9);
	r1 = D(r1, s1_2_2, 0xF6DFF5D6, 0xF6D7170B, 0x070AF1E4, 0x09001109);
	r2 = D(r2, s1_2_2, 0xF61DF111, 0x070BD414, 0xF007ECF0, 0xFDEAF401);
	r3 = D(r3, s1_2_2, 0xE3F51229, 0xF32D3FE9, 0xB4A9B23C, 0xE1B10632);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-3.065e-02, 2.933e-02, -7.642e-02, -2.461e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-2.206e-03, 3.256e-02, 9.253e-02, -4.263e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-5.701e-02, -4.724e-02, 3.814e-02, 1.324e-01);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), f2);
	f3 = vec4(r3) * 6.2000124e-05;
	f3 += vec4(1.170e-02, 1.011e-01, 7.638e-03, 8.203e-03);
	f3 = max(f3, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), f3);
}

//!DESC [CuNNy_4x16_DS_vk] -conv2
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
	r0 = D(r0, s0_0_0, 0xE40120EA, 0xECE63431, 0x16FE03E6, 0x02EB0CFD);
	r1 = D(r1, s0_0_0, 0xF519FB09, 0x06EB1243, 0xF20BFF13, 0xF6F0080E);
	r2 = D(r2, s0_0_0, 0x0E03EA12, 0x05F60807, 0x1CFDF60D, 0x09FD12FE);
	r3 = D(r3, s0_0_0, 0xFEF6FE08, 0x0002FFF5, 0xF2050D24, 0x0B01F6EC);
	r0 = D(r0, s0_0_1, 0x1A08F9DC, 0xD92C03E0, 0x0AFFECE9, 0xFA05F50B);
	r1 = D(r1, s0_0_1, 0xE717D728, 0xFAE3D900, 0xFD0404E8, 0x041EFBFB);
	r2 = D(r2, s0_0_1, 0xF50D1A13, 0x12261EF2, 0x1FE411BE, 0x151404E8);
	r3 = D(r3, s0_0_1, 0xF3FA09F5, 0xFE12F2FE, 0xF11505EC, 0xF108050C);
	r0 = D(r0, s0_0_2, 0x09F0F0F5, 0xE82352EF, 0xFD0BE1F3, 0x05FA0B05);
	r1 = D(r1, s0_0_2, 0xFC0C2007, 0xF4FF0D0B, 0xFC0A0409, 0x00011C0B);
	r2 = D(r2, s0_0_2, 0x01030703, 0x11F3DAF3, 0xFC1E1DE7, 0x03EAEC05);
	r3 = D(r3, s0_0_2, 0xF80B0605, 0x010504FE, 0x00FEEF08, 0x02F100F0);
	r0 = D(r0, s0_1_0, 0x81FE0AD8, 0xFA0D3433, 0xFF1CF2FC, 0xE7F41725);
	r1 = D(r1, s0_1_0, 0xEC02D5EC, 0x22FC1AEC, 0xFFFC1013, 0xFCF212DA);
	r2 = D(r2, s0_1_0, 0x60110AFE, 0x0F0907F6, 0x290C12FD, 0x120E0B21);
	r3 = D(r3, s0_1_0, 0x10F304F8, 0xFBF60708, 0x150BECF1, 0x0BEB030A);
	r0 = D(r0, s0_1_1, 0x0DE5F122, 0xFE0DEEDB, 0xDC0EA342, 0x07070AEC);
	r1 = D(r1, s0_1_1, 0xEFE2EA1D, 0x190BE702, 0x2F1403EA, 0x39F7EF1C);
	r2 = D(r2, s0_1_1, 0x0DF102F3, 0x24E8E818, 0x0FC1BEF1, 0xECDEE1F9);
	r3 = D(r3, s0_1_1, 0x83E5EF06, 0x0FC9EE12, 0x0DEDC200, 0x04050BFB);
	r0 = D(r0, s0_1_2, 0x01F1F40F, 0x0B12D106, 0xFB022221, 0xF9021111);
	r1 = D(r1, s0_1_2, 0x03F6EF09, 0xFD02F218, 0x04F3FD11, 0xFA04DB10);
	r2 = D(r2, s0_1_2, 0x000BFEF6, 0x09C70EF5, 0xFA28FCEE, 0xF42716D5);
	r3 = D(r3, s0_1_2, 0xEB3227E4, 0x080BF903, 0xFCF8F9FF, 0xFDF800F9);
	r0 = D(r0, s0_2_0, 0xD911DEFC, 0xF04BBCEB, 0x0F10FBF6, 0xAB060FEA);
	r1 = D(r1, s0_2_0, 0xFB05FDFE, 0xF70FF3FB, 0x1E06FC0E, 0xF3FDE5FD);
	r2 = D(r2, s0_2_0, 0x0EEDF601, 0xF700FB03, 0x140208FF, 0xEF0D2102);
	r3 = D(r3, s0_2_0, 0x090502F7, 0xFC00FAFC, 0x0BF41302, 0x11E80D04);
	r0 = D(r0, s0_2_1, 0xF80D1A04, 0xE7C60F27, 0xE0E710C2, 0xF5F013E4);
	r1 = D(r1, s0_2_1, 0x16EEF400, 0xF30F05FD, 0x21FF0204, 0xFD120000);
	r2 = D(r2, s0_2_1, 0x04FC0FFC, 0x031FF403, 0x050002FE, 0x08000BEB);
	r3 = D(r3, s0_2_1, 0xEF0909F0, 0xFD0506FC, 0x040212FD, 0x1313041B);
	r0 = D(r0, s0_2_2, 0x030D07F8, 0xF40D1EF4, 0x0022F91A, 0xF6090D03);
	r1 = D(r1, s0_2_2, 0xFD02F70A, 0x01050AF9, 0xFD07F909, 0x02F81507);
	r2 = D(r2, s0_2_2, 0x0101F7FE, 0x0A02F7FB, 0xF9F7FEEE, 0x09F9FBF1);
	r3 = D(r3, s0_2_2, 0xFF0004FE, 0x07FD00F3, 0x03EAFA02, 0x03F014F6);
	r0 = D(r0, s1_0_0, 0xFB05F9D9, 0xFFC90B10, 0xF303FC07, 0x0708FFF1);
	r1 = D(r1, s1_0_0, 0xE41402F3, 0xEA0C00E8, 0xF900F806, 0x14F5010A);
	r2 = D(r2, s1_0_0, 0x080003F6, 0x04FF0307, 0xF1010516, 0xF1FBF3EF);
	r3 = D(r3, s1_0_0, 0x02070200, 0x03FCFE12, 0xF507FDF5, 0xFD051507);
	r0 = D(r0, s1_0_1, 0xE5F30703, 0x0E3EFAE4, 0xE82A0D12, 0x07FB0BEE);
	r1 = D(r1, s1_0_1, 0xE0F83702, 0x0ADF0026, 0x00F4FE0D, 0x08FAF601);
	r2 = D(r2, s1_0_1, 0x0BF2F001, 0xDEF41CEE, 0xFB2D0FEC, 0xCBF32FEC);
	r3 = D(r3, s1_0_1, 0x10FCFFFD, 0xF51110F9, 0xF5F5FF05, 0x0CF0F6FE);
	r0 = D(r0, s1_0_2, 0x1C09FF1F, 0x1E1BDAC0, 0x0F0B13F5, 0x0205F9DE);
	r1 = D(r1, s1_0_2, 0x0CF108DA, 0xFF0BFAE0, 0xFEF4F5F1, 0xFFED0BFA);
	r2 = D(r2, s1_0_2, 0xF8FFFDFF, 0x040DFC19, 0xFB1105E8, 0xEF0C1905);
	r3 = D(r3, s1_0_2, 0xF0FAFBF1, 0xFD0314F0, 0x09EDEC11, 0x03040309);
	r0 = D(r0, s1_1_0, 0x16F2C5F6, 0xBB1A03A4, 0xE0FF0901, 0x03F1FCD4);
	r1 = D(r1, s1_1_0, 0xFEFCEE0C, 0xFBEB0CF0, 0x09F80C01, 0xFD030BF1);
	r2 = D(r2, s1_1_0, 0xF5F7FFFC, 0xF901FBE4, 0xED0A0A05, 0xDD1802D5);
	r3 = D(r3, s1_1_0, 0xFB07010B, 0x050E01F0, 0xFA14ECFC, 0x16E6FD12);
	r0 = D(r0, s1_1_1, 0x112E15DA, 0xF50DF758, 0x1D0EE23F, 0x15E2FAEC);
	r1 = D(r1, s1_1_1, 0xE00907D7, 0x492FF326, 0xF9F5DF1E, 0xDBFE1CDF);
	r2 = D(r2, s1_1_1, 0xF5EFF10F, 0x0B0D35D2, 0x1747050D, 0x3310F506);
	r3 = D(r3, s1_1_1, 0x1A0CF9E7, 0xF93421F2, 0x0B18FE27, 0x12E9DAD3);
	r0 = D(r0, s1_1_2, 0xF0132109, 0x050C00D9, 0xC7F5FD02, 0x16FA12F7);
	r1 = D(r1, s1_1_2, 0x30EF0102, 0x040D09F5, 0xECF0FFF2, 0x0B021210);
	r2 = D(r2, s1_1_2, 0xF600F2F8, 0x06170A13, 0x020CE7F5, 0xFCF91EF9);
	r3 = D(r3, s1_1_2, 0x1D03E9D9, 0x0A0A1B09, 0xFFF50114, 0x211D04F9);
	r0 = D(r0, s1_2_0, 0xE913C913, 0xBE1DFD9D, 0x06EDF4F6, 0x01F91509);
	r1 = D(r1, s1_2_0, 0x06FBED1F, 0xF308FEFE, 0xFF030CE7, 0xF803FF1C);
	r2 = D(r2, s1_2_0, 0xF60108F7, 0x0106030E, 0xF10221FC, 0xFBFE19EA);
	r3 = D(r3, s1_2_0, 0x01FD0500, 0x07FE010D, 0x19F8F5EE, 0x18140316);
	r0 = D(r0, s1_2_1, 0xF80C2408, 0x16DD3C16, 0xFFEE31E0, 0x28EFF8FE);
	r1 = D(r1, s1_2_1, 0xEA020014, 0x0DEFFD0B, 0x20EF0CF1, 0xF0FC04F2);
	r2 = D(r2, s1_2_1, 0xEB0901FA, 0x07E90707, 0x0425E423, 0x12E10519);
	r3 = D(r3, s1_2_1, 0x0C08F802, 0x08000DF3, 0x0BE3E801, 0x2DEA01F3);
	r0 = D(r0, s1_2_2, 0x0D00FAFE, 0xFDE9FAE4, 0xEF0BD523, 0xE805F7FE);
	r1 = D(r1, s1_2_2, 0x020F0A02, 0xF6FDFCF3, 0xFA16EAF8, 0xEC1513EF);
	r2 = D(r2, s1_2_2, 0xFBFE00F6, 0x0AF62502, 0xF40910DB, 0x29E20C0C);
	r3 = D(r3, s1_2_2, 0x22EFFC0C, 0x12F60905, 0x280EED03, 0x28F80B07);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xFD00FBFC, 0xE4E94632, 0xF1EFFD13, 0x010016FF);
	r1 = D(r1, s0_0_0, 0x1100E028, 0xEC0B0006, 0x1100F604, 0x00E8F510);
	r2 = D(r2, s0_0_0, 0xF1F41902, 0x05FC1603, 0x03F02622, 0xF4002BEA);
	r3 = D(r3, s0_0_0, 0xFF070EFF, 0x010500FC, 0x0F06F603, 0x00FFFBF7);
	r0 = D(r0, s0_0_1, 0x14FED40D, 0xF7F9D703, 0xF725E6FF, 0xF60DFE07);
	r1 = D(r1, s0_0_1, 0xF4F426F6, 0x0E4797F9, 0xF102FFEF, 0xFAFF1BF7);
	r2 = D(r2, s0_0_1, 0x08FAFF00, 0x09F8DB0D, 0xFCE2CBFB, 0xFC1DFEE7);
	r3 = D(r3, s0_0_1, 0x1003D2F9, 0x04FD18FE, 0x0311C3FA, 0xF8EDEF08);
	r0 = D(r0, s0_0_2, 0xFD0CFE00, 0xBA0123ED, 0xFB27ECFC, 0x0CE8F70C);
	r1 = D(r1, s0_0_2, 0x03FF0601, 0xF5F81BFA, 0xFA0EEC05, 0x0509F306);
	r2 = D(r2, s0_0_2, 0x0100F707, 0xFAF9FC04, 0x04030AFF, 0x0FED2601);
	r3 = D(r3, s0_0_2, 0x01041105, 0x0C010BF5, 0xFC021604, 0x00DD0E05);
	r0 = D(r0, s0_1_0, 0x03F6F9F8, 0x1FC70205, 0xF7EFFD14, 0x06F3FFFF);
	r1 = D(r1, s0_1_0, 0x0AF602F4, 0xEDF41301, 0x03FB0108, 0x0CF10321);
	r2 = D(r2, s0_1_0, 0xF1ED0A1C, 0xEF0DF406, 0xBEE1FAEC, 0xE804FDF7);
	r3 = D(r3, s0_1_0, 0xEBFC09F1, 0xFD0DEEFE, 0xF71DFADA, 0xE9FBEADC);
	r0 = D(r0, s0_1_1, 0x06144013, 0xEB3981B8, 0xF426C5CD, 0x13DE2100);
	r1 = D(r1, s0_1_1, 0x171A03FB, 0x1AE9F800, 0xFF3FD3FD, 0x23D61821);
	r2 = D(r2, s0_1_1, 0x23EC1C01, 0x061C1201, 0x0519D2DD, 0x240A11EF);
	r3 = D(r3, s0_1_1, 0x1C10FE2F, 0x173000F9, 0x0B57DD11, 0x0008E81C);
	r0 = D(r0, s0_1_2, 0x0C0CF2F4, 0x08DC1AF5, 0xE705EAF3, 0x060BEFFD);
	r1 = D(r1, s0_1_2, 0x040D0D13, 0x06000EFD, 0x0316FD12, 0xE713F123);
	r2 = D(r2, s0_1_2, 0x09FDFA01, 0xF909FCFD, 0xEED51200, 0xE5F5DFED);
	r3 = D(r3, s0_1_2, 0xACF3C904, 0xF60CEFFB, 0x17F7FE05, 0xF700EAF5);
	r0 = D(r0, s0_2_0, 0x19EAFFFD, 0x3CFFE9DC, 0x04E8192D, 0x1DF301FA);
	r1 = D(r1, s0_2_0, 0x03F50D19, 0x0B0DFFE6, 0xF80CF500, 0xFAF6FE00);
	r2 = D(r2, s0_2_0, 0x0200FD0C, 0xFF0706F4, 0xDDFDDE28, 0x050DE4E4);
	r3 = D(r3, s0_2_0, 0x05FFFB02, 0xFC010409, 0xFD040C0D, 0x020B12C8);
	r0 = D(r0, s0_2_1, 0xD620E3FF, 0xFB23DA0C, 0x12BE0E12, 0x1EF7141B);
	r1 = D(r1, s0_2_1, 0xFEFDFDFD, 0xFD0F0DFD, 0xE207F724, 0x1A08F6EB);
	r2 = D(r2, s0_2_1, 0xFE01F705, 0x0C01FEEC, 0xFDF2F1FB, 0xDAF60F11);
	r3 = D(r3, s0_2_1, 0xFCF60CFD, 0xF503F71B, 0xFCF5082F, 0x00F8F403);
	r0 = D(r0, s0_2_2, 0xE9F80306, 0x081004EE, 0x43CB1EF2, 0x2BF800F8);
	r1 = D(r1, s0_2_2, 0xFB06F005, 0xFB0001FE, 0xF6080208, 0xFC05F0FB);
	r2 = D(r2, s0_2_2, 0x1102F8F7, 0xE908F211, 0x0EF507E6, 0x01F7F800);
	r3 = D(r3, s0_2_2, 0x10F312FE, 0xF6FCFC13, 0xF5031107, 0xE9FCFF03);
	r0 = D(r0, s1_0_0, 0xFE14E800, 0xC6EEE4FA, 0x1C23D70A, 0xFB16FE12);
	r1 = D(r1, s1_0_0, 0x0BD1F303, 0x08F9F0FF, 0x03070EF8, 0x000D1601);
	r2 = D(r2, s1_0_0, 0x0A07F7FD, 0xF1F2F2FF, 0x12E5F8EF, 0xFBBED3FF);
	r3 = D(r3, s1_0_0, 0x04FF00FA, 0xF5EEFCF2, 0x0ABE02FD, 0xEC0D1B06);
	r0 = D(r0, s1_0_1, 0xF0EB07F8, 0xC9E0FB19, 0x1634FB03, 0xF615FA17);
	r1 = D(r1, s1_0_1, 0x0EE51301, 0x0024FD19, 0x10090C0D, 0x042DFC18);
	r2 = D(r2, s1_0_1, 0x080B0907, 0xEF1A02FF, 0x02EAFCFA, 0xD9D406FB);
	r3 = D(r3, s1_0_1, 0xF81A0B07, 0xF6DCF80C, 0xFEC90A03, 0x08F41415);
	r0 = D(r0, s1_0_2, 0xFD0019FD, 0xE1E93603, 0xE916D6FC, 0xFFFBFAFE);
	r1 = D(r1, s1_0_2, 0xFDFDFDF1, 0xFFF30CFF, 0x030200FC, 0xFF010DF6);
	r2 = D(r2, s1_0_2, 0x0510F706, 0xFE0EFDF7, 0x0A1111F5, 0xFA14CBF9);
	r3 = D(r3, s1_0_2, 0xF409F2FA, 0xFCFD07F8, 0x09DA0DFD, 0x0AFEF7FC);
	r0 = D(r0, s1_1_0, 0x0A081638, 0x04DECA0F, 0x3119F301, 0x052D0F06);
	r1 = D(r1, s1_1_0, 0x21CF0BFE, 0xED15FF0D, 0xF81306F2, 0x131F0C20);
	r2 = D(r2, s1_1_0, 0xF701EED5, 0x0FECE80A, 0x01FCEFEC, 0xFABCFCFB);
	r3 = D(r3, s1_1_0, 0x060D09FA, 0x0BF2F7FA, 0x07D5E4E0, 0xE1242C14);
	r0 = D(r0, s1_1_1, 0xF7E2EFEF, 0xD11DA39F, 0x3F0AFFF5, 0x0E46FA0D);
	r1 = D(r1, s1_1_1, 0x09D203FF, 0xF60107D0, 0x0B1113F1, 0x0A0EF6D3);
	r2 = D(r2, s1_1_1, 0x05ED0B0B, 0x05ECECEE, 0x0EDDE5FA, 0x1201E718);
	r3 = D(r3, s1_1_1, 0x0DFD0554, 0x01FFE4F2, 0x13E5FAD1, 0xEFCD306F);
	r0 = D(r0, s1_1_2, 0x0603EEF8, 0xB320DA19, 0x111DE2F8, 0xF104EA12);
	r1 = D(r1, s1_1_2, 0x00E7FAFA, 0xFFFCFDFE, 0x0003F4EE, 0x0CFCF8F4);
	r2 = D(r2, s1_1_2, 0x0700FD08, 0xF60CE6F0, 0x0000021E, 0x0403F90B);
	r3 = D(r3, s1_1_2, 0xF623092A, 0x05FBF4EE, 0x01D608F4, 0xECFCFB02);
	r0 = D(r0, s1_2_0, 0x09F80C07, 0x44FBCAE4, 0x16240EEE, 0x0B1F180D);
	r1 = D(r1, s1_2_0, 0xF0FC0700, 0x00FDFCFE, 0x0D06FDFD, 0x02E90E04);
	r2 = D(r2, s1_2_0, 0x0AF20305, 0xF7EE01F9, 0xF5F408FC, 0xEB0DD309);
	r3 = D(r3, s1_2_0, 0xFD03F4FE, 0x01FFFFFD, 0xF4FC1500, 0xE7FDED05);
	r0 = D(r0, s1_2_1, 0x0503FEF3, 0x0226FAEE, 0x180C0DD1, 0x061F231C);
	r1 = D(r1, s1_2_1, 0x03F206F4, 0xFCFCF91A, 0xFB08E3FD, 0x1403080D);
	r2 = D(r2, s1_2_1, 0x000E11FD, 0x170207FE, 0x060F1106, 0xDC12F815);
	r3 = D(r3, s1_2_1, 0xFF000303, 0x0210EC11, 0xF4FEEBF3, 0xFD09F317);
	r0 = D(r0, s1_2_2, 0xF606F7FF, 0xFA18EC22, 0x082B4AFC, 0x021712FD);
	r1 = D(r1, s1_2_2, 0x00FAF9FA, 0xFF02F104, 0x0CFE03F2, 0x0003DEF3);
	r2 = D(r2, s1_2_2, 0x05FB13FC, 0xFDF4E6FD, 0x19F8E005, 0xEAF41F0F);
	r3 = D(r3, s1_2_2, 0xF501070B, 0xFA14E806, 0xF6F4FFFF, 0xF7FCE902);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(3.257e-02, 4.934e-02, -5.801e-03, -1.395e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(1.020e-03, -4.200e-03, 1.679e-02, 4.012e-04);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-2.412e-02, 4.666e-02, 3.340e-02, 2.364e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), f2);
	f3 = vec4(r3) * 6.2000124e-05;
	f3 += vec4(1.063e-02, 6.256e-02, 1.614e-02, -5.703e-02);
	f3 = max(f3, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), f3);
}

//!DESC [CuNNy_4x16_DS_vk] -conv3
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
	r0 = D(r0, s0_0_0, 0x00FDFFFF, 0x0D061514, 0xAEED0816, 0xDFFDDAFB);
	r1 = D(r1, s0_0_0, 0xFD160006, 0x05F8FC00, 0x05FB03F6, 0x08F20FFC);
	r2 = D(r2, s0_0_0, 0x010108FC, 0xF806FDF7, 0x040A0CFB, 0x0C0407F4);
	r3 = D(r3, s0_0_0, 0xF20CF6F3, 0xF905FAFB, 0xEC26FDF9, 0xF2ECF00A);
	r0 = D(r0, s0_0_1, 0x0DFBF6FE, 0xE702D840, 0xEEFD4907, 0x0A15B817);
	r1 = D(r1, s0_0_1, 0x1D1EFD15, 0xF3F5FF06, 0x01F4FFEF, 0xF70103F1);
	r2 = D(r2, s0_0_1, 0xFDFD0C01, 0xE109E803, 0xD90827EA, 0xF807FBDF);
	r3 = D(r3, s0_0_1, 0xE904220F, 0xE3F4F8FA, 0xE01CFAF3, 0xE1CFAD22);
	r0 = D(r0, s0_0_2, 0xEA0B02FC, 0x2AEDCA2A, 0x1703D4FB, 0x14F9D004);
	r1 = D(r1, s0_0_2, 0xE3FEF21D, 0xFC010404, 0xFF0011F0, 0xD8061CED);
	r2 = D(r2, s0_0_2, 0xFDFF0BFB, 0x070ED7EC, 0x040111DB, 0xF70806F6);
	r3 = D(r3, s0_0_2, 0xFA07DB01, 0x0409E5FD, 0x1116E6FA, 0xF212D4FC);
	r0 = D(r0, s0_1_0, 0xF9000AFB, 0x020D0B0D, 0xE20EDBFE, 0xD6EBDC0F);
	r1 = D(r1, s0_1_0, 0xFCFFFF03, 0x050BFEFE, 0xF80717FE, 0xFDFCF80D);
	r2 = D(r2, s0_1_0, 0x04EDF503, 0x1FD933F2, 0x0507EB05, 0x050911EE);
	r3 = D(r3, s0_1_0, 0x06E496FF, 0xEDFE0AFB, 0x0C0F0314, 0x0B19E0F2);
	r0 = D(r0, s0_1_1, 0xF20009FB, 0x08FECE0D, 0xEB08350E, 0xC1EBE4F7);
	r1 = D(r1, s0_1_1, 0x04EDF218, 0xEF00F015, 0xED14F80C, 0x00F817DB);
	r2 = D(r2, s0_1_1, 0x0FF509FA, 0x37BA2DF7, 0x23281CEB, 0xFA0819B2);
	r3 = D(r3, s0_1_1, 0x15020302, 0xE2FA1F07, 0x262FF3F9, 0xF5D3EC0C);
	r0 = D(r0, s0_1_2, 0xE60A18FC, 0x0BFEC222, 0x16F8FA05, 0xE505E9F0);
	r1 = D(r1, s0_1_2, 0x13F8EB3A, 0xF30803F3, 0x02FEF8FD, 0x02030BF8);
	r2 = D(r2, s0_1_2, 0xFF040DFE, 0x040B2CF5, 0x1005E4F3, 0xF40939E2);
	r3 = D(r3, s0_1_2, 0x2A02B8F5, 0xFC04FF0C, 0x0812FED1, 0xD90B040A);
	r0 = D(r0, s0_2_0, 0xFDFF0600, 0xF70D2C12, 0xF90BE507, 0x1102150A);
	r1 = D(r1, s0_2_0, 0xFDFFFB03, 0x090200FA, 0x02F9F002, 0x00010504);
	r2 = D(r2, s0_2_0, 0xFBF10601, 0xFC21EDFA, 0x01FFFFFE, 0x050705F3);
	r3 = D(r3, s0_2_0, 0xF7FEF403, 0x0006DB02, 0xFB1C11F5, 0x02F00902);
	r0 = D(r0, s0_2_1, 0xFD0307FE, 0x0805072E, 0xF608F70D, 0x0B09DB13);
	r1 = D(r1, s0_2_1, 0x00F9F30A, 0x0EF80B13, 0x09FE06FE, 0xF50A0CEB);
	r2 = D(r2, s0_2_1, 0x0406F0F1, 0xF72BB5FD, 0xFC010EE7, 0x020FFEDA);
	r3 = D(r3, s0_2_1, 0x08142904, 0xF60A0001, 0x02111DEF, 0x0B00E001);
	r0 = D(r0, s0_2_2, 0xFE0312FE, 0x04FAFC16, 0x0DFFEA05, 0xFAFFD904);
	r1 = D(r1, s0_2_2, 0xFAFA0A0F, 0x0109FE0F, 0xFDFFFDFD, 0xFBFD08F3);
	r2 = D(r2, s0_2_2, 0x00FD1006, 0x0218B9E8, 0xFBFD04F4, 0xF50820ED);
	r3 = D(r3, s0_2_2, 0x22EBCE0F, 0xFA06F201, 0xF80BF8ED, 0xFC07E307);
	r0 = D(r0, s1_0_0, 0xFE02FC00, 0x0C120D01, 0xE2D71505, 0xF5FBFE02);
	r1 = D(r1, s1_0_0, 0xFBF5FEFE, 0x05FFFFFC, 0x08FFFEFC, 0x0100FA00);
	r2 = D(r2, s1_0_0, 0xFCFEFE05, 0xFFF505F3, 0x05F90503, 0xEF07EF04);
	r3 = D(r3, s1_0_0, 0x10F416FA, 0xFAF3FDFC, 0xFF18F8FB, 0x060002FF);
	r0 = D(r0, s1_0_1, 0xF8FDFB02, 0x32DF0E0A, 0x1009FCF4, 0xF717F2F8);
	r1 = D(r1, s1_0_1, 0xF1050805, 0x06F507FF, 0x040BFBFC, 0xFBE1FEF6);
	r2 = D(r2, s1_0_1, 0x03FCFCFA, 0xFAC4FC13, 0x0E0604F5, 0x081FFB02);
	r3 = D(r3, s1_0_1, 0x12C50E07, 0xF6E40307, 0x2035010A, 0xEFFE0C09);
	r0 = D(r0, s1_0_2, 0xFFF7FE03, 0xFD040008, 0x0109EFFA, 0x0007FA07);
	r1 = D(r1, s1_0_2, 0xF2060D02, 0x08E500FF, 0x0E0104F4, 0x08EF0AFD);
	r2 = D(r2, s1_0_2, 0x0101FF01, 0x01D30209, 0x071200F7, 0x00030006);
	r3 = D(r3, s1_0_2, 0xFB0A090E, 0x03E8FE04, 0x022DFA1B, 0x01D1FF09);
	r0 = D(r0, s1_1_0, 0x0AFFFA01, 0x002C20F2, 0x1A240E20, 0xF726171E);
	r1 = D(r1, s1_1_0, 0xFF0700FE, 0x090704EE, 0x0BFA02F7, 0x1020F2FE);
	r2 = D(r2, s1_1_0, 0x05F8FA02, 0x04FC1213, 0xEDEE07F0, 0x11DEE9ED);
	r3 = D(r3, s1_1_0, 0x1711270E, 0x11FDFA06, 0x19FD000E, 0x020604F2);
	r0 = D(r0, s1_1_1, 0x0516FC06, 0x18FF0F81, 0xF8E32512, 0xEBEEEC18);
	r1 = D(r1, s1_1_1, 0xC8EBF2F0, 0x02460805, 0xF719380A, 0xEB0503EA);
	r2 = D(r2, s1_1_1, 0x21FAFDEE, 0x500311E9, 0x24F72914, 0x2835E9DA);
	r3 = D(r3, s1_1_1, 0x1B1D1418, 0x24191237, 0x41FFF9AC, 0xF63DFF66);
	r0 = D(r0, s1_1_2, 0x12F005F3, 0xFAF20ECD, 0xEF09EDE6, 0x04FEE2F5);
	r1 = D(r1, s1_1_2, 0x00FBF10F, 0x03070AFC, 0xF9F51CF6, 0x03ED1308);
	r2 = D(r2, s1_1_2, 0x00FC0104, 0x3DFC08F7, 0xED21FD0F, 0x0D040304);
	r3 = D(r3, s1_1_2, 0xE9341406, 0x1CE7F7F2, 0xFD0DFB18, 0x39F20EF6);
	r0 = D(r0, s1_2_0, 0x0502F905, 0xFA0912FB, 0x060A0910, 0x31250552);
	r1 = D(r1, s1_2_0, 0xFA07FD00, 0xF5F3F9F8, 0xFB0405FF, 0xF9FBF707);
	r2 = D(r2, s1_2_0, 0x00FEFD09, 0xF3EA09F5, 0xFCF804F1, 0xFEE3E8F1);
	r3 = D(r3, s1_2_0, 0x0B071013, 0x06FEF9FA, 0x0DFB05F5, 0xF2F40403);
	r0 = D(r0, s1_2_1, 0xFC06F308, 0x13162504, 0x05F2121B, 0xFE111716);
	r1 = D(r1, s1_2_1, 0xFEFCF6D5, 0xF3171F31, 0xFD01060C, 0xE603EEEF);
	r2 = D(r2, s1_2_1, 0xF704F01A, 0xCFE60AFD, 0xFEEEFE00, 0x1011D823);
	r3 = D(r3, s1_2_1, 0xD5FB0E00, 0xF508F010, 0x290DC0EC, 0x07FAF0EA);
	r0 = D(r0, s1_2_2, 0x0E02FC1A, 0xF80F1AD5, 0xFC06F6F9, 0x0407FDFE);
	r1 = D(r1, s1_2_2, 0x04F1E9EB, 0x00FF0D0C, 0xFB050304, 0x04F10802);
	r2 = D(r2, s1_2_2, 0xFFF3FA12, 0xEF1111F8, 0xF5F6F7E1, 0x07010923);
	r3 = D(r3, s1_2_2, 0xEC042921, 0x0B02F3FD, 0x0605FCE9, 0x1315041A);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x02FEFEFC, 0x00F2FB0A, 0xE24A15F2, 0x0A1DF4F1);
	r1 = D(r1, s0_0_0, 0xFDF30508, 0xFFFCFDFF, 0x01FD00FB, 0x09F8FB02);
	r2 = D(r2, s0_0_0, 0xFEFE0201, 0x01020D01, 0x030400FD, 0x020900FA);
	r3 = D(r3, s0_0_0, 0xFF1B0EDC, 0xF9FC14FF, 0x0A1204F7, 0xF1DA060B);
	r0 = D(r0, s0_0_1, 0x0004F701, 0x18D6FEF5, 0x20EBEF1A, 0x13E8ED0C);
	r1 = D(r1, s0_0_1, 0xF80B0B12, 0xF9090507, 0xFBF8F3FD, 0x0CF6FBF2);
	r2 = D(r2, s0_0_1, 0xFDFE0006, 0x0E931504, 0x00F40805, 0x0B1B0AFD);
	r3 = D(r3, s0_0_1, 0xED0AFACE, 0x0D0F0DFF, 0x2DEE06DE, 0x0A0504F5);
	r0 = D(r0, s0_0_2, 0xFF18FE04, 0xCBDE08F1, 0xFC06F9E2, 0x0409FE02);
	r1 = D(r1, s0_0_2, 0x00F7FF11, 0x020405FE, 0x00FEFEF5, 0x03050313);
	r2 = D(r2, s0_0_2, 0x070A02FB, 0xE00E2308, 0x0AFA0807, 0x0E0202F1);
	r3 = D(r3, s0_0_2, 0xD1180915, 0xEC0C0811, 0xF7110BE8, 0xDB1B0B1B);
	r0 = D(r0, s0_1_0, 0x0408FE01, 0x101EEC01, 0xBB143DEF, 0xEDD21311);
	r1 = D(r1, s0_1_0, 0xEF081007, 0x0B05EAF8, 0x01E6ED05, 0x230AE3F7);
	r2 = D(r2, s0_1_0, 0x0201F405, 0xD5D6180E, 0x1104F9EE, 0x26FBCEE3);
	r3 = D(r3, s0_1_0, 0xD30CE9F7, 0xF4E81811, 0x080ECAF3, 0x0CF8F1F8);
	r0 = D(r0, s0_1_1, 0x06090707, 0xB7CCC52E, 0x120BCD26, 0xF611F81B);
	r1 = D(r1, s0_1_1, 0xF30C420B, 0xF4091B0C, 0x12FB06FD, 0xE3DC432F);
	r2 = D(r2, s0_1_1, 0xF8EF08F7, 0xC6CE21D6, 0x1608CAD6, 0x011016BF);
	r3 = D(r3, s0_1_1, 0x863CDB08, 0xC1001001, 0x2AAAE381, 0xF10EFD10);
	r0 = D(r0, s0_1_2, 0xFFF5FBEB, 0xC82C08A9, 0x010EFFE8, 0xF019FCE0);
	r1 = D(r1, s0_1_2, 0xFFF9FC33, 0xF6F70D2E, 0x08FEFDF0, 0xFFDDF923);
	r2 = D(r2, s0_1_2, 0x06FA011A, 0xECFB08F3, 0x2C0704DE, 0x0807082B);
	r3 = D(r3, s0_1_2, 0x815D0708, 0x020C02CE, 0xFC0C1AF2, 0xF6D911E3);
	r0 = D(r0, s0_2_0, 0x02F6FEFE, 0xCAF001FE, 0xE31111E3, 0xCC0F01F5);
	r1 = D(r1, s0_2_0, 0x00FB0103, 0xF805FCFD, 0x0105FB00, 0x09F4FB0C);
	r2 = D(r2, s0_2_0, 0x0AF10907, 0x1B09F4F3, 0x020800FE, 0x09ECE007);
	r3 = D(r3, s0_2_0, 0xED2EECF5, 0xFEFBFAFC, 0xFA03E906, 0xFE07FC00);
	r0 = D(r0, s0_2_1, 0x01010100, 0xEDE9F70D, 0xFAF7F2FB, 0xFDFCF8D1);
	r1 = D(r1, s0_2_1, 0xF301F602, 0xDE0527EF, 0xFFF8FC05, 0x0D09FE03);
	r2 = D(r2, s0_2_1, 0x1B00FE14, 0x12F4D1FE, 0x3403F0FE, 0x09FD0106);
	r3 = D(r3, s0_2_1, 0x8144FBDE, 0xF900F6FF, 0xEDE7E213, 0xEA0BFF03);
	r0 = D(r0, s0_2_2, 0x04FDFDF5, 0xFDF70CE4, 0x19110503, 0x0AD7F60F);
	r1 = D(r1, s0_2_2, 0xD3F1FC22, 0x0B0AFC1B, 0x10040303, 0xF0F4FB11);
	r2 = D(r2, s0_2_2, 0xFFF1FD09, 0xD313FC20, 0xF5FAFF23, 0x0D13040F);
	r3 = D(r3, s0_2_2, 0x9440F1B3, 0x0604EE04, 0x04080101, 0x0A19E9DC);
	r0 = D(r0, s1_0_0, 0xFEFEFD02, 0xF3DAFDE8, 0xF21BDF0F, 0x0BFE10E3);
	r1 = D(r1, s1_0_0, 0xF1020007, 0x0304FDF7, 0x06FCFA00, 0x12FBFD17);
	r2 = D(r2, s1_0_0, 0x0C0300FC, 0x1A17E8D9, 0xFA1CF211, 0x0BFBF3F9);
	r3 = D(r3, s1_0_0, 0xF1FF0B0C, 0xFF15EE1F, 0xF0F6E205, 0xEB0BFB16);
	r0 = D(r0, s1_0_1, 0x00120006, 0xF5D9F2E3, 0x17CE1EF0, 0xF212F5FA);
	r1 = D(r1, s1_0_1, 0xF7010C12, 0xF50DFD05, 0x0BFB09FE, 0xF629F10E);
	r2 = D(r2, s1_0_1, 0x090A01FF, 0xEA3AD301, 0xE720FE19, 0x100A04FB);
	r3 = D(r3, s1_0_1, 0xDC22D8F0, 0xF00FEF02, 0xD3F7E803, 0xEDFDE919);
	r0 = D(r0, s1_0_2, 0x07F8FEFC, 0xE6D8F7F6, 0x0D10F9F3, 0x03070C07);
	r1 = D(r1, s1_0_2, 0x0CDA0A03, 0xFA0CF906, 0x0EFB05F6, 0xF6F30607);
	r2 = D(r2, s1_0_2, 0xFD00FD00, 0xF117FF04, 0xEB120E12, 0xFBF8FCFF);
	r3 = D(r3, s1_0_2, 0xE0F9F4FC, 0x0427FEF5, 0xEFE9F2FE, 0xF84100F7);
	r0 = D(r0, s1_1_0, 0xF704F918, 0xD9D43CA4, 0xA7C1D9E2, 0xE2F9DA1B);
	r1 = D(r1, s1_1_0, 0xFBF9000B, 0xFAFF00FF, 0xFC0EFB1B, 0xDCE6F621);
	r2 = D(r2, s1_1_0, 0x07FC080C, 0xFC06170E, 0x061FF215, 0xF418FA09);
	r3 = D(r3, s1_1_0, 0xCFF1ECD6, 0xFC0CE84A, 0xE5FD0FE3, 0x10E0E8E5);
	r0 = D(r0, s1_1_1, 0x0010213E, 0xBFB4F003, 0xFD1111EE, 0x240034E7);
	r1 = D(r1, s1_1_1, 0x2C21D9EA, 0x0DFDEA05, 0xCAF4342B, 0xD0EE360B);
	r2 = D(r2, s1_1_1, 0xE40EFE0E, 0xA1E1F21B, 0xFBF6C5E9, 0xCE1BDE1F);
	r3 = D(r3, s1_1_1, 0xE7F5DDEE, 0xB8F73450, 0x10B18A81, 0xEE05FE2A);
	r0 = D(r0, s1_1_2, 0xE209EB16, 0x0DCA1103, 0x07070CFE, 0x15FEE2FA);
	r1 = D(r1, s1_1_2, 0x160C05F8, 0xF0EA180D, 0x000AF204, 0xF3FE0711);
	r2 = D(r2, s1_1_2, 0xF5030607, 0xF1FB17FE, 0xF102F3F0, 0xE507080D);
	r3 = D(r3, s1_1_2, 0xE4FA17E2, 0x1511DBF4, 0x07DCF909, 0xFEF5DD11);
	r0 = D(r0, s1_2_0, 0xFCFFF00F, 0xF8F813DF, 0x09F2F506, 0xFCECD619);
	r1 = D(r1, s1_2_0, 0xFEF70303, 0x060705FC, 0x01F8FEF9, 0xEF03ED16);
	r2 = D(r2, s1_2_0, 0xF4FEF4FD, 0x11100ACD, 0xFD0D0809, 0xF8210309);
	r3 = D(r3, s1_2_0, 0xE80B0EEC, 0x07F8000C, 0xFC1308F1, 0x0D0A10F0);
	r0 = D(r0, s1_2_1, 0xF9F91216, 0xF514DDFD, 0x0EFDF9EE, 0xFDEBD4EF);
	r1 = D(r1, s1_2_1, 0x0AF716FA, 0xE7E3CD08, 0xFC02F5FD, 0xFCF42DFF);
	r2 = D(r2, s1_2_1, 0xFA0B2EF4, 0x0B1AF4E3, 0xF80E17FA, 0xDC041216);
	r3 = D(r3, s1_2_1, 0xDF142507, 0xF8F713FF, 0x161B21F6, 0x13EFEC04);
	r0 = D(r0, s1_2_2, 0xFBF6FA06, 0xF2F91202, 0x0608F4EF, 0xEF050910);
	r1 = D(r1, s1_2_2, 0x03070C07, 0xF9FA0705, 0xF7020AFB, 0x09040103);
	r2 = D(r2, s1_2_2, 0xFE070003, 0xFA0B28FC, 0x01021103, 0xEF020008);
	r3 = D(r3, s1_2_2, 0x1106A1EF, 0x020D0AFA, 0x0CEC00FB, 0xF406F106);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.752e-02, -3.173e-02, -5.091e-03, 1.396e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(1.467e-02, -1.248e-02, -1.222e-02, -3.298e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-1.605e-02, -3.137e-02, -2.146e-02, -3.328e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), f2);
	f3 = vec4(r3) * 6.2000124e-05;
	f3 += vec4(3.499e-03, -2.341e-02, 1.814e-02, -6.365e-03);
	f3 = max(f3, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), f3);
}

//!DESC [CuNNy_4x16_DS_vk] -conv4
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
	r0 = D(r0, s0_0_0, 0xFD01FCF9, 0x0401FD00, 0x0303FA05, 0x0402FC02);
	r1 = D(r1, s0_0_0, 0x04FB02F9, 0x0902FDDF, 0xF803F6E9, 0x01FFE7DE);
	r2 = D(r2, s0_0_0, 0xF702F4F1, 0x0605FAF8, 0xD40CC3C0, 0xFD000003);
	r3 = D(r3, s0_0_0, 0x0F02FDEE, 0xF605090B, 0xFA0202FE, 0x04FEF2EE);
	r0 = D(r0, s0_0_1, 0xF8FFF6FC, 0xFE0501FE, 0x0303FEF9, 0x0000FE04);
	r1 = D(r1, s0_0_1, 0xFDFA071A, 0x00FDEB18, 0xEBFDEA09, 0x0803E113);
	r2 = D(r2, s0_0_1, 0x00F7EA13, 0xEB09F403, 0x0B02D1F7, 0x0102F705);
	r3 = D(r3, s0_0_1, 0x1D05DEDF, 0xF8F3E406, 0xFFF806FA, 0x0000F1FB);
	r0 = D(r0, s0_0_2, 0xFC0DF900, 0xFF01FDFF, 0xFEFEFA02, 0xFA010001);
	r1 = D(r1, s0_0_2, 0xF6030801, 0xF8FBF401, 0xE9F0F208, 0xFDFAECFB);
	r2 = D(r2, s0_0_2, 0xF41504F5, 0x0A030303, 0xFC181D04, 0xF101FD07);
	r3 = D(r3, s0_0_2, 0xFC08EF0D, 0xE31203F2, 0xF6FE08FE, 0xFD000400);
	r0 = D(r0, s0_1_0, 0xFE00F7F8, 0xFC02F3D9, 0xF5FFEE9F, 0x02FDF0F2);
	r1 = D(r1, s0_1_0, 0x01FC00E5, 0xFE04E925, 0xF507EE29, 0x0206E918);
	r2 = D(r2, s0_1_0, 0xFB07F9E1, 0x07FCA5F1, 0x1A128103, 0x000200E3);
	r3 = D(r3, s0_1_0, 0xEEFEF4E2, 0xFF030509, 0x03FB05FD, 0xF7FCDEE3);
	r0 = D(r0, s0_1_1, 0xEE00F30B, 0x2507EE03, 0x1C08EE09, 0x0200F700);
	r1 = D(r1, s0_1_1, 0x09FEF843, 0xFA0FF3DE, 0xF60FF2D5, 0xF717F7C7);
	r2 = D(r2, s0_1_1, 0xE3E8F324, 0x000CE70D, 0xFB13AD00, 0xF7FCE8D7);
	r3 = D(r3, s0_1_1, 0xC2F7D70B, 0xF801E2FE, 0xFFE7F40C, 0x13FED9FA);
	r0 = D(r0, s0_1_2, 0x0843FBFE, 0xF5F9FCFE, 0x0C02F4F3, 0x0800FB00);
	r1 = D(r1, s0_1_2, 0xF1370C02, 0x01ED0209, 0xFAE7F0FC, 0x01FEFE08);
	r2 = D(r2, s0_1_2, 0xFF2CFF08, 0xE9F40309, 0xEB131BF9, 0x29FCECFB);
	r3 = D(r3, s0_1_2, 0xE116C7E4, 0xF701F2FB, 0xF3F504FE, 0xFEE9FBFC);
	r0 = D(r0, s0_2_0, 0x0102F7FF, 0xFF06F104, 0x000BE904, 0xFA02F010);
	r1 = D(r1, s0_2_0, 0x00010B0B, 0x05FCF30F, 0x02FEF20D, 0x00FCFF12);
	r2 = D(r2, s0_2_0, 0x0004F6EE, 0x81818181, 0x101681AE, 0x0002FB04);
	r3 = D(r3, s0_2_0, 0x0207010E, 0x000106E5, 0xFFFE07FD, 0x010AE6F2);
	r0 = D(r0, s0_2_1, 0xFBFDF203, 0xE8F2EFF3, 0xF5EDEEF2, 0x03FBEEEA);
	r1 = D(r1, s0_2_1, 0xFA0A050F, 0xF8130106, 0xFA07F70A, 0xFF0DFD0A);
	r2 = D(r2, s0_2_1, 0xF7F0F101, 0xF600EDEF, 0xB7068128, 0x0205F210);
	r3 = D(r3, s0_2_1, 0x0304F1EA, 0x0706F625, 0xFCF1F803, 0xECE0F2F1);
	r0 = D(r0, s0_2_2, 0x000BFDFE, 0x1505F8FF, 0x0514FB06, 0xFDFAFE00);
	r1 = D(r1, s0_2_2, 0x00060400, 0xFD1CFCFE, 0xF913FA04, 0x0E130B01);
	r2 = D(r2, s0_2_2, 0x0724FE04, 0x03D6FDFB, 0x1E0C00EE, 0xF304EFF6);
	r3 = D(r3, s0_2_2, 0x04B4FAFE, 0xF2EAEC0B, 0x03FE06FE, 0x01F1F8FA);
	r0 = D(r0, s1_0_0, 0xFFFF0103, 0x0202FDFC, 0x04FFFEFC, 0x0303FFFB);
	r1 = D(r1, s1_0_0, 0xF9FA09FB, 0xF60802FD, 0x02FB05FE, 0x03FB0100);
	r2 = D(r2, s1_0_0, 0xFCFD080A, 0x03FD04F6, 0x23E92CEF, 0x01FF02FF);
	r3 = D(r3, s1_0_0, 0x04FFFBFD, 0xFF0001FF, 0xFFFE09FC, 0xF9FF09FE);
	r0 = D(r0, s1_0_1, 0xFEFA1CFD, 0x030308F9, 0xFB0903F2, 0xFE0302FD);
	r1 = D(r1, s1_0_1, 0xF8FD1EF9, 0x220017FC, 0x0D1F150E, 0x161D2204);
	r2 = D(r2, s1_0_1, 0x02FB14F5, 0x0703F200, 0x0DE800E7, 0xFF04FFF4);
	r3 = D(r3, s1_0_1, 0x01EF09ED, 0xF3FEFCFD, 0xEFFD07FB, 0xFDF8FFF8);
	r0 = D(r0, s1_0_2, 0xFF05FDFD, 0xFF00FEFF, 0xFF020002, 0xFF0002FF);
	r1 = D(r1, s1_0_2, 0xF30200FF, 0x010A0000, 0x03FC00FF, 0x0305FB02);
	r2 = D(r2, s1_0_2, 0xEC010DFD, 0xFBFBFCFF, 0xF300FEFF, 0xF407FDFE);
	r3 = D(r3, s1_0_2, 0x02D912E0, 0xFF1132FA, 0xF4FBFFFD, 0xF9F702FA);
	r0 = D(r0, s1_1_0, 0xFC0505FB, 0xF7090502, 0xF4090404, 0xF3040600);
	r1 = D(r1, s1_1_0, 0xFF0DF118, 0x21FAFAF1, 0x161F0004, 0x0B27F3FE);
	r2 = D(r2, s1_1_0, 0xF60117F7, 0x0FF90202, 0xE62ADEF7, 0x0007FF01);
	r3 = D(r3, s1_1_0, 0x0B110702, 0x05E90100, 0xF6F213FE, 0xF20E100A);
	r0 = D(r0, s1_1_1, 0x18FE1D09, 0x060118FE, 0x32FC25FA, 0x060A11FA);
	r1 = D(r1, s1_1_1, 0xF7000203, 0xF13DFCF2, 0xFE4305FB, 0xFE19EBF2);
	r2 = D(r2, s1_1_1, 0x3C0B0E04, 0x140919FC, 0x3BFD6510, 0xFAEF0B07);
	r3 = D(r3, s1_1_1, 0xE33620E9, 0x10111BFB, 0x4407090F, 0x03114212);
	r0 = D(r0, s1_1_2, 0xF3030201, 0x020603FE, 0xF10A03F9, 0x00FEFB02);
	r1 = D(r1, s1_1_2, 0xFBFA0BFB, 0x1E000002, 0xFFFFFD00, 0x0FECFCFE);
	r2 = D(r2, s1_1_2, 0xF2EB03FD, 0xFBFBFF02, 0xE3F3EDEC, 0x1B1B19F2);
	r3 = D(r3, s1_1_2, 0xC03A2507, 0xE20225E6, 0xF5F906FD, 0xDFFF04FE);
	r0 = D(r0, s1_2_0, 0xFBFF0100, 0x040301F4, 0x0310FFF1, 0x0B0703F0);
	r1 = D(r1, s1_2_0, 0xFE0DFE02, 0xFD14FAF6, 0x030CFDFD, 0x000BFCFD);
	r2 = D(r2, s1_2_0, 0xF6F304FB, 0x81818181, 0xDE81CFA4, 0x020400FD);
	r3 = D(r3, s1_2_0, 0xFBFD05FC, 0x06F205FB, 0x06000005, 0xFAF807F8);
	r0 = D(r0, s1_2_1, 0x08F503FA, 0x0330FEEF, 0xF11CF9EF, 0xDA17F9F7);
	r1 = D(r1, s1_2_1, 0xFC01FC04, 0x130003FF, 0x01FA07FB, 0x04F7FB04);
	r2 = D(r2, s1_2_1, 0x06FF02FC, 0xE5090CF6, 0x230E33D9, 0x0417FFEE);
	r3 = D(r3, s1_2_1, 0x0ACF11D6, 0x0EF009EE, 0xFD0CFB0C, 0xF920FFF5);
	r0 = D(r0, s1_2_2, 0xFDFE0002, 0xF0F8FDF8, 0x01F501FC, 0x07FCFFFC);
	r1 = D(r1, s1_2_2, 0x050200FB, 0xFEFDFF00, 0xFEFA0102, 0x08F8FC05);
	r2 = D(r2, s1_2_2, 0xFDFA03FF, 0x0104FAFC, 0xDC03F5F9, 0xE800FFF3);
	r3 = D(r3, s1_2_2, 0x00F904E0, 0xDBDD0FF1, 0xFEF900FA, 0xF80001FB);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x02020303, 0xFEFDFE01, 0xFEFFFF01, 0xFEFBFF03);
	r1 = D(r1, s0_0_0, 0xFD02FE06, 0xFEF6F703, 0x07010204, 0x0004FDF5);
	r2 = D(r2, s0_0_0, 0x0AFF0301, 0x0507F2EE, 0x170EE5D7, 0xFFFF0000);
	r3 = D(r3, s0_0_0, 0x07FF06F8, 0x05040B01, 0x05FEF908, 0x0000FF04);
	r0 = D(r0, s0_0_1, 0xF900FEFC, 0xF5FDFFFD, 0xFEF5EB07, 0xF8FEFEFF);
	r1 = D(r1, s0_0_1, 0xFB00F90B, 0xF50A06E9, 0xF5F902E8, 0xE7F200F2);
	r2 = D(r2, s0_0_1, 0xE10305EE, 0x07FEF40F, 0x02230FF5, 0x02F8F901);
	r3 = D(r3, s0_0_1, 0xFB0C00F5, 0x0608FFEE, 0x0702EE1A, 0x0805FCFF);
	r0 = D(r0, s0_0_2, 0xFEFCFFFE, 0xFFFDFD08, 0x01FEF714, 0xFDFF0100);
	r1 = D(r1, s0_0_2, 0x0001F918, 0xF60303FE, 0xFD0605F7, 0xF5010710);
	r2 = D(r2, s0_0_2, 0xFC00F605, 0x05FDFA0C, 0x0DF6F221, 0xF9F9E91D);
	r3 = D(r3, s0_0_2, 0x0F10FBF0, 0xF1F0EDE2, 0x03FFF711, 0x050203FB);
	r0 = D(r0, s0_1_0, 0xFBFD01FF, 0x02F90701, 0x04FA0BF8, 0xFEF9080F);
	r1 = D(r1, s0_1_0, 0xFF00FDFD, 0xF3FDFAF1, 0xF0FBF0F0, 0xF900FAFE);
	r2 = D(r2, s0_1_0, 0x02FF0B08, 0xFA0FEDD5, 0x08F0DE9A, 0xFFFC04FB);
	r3 = D(r3, s0_1_0, 0xFB01FFF9, 0xFB0B0A00, 0x0F00080B, 0x09F603F3);
	r0 = D(r0, s0_1_1, 0xF4F7F90E, 0xE9000749, 0xB6FF1F36, 0xE5FB0948);
	r1 = D(r1, s0_1_1, 0xF604FE05, 0xD9D4DF20, 0xF1E9FC0F, 0xE8F0081E);
	r2 = D(r2, s0_1_1, 0xBBE3E2E9, 0xC8F41011, 0xC2320012, 0xF7051313);
	r3 = D(r3, s0_1_1, 0xF6F10A09, 0xFFE1DAE6, 0xDF0D0408, 0xE300F20E);
	r0 = D(r0, s0_1_2, 0xFCFFFAF3, 0xFEF80506, 0xF0F70EFA, 0x05000301);
	r1 = D(r1, s0_1_2, 0xF903FF07, 0x03FF0BF2, 0x0600FBFF, 0x09F905EB);
	r2 = D(r2, s0_1_2, 0xFC0BFD04, 0x01030305, 0x14EEF915, 0xA5ED2620);
	r3 = D(r3, s0_1_2, 0xAFD6ED3E, 0xCFBBEC07, 0xF6000615, 0x010100FB);
	r0 = D(r0, s0_2_0, 0x05FB02FF, 0x020201FC, 0x0003FEFE, 0xFFF4FFF9);
	r1 = D(r1, s0_2_0, 0x020700FE, 0xF60406FC, 0xFB0203FD, 0xFC00FFF9);
	r2 = D(r2, s0_2_0, 0x06F50304, 0x81BB8181, 0x81D0C7F9, 0x0103FFFF);
	r3 = D(r3, s0_2_0, 0xF90F0F00, 0x00FA08FB, 0x01FBFE03, 0x04080404);
	r0 = D(r0, s0_2_1, 0xFDF5F7FD, 0xF4C3EBFF, 0x00050307, 0xFFF3ED05);
	r1 = D(r1, s0_2_1, 0xFEFDFE02, 0xF6F60403, 0xF6010301, 0x02F508FE);
	r2 = D(r2, s0_2_1, 0x0002F8F5, 0xFA06F001, 0xAE030321, 0xFA0303FD);
	r3 = D(r3, s0_2_1, 0xF4130401, 0x0704F0F4, 0x01E7FEFE, 0x0712F7F8);
	r0 = D(r0, s0_2_2, 0x0401FEFD, 0x040301FC, 0xFCFFFCFF, 0x00FB00FC);
	r1 = D(r1, s0_2_2, 0xFD00FF01, 0x01FF02FF, 0xFF0301FE, 0x0607F9FE);
	r2 = D(r2, s0_2_2, 0x0104FF00, 0x0DFC01F9, 0x1AF91CEA, 0x0007FD06);
	r3 = D(r3, s0_2_2, 0xFA170EF0, 0xE8EBE7FA, 0x0203FEFF, 0x040400FA);
	r0 = D(r0, s1_0_0, 0x02020300, 0x01040001, 0x0004FFFF, 0xFB070505);
	r1 = D(r1, s1_0_0, 0xFCFD0704, 0x060E04F5, 0xEAF40DFC, 0xFDF707F4);
	r2 = D(r2, s1_0_0, 0xFB010209, 0x01FEF615, 0xE90325FD, 0x0101FFFF);
	r3 = D(r3, s1_0_0, 0xF6011301, 0x0604FD12, 0xF803060E, 0xF7010EFD);
	r0 = D(r0, s1_0_1, 0xFBFF09F5, 0x0008FA05, 0xFB0BF20C, 0x0105F8FF);
	r1 = D(r1, s1_0_1, 0xF9FA0CF9, 0xF1EA0901, 0xEAEA1902, 0xE8F10703);
	r2 = D(r2, s1_0_1, 0xF5F10C01, 0xFF03F506, 0xE3E7EA04, 0xFB08010E);
	r3 = D(r3, s1_0_1, 0xFBE619DF, 0x0EF002F0, 0xF3FC0304, 0xF4EF08FC);
	r0 = D(r0, s1_0_2, 0xF9FEFFFF, 0xFF020001, 0x0102FD01, 0xFF010101);
	r1 = D(r1, s1_0_2, 0x0301F902, 0x01FFFBFA, 0xF707FFEB, 0x0205F2FE);
	r2 = D(r2, s1_0_2, 0x08FFFFFE, 0x08FFF302, 0x1811EFFD, 0x080AEE02);
	r3 = D(r3, s1_0_2, 0xF2F40DE7, 0xEA011CFD, 0xFF0302FF, 0xFF0102FD);
	r0 = D(r0, s1_1_0, 0x04070304, 0x030808FE, 0x02081300, 0x07030FFA);
	r1 = D(r1, s1_1_0, 0xFFFCFC00, 0xF7EFDEF4, 0xF7ECDCFA, 0xF1FDE605);
	r2 = D(r2, s1_1_0, 0x050B1A0B, 0xEFD119EF, 0xD48130B3, 0x00040902);
	r3 = D(r3, s1_1_0, 0x05FFFF0B, 0x0A050C02, 0x01F50807, 0xF4020004);
	r0 = D(r0, s1_1_1, 0xF9F801FC, 0xEAF31CF3, 0xF5C630E5, 0xECF709FA);
	r1 = D(r1, s1_1_1, 0x0B080E04, 0xECC41D08, 0xE6ED240C, 0x03002B00);
	r2 = D(r2, s1_1_1, 0x10D704E7, 0xD3D22406, 0xE4EF26E4, 0x23EC12F2);
	r3 = D(r3, s1_1_1, 0xF6F3E316, 0xF5D9DDD8, 0xFDF8FAF6, 0x08F601FE);
	r0 = D(r0, s1_1_2, 0xFA000C03, 0x0001FEFD, 0xF6F101F8, 0x0202FF00);
	r1 = D(r1, s1_1_2, 0xF4F60A05, 0xFE0BFBEE, 0xFC0604F8, 0xF40507F6);
	r2 = D(r2, s1_1_2, 0xF7EA0608, 0xFE04FCFD, 0xFB000B09, 0xCFD521EF);
	r3 = D(r3, s1_1_2, 0x1688EE24, 0xC6BE4E24, 0xF0F81200, 0xFDF50603);
	r0 = D(r0, s1_2_0, 0x030102FF, 0xF802FFFF, 0x0400FAFC, 0xF5F4E907);
	r1 = D(r1, s1_2_0, 0x00FCFC06, 0xFB01F6F8, 0xF706FEF1, 0xFB03F900);
	r2 = D(r2, s1_2_0, 0x05030AFF, 0x9A816781, 0xC9814BE1, 0x04010100);
	r3 = D(r3, s1_2_0, 0xFC0304FC, 0x0A001301, 0xFFFCFD01, 0x0B021501);
	r0 = D(r0, s1_2_1, 0xF9FDFFFF, 0x14D1E203, 0xE4E2F907, 0x19D806FF);
	r1 = D(r1, s1_2_1, 0x05F9FA06, 0xFA0DF6F1, 0xE90605F8, 0x04FEF801);
	r2 = D(r2, s1_2_1, 0xFBFB07F4, 0x0CDC1713, 0x92B811C6, 0xEAFDF203);
	r3 = D(r3, s1_2_1, 0x0AFE1AEC, 0x0503ECFC, 0xF407F105, 0xFFF407FE);
	r0 = D(r0, s1_2_2, 0xFA0000FE, 0x01EE0204, 0x0AFE0206, 0xFC0404FD);
	r1 = D(r1, s1_2_2, 0xF8FE0200, 0xFD010308, 0xF80603FA, 0x02F9070B);
	r2 = D(r2, s1_2_2, 0xFFFBFD05, 0x02010401, 0x06F6181D, 0x14EAFE05);
	r3 = D(r3, s1_2_2, 0xE5010BEE, 0xF4D52A03, 0xFF000204, 0x03FAFEFD);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.039e-02, -1.547e-02, -1.366e-02, -1.254e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-6.905e-03, -1.615e-02, -1.581e-02, -1.992e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-1.083e-02, -1.205e-02, -1.368e-02, -1.161e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 1), f2);
	f3 = vec4(r3) * 6.2000124e-05;
	f3 += vec4(-4.031e-03, -1.481e-02, -5.447e-03, -7.707e-03);
	f3 = max(f3, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 1), f3);
}

//!DESC [CuNNy_4x16_DS_vk] -out-shuffle
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
	r0 += M4(-2.814e-02, -1.849e-02, 1.215e-02, -5.896e-03, -4.868e-02, 2.733e-02, 7.804e-03, 2.761e-03, 8.661e-03, 1.192e-04, -1.788e-02, 3.209e-03, 2.238e-02, -8.005e-03, 1.359e-02, -6.296e-03) * s0_0_0;
	r0 += M4(1.099e-02, 6.230e-03, -6.192e-03, -1.019e-02, 1.033e-01, -4.826e-01, 1.481e-02, 1.401e-01, 2.677e-02, 1.323e-01, -1.874e-02, -6.463e-03, -3.818e-01, 1.763e-01, -2.667e-02, -1.343e-01) * s0_0_1;
	r0 += M4(-1.954e-03, 4.139e-03, 1.785e-04, 1.661e-03, -4.084e-03, 5.481e-02, -8.342e-04, 7.203e-03, -1.150e-03, -7.845e-03, -5.080e-03, 1.420e-02, 1.866e-02, -7.887e-02, 1.971e-02, 9.119e-03) * s0_0_2;
	r0 += M4(-2.705e-01, -4.864e-03, -1.959e-01, -2.069e-02, -7.970e-03, -1.873e-02, 4.079e-02, -7.214e-03, 5.456e-02, -1.775e-03, 2.574e-02, -2.094e-02, -1.821e-02, 1.621e-02, -5.967e-03, 9.153e-03) * s0_1_0;
	r0 += M4(9.441e-02, 2.264e-01, 8.618e-02, 1.577e-01, -7.105e-02, 3.772e-02, 3.163e-02, 2.056e-01, 2.867e-02, 2.075e-01, 7.918e-02, -4.818e-01, 7.202e-02, -3.704e-02, 2.466e-01, 1.140e-01) * s0_1_1;
	r0 += M4(1.573e-03, 1.291e-02, -1.382e-03, 1.092e-02, -8.521e-03, -2.192e-02, 5.607e-03, 6.490e-03, -1.633e-03, 2.572e-03, -7.514e-03, -2.205e-02, 2.148e-02, 1.434e-02, -5.710e-03, -7.124e-04) * s0_1_2;
	r0 += M4(-1.323e-02, 1.149e-02, -1.243e-01, 1.274e-02, -1.349e-03, 7.645e-04, -6.541e-03, -1.819e-03, -1.151e-02, 3.163e-03, -5.403e-03, 4.700e-03, -3.422e-03, 2.155e-03, -1.388e-03, 1.637e-03) * s0_2_0;
	r0 += M4(-1.372e-02, -2.179e-02, 8.528e-03, 6.662e-02, -2.494e-03, -6.088e-03, -1.824e-02, -9.064e-03, -1.540e-02, -1.047e-02, -1.193e-02, 5.419e-02, 4.159e-03, -1.216e-03, 4.946e-03, -7.309e-03) * s0_2_1;
	r0 += M4(7.787e-04, 2.790e-03, 2.334e-04, 6.541e-03, 2.022e-03, 4.045e-04, 7.877e-04, -5.698e-03, -7.618e-04, -6.354e-04, 3.398e-03, 9.893e-03, -2.256e-03, 6.416e-04, -1.402e-04, -1.831e-03) * s0_2_2;
	r0 += M4(2.558e-02, 9.330e-03, 6.461e-03, -2.360e-04, 3.560e-03, -7.833e-04, 2.016e-03, 1.788e-03, 8.120e-03, -5.142e-03, -9.906e-04, -2.448e-03, -1.654e-02, 4.119e-03, -2.511e-03, 3.398e-03) * s1_0_0;
	r0 += M4(-1.581e-03, 6.067e-03, 2.386e-02, 1.686e-02, 6.802e-02, -2.892e-03, 2.301e-03, -8.155e-03, 3.822e-02, 3.284e-02, 1.374e-03, 4.884e-03, -3.128e-02, -3.324e-02, -1.254e-02, -1.509e-02) * s1_0_1;
	r0 += M4(3.656e-03, 8.374e-03, -1.546e-03, 4.048e-03, -9.904e-04, -2.192e-03, 3.653e-03, 2.483e-03, 1.090e-02, 2.789e-02, 7.358e-04, -1.205e-03, -1.953e-03, -1.924e-02, -3.349e-03, 7.099e-04) * s1_0_2;
	r0 += M4(1.008e-01, 3.431e-02, 6.861e-02, 3.424e-02, 4.941e-02, -4.361e-03, 9.496e-03, -3.804e-04, 4.798e-02, 1.779e-03, 3.503e-02, -6.087e-03, -7.788e-02, -1.480e-02, -6.365e-02, 1.053e-03) * s1_1_0;
	r0 += M4(-1.698e-01, -5.823e-02, -1.489e-01, -7.788e-02, -3.246e-01, 3.335e-02, 1.065e-01, 1.665e-01, -6.806e-02, 7.007e-02, 6.762e-02, 1.010e-01, 1.811e-01, 1.211e-01, -9.642e-03, -1.254e-01) * s1_1_1;
	r0 += M4(-8.058e-04, -6.005e-02, 2.788e-03, -3.333e-02, 1.812e-02, 1.860e-02, 2.526e-02, -7.886e-02, 4.913e-03, -1.184e-01, 1.557e-02, 1.082e-02, 4.674e-03, -1.250e-02, -3.576e-03, -2.822e-02) * s1_1_2;
	r0 += M4(2.240e-02, -1.756e-02, 6.909e-02, -9.369e-03, 7.622e-03, -2.187e-03, 1.794e-02, -8.046e-03, 1.151e-02, -7.112e-03, 2.905e-02, -4.333e-03, 6.534e-03, -2.962e-02, 1.960e-02, -2.124e-02) * s1_2_0;
	r0 += M4(1.545e-02, 4.759e-02, -2.533e-02, 5.316e-02, 7.349e-02, 5.513e-03, 2.363e-02, -1.431e-01, -3.530e-02, 2.156e-02, -1.587e-01, 1.954e-02, -6.115e-02, -1.053e-01, -8.154e-02, 1.672e-01) * s1_2_1;
	r0 += M4(-9.889e-04, 1.129e-02, 2.807e-03, -1.023e-02, -9.209e-03, 1.443e-03, -9.951e-05, 8.369e-02, 1.407e-02, -3.889e-03, 1.480e-02, -9.776e-02, -3.584e-03, 4.327e-03, -3.976e-03, -2.209e-02) * s1_2_2;
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2]; s1_0_0 = G[3][xy.y+0][xy.x+0];
	s1_0_1 = G[3][xy.y+0][xy.x+1]; s1_0_2 = G[3][xy.y+0][xy.x+2];
	s1_1_0 = G[3][xy.y+1][xy.x+0]; s1_1_1 = G[3][xy.y+1][xy.x+1];
	s1_1_2 = G[3][xy.y+1][xy.x+2]; s1_2_0 = G[3][xy.y+2][xy.x+0];
	s1_2_1 = G[3][xy.y+2][xy.x+1]; s1_2_2 = G[3][xy.y+2][xy.x+2];
	r0 += M4(1.909e-02, -2.455e-03, -1.522e-03, -9.529e-03, 6.917e-03, -3.554e-03, 7.285e-04, -4.012e-03, -9.840e-04, 5.970e-03, -4.867e-03, 5.089e-03, 8.227e-02, -1.849e-02, 4.549e-02, 2.324e-02) * s0_0_0;
	r0 += M4(3.305e-02, -2.131e-02, -1.813e-02, 3.564e-03, -3.291e-01, 1.287e-01, 2.774e-02, 9.011e-02, 1.733e-01, -1.111e-01, 7.578e-02, -5.761e-02, -9.760e-03, 3.046e-02, 1.397e-04, -1.860e-02) * s0_0_1;
	r0 += M4(-8.246e-04, 8.224e-03, 2.702e-03, 9.611e-03, 8.924e-02, -8.088e-02, -7.833e-02, -1.306e-01, -1.174e-01, 7.542e-02, -8.572e-02, 8.380e-03, 1.260e-03, -6.911e-03, -8.505e-04, -2.298e-03) * s0_0_2;
	r0 += M4(1.201e-01, -9.746e-03, 9.554e-02, 6.641e-03, -8.430e-03, -6.493e-03, 9.408e-03, 3.991e-04, 1.418e-03, 1.335e-03, -2.027e-03, 2.318e-03, 2.152e-01, 7.495e-02, -5.254e-01, 5.302e-02) * s0_1_0;
	r0 += M4(2.009e-01, -4.092e-01, 1.929e-01, -2.310e-01, 1.350e-01, 2.635e-01, -9.500e-01, 1.866e-01, 4.633e-02, -3.308e-02, 1.107e-01, -7.817e-02, 9.867e-03, 3.259e-02, 1.851e-03, 2.069e-02) * s0_1_1;
	r0 += M4(-9.794e-03, 2.958e-02, -1.295e-02, 1.260e-02, 1.820e-01, 1.529e-01, 2.032e-02, -6.743e-01, -6.517e-02, 1.588e-02, -7.981e-02, 1.023e-01, 1.629e-03, 2.946e-03, -5.723e-03, -1.113e-02) * s0_1_2;
	r0 += M4(2.059e-02, -5.930e-03, 7.397e-02, -1.039e-02, -2.021e-02, 5.051e-03, -2.734e-02, -9.776e-04, -1.074e-03, 3.635e-03, 4.085e-03, 3.477e-03, -2.934e-03, -1.381e-02, 7.202e-02, 4.396e-03) * s0_2_0;
	r0 += M4(1.492e-02, 1.148e-02, 7.127e-02, -1.759e-01, -1.072e-02, -4.446e-03, 1.281e-01, 8.586e-02, 4.776e-03, -3.172e-03, 1.452e-02, -6.332e-03, 5.357e-03, -1.422e-04, 4.098e-03, -1.060e-02) * s0_2_1;
	r0 += M4(1.882e-03, 9.042e-03, -1.600e-03, 2.478e-02, 1.902e-02, 1.188e-02, -7.911e-03, 9.466e-04, -2.775e-03, 1.776e-02, -2.869e-02, -2.114e-03, -1.520e-03, -5.348e-04, 1.595e-03, 4.587e-03) * s0_2_2;
	r0 += M4(-1.259e-02, 7.323e-03, -2.581e-02, -2.243e-02, -1.160e-01, 8.414e-02, -1.728e-02, 4.613e-03, -4.612e-02, 2.571e-03, -2.653e-03, 5.750e-04, 2.814e-02, 1.340e-02, 1.313e-02, 1.814e-02) * s1_0_0;
	r0 += M4(-8.670e-03, -7.128e-03, -1.736e-03, -5.452e-03, 8.207e-03, 2.229e-02, 4.988e-03, -2.234e-03, -4.064e-02, -1.140e-01, -1.471e-02, -1.445e-02, 1.333e-01, 1.017e-01, 2.607e-02, 3.381e-02) * s1_0_1;
	r0 += M4(-8.271e-04, -5.407e-03, -1.324e-03, -8.310e-04, -1.073e-03, -2.789e-03, -7.147e-04, -2.830e-03, 3.539e-03, 2.250e-02, 5.522e-04, 5.641e-03, -2.224e-03, 4.431e-02, -8.634e-04, 4.955e-04) * s1_0_2;
	r0 += M4(-2.319e-01, -1.321e-01, 2.270e-01, 1.304e-01, -1.460e-01, 1.752e-01, -2.368e-01, 2.055e-01, -1.923e-02, 1.910e-02, -7.542e-02, 1.351e-03, -7.496e-02, 1.791e-03, -6.860e-02, 1.084e-02) * s1_1_0;
	r0 += M4(-9.483e-06, -6.568e-02, -1.052e-02, 8.716e-02, 6.977e-03, 2.305e-03, 8.462e-03, 3.999e-02, 9.445e-02, 1.064e-03, 1.401e-02, -1.521e-01, -8.130e-02, -1.762e-01, 9.422e-02, -5.537e-02) * s1_1_1;
	r0 += M4(-1.930e-03, -6.185e-03, 5.296e-04, -7.462e-03, -1.095e-03, -6.365e-03, 1.177e-03, -7.091e-03, 1.087e-02, 5.958e-02, 1.541e-02, 7.250e-02, 5.006e-04, 1.647e-02, 5.726e-03, 4.602e-02) * s1_1_2;
	r0 += M4(1.642e-02, 9.431e-03, -1.293e-02, 5.930e-03, 8.482e-03, -1.096e-02, -4.228e-04, 3.806e-02, -2.216e-03, 1.912e-04, 1.337e-02, 1.798e-02, 4.170e-03, -7.187e-04, -1.316e-02, -4.025e-03) * s1_2_0;
	r0 += M4(8.402e-03, 3.405e-03, 6.909e-03, -4.964e-03, 3.751e-03, 2.087e-03, 1.440e-03, -1.020e-02, 6.639e-03, 7.429e-03, 5.505e-02, 4.870e-02, 1.250e-02, 9.916e-03, -2.690e-02, -4.724e-02) * s1_2_1;
	r0 += M4(-2.093e-03, 6.824e-03, -2.201e-03, 5.906e-03, -5.140e-04, 3.973e-03, -2.864e-03, 2.391e-03, -4.240e-04, -1.736e-03, -4.198e-03, 1.077e-02, -8.495e-03, -9.189e-03, -3.661e-03, 2.844e-05) * s1_2_2;
	r0 += V4(-6.885e-05, -5.971e-05, -7.500e-05, -5.541e-05);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
