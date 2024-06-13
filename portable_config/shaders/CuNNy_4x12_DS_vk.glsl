// CuNNy 4x12 DS
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


//!DESC [CuNNy_4x12_DS_vk] -in
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
	r0 += V4(3.784e-03, 2.878e-02, 1.310e-02, 3.181e-02) * s0_0_0;
	r1 += V4(1.423e-02, 2.974e-01, -5.921e-02, -3.269e-02) * s0_0_0;
	r2 += V4(-3.253e-02, 2.153e-02, 9.754e-02, -9.600e-02) * s0_0_0;
	r0 += V4(-4.267e-03, -2.637e-02, 8.383e-02, 1.175e-02) * s0_0_1;
	r1 += V4(-5.755e-02, 4.639e-01, -9.260e-02, 8.113e-02) * s0_0_1;
	r2 += V4(2.072e-01, -4.626e-02, -3.316e-01, -1.103e-01) * s0_0_1;
	r0 += V4(-5.380e-03, -1.846e-03, -4.640e-03, -6.695e-03) * s0_0_2;
	r1 += V4(2.981e-02, -4.418e-02, -7.535e-03, 4.705e-03) * s0_0_2;
	r2 += V4(-1.822e-01, 2.190e-02, -2.397e-01, -7.827e-02) * s0_0_2;
	r0 += V4(-3.009e-02, -4.213e-01, -3.297e-03, -2.304e-01) * s0_1_0;
	r1 += V4(-2.459e-02, -4.995e-01, -5.588e-02, 3.010e-01) * s0_1_0;
	r2 += V4(8.849e-02, -9.909e-03, 8.058e-03, -5.064e-02) * s0_1_0;
	r0 += V4(4.809e-02, 6.116e-02, -7.441e-02, -4.964e-01) * s0_1_1;
	r1 += V4(-5.414e-01, -1.279e-01, 6.292e-01, -9.353e-02) * s0_1_1;
	r2 += V4(3.351e-01, 7.431e-01, 4.173e-01, 7.653e-01) * s0_1_1;
	r0 += V4(-1.554e-02, 4.508e-03, 1.568e-02, 3.992e-02) * s0_1_2;
	r1 += V4(5.915e-01, 1.837e-02, -6.292e-02, -2.405e-02) * s0_1_2;
	r2 += V4(-3.975e-01, 4.744e-03, -8.364e-02, -1.082e-01) * s0_1_2;
	r0 += V4(-7.698e-01, -3.383e-01, -7.153e-02, 1.930e-01) * s0_2_0;
	r1 += V4(1.947e-02, -1.678e-02, 2.146e-02, -4.921e-03) * s0_2_0;
	r2 += V4(-5.359e-02, -2.203e-02, -6.667e-02, -7.913e-02) * s0_2_0;
	r0 += V4(7.678e-01, 7.121e-01, 3.682e-01, 4.621e-01) * s0_2_1;
	r1 += V4(-7.412e-02, -1.294e-01, -1.382e-01, 6.511e-02) * s0_2_1;
	r2 += V4(6.506e-02, -6.676e-01, 5.399e-02, -1.494e-01) * s0_2_1;
	r0 += V4(7.820e-03, -1.407e-02, -1.151e-01, -1.668e-02) * s0_2_2;
	r1 += V4(5.652e-02, 2.831e-02, 2.951e-02, 7.576e-03) * s0_2_2;
	r2 += V4(-2.300e-02, -3.980e-02, 1.538e-01, -7.682e-02) * s0_2_2;
	r0 += V4(5.994e-03, -3.772e-03, -1.085e-03, 3.500e-02);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(2.663e-02, 3.577e-02, 1.182e-02, 7.855e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
	r2 += V4(2.404e-02, 8.369e-04, 1.091e-02, 7.886e-03);
	r2 = max(r2, V4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), vec4(r2));
}

//!DESC [CuNNy_4x12_DS_vk] -conv1
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
	r0 = D(r0, s0_0_0, 0x10E311FC, 0xFDE4070C, 0x0002E318, 0xEBE114FA);
	r1 = D(r1, s0_0_0, 0xDEEA1DD3, 0x1004DD19, 0x26E6E91E, 0xED1AFDFA);
	r2 = D(r2, s0_0_0, 0x2A041BF7, 0xD6450EEF, 0xFF51EEEE, 0x0601FF08);
	r0 = D(r0, s0_0_1, 0xF6200D01, 0x174EFD0B, 0x0FCC0767, 0x15E406E8);
	r1 = D(r1, s0_0_1, 0x5DFC1E33, 0x00E1AD64, 0xC4F589B9, 0xC074DEB5);
	r2 = D(r2, s0_0_1, 0x12058181, 0x45E42940, 0x11C6E281, 0xF4260503);
	r0 = D(r0, s0_0_2, 0xFC05E21A, 0xFDF8D335, 0xEAD728FF, 0xFBFBFFE7);
	r1 = D(r1, s0_0_2, 0xEB14D045, 0xE323F21D, 0x1C3BBD81, 0xFC30F0F5);
	r2 = D(r2, s0_0_2, 0xFFF5F5A3, 0x0DED2EF7, 0x0C07FC14, 0xFD07E005);
	r0 = D(r0, s0_1_0, 0xFFEF0602, 0xF601F011, 0xEA27F601, 0xF2F7F611);
	r1 = D(r1, s0_1_0, 0x130226E4, 0x03C613DF, 0x27E1FB1C, 0xF5E411FC);
	r2 = D(r2, s0_1_0, 0xF4DDF118, 0xDF0A0602, 0x07FAF3FF, 0x0A150703);
	r0 = D(r0, s0_1_1, 0x19070304, 0x38D0DA17, 0x2218F6D4, 0x4030F418);
	r1 = D(r1, s0_1_1, 0xC2F727FD, 0x4E4D1989, 0x96151E24, 0x7FDAE71E);
	r2 = D(r2, s0_1_1, 0x41DFF0FD, 0x16F0041F, 0xFD00F8F3, 0xC9C801E9);
	r0 = D(r0, s0_1_2, 0xE8071821, 0x20F30007, 0x02141AD8, 0x09E3F603);
	r1 = D(r1, s0_1_2, 0x66A128C6, 0xD81768A5, 0x01FFA552, 0xF50BED1C);
	r2 = D(r2, s0_1_2, 0xFDE40B2A, 0x16E722F7, 0x0DFA1BE9, 0xF1FF23C2);
	r0 = D(r0, s0_2_0, 0x0A04FA00, 0x0FFEF10D, 0xF52302F4, 0x0232FA02);
	r1 = D(r1, s0_2_0, 0xEB3714F8, 0x09DB0AFC, 0x19C2F813, 0xF8EA00FA);
	r2 = D(r2, s0_2_0, 0x0121F801, 0xF202FFFE, 0xFF080300, 0x07F5EC10);
	r0 = D(r0, s0_2_1, 0xF5070301, 0xF513ED08, 0x0DD5F5FF, 0x21EADC26);
	r1 = D(r1, s0_2_1, 0xDA3AF205, 0x0E181B03, 0xF223FF02, 0x25D90AFB);
	r2 = D(r2, s0_2_1, 0x004AE303, 0x14F0F8FB, 0x07FDF700, 0xF524F107);
	r0 = D(r0, s0_2_2, 0x0FE90A06, 0xF701FA01, 0xF909EC0B, 0xD8130D06);
	r1 = D(r1, s0_2_2, 0xF8E538D7, 0xAFDF44FA, 0x100CF404, 0xF7F8F8FF);
	r2 = D(r2, s0_2_2, 0x000F14FC, 0xFBF60DFA, 0xFCE70804, 0x2DE0FE03);
	r0 = D(r0, s1_0_0, 0x17EF01F2, 0x15FFFD0C, 0x01FE0DF4, 0x00EA0200);
	r1 = D(r1, s1_0_0, 0xDFE701DA, 0xFBFFEF01, 0xBABC09DA, 0x01E404EE);
	r2 = D(r2, s1_0_0, 0x2816F4D6, 0x241F041B, 0x1B1A031A, 0x03EEFB0C);
	r0 = D(r0, s1_0_1, 0x1905F804, 0xE0EBECF0, 0xC905FDE2, 0xD206FE0B);
	r1 = D(r1, s1_0_1, 0x0E1D0502, 0xE8FB0D24, 0x1CDF260C, 0xF71E060B);
	r2 = D(r2, s1_0_1, 0xFB0B08E0, 0x93F5EBF0, 0x0CE702FE, 0x3B0D0712);
	r0 = D(r0, s1_0_2, 0xE7EBFD04, 0x28FF050A, 0xECE113FD, 0x03020D08);
	r1 = D(r1, s1_0_2, 0xC7E9F800, 0xF52BF113, 0xD5FBD9FF, 0xF0F0F401);
	r2 = D(r2, s1_0_2, 0x09FB1807, 0x2AFE140B, 0xFEF9FE06, 0x0B14FC01);
	r0 = D(r0, s1_1_0, 0xFB09F60C, 0x0F00F828, 0x0305FAFF, 0x06110A06);
	r1 = D(r1, s1_1_0, 0x38011EEA, 0x09090ACB, 0x14F4E47F, 0xF71C0422);
	r2 = D(r2, s1_1_0, 0xFDE6FED9, 0x294F052C, 0xF35B0F81, 0x05FDF201);
	r0 = D(r0, s1_1_1, 0x3B0AFA48, 0xBB55E506, 0x24E80312, 0xEFB20418);
	r1 = D(r1, s1_1_1, 0x2B16A429, 0x0EE70216, 0x1B280973, 0x257FFD27);
	r2 = D(r2, s1_1_1, 0xEAC92F36, 0x44BEDF00, 0x0BC4D2DD, 0xFB541020);
	r0 = D(r0, s1_1_2, 0xDC1C1503, 0x61F41107, 0x0919FCFF, 0xF0F81DFC);
	r1 = D(r1, s1_1_2, 0xC939D4EA, 0x2C2810DE, 0x20E66214, 0x8105200C);
	r2 = D(r2, s1_1_2, 0xEA0617F6, 0xFAF421F6, 0xD6F00CF2, 0x0D2B0D0A);
	r0 = D(r0, s1_2_0, 0x00030AFD, 0x00FA0509, 0x04FEFF1B, 0x25EE030C);
	r1 = D(r1, s1_2_0, 0x08FBFE3B, 0xE4C1FDD6, 0x271D0FAD, 0x0FDA07E0);
	r2 = D(r2, s1_2_0, 0x1B080705, 0x1B060EE6, 0x29250A1C, 0xFEF9FBEC);
	r0 = D(r0, s1_2_1, 0xF0FE02FD, 0xDBCE05F3, 0xF534D5F5, 0x074BE908);
	r1 = D(r1, s1_2_1, 0x55F9E825, 0xD41DF7D9, 0xF8251BCF, 0xCDF4E306);
	r2 = D(r2, s1_2_1, 0xF9071BD5, 0xE9EFF306, 0xE0F0FE17, 0xE28B53F8);
	r0 = D(r0, s1_2_2, 0xEAF40A01, 0x17E1FB03, 0xFE0BBA03, 0x2814E704);
	r1 = D(r1, s1_2_2, 0xCFD9EAF4, 0x27E9F212, 0xFF1403EF, 0xEECBE8FC);
	r2 = D(r2, s1_2_2, 0xEA22F306, 0xD2F3FC00, 0x02E6F308, 0xE1DD24F7);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x09030613, 0x03120813, 0x02013FF2, 0x0700FD16);
	r1 = D(r1, s0_0_0, 0x09FE1636, 0x08F9FF1A, 0x121430D5, 0x20F716F0);
	r2 = D(r2, s0_0_0, 0xF016F50B, 0x2A052115, 0xFC0408DC, 0x02FC09EC);
	r0 = D(r0, s0_0_1, 0x08FC56FA, 0xED041800, 0xD3F04705, 0xF4FEF708);
	r1 = D(r1, s0_0_1, 0x00E33527, 0xEBED25E9, 0x010DE00C, 0x1A0C02F2);
	r2 = D(r2, s0_0_1, 0x0A0581F0, 0x12DAEA15, 0x020403F0, 0xFE0BDB00);
	r0 = D(r0, s0_0_2, 0x01060DFF, 0xF90B01F3, 0x1B052DF3, 0xEF07E701);
	r1 = D(r1, s0_0_2, 0x23FF03F7, 0x16FAADFE, 0xEA00D811, 0x1AF8F4FC);
	r2 = D(r2, s0_0_2, 0xEEFA0205, 0xE70DF6FC, 0x080400F4, 0xFC05FA02);
	r0 = D(r0, s0_1_0, 0xF30503D0, 0x07F7FAF0, 0x0DCB33C9, 0xECFE13F0);
	r1 = D(r1, s0_1_0, 0xFAE90FC4, 0x2B1AE00E, 0x96FC2AEB, 0xF713FB49);
	r2 = D(r2, s0_1_0, 0x380B0C24, 0x0D2104F8, 0x6106D43A, 0x07F5EB16);
	r0 = D(r0, s0_1_1, 0xE2D3F9F4, 0x06E9FD26, 0x9E09F705, 0xD5FB81FD);
	r1 = D(r1, s0_1_1, 0x81FC3DC3, 0xB0DD4B9D, 0x42D716DD, 0xD6F4A4F1);
	r2 = D(r2, s0_1_1, 0x18FAED11, 0xEDEBE4FC, 0xC5F10C2D, 0x33FD04F9);
	r0 = D(r0, s0_1_2, 0x2221FFE2, 0xF8130AFC, 0x030F0CF6, 0x0B07EC05);
	r1 = D(r1, s0_1_2, 0x4CE0BBE0, 0x14E4AEF5, 0x1001E8E1, 0x13F8EEFF);
	r2 = D(r2, s0_1_2, 0xFBFA0D12, 0xE7100313, 0xF70D0A0D, 0x0109D4E0);
	r0 = D(r0, s0_2_0, 0x0C04FA21, 0x0403FA13, 0x1F12FA03, 0x090A03E1);
	r1 = D(r1, s0_2_0, 0x07C715B8, 0x2406F024, 0xEE23E421, 0x1E14FA10);
	r2 = D(r2, s0_2_0, 0xFBE81E10, 0xF30A0C06, 0x070400EA, 0xED021124);
	r0 = D(r0, s0_2_1, 0xFEF2FFF8, 0xFF010C18, 0x3F2DDD10, 0x4A36D702);
	r1 = D(r1, s0_2_1, 0x1A0C18BF, 0xD1F40B21, 0xF70E1D09, 0x142AEFBC);
	r2 = D(r2, s0_2_1, 0xECF902FA, 0xEF02FE03, 0xF8FBFAE8, 0xD3C51A17);
	r0 = D(r0, s0_2_2, 0xF901FF0F, 0xFA0F0B11, 0x0E0603FF, 0x03FB18FC);
	r1 = D(r1, s0_2_2, 0xEAC9EE31, 0xDBED0C0F, 0xFFFEF90D, 0x2305FBF2);
	r2 = D(r2, s0_2_2, 0xF40404FF, 0xF1FF0210, 0x04FE0302, 0xEA03F229);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(1.031e-02, -3.331e-02, -3.744e-03, -1.394e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(3.039e-02, 5.579e-02, -3.812e-02, -2.826e-03);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-1.685e-03, -5.849e-02, 1.366e-02, -2.078e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_4x12_DS_vk] -conv2
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
	r0 = D(r0, s0_0_0, 0xED0ADCFB, 0x11041102, 0xE3FFF8F4, 0x16F50013);
	r1 = D(r1, s0_0_0, 0x270923E8, 0xF006F8F7, 0x16FF030B, 0xF2F9F9EE);
	r2 = D(r2, s0_0_0, 0x010318F5, 0x15FEF521, 0xFF0CF0F6, 0x04F7081F);
	r0 = D(r0, s0_0_1, 0x19F210E3, 0x06FD17FE, 0xED0FF2F3, 0xF404FF00);
	r1 = D(r1, s0_0_1, 0xB5140104, 0xFF0923F2, 0x0FF20811, 0xB233DEAE);
	r2 = D(r2, s0_0_1, 0x4F18CBD5, 0x0DE8020D, 0x1FF80916, 0x3AECFA20);
	r0 = D(r0, s0_0_2, 0xDF14E8F0, 0xEE0203F3, 0xFF0AFAEA, 0x0AFC0603);
	r1 = D(r1, s0_0_2, 0x0A08F6F7, 0xF90100FF, 0x03010200, 0xFB18FF02);
	r2 = D(r2, s0_0_2, 0x07F50611, 0xFC080010, 0x0C0903FA, 0x17F7F70A);
	r0 = D(r0, s0_1_0, 0xDEFA2A08, 0x1D0DED16, 0xFA1813F1, 0xD1E3E45D);
	r1 = D(r1, s0_1_0, 0x1405CC47, 0x02F90FF9, 0x0FF90603, 0x02F70BC0);
	r2 = D(r2, s0_1_0, 0x0201F0FC, 0x0FEAF215, 0xFBFE0AF7, 0x00040B0A);
	r0 = D(r0, s0_1_1, 0x313C2EFD, 0x310FF9EA, 0x2DFB1C2B, 0x2D0929FA);
	r1 = D(r1, s0_1_1, 0xE70FF607, 0xCE14D30F, 0x2613DC19, 0xCF0C0F18);
	r2 = D(r2, s0_1_1, 0x27E432F7, 0x81F3ADD2, 0xE808FFD5, 0xDAFD01EE);
	r0 = D(r0, s0_1_2, 0xFA0F090A, 0xE004FF0A, 0x02111107, 0x0007F4E8);
	r1 = D(r1, s0_1_2, 0x0AFE0EF4, 0xFC0B010B, 0x0FFA13FA, 0x13FCFC0F);
	r2 = D(r2, s0_1_2, 0xE90307F7, 0x0AF9F91F, 0xFF1D0BED, 0x02090311);
	r0 = D(r0, s0_2_0, 0xF906F8F8, 0xFF0AEE04, 0xF810E724, 0xFFF4E807);
	r1 = D(r1, s0_2_0, 0xF4FF15E5, 0x06000105, 0xFFFFF80B, 0xFE090311);
	r2 = D(r2, s0_2_0, 0xFB02FC05, 0x03EB30E9, 0xF9020C0C, 0x0107E313);
	r0 = D(r0, s0_2_1, 0xFAF4110D, 0x0BFC11FB, 0x0F0A39CC, 0x00001623);
	r1 = D(r1, s0_2_1, 0xF2360C19, 0x02F117EE, 0x0205F4F2, 0x040A403A);
	r2 = D(r2, s0_2_1, 0x01050000, 0x13BB4D34, 0x030EF42C, 0x12EB32DA);
	r0 = D(r0, s0_2_2, 0xEF28F60B, 0x0011ED16, 0xF9F9EAF2, 0x06F6FCFF);
	r1 = D(r1, s0_2_2, 0x06F20C02, 0x00FF0100, 0x03F9F600, 0x08F8CEF9);
	r2 = D(r2, s0_2_2, 0x02FD0301, 0x17C603D9, 0xFA0AEE0D, 0xFEF40CF0);
	r0 = D(r0, s1_0_0, 0xFEF424EA, 0xFC0804F3, 0x0EFD0318, 0x04FFF904);
	r1 = D(r1, s1_0_0, 0x060B0BE2, 0x07020103, 0x0201FAFC, 0xF2FEF50A);
	r2 = D(r2, s1_0_0, 0xF2030315, 0xFFEE02F9, 0x09FDF7FD, 0xF906FF07);
	r0 = D(r0, s1_0_1, 0x151A2FE2, 0x1604F4F3, 0x0501110A, 0xFDFD100A);
	r1 = D(r1, s1_0_1, 0xF212F116, 0x040EFB03, 0x02FEFE07, 0xFCF92013);
	r2 = D(r2, s1_0_1, 0x41F20BC9, 0xE310EFF6, 0xF9FA00FF, 0x1E02F308);
	r0 = D(r0, s1_0_2, 0x0B0F0D09, 0x11F809ED, 0x19010F0B, 0xFF07FC0B);
	r1 = D(r1, s1_0_2, 0xF4F90FDF, 0x04FBFD04, 0xFD060006, 0xF5FF0C21);
	r2 = D(r2, s1_0_2, 0xF8FA06E8, 0xFA07FEF6, 0xFE090113, 0x07F9F6FF);
	r0 = D(r0, s1_1_0, 0xD40BD11B, 0xF801F7DD, 0x0DEF25D8, 0x0B09F7FB);
	r1 = D(r1, s1_1_0, 0x10F626AA, 0xFF08F511, 0x0601EF05, 0x00F8191D);
	r2 = D(r2, s1_1_0, 0x0402FA0B, 0x0C0FF0EB, 0x080701E7, 0xE50AFC05);
	r0 = D(r0, s1_1_1, 0x811710D7, 0xDEFCE7E1, 0xCD0E08EB, 0xEC1DEF1F);
	r1 = D(r1, s1_1_1, 0x92EB0BFB, 0x1D01FC1D, 0x07FEEA2F, 0xA4F2FC00);
	r2 = D(r2, s1_1_1, 0xC9D70CE0, 0xEFF4FD1D, 0xD5F6EE2D, 0x4B1706BD);
	r0 = D(r0, s1_1_2, 0x20CDFA13, 0xF60FEA0B, 0xFB02FC0E, 0x0CE50507);
	r1 = D(r1, s1_1_2, 0x073D15BB, 0x0B16FCFD, 0xFE03FF0A, 0x21F8EA1B);
	r2 = D(r2, s1_1_2, 0x15FD0308, 0x20090404, 0x0B14040B, 0x030A00E5);
	r0 = D(r0, s1_2_0, 0xFCF6F2E1, 0xFE01FCE2, 0x05040606, 0x19122EF8);
	r1 = D(r1, s1_2_0, 0x0210F9F7, 0xFE010802, 0x01FAFA0B, 0xFDF80C16);
	r2 = D(r2, s1_2_0, 0xFAFEFD01, 0xE707FF24, 0x02F903F2, 0xF90B0613);
	r0 = D(r0, s1_2_1, 0xF12726AF, 0x041DDD19, 0xA2D4072E, 0x19E702E1);
	r1 = D(r1, s1_2_1, 0x081D04F2, 0x0C0A020A, 0xF8F3ED10, 0x09E0FB14);
	r2 = D(r2, s1_2_1, 0x08F30708, 0x08290804, 0x0EE0F902, 0x0C170F0C);
	r0 = D(r0, s1_2_2, 0x0A010BE3, 0x13F2EF06, 0xEDE302FA, 0x04E20604);
	r1 = D(r1, s1_2_2, 0x00FD05FE, 0xFD1100FA, 0xF3FE0002, 0x1CBBF9E4);
	r2 = D(r2, s1_2_2, 0xF807FEF7, 0xF6B005E4, 0xF4EE0FE9, 0xEF3CF314);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x03FE12E5, 0xF4060502, 0x06F60506, 0xED000108);
	r1 = D(r1, s0_0_0, 0xC6170104, 0x130101FA, 0xF30704FC, 0x1DE31A01);
	r2 = D(r2, s0_0_0, 0x05F01005, 0xF500080B, 0x09F804FC, 0xEF0DFBFB);
	r0 = D(r0, s0_0_1, 0xCF2211E1, 0x02F80601, 0x01F6FB0A, 0x08FC0800);
	r1 = D(r1, s0_0_1, 0x2EEE1612, 0x2F0EF908, 0xF80A11F5, 0x37DD0800);
	r2 = D(r2, s0_0_1, 0xACE2FB0F, 0xFB28FEF1, 0x1913FAF7, 0xE909F806);
	r0 = D(r0, s0_0_2, 0x14FA18F3, 0xF7F2F4FE, 0x030402FD, 0x04FEF009);
	r1 = D(r1, s0_0_2, 0xE2DC0F1E, 0x06F111FA, 0xF70206FD, 0x00F20A07);
	r2 = D(r2, s0_0_2, 0x0DEDFF17, 0xEB0517FB, 0x00020CFB, 0xFEF8F706);
	r0 = D(r0, s0_1_0, 0xE1EE19FA, 0x0B11F6FA, 0xFCF7FB0B, 0xBDF1FA08);
	r1 = D(r1, s0_1_0, 0xFC22D4F9, 0xFDFDFD05, 0xFD08FFFB, 0xEDDE150D);
	r2 = D(r2, s0_1_0, 0x0AFBFB06, 0xEF0E14F0, 0xF400F70A, 0xF2F02104);
	r0 = D(r0, s0_1_1, 0xCE53D506, 0x0F1913ED, 0xF8F01EF2, 0x43F6C70B);
	r1 = D(r1, s0_1_1, 0x22FF1AC7, 0x11371012, 0x14FBF6F9, 0x2950D00B);
	r2 = D(r2, s0_1_1, 0xE3200F11, 0x3F0214DF, 0x28DD0A04, 0x0BC91613);
	r0 = D(r0, s0_1_2, 0x14320BF5, 0x15001FEA, 0xF230E0E4, 0x0DEF0F08);
	r1 = D(r1, s0_1_2, 0x021515BD, 0xFC04F909, 0xF01EEDF6, 0xED500FE4);
	r2 = D(r2, s0_1_2, 0xFBDE1D1E, 0xD6FCDC1F, 0xF50BDB04, 0x07911F39);
	r0 = D(r0, s0_2_0, 0xFEE31613, 0x0C07F103, 0x1118F4ED, 0xFBC62EF9);
	r1 = D(r1, s0_2_0, 0xF5F214FE, 0xFBF70A09, 0x05FDFCFF, 0x00F52CF9);
	r2 = D(r2, s0_2_0, 0xFFFB0EFC, 0xDDF70A06, 0xFBFF00FB, 0xF8F9FE02);
	r0 = D(r0, s0_2_1, 0xEFD8F833, 0xF925D5F1, 0xF70813F9, 0x029AF5E1);
	r1 = D(r1, s0_2_1, 0xFD02E4F7, 0xFA010B0C, 0x0B08FD05, 0xFD24EDD5);
	r2 = D(r2, s0_2_1, 0x04040405, 0xE611E5E9, 0xFCE8F8FF, 0xFE05111C);
	r0 = D(r0, s0_2_2, 0xFD04C50A, 0x0906EEF9, 0x07E73EDF, 0x03E90AFC);
	r1 = D(r1, s0_2_2, 0xFB36B9EF, 0xFFF00209, 0x050A15EB, 0xF605BBFD);
	r2 = D(r2, s0_2_2, 0xFFF40104, 0x0026F9F8, 0x0AFB14FA, 0xFEDB2C18);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-5.476e-02, 1.584e-02, -1.279e-02, -2.738e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-4.246e-02, -2.097e-02, 3.247e-02, -2.286e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-1.297e-02, 9.459e-03, -4.096e-04, -3.904e-03);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_4x12_DS_vk] -conv3
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
	r0 = D(r0, s0_0_0, 0x01020200, 0xF112EC10, 0xFBEE040A, 0x04FEFEF4);
	r1 = D(r1, s0_0_0, 0xFC060704, 0xFE01E907, 0xF8EB0DED, 0xFEFF0B0A);
	r2 = D(r2, s0_0_0, 0xFF0303FD, 0xF3F91409, 0xFFF6FAFF, 0xFB2409F3);
	r0 = D(r0, s0_0_1, 0x10F704F1, 0xDC23F718, 0xF6E6F704, 0x14F90CF4);
	r1 = D(r1, s0_0_1, 0x03F20709, 0x05FDFAEB, 0x02B21118, 0x01CD1D21);
	r2 = D(r2, s0_0_1, 0x15EF0908, 0xE21F0826, 0x0FF80E11, 0xFAEA06E9);
	r0 = D(r0, s0_0_2, 0x0DF6FF03, 0xA4F5F10A, 0x00051801, 0x17FFFDF2);
	r1 = D(r1, s0_0_2, 0xFF020303, 0x19FC03F5, 0x2401F605, 0x0D04010B);
	r2 = D(r2, s0_0_2, 0x1813FDF9, 0x021EF4E6, 0x1114EEED, 0x0C010DF0);
	r0 = D(r0, s0_1_0, 0xFA020203, 0xF213E3FC, 0x01FF160F, 0xFFF900EF);
	r1 = D(r1, s0_1_0, 0xFE17F21A, 0x0404EC09, 0xF9FCE9EF, 0xFA0BD804);
	r2 = D(r2, s0_1_0, 0x000004F6, 0xF1F0DFE1, 0x06F209F6, 0xEF17E1CE);
	r0 = D(r0, s0_1_1, 0xFCF30D01, 0xD10FED17, 0xF9F42B13, 0xECD9E906);
	r1 = D(r1, s0_1_1, 0xF91208E4, 0x1B3005F5, 0xFDED1EF7, 0x163FE4D4);
	r2 = D(r2, s0_1_1, 0x070A0416, 0xDF10FD37, 0x0F05FD30, 0xD72A14DD);
	r0 = D(r0, s0_1_2, 0x0B090702, 0xD8F61017, 0x04D62246, 0xFBE4FA0B);
	r1 = D(r1, s0_1_2, 0xF605F907, 0x2905FF10, 0x311CF6EF, 0xF7FE0AD8);
	r2 = D(r2, s0_1_2, 0x12190001, 0x08100501, 0x1108F6F6, 0xE9253695);
	r0 = D(r0, s0_2_0, 0x0006FAFD, 0xF302FA09, 0x05050320, 0x02FAFBF8);
	r1 = D(r1, s0_2_0, 0xFEFE2301, 0x02FE070D, 0x010308F4, 0xF9171411);
	r2 = D(r2, s0_2_0, 0x00FA04F5, 0xFBFDF2F3, 0x02FCF904, 0x0418FFC0);
	r0 = D(r0, s0_2_1, 0x03F900F9, 0xEC02FFF6, 0x010C12E4, 0x03F4F6F4);
	r1 = D(r1, s0_2_1, 0x0012FB28, 0x03050310, 0x00F60300, 0xF7E91F08);
	r2 = D(r2, s0_2_1, 0xFEFBF70F, 0xFAFA0005, 0x030502FD, 0xE6F61BCF);
	r0 = D(r0, s0_2_2, 0xFD0000FC, 0xF1F4FA0F, 0xF7ECF810, 0xFEF1F6F9);
	r1 = D(r1, s0_2_2, 0xF10708FC, 0x130EFC11, 0x0D11FC04, 0xEF1D08ED);
	r2 = D(r2, s0_2_2, 0x0201FD04, 0x0401FD09, 0xFE09FAFF, 0xE6F10BC6);
	r0 = D(r0, s1_0_0, 0xFA070009, 0x12150907, 0xC90BFA0D, 0xFD0300FE);
	r1 = D(r1, s1_0_0, 0xFA01FDFA, 0xFCFBF702, 0xE9F4F8F6, 0x00F7FAEF);
	r2 = D(r2, s1_0_0, 0xFFFD0305, 0xEFFA00FC, 0xF9F60102, 0x050702DC);
	r0 = D(r0, s1_0_1, 0x13E5F708, 0xF4EDECEE, 0xCFDD1611, 0x1DF6FE0B);
	r1 = D(r1, s1_0_1, 0xF80500F1, 0x0AFAFC07, 0xEEE305FA, 0xF1EFFEE4);
	r2 = D(r2, s1_0_1, 0x1EF7F607, 0x19F4FB0B, 0x1A01FB0A, 0xFB01FCC4);
	r0 = D(r0, s1_0_2, 0x04FFFF03, 0x04F3FAFB, 0xDBF0F314, 0x01F9040B);
	r1 = D(r1, s1_0_2, 0xFD03FEFF, 0x0F100704, 0x0A1108FD, 0xFE03F6F9);
	r2 = D(r2, s1_0_2, 0x0FFF00FE, 0x16FE0203, 0x07010AFC, 0x11FAFDCA);
	r0 = D(r0, s1_1_0, 0x08FE0CFF, 0x0921FB18, 0xDEC7090B, 0xFA050100);
	r1 = D(r1, s1_1_0, 0x08010712, 0x01010A02, 0xE3F90812, 0xF7FF130C);
	r2 = D(r2, s1_1_0, 0x0004040D, 0xE508FF02, 0xFF020509, 0xF010F7E6);
	r0 = D(r0, s1_1_1, 0xED3A2705, 0x15B0810A, 0x8DF5FD12, 0xF12445D3);
	r1 = D(r1, s1_1_1, 0x15160522, 0x0C371322, 0x26401BDC, 0x4D500D35);
	r2 = D(r2, s1_1_1, 0x360C3409, 0x4CF7AAF2, 0x463B22E2, 0x1F402AE4);
	r0 = D(r0, s1_1_2, 0x060A0911, 0x0305F4EF, 0xD0EDCED2, 0xE5160C08);
	r1 = D(r1, s1_1_2, 0x0000FFF9, 0x18D5DDEA, 0x19F2F81B, 0x252903FD);
	r2 = D(r2, s1_1_2, 0x0DE3FB15, 0x11DF2618, 0xEDF91A17, 0x19CCD1AE);
	r0 = D(r0, s1_2_0, 0xFE01FFFE, 0x0DEDEBFE, 0xF4FEEFFC, 0xEF05FFFD);
	r1 = D(r1, s1_2_0, 0xFFF8F516, 0x1000FB07, 0xF1F208FF, 0x27D8FAEA);
	r2 = D(r2, s1_2_0, 0xFA000000, 0xFBFAF104, 0xFF0F03F9, 0xFAD5F8F0);
	r0 = D(r0, s1_2_1, 0x07F5EBFF, 0x06E4E70E, 0xD5B0CF48, 0xDD07F6FE);
	r1 = D(r1, s1_2_1, 0x17C6E0FD, 0x150AF40D, 0x052307DE, 0xFBEFC1F1);
	r2 = D(r2, s1_2_1, 0xF8130CF9, 0x14170CFC, 0x03EE0214, 0x05F3EDB8);
	r0 = D(r0, s1_2_2, 0xFFFCFC07, 0x0B280906, 0xCD2F2D0D, 0xFD1112FD);
	r1 = D(r1, s1_2_2, 0xFDF7FC09, 0x00DD0316, 0xFFDD0716, 0x07D7EBDF);
	r2 = D(r2, s1_2_2, 0x05F2040C, 0x06F9F601, 0xF7F40D0E, 0xE1301CBC);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0x0410EEF9, 0x240501EE, 0xEE283300, 0xF9050505);
	r1 = D(r1, s0_0_0, 0x00FDF5FF, 0xFDFF0404, 0x0B0DFEF8, 0x1BEEF9F2);
	r2 = D(r2, s0_0_0, 0xFD07FBFD, 0x0611F3F7, 0xF90C01FF, 0x0D0019F8);
	r0 = D(r0, s0_0_1, 0xF121E002, 0x123104F6, 0xE7242402, 0xEB1FFD0F);
	r1 = D(r1, s0_0_1, 0xFA01F600, 0xF8D60C04, 0xFF0403F6, 0x07FFE7EE);
	r2 = D(r2, s0_0_1, 0xEC0AF80A, 0x0AF81000, 0xEDF3070F, 0xF61416FE);
	r0 = D(r0, s0_0_2, 0x01FCEAFE, 0xFE0E02F9, 0x04142DFD, 0xF902FA04);
	r1 = D(r1, s0_0_2, 0x08F9F3FD, 0xFFF70A02, 0xF4E5FC0C, 0x0CE8D9F9);
	r2 = D(r2, s0_0_2, 0x04F1FA03, 0xF3F00A13, 0xFEF2FD07, 0xF0144401);
	r0 = D(r0, s0_1_0, 0x00F8F0FE, 0x0C2D0DDB, 0xEC101C02, 0xFBEFF805);
	r1 = D(r1, s0_1_0, 0x00E3EB00, 0xFB040701, 0x0012FBF6, 0xFC2FEFF7);
	r2 = D(r2, s0_1_0, 0xFD01F6FD, 0x1A0DFCEA, 0xFEF7F3FD, 0xE8E817FB);
	r0 = D(r0, s0_1_1, 0xF80FEB24, 0x4C7F16D3, 0xFCF3191C, 0x0BF1012D);
	r1 = D(r1, s0_1_1, 0x07F3ECF5, 0xF6EF091D, 0x08F40311, 0xF4D3B8F1);
	r2 = D(r2, s0_1_1, 0xE9FDFE23, 0x05EEF40E, 0xDED30646, 0x250826CE);
	r0 = D(r0, s0_1_2, 0xFA02F3FF, 0x17FF19EA, 0x18013104, 0x03FAFB07);
	r1 = D(r1, s0_1_2, 0x0404DEF7, 0x0CF2FA01, 0xEDE3FD0E, 0xF215E803);
	r2 = D(r2, s0_1_2, 0x00FDFDFE, 0xF012FE12, 0x01F5F605, 0x1A3242DB);
	r0 = D(r0, s0_2_0, 0x0000F900, 0x1D0A08C5, 0x0E0A1417, 0x010AFEFE);
	r1 = D(r1, s0_2_0, 0xF61AF20C, 0x05EE06FD, 0x000BF606, 0x08F0E9F6);
	r2 = D(r2, s0_2_0, 0x0102F8FC, 0x1014FCEF, 0x0206F503, 0xFB0B120A);
	r0 = D(r0, s0_2_1, 0x0805F30F, 0x27220B81, 0x0328061C, 0x13FA02EF);
	r1 = D(r1, s0_2_1, 0xF22AD320, 0xEFF7FA0C, 0x0502F10B, 0xDFE8AC26);
	r2 = D(r2, s0_2_1, 0x00F8FCFC, 0xFCE400D6, 0xF6FFFF14, 0x17100FD9);
	r0 = D(r0, s0_2_2, 0xFEFCFB05, 0xFDF60CDE, 0xDCF82CFC, 0x0B000300);
	r1 = D(r1, s0_2_2, 0x010FF402, 0xFF0A00E9, 0xEDFDFD0F, 0x000EF507);
	r2 = D(r2, s0_2_2, 0x000905FD, 0x000C0209, 0xFF030809, 0xFD0123BE);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-2.093e-02, -1.508e-02, 1.871e-02, -2.984e-02);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(5.939e-03, 9.683e-03, -1.087e-02, -2.021e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(4.071e-03, 1.729e-02, 5.548e-03, -3.845e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_4x12_DS_vk] -conv4
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
	r0 = D(r0, s0_0_0, 0xFCEE03FE, 0x000202FC, 0xFCF8FF04, 0xFEFB0003);
	r1 = D(r1, s0_0_0, 0x0516FEF5, 0x0813F3FF, 0xFE170102, 0xF5FE0502);
	r2 = D(r2, s0_0_0, 0x011BFDF3, 0xFEFD0002, 0xFFF9FF02, 0xFC09ECF6);
	r0 = D(r0, s0_0_1, 0xF812EDF7, 0xFFFAFE02, 0xFB0AEEF7, 0xFFFD0006);
	r1 = D(r1, s0_0_1, 0x080500E5, 0x0C0DEEFC, 0xF3DB0702, 0xF6FAF100);
	r2 = D(r2, s0_0_1, 0xFBDFF410, 0x01FAFBFA, 0xFC00FB11, 0x03F4F612);
	r0 = D(r0, s0_0_2, 0xFF05FE01, 0x01FC05FD, 0xF8FDF70F, 0xFDFE0204);
	r1 = D(r1, s0_0_2, 0xFC03FFFD, 0x01FFFD05, 0x0415EAF2, 0x0DF7CCDD);
	r2 = D(r2, s0_0_2, 0xFC050801, 0xFE01FF08, 0xFAFD010A, 0xF9FF060A);
	r0 = D(r0, s0_1_0, 0xF90CFCFA, 0x0EF601F5, 0x07030005, 0xFC07F904);
	r1 = D(r1, s0_1_0, 0xF4E10214, 0xD9E3F725, 0x080B00FE, 0x0D0108F7);
	r2 = D(r2, s0_1_0, 0x0817D4DE, 0x02FA0106, 0xF109ED14, 0x09F106F9);
	r0 = D(r0, s0_1_1, 0x0A081830, 0xCE0AD607, 0xF9FCD54D, 0xF4FFF000);
	r1 = D(r1, s0_1_1, 0xE2E80A64, 0xA5D18169, 0xFBD81601, 0xD4F6EEEC);
	r2 = D(r2, s0_1_1, 0xC5CF8205, 0xD312C20B, 0xE1FDC022, 0xBE078149);
	r0 = D(r0, s0_1_2, 0x01F9EF07, 0xF403F523, 0xFFF9F814, 0xFB00000F);
	r1 = D(r1, s0_1_2, 0x04FD0208, 0xE600F433, 0xD61685C2, 0x0E04DA02);
	r2 = D(r2, s0_1_2, 0x061A05E0, 0xFFF9E212, 0xFB02080D, 0x0B050ADC);
	r0 = D(r0, s0_2_0, 0x0004FA01, 0x0F0008F6, 0xFD000103, 0x0002F00C);
	r1 = D(r1, s0_2_0, 0xE90BE713, 0x02050CF9, 0x02FD000B, 0xFB000301);
	r2 = D(r2, s0_2_0, 0xFBFDFBF4, 0x0100FF08, 0x05FDFA0A, 0x01070610);
	r0 = D(r0, s0_2_1, 0xF8F9FBFA, 0xE000C3E7, 0x040005FC, 0x09F9AD55);
	r1 = D(r1, s0_2_1, 0xC41B810F, 0xFA1910EB, 0x0A050EE6, 0xF502FF06);
	r2 = D(r2, s0_2_1, 0x0500F1E3, 0x15F9DE34, 0x1FFAE842, 0x060115CE);
	r0 = D(r0, s0_2_2, 0x0301FA04, 0x16EEEDDF, 0xFD0001FF, 0x01FB07FF);
	r1 = D(r1, s0_2_2, 0x01F8FB16, 0x030111F7, 0xE1EEEDF1, 0x07FB05F1);
	r2 = D(r2, s0_2_2, 0xFDFA03FD, 0xFFF90207, 0xFDFC0300, 0xF603EE22);
	r0 = D(r0, s1_0_0, 0xFFFE04FB, 0x02010100, 0xFDFEF8FA, 0x030002FF);
	r1 = D(r1, s1_0_0, 0xFC07FC0F, 0x19F9E30F, 0xFB08F0FD, 0x05060400);
	r2 = D(r2, s1_0_0, 0xEE09F210, 0x0C01FEFA, 0x04FE0804, 0x0C05FBFB);
	r0 = D(r0, s1_0_1, 0x03FBF7E4, 0xDF01FD16, 0x0BF8F611, 0xF6FD030B);
	r1 = D(r1, s1_0_1, 0x01080606, 0x00F7FA19, 0x0AFA04FE, 0xFD00F5EB);
	r2 = D(r2, s1_0_1, 0x03E721D2, 0xEEFFFFE9, 0xE80305BE, 0xB6FCED0F);
	r0 = D(r0, s1_0_2, 0xFA03F6F5, 0x0DF50DF9, 0x0AFCFFDF, 0x09FD01F8);
	r1 = D(r1, s1_0_2, 0x1107FFF6, 0x20FB0108, 0xE7FD02FD, 0x0CE60C03);
	r2 = D(r2, s1_0_2, 0xF4F9F80B, 0x04FCFEE4, 0x08FD05FB, 0xFEF3030B);
	r0 = D(r0, s1_1_0, 0xFCFEFE00, 0x0EF20208, 0x05EC07FF, 0xF404F3FF);
	r1 = D(r1, s1_1_0, 0x00030D04, 0xFBF508FB, 0x0103F10B, 0x01FA0E01);
	r2 = D(r2, s1_1_0, 0x0309F50A, 0x07F2FAFB, 0x0F06E7F5, 0xF6FA1301);
	r0 = D(r0, s1_1_1, 0xFBF7F601, 0xF01418F5, 0xF0E403EE, 0x36021CDE);
	r1 = D(r1, s1_1_1, 0xF2EDF8D1, 0xD9BD0DDE, 0xF7DA2EFB, 0x0504FAFC);
	r2 = D(r2, s1_1_1, 0xEF814EFC, 0x31FEF314, 0x2DEA2F23, 0xECE513EE);
	r0 = D(r0, s1_1_2, 0xF800FB02, 0xE5FB0DF1, 0xF4FD020E, 0xFDFF03EE);
	r1 = D(r1, s1_1_2, 0x08F5FDF7, 0xE2ECFAFD, 0x12D6FBEC, 0xFBF61001);
	r2 = D(r2, s1_1_2, 0x07FDF5FB, 0xFA03FE09, 0xFC00FFF7, 0x0214F70F);
	r0 = D(r0, s1_2_0, 0xFB0101FE, 0x04F10405, 0xFF00FDFF, 0x06FA03FF);
	r1 = D(r1, s1_2_0, 0x13ECE0FD, 0x0105F900, 0xFF0DFA02, 0x0000FAFF);
	r2 = D(r2, s1_2_0, 0x0907F003, 0xFFF504FE, 0xFCF70AFF, 0xFB00F3FC);
	r0 = D(r0, s1_2_1, 0x0303FE02, 0x02FE04F9, 0x01FFFD00, 0xEAE615F0);
	r1 = D(r1, s1_2_1, 0x0BE6EE0D, 0x1616EB04, 0x0EFC06F9, 0xFD01F802);
	r2 = D(r2, s1_2_1, 0xFEF51900, 0xEEE806F6, 0xEFF510F1, 0x0C11F906);
	r0 = D(r0, s1_2_2, 0xFEFE0001, 0x09FF070B, 0x01FEFF00, 0xFAFCFE09);
	r1 = D(r1, s1_2_2, 0xFBF1FC03, 0x0005FBFA, 0x00F8F6FD, 0x0203FFFE);
	r2 = D(r2, s1_2_2, 0x0800FC04, 0xFDFB0204, 0xFBF90104, 0xF8F405FC);
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 = D(r0, s0_0_0, 0xF91300F7, 0xFD0403FE, 0x021104F0, 0x02FE0001);
	r1 = D(r1, s0_0_0, 0xFBFB0508, 0xF1F30506, 0xFCFE0304, 0x01F7020F);
	r2 = D(r2, s0_0_0, 0xEEF20711, 0x000901F8, 0x0203FDFD, 0xF104FD06);
	r0 = D(r0, s0_0_1, 0x0B0BFC0C, 0xF807F9FE, 0xF3FFFB12, 0x020203FB);
	r1 = D(r1, s0_0_1, 0xF1E9071C, 0xE7F20801, 0x181203E9, 0xFC2DFCD2);
	r2 = D(r2, s0_0_1, 0x2110E8F0, 0x02020104, 0x01FD06FB, 0xF90305EA);
	r0 = D(r0, s0_0_2, 0x0C02FD02, 0x08FF0007, 0x0A05FFF9, 0xFD020000);
	r1 = D(r1, s0_0_2, 0x02F60305, 0x00F40701, 0xDF01FD18, 0x04F7D627);
	r2 = D(r2, s0_0_2, 0xE2FF010C, 0x020303FB, 0xFE0500F8, 0xD6FF0204);
	r0 = D(r0, s0_1_0, 0x06000703, 0x04FE02F2, 0x040106EE, 0xF904FF00);
	r1 = D(r1, s0_1_0, 0x10FEFFEE, 0x2311F7F1, 0xE9FC0700, 0xFFFC0105);
	r2 = D(r2, s0_1_0, 0xEAEB0BFB, 0x041004E8, 0xF6060AFA, 0x0E0A0BE1);
	r0 = D(r0, s0_1_1, 0xF2F8E44E, 0xF1F2FA3B, 0x0542D3FE, 0xFEFBE20A);
	r1 = D(r1, s0_1_1, 0x1C3EFD8B, 0x2035CBED, 0x1FE7FEEE, 0xF82A110C);
	r2 = D(r2, s0_1_1, 0x1013C137, 0xEF23E712, 0x020FC308, 0xFC0F9D2C);
	r0 = D(r0, s0_1_2, 0x04F7020D, 0x0511F6D0, 0xFD0401F5, 0x0207FAF5);
	r1 = D(r1, s0_1_2, 0xFA110AE8, 0xF610F900, 0xEE51A243, 0x00F2F100);
	r2 = D(r2, s0_1_2, 0xF718E517, 0x06FC0100, 0x000AF6F0, 0xF904F603);
	r0 = D(r0, s0_2_0, 0x0E020105, 0xF6F601FC, 0xFA02FF02, 0x050400F0);
	r1 = D(r1, s0_2_0, 0xE8E40626, 0xE9F10106, 0x050205FC, 0xFCFC0401);
	r2 = D(r2, s0_2_0, 0x100004FC, 0xFD0104F6, 0x0606FDEC, 0xD8F9F909);
	r0 = D(r0, s0_2_1, 0x00FEFEFD, 0x0B21F210, 0xFF0306FE, 0xFF13DCF2);
	r1 = D(r1, s0_2_1, 0xF4DED567, 0xF0F1FF0C, 0xF6EC0AF9, 0x0507FCF9);
	r2 = D(r2, s0_2_1, 0xF202D6F1, 0x0521F1F0, 0xFE0EE4E6, 0xFF0801E3);
	r0 = D(r0, s0_2_2, 0x02FAFF03, 0x00FBF8FE, 0x020602FC, 0x020CFCF7);
	r1 = D(r1, s0_2_2, 0x03ECFC29, 0xFFFA030C, 0x0D21EA04, 0x0107FA00);
	r2 = D(r2, s0_2_2, 0x090CFB06, 0x000901F4, 0x010DFDF9, 0xFDFBF602);
	f0 = vec4(r0) * 6.2000124e-05;
	f0 += vec4(-2.452e-03, -2.264e-02, -4.130e-03, -2.051e-03);
	f0 = max(f0, vec4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), f0);
	f1 = vec4(r1) * 6.2000124e-05;
	f1 += vec4(-1.186e-02, -9.394e-03, -3.528e-02, -2.472e-02);
	f1 = max(f1, vec4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), f1);
	f2 = vec4(r2) * 6.2000124e-05;
	f2 += vec4(-3.111e-02, -3.587e-03, -3.537e-03, -1.180e-02);
	f2 = max(f2, vec4(0.0));
	imageStore(out_image, opos + ivec2(2, 0), f2);
}

//!DESC [CuNNy_4x12_DS_vk] -out-shuffle
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
	r0 += M4(-9.863e-03, 6.995e-04, 4.123e-03, 2.740e-05, 1.974e-01, 2.618e-02, 4.899e-02, 7.146e-03, 1.874e-02, 1.822e-03, -2.352e-03, -2.460e-03, 8.276e-02, -3.787e-03, 3.600e-02, 4.651e-04) * s0_0_0;
	r0 += M4(-7.020e-02, -8.130e-02, -5.072e-03, -8.817e-03, 4.787e-02, -3.057e-01, 5.459e-03, -7.411e-02, 7.201e-02, 8.912e-02, 6.973e-03, 8.400e-03, -5.008e-01, 1.091e-01, 7.096e-02, 3.137e-02) * s0_0_1;
	r0 += M4(1.329e-02, 2.711e-03, -8.845e-04, 9.307e-03, -4.322e-03, 3.094e-02, -2.776e-03, 1.616e-02, -5.198e-03, 1.016e-02, 5.780e-04, -4.303e-03, 1.769e-02, -1.033e-01, -1.297e-02, -5.177e-02) * s0_0_2;
	r0 += M4(1.754e-03, 2.032e-02, -1.936e-02, 8.576e-03, 1.566e-02, -1.774e-04, 1.665e-01, 2.434e-02, -1.158e-01, 1.245e-02, 1.385e-02, 2.508e-03, -5.090e-03, 1.996e-03, 5.208e-02, 2.065e-02) * s0_1_0;
	r0 += M4(-3.506e-02, -8.371e-02, -1.860e-01, -1.997e-01, 2.770e-03, -1.248e-02, 5.285e-02, -2.462e-01, 9.156e-02, -4.733e-01, 1.158e-01, 1.698e-01, 1.860e-02, -3.325e-04, 1.891e-01, 2.919e-02) * s0_1_1;
	r0 += M4(3.135e-02, 3.729e-02, 3.600e-02, 2.796e-02, -4.282e-03, 1.775e-02, 2.255e-03, 2.689e-02, -1.301e-02, 7.886e-02, -4.628e-03, 4.897e-02, 1.232e-02, -2.697e-02, 2.556e-03, -2.076e-02) * s0_1_2;
	r0 += M4(3.071e-02, -6.457e-03, 3.118e-02, 1.387e-02, -5.050e-03, -1.233e-03, -2.277e-02, -1.290e-02, -2.236e-02, -7.341e-03, -5.721e-02, -1.178e-02, 3.093e-05, -1.749e-03, 9.528e-04, -1.622e-03) * s0_2_0;
	r0 += M4(6.647e-02, 9.635e-02, 1.194e-01, 1.243e-01, -1.352e-03, -9.307e-03, -3.531e-03, 2.726e-03, -5.604e-02, -3.079e-02, -7.085e-03, 9.877e-02, -8.026e-03, -7.616e-04, 1.120e-02, 1.922e-02) * s0_2_1;
	r0 += M4(-1.285e-02, 3.392e-03, 3.226e-03, 2.264e-02, 1.984e-03, -1.937e-04, 7.970e-04, 6.786e-03, 7.620e-03, -4.686e-03, 7.606e-03, 3.799e-02, -3.072e-04, -6.243e-03, 1.912e-03, 2.073e-03) * s0_2_2;
	r0 += M4(2.297e-02, -5.998e-03, -3.116e-02, -4.103e-03, 3.552e-02, 4.222e-03, -7.092e-03, 2.768e-03, 5.439e-02, -5.705e-02, -5.670e-03, 1.523e-02, 1.052e-02, 3.529e-03, -3.281e-03, 9.043e-03) * s1_0_0;
	r0 += M4(2.966e-01, 2.861e-01, -2.446e-01, -1.953e-01, 3.584e-02, 5.088e-02, -1.727e-02, -2.800e-02, -1.664e-03, -3.387e-03, 6.040e-03, 8.410e-04, -1.213e-03, 1.002e-02, -3.720e-03, 5.258e-03) * s1_0_1;
	r0 += M4(-9.917e-03, 3.401e-02, 6.967e-03, -4.937e-02, -1.902e-03, 9.185e-03, 3.291e-03, 3.139e-03, 3.252e-04, -1.741e-03, 2.354e-04, -1.621e-03, -4.085e-04, 7.262e-03, -1.656e-04, 2.933e-03) * s1_0_2;
	r0 += M4(-1.108e-02, 4.130e-03, 1.005e-02, 1.554e-03, -8.911e-02, 1.065e-02, 6.073e-02, 1.248e-02, 2.450e-01, -1.831e-01, 2.565e-01, -2.324e-01, -2.869e-01, 5.897e-02, -5.420e-02, 1.301e-02) * s1_1_0;
	r0 += M4(-6.904e-02, -6.567e-02, 4.458e-02, 2.889e-02, -2.592e-01, -3.291e-01, 2.005e-01, 2.417e-01, -2.367e-02, -2.169e-03, -2.370e-02, -7.492e-03, 1.988e-02, 1.912e-01, 2.109e-02, 9.253e-02) * s1_1_1;
	r0 += M4(7.238e-03, -1.273e-02, -6.119e-03, 1.291e-02, 2.781e-04, -2.413e-02, 3.537e-03, 2.051e-02, 2.827e-04, -1.825e-03, 1.007e-03, 7.436e-05, 2.419e-03, -6.703e-03, 1.937e-04, 2.292e-03) * s1_1_2;
	r0 += M4(-6.391e-04, -9.942e-04, -2.871e-03, -2.023e-03, 1.871e-02, 4.029e-03, 2.165e-02, -1.825e-02, -2.095e-02, -4.715e-03, 3.085e-02, -3.536e-02, -2.275e-02, -2.816e-02, -2.023e-01, -8.829e-03) * s1_2_0;
	r0 += M4(2.210e-03, 2.915e-03, 1.352e-04, -8.111e-04, 2.032e-02, 2.143e-02, -6.211e-03, 2.884e-02, 7.631e-03, 3.580e-03, -9.259e-03, -2.721e-04, -6.718e-03, 3.864e-02, -4.345e-03, 1.476e-01) * s1_2_1;
	r0 += M4(6.857e-05, -6.138e-05, -1.655e-03, -3.891e-03, -7.130e-05, 1.371e-02, -9.720e-03, -1.787e-02, 1.444e-05, 3.490e-04, -4.827e-04, -9.716e-04, -2.017e-03, 6.366e-04, -1.041e-03, -6.003e-03) * s1_2_2;
	s0_0_0 = G[2][xy.y+0][xy.x+0]; s0_0_1 = G[2][xy.y+0][xy.x+1];
	s0_0_2 = G[2][xy.y+0][xy.x+2]; s0_1_0 = G[2][xy.y+1][xy.x+0];
	s0_1_1 = G[2][xy.y+1][xy.x+1]; s0_1_2 = G[2][xy.y+1][xy.x+2];
	s0_2_0 = G[2][xy.y+2][xy.x+0]; s0_2_1 = G[2][xy.y+2][xy.x+1];
	s0_2_2 = G[2][xy.y+2][xy.x+2];
	r0 += M4(1.106e-02, -8.995e-03, 7.862e-03, 1.732e-04, -1.982e-02, -6.335e-03, -1.551e-02, -3.176e-03, 3.775e-02, 1.139e-02, 2.872e-03, 9.214e-04, -1.739e-02, -1.050e-02, -4.878e-04, 1.591e-02) * s0_0_0;
	r0 += M4(-7.978e-02, 7.202e-02, 6.676e-03, -7.618e-03, 4.993e-02, 1.743e-01, 1.504e-02, 2.557e-02, 1.724e-01, 5.610e-02, 3.014e-02, 1.185e-02, 4.919e-02, 3.036e-02, -7.920e-03, 2.985e-02) * s0_0_1;
	r0 += M4(7.303e-03, 3.865e-03, -2.086e-03, -8.694e-03, 1.092e-02, 4.153e-02, -2.216e-07, 2.202e-03, -1.546e-02, -2.910e-02, -6.668e-03, -1.531e-02, -1.531e-02, -1.386e-02, -1.590e-03, -6.515e-03) * s0_0_2;
	r0 += M4(-1.901e-04, -1.617e-02, -8.695e-03, -2.003e-02, -2.502e-02, -1.203e-03, -9.741e-02, 1.215e-02, 4.521e-02, 4.055e-03, 1.003e-01, 3.306e-03, 1.135e-01, -1.035e-02, -3.381e-02, 9.249e-04) * s0_1_0;
	r0 += M4(-2.172e-01, 2.329e-01, -2.666e-01, 2.529e-01, 1.910e-02, 9.020e-02, 9.971e-02, -5.091e-01, 3.284e-02, -1.175e-02, -4.342e-01, 1.086e-01, -2.954e-01, 2.016e-01, 1.411e-01, -2.504e-01) * s0_1_1;
	r0 += M4(8.396e-03, 1.283e-02, 2.007e-02, 1.856e-02, -1.474e-02, 3.040e-02, -1.035e-02, 6.212e-02, 3.115e-03, -8.803e-03, 2.196e-03, -5.724e-02, 1.543e-02, -8.155e-03, -1.364e-02, 4.238e-02) * s0_1_2;
	r0 += M4(6.875e-03, 8.927e-04, 3.936e-03, -4.910e-03, 5.398e-03, -1.484e-03, -5.784e-03, -4.430e-04, -2.907e-03, 6.983e-04, 4.451e-03, -4.333e-03, -7.008e-03, 6.912e-03, -3.307e-03, -6.985e-03) * s0_2_0;
	r0 += M4(1.490e-02, -1.259e-02, -2.897e-02, 3.505e-02, 1.514e-02, -8.337e-03, -1.075e-02, 6.515e-03, 1.435e-03, 1.124e-02, 3.458e-03, -1.648e-02, 2.147e-02, -2.466e-02, 5.764e-04, 5.887e-02) * s0_2_1;
	r0 += M4(1.453e-03, -3.450e-03, 6.481e-03, 1.991e-04, 3.945e-04, 4.677e-03, 2.245e-04, 1.016e-02, -3.221e-03, 6.550e-03, -2.781e-03, -2.048e-02, 2.857e-02, -8.715e-03, 1.235e-02, -4.370e-02) * s0_2_2;
	r0 += V4(-6.136e-05, -5.852e-05, -5.821e-05, -6.116e-05);
	r0 = r0;
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
