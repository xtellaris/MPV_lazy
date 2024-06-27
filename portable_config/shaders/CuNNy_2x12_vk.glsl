// CuNNy 2x12
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


//!DESC [CuNNy_2x12_vk] -in
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
	r0 += V4(1.228e-02, -1.133e-01, -2.986e-02, 4.364e-04) * s0_0_0;
	r1 += V4(-6.615e-01, 5.000e-03, -2.008e-01, 2.753e-02) * s0_0_0;
	r2 += V4(3.324e-01, 8.807e-03, -1.101e-03, 1.812e-01) * s0_0_0;
	r0 += V4(-1.217e-02, -2.378e-01, 1.460e-01, -4.317e-03) * s0_0_1;
	r1 += V4(7.520e-01, 3.656e-02, 2.095e-01, -3.173e-02) * s0_0_1;
	r2 += V4(-8.349e-02, 1.019e-01, 4.051e-02, -2.979e-01) * s0_0_1;
	r0 += V4(-6.734e-03, -9.601e-02, -2.881e-02, 5.345e-03) * s0_0_2;
	r1 += V4(-9.058e-02, -3.155e-02, 2.199e-01, -3.553e-03) * s0_0_2;
	r2 += V4(-1.878e-01, 6.927e-02, -5.115e-02, -2.924e-01) * s0_0_2;
	r0 += V4(-1.171e-02, 5.094e-01, 6.763e-02, 8.262e-01) * s0_1_0;
	r1 += V4(-1.429e-01, -6.734e-03, 9.402e-02, -8.697e-02) * s0_1_0;
	r2 += V4(5.048e-01, 3.844e-01, -6.518e-02, 1.920e-01) * s0_1_0;
	r0 += V4(-8.379e-01, -2.032e-01, -7.207e-01, -8.109e-01) * s0_1_1;
	r1 += V4(7.152e-02, 6.916e-02, 5.959e-01, 8.322e-01) * s0_1_1;
	r2 += V4(-5.176e-01, -1.116e+00, -1.292e-01, 3.328e-01) * s0_1_1;
	r0 += V4(2.611e-02, 1.109e-01, 1.401e-01, -1.470e-02) * s0_1_2;
	r1 += V4(9.149e-02, -6.658e-01, -4.903e-01, 5.042e-02) * s0_1_2;
	r2 += V4(-3.341e-02, 4.474e-02, -5.605e-01, -4.385e-01) * s0_1_2;
	r0 += V4(-2.539e-04, 9.196e-02, -2.845e-03, -1.086e-02) * s0_2_0;
	r1 += V4(2.723e-02, 7.420e-03, 1.170e-01, -1.023e-02) * s0_2_0;
	r2 += V4(-1.753e-01, 5.797e-02, 7.734e-02, -2.477e-01) * s0_2_0;
	r0 += V4(8.465e-01, -4.212e-02, -2.101e-02, 3.470e-03) * s0_2_1;
	r1 += V4(-3.190e-02, -1.177e-01, -2.390e-01, -7.324e-01) * s0_2_1;
	r2 += V4(-8.428e-02, 1.264e-01, 4.557e-02, 3.097e-01) * s0_2_1;
	r0 += V4(-1.753e-02, -8.298e-02, -6.123e-02, 8.114e-03) * s0_2_2;
	r1 += V4(-1.271e-02, 7.151e-01, -3.072e-01, -3.876e-02) * s0_2_2;
	r2 += V4(2.485e-01, 5.053e-02, 6.482e-01, 2.606e-01) * s0_2_2;
	r0 += V4(-2.582e-04, 1.013e-01, 5.488e-01, -2.073e-04);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(-1.363e-04, -5.457e-02, 4.150e-03, -6.477e-04);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(-4.121e-03, 3.954e-03, 3.899e-02, 4.100e-03);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), vec4(r2));
}

//!DESC [CuNNy_2x12_vk] -conv1
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
	r0 = D(r0, s0_0_0, 0x083CF90C, 0x011F04F8, 0xC2171905, 0x1507F309);
	r1 = D(r1, s0_0_0, 0xB7F71C0D, 0x11E0F8FD, 0x01F30902, 0x19FAFB1B);
	r2 = D(r2, s0_0_0, 0x02DFFFF7, 0xC3532B02, 0xFC0401DA, 0xF2010407);
	r0 = D(r0, s0_0_1, 0x3CCD0C40, 0xFEEB132A, 0xDCE8217F, 0x330108E7);
	r1 = D(r1, s0_0_1, 0xA24B3A0B, 0xB64D2081, 0xCD2FFAFD, 0x36F80213);
	r2 = D(r2, s0_0_1, 0xA61016E3, 0x8FB7493B, 0xF8BEFD03, 0xE4E01726);
	r0 = D(r0, s0_0_2, 0x23ECFA05, 0x0FF805B1, 0x07F8F412, 0x15F6FD2D);
	r1 = D(r1, s0_0_2, 0xC4A53A7F, 0x12C6091C, 0xFAF3F0E8, 0x350FEF0C);
	r2 = D(r2, s0_0_2, 0xE10E0BB5, 0xEBD82B5A, 0xE13ADB06, 0xF00E0CF7);
	r0 = D(r0, s0_1_0, 0x3AF2EC2B, 0x2845FA27, 0xF5581B33, 0xF7F416DC);
	r1 = D(r1, s0_1_0, 0xEC281935, 0xDDFD0D02, 0x43D8F442, 0x10FF07FA);
	r2 = D(r2, s0_1_0, 0x2500E527, 0xC7262031, 0xDCED07EB, 0x09D9082F);
	r0 = D(r0, s0_1_1, 0xCDF6F681, 0x1E8106F4, 0x2D9E0A2E, 0x3BB80254);
	r1 = D(r1, s0_1_1, 0x25CE07EE, 0x81F10F81, 0x3481F7E0, 0x0BEDEBD6);
	r2 = D(r2, s0_1_1, 0x321EFE5E, 0x9C012C6B, 0x223A026F, 0x39392132);
	r0 = D(r0, s0_1_2, 0x812A2881, 0xCA2B08D6, 0x11012BE9, 0x34D0FD1A);
	r1 = D(r1, s0_1_2, 0x37FF412D, 0xD417F434, 0x0208E413, 0x7FE0FD30);
	r2 = D(r2, s0_1_2, 0xFEF4F2D4, 0xD8E933F1, 0x43E5FA14, 0xAC00F781);
	r0 = D(r0, s0_2_0, 0x2438E903, 0x1635E802, 0x0820F0FE, 0xD3042998);
	r1 = D(r1, s0_2_0, 0x20E5C7FC, 0x1119F00F, 0x113FF9FA, 0xEC060DEB);
	r2 = D(r2, s0_2_0, 0x1B2AFA0F, 0xF5E5C6FA, 0xF80613FB, 0x2429DB0E);
	r0 = D(r0, s0_2_1, 0xF4B43BDB, 0x2BCF041A, 0xF4E5F50F, 0x813E3981);
	r1 = D(r1, s0_2_1, 0x2106A40C, 0x05C70213, 0x1B37F012, 0xF12408E1);
	r2 = D(r2, s0_2_1, 0x28C60616, 0xE0E6A810, 0x0B1310EF, 0xF5D608F2);
	r0 = D(r0, s0_2_2, 0x9CFC31C7, 0x010215E5, 0xDB04E8F5, 0xEF3017F4);
	r1 = D(r1, s0_2_2, 0xD530F2DC, 0x1820FB24, 0xF6171A05, 0x110B0AEB);
	r2 = D(r2, s0_2_2, 0x2703001A, 0xC239C0D9, 0x0EE3F1F4, 0xB6FB09D6);
	r0 = D(r0, s1_0_0, 0x2D0F3403, 0xF2F6F90B, 0xEA2CFDF3, 0x02FFFDFC);
	r1 = D(r1, s1_0_0, 0xD62C1FF3, 0x0EFD7F04, 0x1700F103, 0xFBF63307);
	r2 = D(r2, s1_0_0, 0x19FE0008, 0xFF5E2CE1, 0x0911FCFA, 0x0B171BF9);
	r0 = D(r0, s1_0_1, 0xBF090A1E, 0xD3092B00, 0xDE13E6FB, 0x1AFFF104);
	r1 = D(r1, s1_0_1, 0xFF23DCF1, 0x810CEEF2, 0xA20914FB, 0x03F9CD00);
	r2 = D(r2, s1_0_1, 0xE20C02FA, 0xCB24A4FC, 0x5F07E901, 0x2114F60D);
	r0 = D(r0, s1_0_2, 0x08F500F4, 0x0FFCFB03, 0xEF050401, 0x0B05F703);
	r1 = D(r1, s1_0_2, 0x0B2420F5, 0xE4050505, 0xFFFD01F2, 0x25FD00FB);
	r2 = D(r2, s1_0_2, 0xF8FF0209, 0xD0120D01, 0x25FC1802, 0x01011909);
	r0 = D(r0, s1_1_0, 0xE439D100, 0xE8F3E003, 0xEA06EB11, 0xD4EED9F6);
	r1 = D(r1, s1_1_0, 0x00D70A14, 0xF4FDEBF2, 0xEEDD2514, 0xF9FEFBF5);
	r2 = D(r2, s1_1_0, 0x09E015FE, 0xAF700600, 0x0606F0FF, 0x0DFFE909);
	r0 = D(r0, s1_1_1, 0xF21920C5, 0x2BF2151D, 0xED1A1A1B, 0x81F6FCF9);
	r1 = D(r1, s1_1_1, 0x18EE0F26, 0x2D0DE73A, 0x39E4DD1B, 0x2509EEE9);
	r2 = D(r2, s1_1_1, 0xEDFB0748, 0x813DFDF7, 0xE2F3FBFF, 0xBF0A3B13);
	r0 = D(r0, s1_1_2, 0xF700FA18, 0xFC0301DC, 0x05170706, 0xE50108FE);
	r1 = D(r1, s1_1_2, 0xF10FD7CF, 0xE4FE0DBD, 0x1600F3C3, 0xFAF1F8FE);
	r2 = D(r2, s1_1_2, 0x280BF6F3, 0xBF28F9FC, 0x27F60631, 0x290B000B);
	r0 = D(r0, s1_2_0, 0x00092305, 0x0306F0F9, 0x07090D01, 0x1EE82F13);
	r1 = D(r1, s1_2_0, 0xF725F2FB, 0xFB03F30D, 0x0900FEE7, 0x0900FC06);
	r2 = D(r2, s1_2_0, 0x09F2E3F5, 0xE9422B21, 0x04F5FB09, 0xF90E1DFE);
	r0 = D(r0, s1_2_1, 0x04C91B44, 0xF403030F, 0xE712FD06, 0xF5121F0A);
	r1 = D(r1, s1_2_1, 0xE9260BE5, 0x01F6ECEA, 0xECF8F7F5, 0xF8FEFE19);
	r2 = D(r2, s1_2_1, 0x0CEC06D6, 0xD53306DD, 0x09F807FE, 0x12EA06ED);
	r0 = D(r0, s1_2_2, 0x1CF2F4B7, 0x0AFB02D0, 0x01041003, 0xDC061705);
	r1 = D(r1, s1_2_2, 0xF01AF8CC, 0x051015D2, 0x03000881, 0xF802FDEE);
	r2 = D(r2, s1_2_2, 0x11F011D9, 0xF61FFB0E, 0x05F4031F, 0xF90B1300);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x06DF0608, 0xF0EBFE03, 0xEACF2C1D, 0x0600F901);
	r1 = D(r1, s0_0_0, 0xB9EA0348, 0xF13CF406, 0x09080402, 0xFBF6F6F5);
	r2 = D(r2, s0_0_0, 0xF0C5F012, 0xB081E244, 0x05021AF4, 0xE7D4FF21);
	r0 = D(r0, s0_0_1, 0xDE2CDDF1, 0xF520EB19, 0xE81E0022, 0x09D3F1F5);
	r1 = D(r1, s0_0_1, 0xD4B9CC4E, 0xF5FC0207, 0x010A0312, 0x16FDF1E3);
	r2 = D(r2, s0_0_1, 0xF62D0922, 0xCE29F559, 0x181007ED, 0xEE1EF92D);
	r0 = D(r0, s0_0_2, 0x1DD710DC, 0xFC0D08F2, 0xFAFBF10D, 0xFD1F0404);
	r1 = D(r1, s0_0_2, 0xDCF1EC08, 0xF8FF16FE, 0x08FA0BF6, 0x040DFBFE);
	r2 = D(r2, s0_0_2, 0xFB0408F6, 0xDAEEF102, 0x0EECFCF0, 0xFCEB0DE7);
	r0 = D(r0, s0_1_0, 0x0906DDE6, 0xF9E4CD01, 0xE9F8E027, 0xF9F3D5DC);
	r1 = D(r1, s0_1_0, 0xE211E02A, 0x03130C15, 0xFFFCBBE0, 0x0B01E8EA);
	r2 = D(r2, s0_1_0, 0x0F0EEDEF, 0xC8D1F23E, 0x0108110D, 0xE6E5D4FE);
	r0 = D(r0, s0_1_1, 0x05292F24, 0xF826810C, 0xD118E820, 0xE700D3DA);
	r1 = D(r1, s0_1_1, 0xD207892A, 0xF7117F27, 0x19F2EFF6, 0xFFDF00DA);
	r2 = D(r2, s0_1_1, 0x17191A19, 0xA565F54C, 0xF2E8D3E7, 0xF648061F);
	r0 = D(r0, s0_1_2, 0xF4FFFE0C, 0x0AFC1AFF, 0xF608ED13, 0xFBFB03EF);
	r1 = D(r1, s0_1_2, 0xE03FC327, 0xFBF8E81B, 0x0219FB0B, 0x0CF5E5EE);
	r2 = D(r2, s0_1_2, 0xFE00132C, 0xEA17F011, 0x17F1EAFC, 0x0409F80A);
	r0 = D(r0, s0_2_0, 0x0B08E2ED, 0xE6F2F9EC, 0xE8F2F6FB, 0x160C4E08);
	r1 = D(r1, s0_2_0, 0xD0050306, 0xF1FCF604, 0xF61203EA, 0x122A1205);
	r2 = D(r2, s0_2_0, 0xE7F0EDF6, 0xE0D5132B, 0x010B0306, 0xEEEBE9F8);
	r0 = D(r0, s0_2_1, 0x1606FB10, 0x041B09F1, 0xEC170A14, 0x011975C6);
	r1 = D(r1, s0_2_1, 0xC94524E9, 0xFBEBFA18, 0xFAF7F5F1, 0xFD1A15F1);
	r2 = D(r2, s0_2_1, 0x00E7EAE1, 0xD73C0B40, 0x010613ED, 0x12320A11);
	r0 = D(r0, s0_2_2, 0xFF082230, 0xFC000500, 0xEAFDFE07, 0xFCF714FC);
	r1 = D(r1, s0_2_2, 0xDC172B09, 0xFDF10213, 0x020002F0, 0x04FF0BF4);
	r2 = D(r2, s0_2_2, 0x0EF6FFD6, 0xCA0CF83A, 0x03F507F2, 0xE1FC100C);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-1.418e-02, -2.284e-02, -2.098e-02, -2.612e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-5.359e-02, -2.153e-05, 9.277e-03, -1.480e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(7.103e-03, -7.697e-03, 3.689e-03, -2.447e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_2x12_vk] -conv2
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
	r0 = D(r0, s0_0_0, 0x130600F9, 0x0FFFFEFC, 0x0BFBFF05, 0xFD0AFFF7);
	r1 = D(r1, s0_0_0, 0x140201FA, 0x17FE0A01, 0x0D00FC02, 0xDB17E0EA);
	r2 = D(r2, s0_0_0, 0x22E520F9, 0x0F0AFCF9, 0x0802FFFB, 0x1001F400);
	r0 = D(r0, s0_0_1, 0xB90107F4, 0xF0FAEEFF, 0xFEF50905, 0xBD070DFE);
	r1 = D(r1, s0_0_1, 0xB90DD7DD, 0x9CF113DB, 0xD11505F6, 0x81E5EEF0);
	r2 = D(r2, s0_0_1, 0x981C14AB, 0xCEFCF3F1, 0xE20401FB, 0x940BEAE0);
	r0 = D(r0, s0_0_2, 0xD801FE02, 0xED0106FE, 0xFBFA0C03, 0xF101F804);
	r1 = D(r1, s0_0_2, 0x89EEF2F9, 0xF50704F3, 0xE709F908, 0xE005F700);
	r2 = D(r2, s0_0_2, 0xE0F41708, 0xECFFF9FF, 0xDD030B00, 0xBDFBF704);
	r0 = D(r0, s0_1_0, 0x0B0EFAF2, 0x060206F5, 0xFD030A01, 0x31DF2CE5);
	r1 = D(r1, s0_1_0, 0xF90BF3FB, 0x092FDDF9, 0x0703FEDA, 0x24FD1AEE);
	r2 = D(r2, s0_1_0, 0x0DD94EEB, 0x0D11F1EF, 0x050303F6, 0x1A16F1DA);
	r0 = D(r0, s0_1_1, 0xD2F007E7, 0xD4F021F3, 0xDC12EBDB, 0xB830D1BC);
	r1 = D(r1, s0_1_1, 0x4012F0C6, 0xDAB86DC5, 0x14F8E1CA, 0x723BDCC3);
	r2 = D(r2, s0_1_1, 0xA16BD8BA, 0xFBFC0FF2, 0xC8FEF9F9, 0x2715F2EC);
	r0 = D(r0, s0_1_2, 0xE40E11F2, 0xFD0D2E00, 0xBBF7F3FF, 0xD7EB01FB);
	r1 = D(r1, s0_1_2, 0x1D1222F5, 0xFB1149F0, 0x81F600E3, 0x211F1509);
	r2 = D(r2, s0_1_2, 0xF2D81EF9, 0x020AFBF8, 0xEF1343F8, 0x11ED11F7);
	r0 = D(r0, s0_2_0, 0xFA040302, 0x0408FBFF, 0x0A13E7F2, 0xEB09FB09);
	r1 = D(r1, s0_2_0, 0xFDF80302, 0x140FFCF8, 0x0BF90514, 0xCA08E50F);
	r2 = D(r2, s0_2_0, 0xFFE607F9, 0x05070705, 0x05000700, 0xF9F50E0F);
	r0 = D(r0, s0_2_1, 0xF7E003FA, 0x0207E9FF, 0xD7E90AE4, 0x15EA11EA);
	r1 = D(r1, s0_2_1, 0xDAEE1012, 0x15DF27C9, 0xF6F7EC09, 0xB6ED270B);
	r2 = D(r2, s0_2_1, 0x161E15F1, 0xFC15F505, 0xFA1BF702, 0xE7E50508);
	r0 = D(r0, s0_2_2, 0x010BFFFE, 0xF7FF05FF, 0xF5F901FA, 0x1DE922FE);
	r1 = D(r1, s0_2_2, 0xFDF9EB00, 0xF11E15FB, 0x2005F90F, 0xF8F7D802);
	r2 = D(r2, s0_2_2, 0xFFE229FF, 0x070E0704, 0xFE040C01, 0xF6FCFF00);
	r0 = D(r0, s1_0_0, 0x080605F6, 0x03F80EFE, 0x04FA000A, 0xF81707EC);
	r1 = D(r1, s1_0_0, 0xF8090D01, 0x1BFF10EE, 0xF02CF9F4, 0xF01C4711);
	r2 = D(r2, s1_0_0, 0xE5E8160D, 0x0CF80CF9, 0x05FD06FF, 0xF30CD00C);
	r0 = D(r0, s1_0_1, 0x00F119F7, 0x03FC04FD, 0x08F8FC08, 0xF12913DA);
	r1 = D(r1, s1_0_1, 0x112ADB1C, 0xFCE7E90A, 0xF219F9E1, 0x00F1A741);
	r2 = D(r2, s1_0_1, 0x0CBE81EC, 0x06FAFD03, 0x00FAFFFC, 0x1649AAF8);
	r0 = D(r0, s1_0_2, 0x02FF0EFC, 0x00FE0000, 0x02FCFF06, 0x07EE0409);
	r1 = D(r1, s1_0_2, 0x091CAD0D, 0xFAFDF6F8, 0xF603F6FA, 0xFBFCA00F);
	r2 = D(r2, s1_0_2, 0x08041404, 0x0304F4FC, 0xFF0004FC, 0x02070908);
	r0 = D(r0, s1_1_0, 0x21FB0D03, 0x26F1F313, 0xF80816F0, 0x0500A803);
	r1 = D(r1, s1_1_0, 0xFB06F107, 0x150832FB, 0x14F8CB1C, 0xDCEB991F);
	r2 = D(r2, s1_1_0, 0x30D8C0EB, 0x21FE0806, 0x0BF4EDFF, 0x0E08C2EA);
	r0 = D(r0, s1_1_1, 0x0EE99E15, 0xFBF5D205, 0x112D030F, 0x23BB810B);
	r1 = D(r1, s1_1_1, 0xD82B81E6, 0xE00381F8, 0x0FF38148, 0x9CD48120);
	r2 = D(r2, s1_1_1, 0xEF828119, 0xE811A0F6, 0xFF04C404, 0xBA22C9E4);
	r0 = D(r0, s1_1_2, 0x0EE3E4FB, 0xFFE9F5FF, 0x020F0E0A, 0xFD211304);
	r1 = D(r1, s1_1_2, 0xE6DCE909, 0x03C5DB02, 0x14188100, 0xFEF7F4FE);
	r2 = D(r2, s1_1_2, 0x012D06F5, 0xFEE4E603, 0x04D9EFFE, 0xF90BFAF9);
	r0 = D(r0, s1_2_0, 0x10F9FCFD, 0x0E01FDF3, 0xFD06FE0A, 0x1101FAD8);
	r1 = D(r1, s1_2_0, 0xFC01F211, 0x07062004, 0xF6FF0EF6, 0xF6FDE81B);
	r2 = D(r2, s1_2_0, 0x000DF2F2, 0x04FB0901, 0xFDFEF9F9, 0xFEFC0C12);
	r0 = D(r0, s1_2_1, 0x0007EEED, 0xFDFDFB05, 0xE9EEE2FF, 0xE525B9F0);
	r1 = D(r1, s1_2_1, 0x17F1F711, 0xF9FAB4F2, 0xFE2CCBF7, 0x14FAFCFD);
	r2 = D(r2, s1_2_1, 0x06F2E0F6, 0x25FAE9F5, 0x06F8F000, 0x1B04F7F9);
	r0 = D(r0, s1_2_2, 0x03E9080D, 0x04FE03FD, 0xFD00FF05, 0x02030EFA);
	r1 = D(r1, s1_2_2, 0xFF0B13F8, 0xFFD9F105, 0xF00EFC08, 0x05050E09);
	r2 = D(r2, s1_2_2, 0x04070AF9, 0x06F90B00, 0x03FC0FFD, 0x0705FFF8);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x05FC0301, 0x01FF02FC, 0xFB0100FE, 0x0805F50D);
	r1 = D(r1, s0_0_0, 0xFE02FCFF, 0x02F607F4, 0xFAFF0D05, 0x11F8ECF8);
	r2 = D(r2, s0_0_0, 0x1009F2C9, 0x08F9FF07, 0x020202FE, 0xF808EF1E);
	r0 = D(r0, s0_0_1, 0x07FDFEF0, 0xFE0202F6, 0xF7000205, 0xFCFDF2E4);
	r1 = D(r1, s0_0_1, 0x04F2E63A, 0x11020209, 0x15F608F6, 0xD915ED3D);
	r2 = D(r2, s0_0_1, 0x2CDBE9FC, 0x06FFF60F, 0xFFFCFDFA, 0x0DE7E916);
	r0 = D(r0, s0_0_2, 0x03FDFEF4, 0xFEFCFE02, 0xFFFF03FF, 0x0D01DF0E);
	r1 = D(r1, s0_0_2, 0x07FEF903, 0x1BF0F0F9, 0xFF0AE601, 0x16F5F801);
	r2 = D(r2, s0_0_2, 0xFD10F803, 0x09FAFEFA, 0xFCFEFBFE, 0xFD06FC03);
	r0 = D(r0, s0_1_0, 0x08F6F8F4, 0xFFFAFEFE, 0x01FE00FA, 0x092807D8);
	r1 = D(r1, s0_1_0, 0xFFF9F50B, 0x0BEBE7F6, 0x070BE6F5, 0x0415FA08);
	r2 = D(r2, s0_1_0, 0xFAFB21FC, 0x01F0F2F5, 0x06FCFF01, 0x0FFE07EE);
	r0 = D(r0, s0_1_1, 0xCE3D0817, 0x190CF814, 0x09E4F4E2, 0xF3EBEA2E);
	r1 = D(r1, s0_1_1, 0x121E1CD9, 0xC8353E09, 0xE528B532, 0x4AA3F8F7);
	r2 = D(r2, s0_1_1, 0x50DCA505, 0xCB281427, 0xEA37FB22, 0xFA3B11F2);
	r0 = D(r0, s0_1_2, 0x2FDDEFF7, 0xFBFA02FE, 0x05FFFCF4, 0xEA05FEFC);
	r1 = D(r1, s0_1_2, 0x0504F70E, 0x4CD2C9E1, 0x13E90108, 0xE61ADDFB);
	r2 = D(r2, s0_1_2, 0xEC042FF5, 0x1EF5EC08, 0x03EDFFFC, 0x00FF0B0A);
	r0 = D(r0, s0_2_0, 0x07FEFC02, 0x00F80402, 0x0907F2FE, 0x05E4000D);
	r1 = D(r1, s0_2_0, 0xFE020801, 0xFE0CF7FA, 0xF9F30600, 0x04FBF20C);
	r2 = D(r2, s0_2_0, 0x02E01D0E, 0x02F5F8FF, 0x01FB0001, 0xFAF9F601);
	r0 = D(r0, s0_2_1, 0x18FE1103, 0x0207FCFE, 0x0E340702, 0x162607FA);
	r1 = D(r1, s0_2_1, 0xF8F5EB02, 0x11D00D0D, 0x0FDF0F03, 0xF529F5EB);
	r2 = D(r2, s0_2_1, 0x1122DEF3, 0x01DFFD0A, 0x08FAF600, 0xFCF4FD0A);
	r0 = D(r0, s0_2_2, 0x0819F4F8, 0x010300FF, 0x0DFC0300, 0x0AFE0AF9);
	r1 = D(r1, s0_2_2, 0x00F40B06, 0x0A0FEDED, 0xF508F500, 0x10E21003);
	r2 = D(r2, s0_2_2, 0x06E70C03, 0xFA0CFF02, 0xFD0BFEFD, 0x02F70904);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(1.522e-03, 3.565e-05, -6.186e-03, -1.187e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-9.550e-03, -1.035e-02, -1.137e-02, -6.586e-03);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-5.950e-03, 1.130e-03, 2.250e-03, -1.098e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_2x12_vk] -out-shuffle
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
	r0 += M4(-9.433e-02, 6.468e-03, 5.755e-04, 2.395e-02, 3.323e-03, 8.409e-04, 1.133e-03, 1.520e-03, -9.448e-02, -2.182e-02, -4.065e-02, -1.318e-04, 9.313e-03, -9.101e-03, 1.374e-02, 1.080e-03) * s0_0_0;
	r0 += M4(-9.081e-02, -2.524e-01, -2.843e-02, 1.332e-02, -4.309e-02, -3.768e-02, 3.449e-03, -1.807e-02, 2.483e-01, 1.936e-01, -2.478e-01, -2.861e-01, -4.574e-02, -7.854e-02, 6.568e-02, 2.975e-03) * s0_0_1;
	r0 += M4(-2.433e-02, 1.991e-02, -1.362e-02, -2.057e-02, -2.364e-02, 8.045e-02, -3.391e-03, -2.980e-02, -1.661e-02, -8.005e-04, -2.584e-02, -5.664e-02, -3.938e-03, 3.204e-02, -8.266e-03, -1.401e-02) * s0_0_2;
	r0 += M4(4.229e-02, 3.931e-02, -2.156e-02, 5.750e-02, 4.357e-02, 1.108e-03, 3.058e-02, -4.015e-03, -1.862e-03, -7.042e-04, 1.304e-02, 6.971e-03, 1.669e-02, -4.233e-03, 6.811e-02, -1.477e-02) * s0_1_0;
	r0 += M4(9.644e-02, 8.032e-02, 1.509e-01, -2.466e-01, -3.488e-02, -1.548e-01, -1.861e-01, -1.615e-01, 1.754e-03, -1.408e-03, 1.635e-01, 1.799e-01, 1.781e-01, 1.847e-01, -4.463e-01, 1.313e-01) * s0_1_1;
	r0 += M4(1.155e-03, 2.488e-02, -1.379e-03, 7.451e-02, 5.166e-02, 2.247e-01, 6.511e-02, 3.142e-01, 4.191e-04, -8.543e-03, 8.439e-03, 2.243e-02, 4.138e-02, -8.858e-02, 4.783e-02, -6.616e-02) * s0_1_2;
	r0 += M4(6.556e-03, 2.209e-03, 1.758e-02, 1.752e-02, -1.096e-02, -6.249e-04, -1.311e-03, -3.495e-03, -8.690e-05, 2.362e-07, 2.217e-04, -1.384e-07, -1.781e-03, -2.120e-06, 1.250e-03, -3.768e-03) * s0_2_0;
	r0 += M4(-5.095e-03, -4.139e-03, 2.136e-02, 4.430e-02, -2.191e-02, -8.874e-03, -3.650e-02, -3.376e-02, -6.832e-06, -2.100e-07, -4.378e-03, -3.951e-03, -9.229e-03, -4.787e-03, 7.544e-02, 1.070e-02) * s0_2_1;
	r0 += M4(-4.102e-05, -6.081e-05, -8.219e-04, 1.193e-02, 7.165e-03, 1.120e-02, -1.142e-03, 4.770e-03, 5.750e-06, 8.225e-07, 1.987e-04, -1.805e-03, 7.862e-04, -1.774e-03, 1.303e-02, -3.323e-03) * s0_2_2;
	r0 += M4(-2.955e-02, -3.772e-03, 1.010e-02, -3.713e-03, 3.138e-02, 3.218e-03, -1.980e-02, 4.578e-03, 1.514e-02, -6.075e-03, 7.531e-03, 8.875e-03, 3.869e-03, -2.311e-04, -3.288e-03, 8.785e-05) * s1_0_0;
	r0 += M4(-4.850e-02, 3.461e-03, 7.614e-03, -3.951e-03, 1.087e-01, -1.304e-01, -1.194e-04, 3.821e-02, 8.035e-02, 1.082e-01, -3.211e-02, -1.447e-02, 5.604e-02, 6.309e-03, -1.467e-02, -6.187e-03) * s1_0_1;
	r0 += M4(-4.582e-03, 3.037e-03, 4.471e-03, -8.156e-03, -1.201e-02, 1.486e-02, -5.010e-03, -4.214e-03, -5.447e-03, -9.549e-03, 6.212e-03, 4.896e-03, 3.230e-02, 3.259e-02, -1.581e-02, -1.108e-02) * s1_0_2;
	r0 += M4(5.725e-02, 3.033e-02, 7.017e-03, -1.145e-02, 4.236e-02, -6.207e-03, 1.071e-01, -1.759e-02, 1.135e-01, 9.492e-03, -1.423e-01, -6.050e-03, 5.639e-02, -1.222e-02, 3.982e-03, -9.136e-03) * s1_1_0;
	r0 += M4(1.313e-01, -4.743e-01, -1.773e-02, 2.783e-01, 2.075e-01, -2.445e-01, 3.174e-01, -3.603e-01, 1.429e-01, 2.204e-01, -1.042e-01, -4.035e-01, -3.682e-01, 2.832e-02, 2.071e-01, 1.276e-01) * s1_1_1;
	r0 += M4(-1.484e-02, 4.070e-02, -1.211e-03, -3.446e-03, -2.489e-02, -9.533e-03, -2.324e-02, 1.715e-02, -3.020e-02, 6.165e-02, -1.023e-02, -6.050e-04, 1.387e-02, -5.504e-02, 1.667e-02, -1.197e-02) * s1_1_2;
	r0 += M4(9.139e-03, 2.279e-02, -6.091e-02, 2.033e-02, -4.500e-03, 8.906e-03, -2.814e-02, 5.067e-03, -8.630e-03, -2.434e-03, -1.098e-03, -5.846e-03, 1.811e-02, 1.788e-02, -4.309e-02, -3.512e-03) * s1_2_0;
	r0 += M4(-3.924e-02, 8.110e-03, 4.062e-02, 6.909e-02, -2.883e-03, 2.563e-02, 1.837e-02, -3.078e-03, -2.025e-02, -1.630e-02, -1.458e-03, 4.035e-04, 6.237e-02, 6.361e-02, -2.773e-03, -1.701e-01) * s1_2_1;
	r0 += M4(-4.524e-03, 2.832e-03, -6.048e-03, -6.795e-03, 1.175e-03, -6.787e-03, -4.355e-03, -8.498e-03, 2.594e-03, -8.764e-03, -1.072e-03, 1.605e-02, 8.714e-04, -9.019e-03, -1.059e-02, 1.941e-02) * s1_2_2;
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 += M4(-1.464e-03, -2.774e-03, -1.431e-03, -1.215e-03, 4.845e-02, 3.675e-02, -1.349e-02, -2.743e-03, 4.127e-02, -4.658e-03, 8.072e-03, 2.470e-03, 1.765e-02, 2.215e-03, -1.077e-02, 6.873e-04) * s0_0_0;
	r0 += M4(1.955e-02, 1.319e-02, -1.576e-03, -1.182e-02, 1.323e-01, 1.743e-01, -5.490e-03, -1.327e-02, 5.819e-02, 1.205e-01, 7.495e-02, 3.583e-02, 3.678e-02, -1.142e-02, -1.653e-02, 1.538e-03) * s0_0_1;
	r0 += M4(9.674e-03, -1.208e-02, 2.774e-03, -2.331e-03, 2.678e-03, 2.081e-02, 3.340e-05, 3.151e-03, 3.792e-02, -7.259e-02, 1.593e-02, 4.286e-02, -8.516e-04, 5.849e-03, -7.198e-03, -4.296e-03) * s0_0_2;
	r0 += M4(-3.288e-03, -2.253e-02, -1.717e-02, -1.727e-02, -2.261e-01, 5.979e-03, -1.255e-01, -2.924e-03, 1.777e-01, 7.550e-03, 1.704e-01, -4.909e-03, 2.174e-02, -3.147e-02, 2.777e-02, -7.199e-03) * s0_1_0;
	r0 += M4(-3.564e-01, 2.598e-01, -9.818e-02, 1.489e-01, 9.643e-02, -3.115e-01, 1.959e-01, 4.496e-03, -2.920e-01, 8.035e-02, -3.193e-01, 1.544e-01, -6.127e-01, -4.497e-02, 3.417e-01, 8.041e-02) * s0_1_1;
	r0 += M4(-1.772e-02, 8.248e-02, -2.285e-02, 2.618e-02, 9.024e-03, 5.762e-02, 6.124e-03, 7.495e-02, -1.687e-02, -1.362e-01, -2.577e-02, -2.646e-01, -7.587e-04, -8.138e-02, 8.503e-03, 1.116e-01) * s0_1_2;
	r0 += M4(8.863e-04, -9.921e-03, 5.597e-03, -2.054e-02, 7.904e-03, -2.672e-03, -3.961e-02, 4.095e-03, 5.378e-03, 9.669e-04, 3.771e-02, 7.053e-03, 4.905e-04, 1.380e-03, 4.809e-03, -8.170e-03) * s0_2_0;
	r0 += M4(-4.862e-03, 1.240e-02, -1.499e-01, 1.495e-01, 2.827e-03, 1.556e-02, -4.895e-02, -6.969e-02, 1.541e-02, 8.086e-03, 1.492e-02, 5.086e-03, 2.144e-02, -1.961e-02, 9.303e-02, 3.885e-02) * s0_2_1;
	r0 += M4(9.444e-03, -3.185e-02, 1.715e-03, 3.455e-02, -5.060e-03, 3.881e-03, -8.667e-03, -9.851e-03, -2.487e-03, -8.020e-03, 8.026e-03, 5.059e-04, 1.321e-02, 9.980e-04, 4.440e-04, -8.374e-03) * s0_2_2;
	r0 += V4(-1.508e-08, -1.485e-08, -1.518e-08, -1.474e-08);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
